From: Noam Postavsky <npostavs@users.sourceforge.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it to
 ignore instead?
Date: Thu, 29 Oct 2015 20:43:58 -0400
Message-ID: <CAM-tV-_dc_YEE0Dh2T=8+_DcBiq_rvynOw2cFi+8QizkeGTusw@mail.gmail.com>
References: <CAM-tV-_JPazYxeDYogtQTRfBxONpSZwb3u5pPanB=F9XnLnZyg@mail.gmail.com>
	<CAM-tV-_eOgnhqsTFN6kKW=tcS7gAPYaxskBaxnJZo3bsx02HZg@mail.gmail.com>
	<xmqqfv18awj4.fsf@gitster.mtv.corp.google.com>
	<CAM-tV-8VXtB5uRgqP9dFpww6AaLzasPV46tCiquz=nz=ksBNng@mail.gmail.com>
	<CAM-tV-9sNgHncsWRPh36tEY3YFORUJBA-Q6W5R=mvX_KhSmWEQ@mail.gmail.com>
	<xmqqfv0ylwa7.fsf@gitster.mtv.corp.google.com>
	<20151026215016.GA17419@sigill.intra.peff.net>
	<xmqqoafkci6j.fsf@gitster.mtv.corp.google.com>
	<20151027184702.GB12717@sigill.intra.peff.net>
	<CAM-tV--B3HaC1DcORfnx9bWW9-quyk0=pQDxmvonc=6dgrMOxA@mail.gmail.com>
	<20151030001000.GA2123@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 01:50:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zrxtp-0007q5-Tp
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 01:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbbJ3Au3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 20:50:29 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38835 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbbJ3Au2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 20:50:28 -0400
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Oct 2015 20:50:28 EDT
Received: by wmeg8 with SMTP id g8so909149wme.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2015 17:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9Ua3XolGSzr9ANJvZTfKiuZ3VTemGWSZSKjvY7VuRXU=;
        b=yMm1ssvQGVwqT9iv3mNpOfC9dwqwK8b+ii+6YzJdTXY5W6K/HznhvkQh13XTLZQiXD
         ET8QU8BEFebc1UCs9jacQoZXCZn1bjfgDWqN6eizzKBiY4vjTIZjIkLEUEAmajygxU3L
         Pvjkn8t5CL3XHrMPO3Gyq+0RgV7zPDnhAWnqYuB5ThR2fIbCcqfLpECDC2I/VKR5xbBH
         Nyrl3D1DYsBwW4TXNOqYqElkXKmDfr0vyXkeDIJ8WJTvhVtUBp/Mm3asBopvZo9IJPje
         XFs7lajCGhPjM4o0CciiKhhwbPqbtFILzeiV+ScIQW8a35tFG4O1tN7l+pe7IaDu70kN
         5C/A==
X-Received: by 10.28.142.193 with SMTP id q184mr150608wmd.15.1446165838186;
 Thu, 29 Oct 2015 17:43:58 -0700 (PDT)
Received: by 10.28.29.87 with HTTP; Thu, 29 Oct 2015 17:43:58 -0700 (PDT)
In-Reply-To: <20151030001000.GA2123@sigill.intra.peff.net>
X-Google-Sender-Auth: AFCOoI_6GeUv4ORraLjF1RO9auA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280466>

On Thu, Oct 29, 2015 at 8:10 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 27, 2015 at 11:46:20PM -0400, Noam Postavsky wrote:
>> Perhaps we could express the auto-spawn more explicitly, something
>> like "git config credential.pre-helper start-cache-daemon". A way to
>> run a command before the credential helpers start would be useful to
>> our magit workaround for this issue (currently we start the daemon
>> before "push", "fetch", and "pull", but it won't work with user
>> aliases that run those commands).
>
> I'm not clear on when the pre-helper would be run. Git runs the helper
> when it needs a credential. What git command would start it?

I was just thinking in terms of our current workaround, it would have
been helpful to be able to run a command just before the helpers are
run. Or in other words, as the first helper. (doing "git -c
credential.helper=foo" puts foo as the last helper).

> I guess the most elegant thing would be to add an "init" command to the
> helper interface. So magit would run:
>
>   git credential init

Although, we could use something like that too, as we're currently
checking the helpers configured and then running git
credential-cache--daemon directly.

> I dunno. It almost seems like adding a credentialcache.ignoreHUP option
> would be less hacky. :)

The pre-helper thing is probably the best way to make the current
hacks less hacky, but maybe not so great for actually fixing the
problem and getting rid of the need for said hacks. :)

> Mostly, I think, because there was a lot of support load in teaching
> people to set up ssh. But I guess a lot of those people are on
> non-Linux platforms.

Hmm, the pre-helper thing would also help for the hack I wrote getting
ssh-agent to autostart and work from Emacs on Windows (ssh-agent on
Windows is a total PITA).
