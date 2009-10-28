From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] Teach 'git merge' and 'git pull' the option --ff-only
Date: Wed, 28 Oct 2009 23:15:29 +0100
Message-ID: <4AE8C281.50104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 23:15:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Gnq-0002hI-Ed
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 23:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482AbZJ1WP2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 18:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753058AbZJ1WP2
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 18:15:28 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:45534 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbZJ1WP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 18:15:27 -0400
Received: by ewy4 with SMTP id 4so1251447ewy.37
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 15:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=nWOwyQv62gBJYnWgqn27GVGwVDD+ua6KeNX7YXAZtXI=;
        b=xAYvoi2Kjtxzjt9RaO6mnWcIoqIhiJZh1XSSp3TBTGGgkcHlfa0BaYZ/u8Yp82XSB9
         OAa3ZYIP0JK/Ld8qmfJ3PTiGMOkGDcfD95d+orkKEwtyZR25KE0KmNMx4l9u4gBNMHUo
         ORAiSrEwKMY1z351TT3FA00MQ5dY7d3LjUC3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=KnkwNkLKIuIoKcOCaqf4vQpx6zUgWmR5pTFenY3a80+8EzjktrNHwc7Nxxkp8DuWkA
         6G2uXUKGWpu2pqTFsRcuYI+AVX7PQoTwqiYvjTGVnN8urDlQJePmkw4oj8KGSNnRAZ5x
         5iEyA0TNcMTtOD3VK2Yw/cI/LQuea+kK2bfm4=
Received: by 10.211.172.8 with SMTP id z8mr5599936ebo.92.1256768131457;
        Wed, 28 Oct 2009 15:15:31 -0700 (PDT)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 10sm4573037eyd.8.2009.10.28.15.15.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 15:15:30 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131503>

=46or convenience in scripts and aliases, add the option
--ff-only to only allow fast-forwards.

Acknowledgements: I did look at Yuval Kogman's earlier
patch (107768 in gmane), mainly as shortcut to find my
way in the code, but I did not copy anything directly.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
When I started to use git earlier this year, I was suprised
that there was a --no-ff option but no --ff-only option.

I saw in the mailing list archive at gmane that there has
been two previous attempts to implement --ff-only. The first
patch was made to the git-merge.sh script (before
builtin-merge.c was created). As far as I understand it,
the author of the patch said he would send some corrections
of the patch, but he never did, and nothing more happened.

So here is my patch, the third attempt.

 Documentation/merge-options.txt |    4 ++++
 builtin-merge.c                 |   16 ++++++++++++++--
 git-pull.sh                     |    7 +++++--
 t/t7600-merge.sh                |   29 +++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-opti=
ons.txt
index adadf8e..fbf8976 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -60,6 +60,10 @@
 	a fast-forward, only update the branch pointer. This is
 	the default behavior of git-merge.
=20
+--ff-only::
+	Refuse to merge unless the merge can be resolved as a
+	fast-forward.
+
 -s <strategy>::
 --strategy=3D<strategy>::
 	Use the given merge strategy; can be supplied more than
diff --git a/builtin-merge.c b/builtin-merge.c
index b6b8428..298adfb 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -43,6 +43,7 @@ static const char * const builtin_merge_usage[] =3D {
=20
 static int show_diffstat =3D 1, option_log, squash;
 static int option_commit =3D 1, allow_fast_forward =3D 1;
+static int fast_forward_only;
 static int allow_trivial =3D 1, have_message;
 static struct strbuf merge_msg;
 static struct commit_list *remoteheads;
@@ -167,6 +168,8 @@ static struct option builtin_merge_options[] =3D {
 		"perform a commit if the merge succeeds (default)"),
 	OPT_BOOLEAN(0, "ff", &allow_fast_forward,
 		"allow fast forward (default)"),
+	OPT_BOOLEAN(0, "ff-only", &fast_forward_only,
+		"abort if fast forward is not possible"),
 	OPT_CALLBACK('s', "strategy", &use_strategies, "strategy",
 		"merge strategy to use", option_parse_strategy),
 	OPT_CALLBACK('m', "message", &merge_msg, "message",
@@ -874,6 +877,9 @@ int cmd_merge(int argc, const char **argv, const ch=
ar *prefix)
 		option_commit =3D 0;
 	}
=20
+	if (!allow_fast_forward && fast_forward_only)
+		die("You cannot combine --no-ff with --ff-only.");
+
 	if (!argc)
 		usage_with_options(builtin_merge_usage,
 			builtin_merge_options);
@@ -969,8 +975,11 @@ int cmd_merge(int argc, const char **argv, const c=
har *prefix)
 	}
