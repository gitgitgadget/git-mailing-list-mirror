From: "Bernhard R. Link" <brlink@debian.org>
Subject: Re: equal-tree-merges as way to make rebases fast-forward-able
Date: Mon, 30 Nov 2009 17:54:37 +0100
Message-ID: <20091130165437.GB3792@pcpool00.mathematik.uni-freiburg.de>
References: <cover.1259524136.git.brlink@debian.org> <4B13EBD6.5060608@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Nov 30 17:54:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF9WN-0007Yc-MN
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 17:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbZK3Qyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 11:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbZK3Qyb
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 11:54:31 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:50022
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752402AbZK3Qyb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 11:54:31 -0500
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF9WH-0006ci-AO
	for git@vger.kernel.org; Mon, 30 Nov 2009 17:54:37 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF9WH-000160-8M
	for git@vger.kernel.org; Mon, 30 Nov 2009 17:54:37 +0100
Content-Disposition: inline
In-Reply-To: <4B13EBD6.5060608@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134119>

* Michael J Gruber <git@drmicha.warpmail.net> [091130 17:00]:
> Bernhard R. Link venit, vidit, dixit 30.11.2009 15:43:
> > o=m=o=o=master
> >    \
> >     a=b=c=d=e=feature
> >
> > with this patch you can do "git rebase -eqt master" and get:
> >
>
> git checkout -b featureprime feature
> git rebase master
> git merge feature # should be trivial
> git branch -M featureprime feature

> [...]

> Note that I always use a temporary branch for rewriting, before renaming
> it to the proper branch name. I haven't checked, but I assume the
> "first-parents" are the way you want them (you want log --first-parent
> --no-merges to show the rewritten commits, right?); otherwise you would
> have to do the merges the other way round.

My problem with that is that --first-parent-only makes no difference
between this and other merges.

Assume the example2

o=master
   \
    a=b=c=d=e=f---
     \            \
      b+f=c'=d'=e'=eqt

would continue with some paralel commits and a merge:

o=master
   \
    a=b=c=d=e=f---       y
     \            \     / \
      b+f=c'=d'=e'=eqt-x   m
                        \ /
                         z

now if you rebase that tree (or want to send it with format-patch),
you either get the old commits multiple times in format-patch
(and possibly causing already resolved conflicts when doing the am
step in rebase), or you use --first-parent-only and might miss z.

Thus the idea to have some way to destinguish this merge from a normal
merge and thus the extra pseudo-merge in example 1 to get the following
merge to merge things with equal tree.

Hochachtungsvoll,
	Bernhard R. Link
-- 
"Never contain programs so few bugs, as when no debugging tools are available!"
	Niklaus Wirth
