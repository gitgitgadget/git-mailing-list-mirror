From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Add unit test for check_cherry_pick
Date: Fri, 3 Sep 2010 13:48:51 -0700
Message-ID: <20100903204851.GA16831@dcvr.yhbt.net>
References: <AANLkTikuY28wwccxekDXD1WGtaOoF3JG7ZBfm6vjapwt@mail.gmail.com> <1283539935-14672-1-git-send-email-stevenrwalter@gmail.com> <AANLkTikjGgzOxNz-Fepcg2ALqdWurzMyQUmRgqyxQN5L@mail.gmail.com> <AANLkTik5kcD1reuGfq4k_Oidkx00MY8E+Ucf+Ef_gCDD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 22:48:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrdBx-0007Js-Bn
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 22:48:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757335Ab0ICUsw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 16:48:52 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60707 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752874Ab0ICUsw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 16:48:52 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4571F677;
	Fri,  3 Sep 2010 20:48:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <AANLkTik5kcD1reuGfq4k_Oidkx00MY8E+Ucf+Ef_gCDD@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155272>

Steven Walter <stevenrwalter@gmail.com> wrote:
> On Fri, Sep 3, 2010 at 3:12 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> > On Fri, Sep 3, 2010 at 18:52, Steven Walter <stevenrwalter@gmail.co=
m> wrote:
> >> +GIT_SVN_LC_ALL=3D${LC_ALL:-$LANG}
> >
> > What's this about?
>=20
> I'll admit that I copied these from t9100.  I assumed they were
> necessary for correct operation.  If that's not the case, then they
> can be removed.

Hi Steven, I've squashed your test case along with the following change
and pushed the original commit up to git://git.bogomips.org/git-svn

Here's the intermediate diff -w of changes I made
(all space indentations were convert to tabs, too):

diff --git a/t/t9157-git-svn-fetch-merge.sh b/t/t9157-git-svn-fetch-mer=
ge.sh
index 1c87986..da582c5 100644
--- a/t/t9157-git-svn-fetch-merge.sh
+++ b/t/t9157-git-svn-fetch-merge.sh
@@ -4,27 +4,13 @@
 #
=20
 test_description=3D'git svn merge detection'
-
-GIT_SVN_LC_ALL=3D${LC_ALL:-$LANG}
-
 . ./lib-git-svn.sh
=20
-say 'define NO_SVN_TESTS to skip git svn tests'
-
-case "$GIT_SVN_LC_ALL" in
-*.UTF-8)
-	test_set_prereq UTF8
-	;;
-*)
-	say "UTF-8 locale not set, some tests skipped ($GIT_SVN_LC_ALL)"
-	;;
-esac
-
-test_expect_success \
-    'initialize source svn repo' '
+test_expect_success 'initialize source svn repo' '
         svn_cmd mkdir -m x "$svnrepo"/trunk &&
         svn_cmd mkdir -m x "$svnrepo"/branches &&
         svn_cmd co "$svnrepo"/trunk "$SVN_TREE" &&
+	(
 	cd "$SVN_TREE" &&
 	touch foo &&
 	svn add foo &&
@@ -49,17 +35,16 @@ test_expect_success \
 	svn switch "$svnrepo"/trunk &&
 	svn merge "$svnrepo"/branches/branch2 &&
 	svn resolved baz &&
-	svn commit -m "merge branch2" &&
-	cd .. &&
-	rm -rf "$SVN_TREE"'
+		svn commit -m "merge branch2"
+	) &&
+	rm -rf "$SVN_TREE"
+'
=20
-test_expect_success \
-    'clone svn repo' '
+test_expect_success 'clone svn repo' '
         git svn init -s "$svnrepo" &&
-	git svn fetch'
+	git svn fetch
+'
=20
-test_expect_success \
-    'verify merge commit' '
-        git rev-parse HEAD^2'
+test_expect_success 'verify merge commit' 'git rev-parse HEAD^2'
=20
 test_done

--=20
Eric Wong
