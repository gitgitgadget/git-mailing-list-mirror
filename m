From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Cygwin + git log = no pager!
Date: Mon, 24 Feb 2014 13:34:34 -0600
Message-ID: <CAHd499BDBgaAZFkoc=S9i9hG=NifAmqhaW86fqgkzjShZd07ww@mail.gmail.com>
References: <CAHd499BT1Q308+q0NB9Dpx=ncQZwRn0tg=q_PE8RutaVqH+xQQ@mail.gmail.com>
	<53085434.4060106@gmail.com>
	<CAHd499AbsUwmA0HWu31jW2n8eUNnRtU7URKPfBU7EhU6-F48zg@mail.gmail.com>
	<530AFAFD.2060504@gmail.com>
	<20140224090618.GB10698@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Chris Packham <judge.packham@gmail.com>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 24 20:34:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI1IX-000878-0Y
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 20:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbaBXTeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 14:34:36 -0500
Received: from mail-vc0-f175.google.com ([209.85.220.175]:35115 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbaBXTef (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 14:34:35 -0500
Received: by mail-vc0-f175.google.com with SMTP id ij19so6285576vcb.34
        for <git@vger.kernel.org>; Mon, 24 Feb 2014 11:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=buBcIEP8sV6qKnUseUGymWY6fCNWCWTewkZnqYAsrwc=;
        b=o6jBbpJtvmVWeW8sjzDgQoORSyzA/DllOfWkaR1/IlWRdo16DDvr+7AEFPb49Zfc/w
         xR/wsswyJvifDgycO2Ja1CQrRkUQRO9GV/7fGNKEqHhtac/ExPz6JYMglIsP13sBtbhA
         l42NXUNgGjNEC7Iuh042KBjTgS/ye1+aR/n43fNlNPfWbxP7ln8W9R/pQ3JUc7L/QOma
         ugk1TWuTPf1OxLBBH+sV0TJYwm+0e8Y8KvaS81tv2vVWGd6mKr7CSxr01GWQ/qHW2NUc
         nf6yr+y0+S+5ahFJLuxxqhRBzeuNCFKFADPYtAxiPXIc5IT1DJ4W9GpAt7AhokDEdo/y
         Gdiw==
X-Received: by 10.221.39.138 with SMTP id tm10mr13848788vcb.7.1393270474752;
 Mon, 24 Feb 2014 11:34:34 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.49.68 with HTTP; Mon, 24 Feb 2014 11:34:34 -0800 (PST)
In-Reply-To: <20140224090618.GB10698@sigill.intra.peff.net>
X-Google-Sender-Auth: mIXN7cUldO3c-fRdfGfRK_w0UsM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242631>

On Mon, Feb 24, 2014 at 3:06 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 24, 2014 at 08:55:41PM +1300, Chris Packham wrote:
>
>> > Thanks for the response. I did set this environment variable in my
>> > .bashrc like so:
>> >
>> > export GIT_PAGER=less
>> >
>> > However after I do a 'git log' it is just spitting it out all at once
>> > and not entering the pager.
>> >
>>
>> Um OK that was the obvious thing to try. There is also the config
>> variable core.pager but GIT_PAGER should take precedence.
>
> Presumably we are actually running what's in GIT_PAGER, but we can
> double-check with:
>
>   GIT_PAGER='echo custom pager' git log
>
> You can also try:
>
>   GIT_TRACE=1 git log
>
> which should describe the pager being run.
>
>> Could something be setting the environment variable LESS? Reading the
>> git-config man page for core.pager git wants to set LESS to FRSX but if
>> it is already set git takes that as an indication that you don't want to
>> set LESS automatically.
>
> We can also double-check the LESS setting in the executed pager:
>
>   GIT_PAGER='echo LESS=$LESS' git log
>
> If we are running less, and it is using FRSX, I'd suspect some kind of
> terminal weirdness with less itself. With "-F", less will quit if the
> whole output can be displayed; it's possible it thinks the screen is
> bigger than it is.
>
> Trying:
>
>   GIT_PAGER=less LESS=RSX git log
>
> might help.
>
> -Peff

So I set GIT_PAGER to 'echo custom pager' as you instructed, and I
noticed that wasn't being printed when I ran my git log alias. So what
I did after that was set GIT_TRACE=1 and here is the output I see
before my logs start printing:

$ git lg
trace: exec: 'git-lg'
trace: run_command: 'git-lg'
trace: run_command: 'git lg1'
trace: exec: 'git-lg1'
trace: run_command: 'git-lg1'
trace: run_command: 'git short-log-base --branches --remotes --tags'
trace: exec: 'git-short-log-base' '--branches' '--remotes' '--tags'
trace: run_command: 'git-short-log-base' '--branches' '--remotes' '--tags'
trace: alias expansion: short-log-base => 'log' '--graph'
'--abbrev-commit' '--decorate' '--date=relative'
'--format=format:%C(bold blue)%h%C(reset)%x09%C(bold
green)(%ar)%C(reset)%C(bold yellow)%d%C(reset) %C(dim
white)%an%C(reset) - %C(white)%s%C(reset)'
trace: built-in: git 'log' '--graph' '--abbrev-commit' '--decorate'
'--date=relative' '--format=format:%C(bold blue)%h%C(reset)%x09%C(bold
green)(%ar)%C(reset)%C(bold yellow)%d%C(reset) %C(dim
white)%an%C(reset) - %C(white)%s%C(reset)' '--branches' '--remotes'
'--tags'

Does using an alias have something to do with this?