=20
 	for (i =3D 0; i < use_strategies_nr; i++) {
-		if (use_strategies[i]->attr & NO_FAST_FORWARD)
+		if (use_strategies[i]->attr & NO_FAST_FORWARD) {
 			allow_fast_forward =3D 0;
+			if (fast_forward_only)
+				die("You cannot combine --ff-only with the merge strategy '%s'.", =
use_strategies[i]->name);
+		}
 		if (use_strategies[i]->attr & NO_TRIVIAL)
 			allow_trivial =3D 0;
 	}
@@ -1040,7 +1049,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		 * only one common.
 		 */
 		refresh_cache(REFRESH_QUIET);
-		if (allow_trivial) {
+		if (allow_trivial && !fast_forward_only) {
 			/* See if it is really trivial. */
 			git_committer_info(IDENT_ERROR_ON_NO_NAME);
 			printf("Trying really trivial in-index merge...\n");
@@ -1079,6 +1088,9 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		}
 	}
=20
+	if (fast_forward_only)
+		die("Not possible to fast forward, aborting.");
+
 	/* We are going to make a new commit. */
 	git_committer_info(IDENT_ERROR_ON_NO_NAME);
=20
diff --git a/git-pull.sh b/git-pull.sh
index fc78592..37f3d93 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -16,7 +16,8 @@ cd_to_toplevel
 test -z "$(git ls-files -u)" ||
 	die "You are in the middle of a conflicted merge."
=20
-strategy_args=3D diffstat=3D no_commit=3D squash=3D no_ff=3D log_arg=3D=
 verbosity=3D
+strategy_args=3D diffstat=3D no_commit=3D squash=3D no_ff=3D ff_only=3D
+log_arg=3D verbosity=3D
 curr_branch=3D$(git symbolic-ref -q HEAD)
 curr_branch_short=3D$(echo "$curr_branch" | sed "s|refs/heads/||")
 rebase=3D$(git config --bool branch.$curr_branch_short.rebase)
@@ -45,6 +46,8 @@ do
 		no_ff=3D--ff ;;
 	--no-ff)
 		no_ff=3D--no-ff ;;
+	--ff-only)
+		ff_only=3D--ff-only ;;
 	-s=3D*|--s=3D*|--st=3D*|--str=3D*|--stra=3D*|--strat=3D*|--strate=3D*=
|\
 		--strateg=3D*|--strategy=3D*|\
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
@@ -215,5 +218,5 @@ merge_name=3D$(git fmt-merge-msg $log_arg <"$GIT_DI=
R/FETCH_HEAD") || exit
 test true =3D "$rebase" &&
 	exec git-rebase $diffstat $strategy_args --onto $merge_head \
 	${oldremoteref:-$merge_head}
-exec git-merge $diffstat $no_commit $squash $no_ff $log_arg $strategy_=
args \
+exec git-merge $diffstat $no_commit $squash $no_ff $ff_only $log_arg $=
strategy_args \
 	"$merge_name" HEAD $merge_head $verbosity
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index e5b210b..d696ea9 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -243,6 +243,16 @@ test_expect_success 'merge c0 with c1' '
=20
 test_debug 'gitk --all'
=20
+test_expect_success 'merge c0 with c1 with --ff-only' '
+	git reset --hard c0 &&
+	git merge --ff-only c1 &&
+	git merge --ff-only HEAD c0 c1 &&
+	verify_merge file result.1 &&
+	verify_head "$c1"
+'
+
+test_debug 'gitk --all'
+
 test_expect_success 'merge c1 with c2' '
 	git reset --hard c1 &&
 	test_tick &&
@@ -263,6 +273,14 @@ test_expect_success 'merge c1 with c2 and c3' '
=20
 test_debug 'gitk --all'
=20
+test_expect_success 'failing merges with --ff-only' '
+	git reset --hard c1 &&
+	test_tick &&
+	test_must_fail git merge --ff-only c2 &&
+	test_must_fail git merge --ff-only c3 &&
+	test_must_fail git merge --ff-only c2 c3
+'
+
 test_expect_success 'merge c0 with c1 (no-commit)' '
 	git reset --hard c0 &&
 	git merge --no-commit c1 &&
@@ -432,6 +450,17 @@ test_expect_success 'combining --squash and --no-f=
f is refused' '
 	test_must_fail git merge --no-ff --squash c1
 '
=20
+test_expect_success 'combining --ff-only and --no-ff is refused' '
+	test_must_fail git merge --ff-only --no-ff c1 &&
+	test_must_fail git merge --no-ff --ff-only c1
+'
+
+test_expect_success 'combining --ff-only with certain merge strategies=
 is refused' '
+	git reset --hard c0 &&
+	test_must_fail git merge --ff-only --strategy=3Dours c1 &&
+	test_must_fail git merge --ff-only --strategy=3Dsubtree c1
+'
+
 test_expect_success 'merge c0 with c1 (ff overrides no-ff)' '
 	git reset --hard c0 &&
 	git config branch.master.mergeoptions "--no-ff" &&
--=20
1.6.5.1.69.g36942
