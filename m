From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Automatic merge failed, fix up by hand
Date: Tue, 23 Aug 2005 17:48:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508231733500.3317@g5.osdl.org>
References: <1124831571.13042.27.camel@firebird.lenb.worldpath.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 02:49:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7jRr-0004es-4E
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 02:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVHXAsy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 20:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbVHXAsx
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 20:48:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4238 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750722AbVHXAsx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 20:48:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7O0mpjA015690
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Aug 2005 17:48:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7O0mocY017809;
	Tue, 23 Aug 2005 17:48:50 -0700
To: Len Brown <len.brown@intel.com>
In-Reply-To: <1124831571.13042.27.camel@firebird.lenb.worldpath.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7694>



On Tue, 23 Aug 2005, Len Brown wrote:
>
> I'm having trouble using git for merging kernel trees.
> 
> git seems to manufacture conflicts in files that
> I never touched, and on some files it completely
> throws up its arms, see "Not handling case" below.

Cool.

You've found a case where git-merge-base finds what appears to be two 
equally good merge candidates, but they really aren't.

The merge candidates are 30e332f3307e9f7718490a706e5ce99f0d3a7b26 and 
3edea4833a1efcd43e1dff082bc8001fdfe74b34.

To see this graphically, do:

	echo 30e332f3307e9f7718490a706e5ce99f0d3a7b26 > .git/refs/tags/selected-merge-base
	echo 3edea4833a1efcd43e1dff082bc8001fdfe74b34 > .git/refs/tags/other-merge-base

	echo 81065e2f415af6c028eac13f481fb9e60a0b487b > .git/refs/tags/linus-head
	echo 702c7e7626deeabb057b6f529167b65ec2eefbdb > .git/refs/tags/lenb-head

	gitk --all

and notice how the not-selected one is:

	Author: Antonino A. Daplas <adaplas@gmail.com>  2005-08-15 06:29:11
	Committer: Linus Torvalds <torvalds@g5.osdl.org>  2005-08-15 09:59:39
	Tags: not-selected

while the selected on is:

	Author: Luming Yu <luming.yu@intel.com>  2005-08-11 21:31:00
	Committer: Len Brown <len.brown@intel.com>  2005-08-15 12:46:58
	Tags: selected

and the reason we chose that one is that it's three hours later than the 
other one, and we don't know any better.

> Not clear how I got into this state -- probably
> something to do with adding commits on branches
> and them git-pull-branch'ing them into the master;
> combined with updating the master from-linus.

No, it's git.

Well, it's git, together with your propensity to merge old work, which 
causes this kind of confusion where there are two "equally good" points to 
choose from as the merge base, and git chose the wrong one because it 
_looked_ newer and there was a recent merge to an old version of my tree. 

Cross-merges cause this, but I'm sure there's a good algorithm for 
selecting _which_ of the two interesting commits to pick.

Give me a moment to think about this.

		Linus
