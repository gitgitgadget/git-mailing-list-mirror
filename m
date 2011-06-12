From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v2] revert: Implement --abort processing
Date: Sun, 12 Jun 2011 07:21:45 -0500
Message-ID: <20110612122145.GA20495@elie>
References: <1307774186-14207-1-git-send-email-artagnon@gmail.com>
 <20110611112213.GA25268@elie>
 <BANLkTi=T0wCg1bKzmtQEQ-J-5ogqRZaqRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 12 14:22:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVjfz-00071A-UN
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 14:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356Ab1FLMVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2011 08:21:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35869 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233Ab1FLMVy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2011 08:21:54 -0400
Received: by iwn34 with SMTP id 34so3201608iwn.19
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 05:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=cPY3ybZdpzR2y5js0HS8jec/deGNpswhXKCLUjvY8xc=;
        b=n6HovT3nVrrBnQVUZ+foRPY+NL2X15Bjm+fWO8QF92sEVyBYDZo8WghSaJ+T7AxxRK
         oH/BGreldkUBD4T3Gk77z6uCk3maqOg4Rp15FoIMZxj3i+lUZEtxRG3skyGkfFBTwKNt
         ubhPYJKN6VjfIfBF6Qk5zCkwd/poGz3/bZFgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SY0yKkYQeT2vEuVkuLoWRBJACcFLQjs1cTgGbHxzvNsHR32gcvbSGohgv3CdkCU/o5
         JSzXPwb+3b7RIIvdzVmoLwNnRZVeTcXGRPVChQPw9sKvgkIupHMTXElgLWnuo9Vw9Ibl
         2E19/uc60eygad0+jb6ebELLxeNsTO6ecr76Y=
Received: by 10.42.154.198 with SMTP id r6mr5411840icw.276.1307881313958;
        Sun, 12 Jun 2011 05:21:53 -0700 (PDT)
Received: from elie (adsl-69-209-71-178.dsl.chcgil.sbcglobal.net [69.209.71.178])
        by mx.google.com with ESMTPS id a9sm3897332icy.6.2011.06.12.05.21.51
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Jun 2011 05:21:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=T0wCg1bKzmtQEQ-J-5ogqRZaqRg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175657>

Ramkumar Ramachandra wrote:

> My notion of --abort has changed: I simply want to remove the state
> files for the cherry-pick so that the user can execute more
> cherry-pick/ revert commands.  I didn't think a soft reset would be
> intrusive.

Well, if you understand this part then you can forget most of the
rest of what I said.  Think about this for a second.  New user (or
forgetful, experienced user), has just run

	git cherry-pick HEAD..topic

to integrate the changes from topic in a linear history.  Ran into
conflicts, wanted to give up.  Ran

	git cherry-pick --abort

Would this person expect:

 - that "git diff --cached" would return a pile of changes
 - that "git reset --keep", "git reset --merge", "git checkout",
   "git merge", and various other commands would refuse to do much,
   for fear of clobbering the new "local changes"
 - that the worktree would be unchanged
 - etc

Would they be happy about it?  Just put yourself in their shoes.  A
soft reset is near the most intrusive behavior possible.

And that is a good way to think about the UI for any new facility.  If
you disregard about how flexible it is in abstract, how easy to
implement, how elegant-sounding and just think about a person using it
will find her quality of life improved or worsened, that is (1) a good
sanity-check on a design and (2) basically the only way to explain it
to other people.
