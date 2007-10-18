From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Howto request: going home in the middle of something?
Date: Thu, 18 Oct 2007 12:29:03 +0100
Message-ID: <200710181229.07106.andyparkins@gmail.com>
References: <200710181144.22655.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jan Wielemaker <wielemak@science.uva.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 18 13:29:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiTZ5-0002fP-Ip
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 13:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756552AbXJRL3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 07:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757305AbXJRL3N
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 07:29:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:14080 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756433AbXJRL3L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 07:29:11 -0400
Received: by ug-out-1314.google.com with SMTP id z38so408806ugc
        for <git@vger.kernel.org>; Thu, 18 Oct 2007 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=c3gfm2WKWu+N4wPARrZcq0CXl40U9703nqRvo2jqzpk=;
        b=eTffU3esmSUeqDLPrRPJCDV1f+dSa6LiNg+B7AtCR+ErIBZHGxK93pjq4bwGviLGxhnAOCpDvw4MADz79aswgEqiJmPmpN6BKZrZZaXe9Ddyfb5/a1+t3/D0B7Mfx3qjWC0QkIAfAiix4cpPBqYTodBmBa4mUpd2yNoppGYMueY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LD1ik0BwM+Oykqds7pAYQdDvxyqkavK3hOglROMTCsdpVTHqUuZ63exucRhwNaYt2aTTFJp6DNlobMWzGIWvXTESDSEqLW0/k9wn0LbeDhGLtlfmMWeM983bVI+9geYCWDtPIZ2ZbOAaCbiLnZUsmBrhBkIMoOJYQZ0u0dU8dUs=
Received: by 10.66.236.13 with SMTP id j13mr1738601ugh.1192706950067;
        Thu, 18 Oct 2007 04:29:10 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id b33sm859229ika.2007.10.18.04.29.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Oct 2007 04:29:09 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <200710181144.22655.wielemak@science.uva.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61518>

On Thursday 2007 October 18, Jan Wielemaker wrote:

> I've somewhere seen it in a mail, but I can't find it anymore. I have a
> bare central (public) repository and clones on various machines I work
> on. We all know it, you're right in the middle of something and it is
> really time to go home. You want to pick up your work at home, but
> without pushing to the shared repository.
>
> I'm sure GIT can do this elegantly, but I'm not yet sure how.  I guess
> Ideally I want "git stash" at work, transfer the stashed changes to my
> other machine and apply them.  How do I do that?
>
> Alternatively, I guess, one can commit at machine A, fetch the commit
> from machine A and continue. I'm still too uncertain about the remote
> access options to work this out properly, but it also feels less
> clean.
>
> How do you deal with this?

I have two remotes (typically) in my .git/config.  One for the real central 
repository and one for the alternate computer.  The two locations (say home 
and work) list the other as a remote.

So; before I go home I do this:

 git commit -b temp -a -m "Hold for transport home"

Then when I get home I do this:

 git fetch work
 git merge work/temp
 git reset HEAD^
 # code code code
 git commit -b temp -a -m "Hold for transport to work"

When I'm finished at home and want to carry on at work:

 git fetch --force home
 git merge home/temp
 git reset HEAD^
 # start coding for the day

Obviously if you do this repeatedly you'd need to tidy up the left over temp 
branches, or ensure that your remote configurations list "+" in the fetch 
lines.  You can also use pushes instead of fetches if you're that way 
inclined, or you have a connection problem in one direction because of a 
firewall.

It's slightly inelegant but it does ensure that nothing is ever accidentally 
lost by overwriting new with newer, which happened a few times in the days 
when I used rsync for copying the working directory between computers.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
