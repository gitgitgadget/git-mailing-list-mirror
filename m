From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Cygwin + git log = no pager!
Date: Wed, 26 Feb 2014 09:54:39 -0600
Message-ID: <CAHd499Co9Amdf_gWnY81dkRa2uDTH0fVM8HSb99VHhrb1AAKhA@mail.gmail.com>
References: <CAHd499BT1Q308+q0NB9Dpx=ncQZwRn0tg=q_PE8RutaVqH+xQQ@mail.gmail.com>
	<53085434.4060106@gmail.com>
	<CAHd499AbsUwmA0HWu31jW2n8eUNnRtU7URKPfBU7EhU6-F48zg@mail.gmail.com>
	<530AFAFD.2060504@gmail.com>
	<20140224090618.GB10698@sigill.intra.peff.net>
	<CAHd499BDBgaAZFkoc=S9i9hG=NifAmqhaW86fqgkzjShZd07ww@mail.gmail.com>
	<20140226092610.GB32537@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Chris Packham <judge.packham@gmail.com>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 26 16:54:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIgom-0004DK-SE
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 16:54:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbaBZPyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 10:54:40 -0500
Received: from mail-vc0-f181.google.com ([209.85.220.181]:43174 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbaBZPyk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 10:54:40 -0500
Received: by mail-vc0-f181.google.com with SMTP id lg15so1127181vcb.12
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 07:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+TU3LOQFNpajBgcp1buDaD4E8OMeKIaGloQ8v9aShGA=;
        b=d7dPSEACW5WTme0m5e6MLiy8ppEK4Lr/WVrNXG8wyhvCCfUydeQTbseR2J61lud7tD
         aWgJ70aedNRiX43nZP5B8XfI1uK6ltibjruKciRkUcvqZAUL6BF+NntcRMcCQaPzePvc
         NbiWWCI1a/5oYdVl7TTuDNy+Ycr5N2h2/UUQ70Tbz92aOhetvQFJMVBBTnw96NM9+JFo
         406MHbuIwiEIrpGJu1rKzgpSxTIhOnixq6l5/J5LJ6Vh3XIHszr10mhw6thnOw866qo+
         awaiLcXwR+yL1nRA/ZF61DHOzQ/1d3OTSbnThbqvrJCdOyfyS5YTM0JF2XK7zwUucTw2
         TWzA==
X-Received: by 10.220.147.16 with SMTP id j16mr6516834vcv.28.1393430079189;
 Wed, 26 Feb 2014 07:54:39 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.49.68 with HTTP; Wed, 26 Feb 2014 07:54:39 -0800 (PST)
In-Reply-To: <20140226092610.GB32537@sigill.intra.peff.net>
X-Google-Sender-Auth: srpPR_mRusZoJ2J4dnxWr45Im3Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242732>

On Wed, Feb 26, 2014 at 3:26 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 24, 2014 at 01:34:34PM -0600, Robert Dailey wrote:
>
>> So I set GIT_PAGER to 'echo custom pager' as you instructed, and I
>> noticed that wasn't being printed when I ran my git log alias. So what
>> I did after that was set GIT_TRACE=1 and here is the output I see
>> before my logs start printing:
>> [...]
>> Does using an alias have something to do with this?
>
> The aliases shouldn't matter (and I constructed a scenario like the one
> you showed and it starts the pager for me on Linux). It's more like git
> is deciding not to show a pager at all (e.g., it thinks your stdout is
> not a tty). Does running:
>
>   git log
>
> not use a pager, but:
>
>   git -p log
>
> does? In that case, I think that your stdout is not a tty for some
> reason.
>
> If that is the case, try:
>
>   git -p lg
>
> That _should_ turn on the pager, but I think it does not due to a bug
> with setup_pager and aliases. Something like the patch below would make
> it work (but if you are having to use "-p" manually, there is something
> to fix in your cygwin environment, which does not think you are on a
> terminal).
>
> -Peff
>
> <snip>

I have tried `git -p log` and `git log` and neither use the pager.
Should I apply the provided patch to the Git for Windows master
branch? Also I'm not sure if there is a convenient way to apply a
patch via email, so should I copy & paste it to a file & then apply
the file?

I'm assuming your patch depended on -p working but not without it, so
I'm not sure if you still think the patch might help. Let me know!
Thanks for your help.
