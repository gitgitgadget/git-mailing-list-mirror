From: Luke Diamand <luke@diamand.org>
Subject: Re: git p4 submit bugs (submit fails due to keyword expansion mismatch
 and gives bad instructions for how to proceed)
Date: Wed, 08 Feb 2012 22:27:29 +0000
Message-ID: <4F32F6D1.8030009@diamand.org>
References: <CAEe=O8o-BG0xNGQEweezPu8cj+Brt1Km_anhEJBg0W7Q=rLbkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Scouten <eric@scouten.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 23:27:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvFzB-0006Nr-8a
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 23:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884Ab2BHW11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 17:27:27 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:36688 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816Ab2BHW11 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 17:27:27 -0500
Received: by werb13 with SMTP id b13so766174wer.19
        for <git@vger.kernel.org>; Wed, 08 Feb 2012 14:27:25 -0800 (PST)
Received: by 10.180.97.166 with SMTP id eb6mr43952110wib.5.1328740045929;
        Wed, 08 Feb 2012 14:27:25 -0800 (PST)
Received: from [86.6.30.7] (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id q7sm2886117wix.5.2012.02.08.14.27.24
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Feb 2012 14:27:25 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.21) Gecko/20110831 Iceowl/1.0b2 Icedove/3.1.13
In-Reply-To: <CAEe=O8o-BG0xNGQEweezPu8cj+Brt1Km_anhEJBg0W7Q=rLbkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190262>

On 08/02/12 21:49, Eric Scouten wrote:
> I've been experimenting with git-p4 as a front-end to Perforce as
> described in http://www.perforce.com/blog/120113/git-perforce-client,
> but two bugs are causing me major headaches:
>
> (1) git-p4 doesn't work with P4 keyword expansion. (I gather there's a
> fork of git-p4 that makes it work, but the current official distro
> doesn't.) This can lead to some ugly failed submits down the road.
> Which leads me to ...

Do you mean those awful $RCS$ keywords?

I had a go at creating some code that would cope, but in the end I'm 
afraid I gave up.

My strategy was to try the patch, if it failed, look for RCS keywords, 
and then zap them in the destination p4 file and then try the patch again.

It worked for some cases reasonably well (deletion is a bit trickier), 
but it failed horribly if anyone was crazy enough to copy a p4 file with 
expanded RCS keywords into the git repo. So at that point, I gave up in 
disgust and just wrote a pre-commit script to reject all changes 
involving $RCS$.

Basically, my feeling now is that RCS keywords are utterly bonkers, and 
anyone stupid enough to use them has probably got bigger problems than 
just git-p4 - I hope that's not you though :-)

>
> (2) When a git p4 submit fails, the error message for how to resolve
> it is bogus. The instructions say "Please resolve and submit the
> conflict manually and continue afterwards with git-p4 submit
> --continue", but when I do that, I get:
>
> $ git p4 submit --continue
> Usage: git-p4 submit [options] [name of git branch to submit into
> perforce depot]
> git-p4: error: no such option: --continue

Yes, that _is_ annoying.

>
> Ugh.
>
> (P.S. If there's a better place to post bug reports, etc., please
> inform. Thanks.)
>
> -Eric
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
