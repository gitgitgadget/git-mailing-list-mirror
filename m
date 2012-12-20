From: Adam Spiers <git@adamspiers.org>
Subject: Re: $PATH pollution and t9902-completion.sh
Date: Thu, 20 Dec 2012 15:13:27 +0000
Message-ID: <CAOkDyE-J7sTJ-GefhteP1wy7WorqTRnj5nn0k6hd1dp0VJz5iQ@mail.gmail.com>
References: <20121217010538.GC3673@gmail.com>
	<20121220145519.GB27211@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 20 16:19:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlhu7-0002K5-LR
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 16:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036Ab2LTPTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 10:19:06 -0500
Received: from mail-wi0-f176.google.com ([209.85.212.176]:57480 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913Ab2LTPTD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 10:19:03 -0500
X-Greylist: delayed 330 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Dec 2012 10:19:03 EST
Received: by mail-wi0-f176.google.com with SMTP id hm6so4368855wib.9
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 07:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=zK/sTx4wyCsx6LPb7bmMSyl7KVHh0RfSGjpcEg8HK90=;
        b=h0MYK8y4lBusFzdShvqxndOC0ymDiJOxoVdU3VsiarY5YFmRjokQRZtiI+OkGBCrM0
         OZ78PEwRt5+Ga2Fwgdh2pQ82yQ0CPT2dl73oY5Y6kHpgjoYogkKOgDAUcsJbXf2okBan
         R6AL/+LZ+LtdqTCshQS6WpARGqASK8Bjhe/B8KLMC2a/LKMNMG3EnBNWP+9AKEtO1Ien
         jhKGNcxEXUH0xPZzaCJr7E/wYtVnO8WI7cpTXl1j2u+KN7AgcmiXESqWUvWp8LDJ0hrv
         yPZaHgWLxCO2ag7MyA3+FxgNZZN3vcfmSVR2JkQUMWoSFnh/WqqihNYDBblQXdKo/zTx
         QGUA==
Received: by 10.180.8.130 with SMTP id r2mr10602631wia.28.1356016407920; Thu,
 20 Dec 2012 07:13:27 -0800 (PST)
Received: by 10.194.56.232 with HTTP; Thu, 20 Dec 2012 07:13:27 -0800 (PST)
In-Reply-To: <20121220145519.GB27211@sigill.intra.peff.net>
X-Google-Sender-Auth: F6UqECGXhYu9PqeFGkzbcrNq_EY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211896>

On Thu, Dec 20, 2012 at 2:55 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Dec 17, 2012 at 01:05:38AM +0000, Adam Spiers wrote:
>> t/t9902-completion.sh is currently failing for me because I happen to
>> have a custom shell-script called git-check-email in ~/bin, which is
>> on my $PATH.  This is different to a similar-looking case reported
>> recently, which was due to an unclean working tree:
>>
>>   http://thread.gmane.org/gmane.comp.version-control.git/208085
>>
>> It's not unthinkable that in the future other tests could break for
>> similar reasons.  Therefore it would be good to sanitize $PATH in the
>> test framework so that it cannot destabilize tests, although I am
>> struggling to think of a good way of doing this.  Naively stripping
>> directories under $HOME would not protect against git "plugins" such
>> as the above being installed into places like /usr/bin.  Thoughts?
>
> I've run into this, too. I think sanitizing $PATH is the wrong approach.
> The real problem is that the test is overly picky. Right now it is
> failing because you happen to have "check-email" in your $PATH, but it
> will also need to be adjusted when a true "check-email" command is added
> to git.
>
> I can think of two other options:
>
>   1. Make the test input more specific (e.g., looking for "checkou").
>      This doesn't eliminate the problem, but makes it less likely
>      to occur.
>
>   2. Loosen the test to look for the presence of "checkout", but not
>      fail when other items are present. Bonus points if it makes sure
>      that everything returned starts with "check".
>
> I think (2) is the ideal solution in terms of behavior, but writing it
> may be more of a pain.

I agree with all your points.  Thanks for the suggestions.
