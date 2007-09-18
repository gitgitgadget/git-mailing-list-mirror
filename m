From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Wed, 19 Sep 2007 02:34:52 +1200
Message-ID: <46EFE20C.6010904@vilain.net>
References: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com>	 <20070918005013.GA6368@muzzle>	 <8c5c35580709172312w55613a1bw8cc58b200c526fab@mail.gmail.com>	 <7v4phsxy55.fsf@gitster.siamese.dyndns.org>	 <46EF7EA1.6020402@vilain.net> <46EF9687.6070304@vilain.net>	 <8c5c35580709180419i4500a2d4s8a997d45dd31944e@mail.gmail.com>	 <46EFBB9A.5070404@vilain.net>	 <8c5c35580709180503g24ef6c5hda2877e2215ba58d@mail.gmail.com>	 <46EFD0F8.5050603@vilain.net> <8c5c35580709180701m54810d80nefa4704abb8797dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 16:34:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXe9I-0006w7-G6
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 16:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247AbXIROdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 10:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755303AbXIROdy
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 10:33:54 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:52840 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756090AbXIROdy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 10:33:54 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id D02B023C26E; Wed, 19 Sep 2007 02:33:51 +1200 (NZST)
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id E20FD23C26D;
	Wed, 19 Sep 2007 02:33:47 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <8c5c35580709180701m54810d80nefa4704abb8797dd@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58613>

Lars Hjemli wrote:
> Ok. I'll try to explain why I needed --no-ff in the first place:
>
> I have two git-svn brances, lets call them FEATURE and RELEASE. At one
> point, I did
>   $ git checkout FEATURE
>   $ git merge RELEASE
>   $ git svn dcommit
>
> Now, my coworkers can continue testing/developing on top of the
> subversion branch FEATURE (I'm currently the only git user), knowing
> that every bugfix from RELEASE have been merged.
>
> A few days later, FEATURE is completed and tested and should be
> integrated in RELEASE. I did
>
>   $ git checkout RELEASE
>   $ git merge FEATURE
>   $ git svn dcommit -n
>
> and noticed that git-svn wanted to commit the result to FEATURE, since
> the merge actually was a fast-forward. If this was a a pure git
> environment it would be no problem, but as I needed to get a merge
> revision on top of the subversion RELEASE branch, I was in trouble.
>   

I understand.  But if you could specify a target branch of "RELEASE" to
dcommit (which git-svn might know based on which svn tracking branch it
was branched from), then it should be able to do the same thing that
'svn merge' would do on svn 1.5+, or 'svk sm' does.  Which is to write
to the SVN repository a squash merge, and write svn properties to let
merge-aware svn tools know which SVN revisions are being squashed.

> My options:
> * rebase FEATURE onto RELEASE: this would have duplicated ~150
> revisions from FEATURE onto RELEASE in subversion
>   

Yes, not desirable.

> * merge --squash: this would have created the wanted history in
> subversion, but my git history would have lacked the info that
> everything in FEATURE had been integrated into RELEASE (this could
> have been fixed by editing the grafts file)
>   

This is a current deficiency in git-svn; bidirectional merge tracking is
not there yet.

> * merge --no-ff: this made both the subversion history and my local
> git history reflect what actually happened.
>
> So I went for the --no-ff option.
>
> If this use-case isn't good enough, oh well. I can always carry the
> patch forward in my git repo ;-)
>   

And you'll probably need to keep it around until bidirectional merge
handling is in.

Sam.
