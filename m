From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] builtin-commit: avoid using reduce_heads()
Date: Fri, 26 Sep 2008 03:03:12 +0200
Message-ID: <20080926010312.GE6816@neumann>
References: <20080925235029.GA15837@neumann>
	<1222389359-22191-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 03:04:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj1lD-0001Yh-9C
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 03:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982AbYIZBDQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2008 21:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752853AbYIZBDQ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 21:03:16 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:59062 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004AbYIZBDP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 21:03:15 -0400
Received: from [127.0.1.1] (p5B13352D.dip0.t-ipconnect.de [91.19.53.45])
	by mrelayeu.kundenserver.de (node=mrelayeu5) with ESMTP (Nemesis)
	id 0ML25U-1Kj1jl1W4T-00068S; Fri, 26 Sep 2008 03:03:13 +0200
Content-Disposition: inline
In-Reply-To: <1222389359-22191-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Provags-ID: V01U2FsdGVkX182Mje+QtvUHJ66iLiSvFksS1hyV6trc6XP4p2
 fxOadFs74z+NB90TYtpWQQZAMe2gcrAl5xrHuXzut2tjX8/0Hg
 6MUOF6h3QT3ATQtiSsBGw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96823>

Szia Mikl=F3s,

On Fri, Sep 26, 2008 at 02:35:59AM +0200, Miklos Vajna wrote:
> reduce_heads() can filter "duplicated" parents, where "duplicated"
> means: A is duplicated if both A and B are parent candidates and A is
> reachable from B. Doing so in builtin-merge makes sense, but not in
> builtin-commit, because this breaks git merge --no-commit --no-ff.

> Here is a patch that fixes the problem for me.

Thanks for the quick response.  While your patch does fix the bug I
reported, unfortunately it introduces a new one:  t7502-commit.sh
fails at me with the following:


*   ok 17: a SIGTERM should break locks

* expecting success:=20

        git rev-parse second master >expect &&
        test_must_fail git merge second master &&
        git checkout master g &&
        EDITOR=3D: git commit -a &&
        git cat-file commit HEAD | sed -n -e "s/^parent //p" -e
"/^$/q" >actual &&
        test_cmp expect actual


Already up-to-date with 1ae92d674ba95768a00bace571f5ef295ff1696b
Trying simple merge with 9af21aa779d9e148680be525ce161baa37e4bdec
Simple merge did not work, trying automatic merge.
Auto-merging g
ERROR: Merge conflict in g
fatal: merge program failed
Automatic merge failed; fix conflicts and then commit the result.
Created commit 45a4b2b: Merge branches 'second' and 'master' into
second
--- expect      2008-09-26 00:59:42.000000000 +0000
+++ actual      2008-09-26 00:59:42.000000000 +0000
@@ -1,2 +1,3 @@
 1ae92d674ba95768a00bace571f5ef295ff1696b
+1ae92d674ba95768a00bace571f5ef295ff1696b
 9af21aa779d9e148680be525ce161baa37e4bdec
* FAIL 18: Hand committing of a redundant merge removes dups
       =20
       =20
                git rev-parse second master >expect &&
                test_must_fail git merge second master &&
                git checkout master g &&
                EDITOR=3D: git commit -a &&
                git cat-file commit HEAD | sed -n -e "s/^parent //p"
-e "/^$/q" >actual &&
                test_cmp expect actual
       =20
       =20

* failed 1 among 18 test(s)
make: *** [t7502-commit.sh] Error 1


Regards,
G=E1bor
