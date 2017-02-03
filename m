Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 903CA1F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 02:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752215AbdBCCya (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 21:54:30 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33257 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbdBCCy2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 21:54:28 -0500
Received: by mail-wm0-f67.google.com with SMTP id v77so1211017wmv.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 18:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qA+wvX06qWHw7vnYiUsDwG1zUt5nXRBOGA5m+rtdVtk=;
        b=MObZtopwQkPnEkw8m4scdKYOvjzW0ECFSnqyxvG+lsBPQhw9h6KTbTIMlGl8AU8eDp
         Kgk5U8zXGzxhskHe6OLUYXWBAuFhtCFdd+Xjr4H0b8yEE5FL8Sf1w0NMsKYdxHhnmdvB
         sk6QxgpvgOdFn28psJcJ6qmS/HnoIqZKh9yCGZK7ay4xibdpSCsJx4rlEZkrWuPP+UfL
         az1nLha6XSdd1v/VAca0JS5GK2+6qahE7qBrYNIrcWqEfi3tjV1eme2p4Y2Q/S3yo2jP
         nueqGlc0ItOqjLsQrywkZwhlsGiC6brgsoGCKwMwujwwBfS5j3hz+X1H1A2nvC1mited
         HVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qA+wvX06qWHw7vnYiUsDwG1zUt5nXRBOGA5m+rtdVtk=;
        b=mUMpzXk//6WsTkgj554hqJ78bQl7UA3fqtvEvVc2rQgu50sqaqILQPUcEPeNlyV0dZ
         zm0W0kWpcgfyMy/CIXdrz7fSWdahC9l6y+3i33BEVFh++cLq7ffXvxCKqc6nV48psbdU
         JWCxQUVy1MFhZyjwoZRCKtRxgls+uZGm308D1ukH5Fw3sK/3IplVBWsk1Gmzob99DHbB
         qlJhN90aRkQ6j4nyQvoY/NKdTwy1os+YWYuR49e+FHtLUXXHlQvayi/IDSZT9CX8uoVB
         RxGLB2Dx5Dt/hImUO9H3FX8w8NpWnqf094I1B6II+MvzMGbsGbqzH8VUJER5/pqMXcXz
         +r0A==
X-Gm-Message-State: AIkVDXLa7dDIRnO0/oK1YfzJa0hS8sTb4nvNDhQp1d8G/4qiWNzlqnSD5aNqNRi7gSEDsw==
X-Received: by 10.223.142.208 with SMTP id q74mr10122328wrb.101.1486090466394;
        Thu, 02 Feb 2017 18:54:26 -0800 (PST)
Received: from localhost.localdomain (x590d744d.dyn.telefonica.de. [89.13.116.77])
        by smtp.gmail.com with ESMTPSA id c133sm652291wmd.13.2017.02.02.18.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 18:54:25 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 02/12] completion: wrap __git_refs() for better option parsing
Date:   Fri,  3 Feb 2017 03:53:55 +0100
Message-Id: <20170203025405.8242-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.555.g967c1bcb3
In-Reply-To: <20170203025405.8242-1-szeder.dev@gmail.com>
References: <20170203025405.8242-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

__git_refs() currently accepts two optional positional parameters: a
remote and a flag for 'git checkout's tracking DWIMery.  To fix a
minor bug, and, more importantly, for faster refs completion, this
series will add three more parameters: a prefix, the current word to
be completed and a suffix, i.e. the options accepted by __gitcomp() &
friends, and will change __git_refs() to list only refs matching that
given current word and to add that given prefix and suffix to the
listed refs.

However, __git_refs() is the helper function that is most likely used
in users' custom completion scriptlets for their own git commands, and
we don't want to break those, so

  - we can't change __git_refs()'s default output format, i.e. we
    can't by default append a trailing space to every listed ref,
    meaning that the suffix parameter containing the default trailing
    space would have to be specified on every invocation, and

  - we can't change the position of existing positional parameters
    either, so there would have to be plenty of set-but-empty
    placeholder positional parameters all over the completion script.

Furthermore, with five positional parameters it would be really hard
to remember which position means what.

To keep callsites simple, add the new wrapper function
__git_complete_refs() around __git_refs(), which:

  - instead of positional parameters accepts real '--opt=val'-style
    options and with minimalistic option parsing translates them to
    __git_refs()'s and __gitcomp_nl()'s positional parameters, and

  - includes the '__gitcomp_nl "$(__git_refs ...)" ...' command
    substitution to make its behavior match its name and the behavior
    of other __git_complete_* functions, and to limit future changes
    in this series to __git_refs() and this new wrapper function.

Call this wrapper function instead of __git_refs() wherever possible
throughout the completion script, i.e. when __git_refs()'s output is
fed to __gitcomp_nl() right away without further processing, which
means all callsites except a single one in the __git_refs2() helper.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 102 ++++++++++++++++++++-----------
 t/t9902-completion.sh                  | 106 +++++++++++++++++++++++++++++++++
 2 files changed, 173 insertions(+), 35 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f20d4600c..7f19e2a4f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -354,6 +354,8 @@ __git_tags ()
 #    Can be the name of a configured remote, a path, or a URL.
 # 2: In addition to local refs, list unique branches from refs/remotes/ for
 #    'git checkout's tracking DWIMery (optional; ignored, if set but empty).
+#
+# Use __git_complete_refs() instead.
 __git_refs ()
 {
 	local i hash dir track="${2-}"
@@ -446,6 +448,36 @@ __git_refs ()
 	esac
 }
 
+# Completes refs, short and long, local and remote, symbolic and pseudo.
+#
+# Usage: __git_complete_refs [<option>]...
+# --remote=<remote>: The remote to list refs from, can be the name of a
+#                    configured remote, a path, or a URL.
+# --track: List unique remote branches for 'git checkout's tracking DWIMery.
+# --pfx=<prefix>: A prefix to be added to each ref.
+# --cur=<word>: The current ref to be completed.  Defaults to the current
+#               word to be completed.
+# --sfx=<suffix>: A suffix to be appended to each ref instead of the default
+#                 space.
+__git_complete_refs ()
+{
+	local remote track pfx cur_="$cur" sfx=" "
+
+	while test $# != 0; do
+		case "$1" in
+		--remote=*)	remote="${1##--remote=}" ;;
+		--track)	track="yes" ;;
+		--pfx=*)	pfx="${1##--pfx=}" ;;
+		--cur=*)	cur_="${1##--cur=}" ;;
+		--sfx=*)	sfx="${1##--sfx=}" ;;
+		*)		return 1 ;;
+		esac
+		shift
+	done
+
+	__gitcomp_nl "$(__git_refs "$remote" "$track")" "$pfx" "$cur_" "$sfx"
+}
+
 # __git_refs2 requires 1 argument (to pass to __git_refs)
 __git_refs2 ()
 {
@@ -554,15 +586,15 @@ __git_complete_revlist_file ()
 	*...*)
 		pfx="${cur_%...*}..."
 		cur_="${cur_#*...}"
-		__gitcomp_nl "$(__git_refs)" "$pfx" "$cur_"
+		__git_complete_refs --pfx="$pfx" --cur="$cur_"
 		;;
 	*..*)
 		pfx="${cur_%..*}.."
 		cur_="${cur_#*..}"
-		__gitcomp_nl "$(__git_refs)" "$pfx" "$cur_"
+		__git_complete_refs --pfx="$pfx" --cur="$cur_"
 		;;
 	*)
-		__gitcomp_nl "$(__git_refs)"
+		__git_complete_refs
 		;;
 	esac
 }
@@ -649,21 +681,21 @@ __git_complete_remote_or_refspec ()
 		if [ $lhs = 1 ]; then
 			__gitcomp_nl "$(__git_refs2 "$remote")" "$pfx" "$cur_"
 		else
-			__gitcomp_nl "$(__git_refs)" "$pfx" "$cur_"
+			__git_complete_refs --pfx="$pfx" --cur="$cur_"
 		fi
 		;;
 	pull|remote)
 		if [ $lhs = 1 ]; then
-			__gitcomp_nl "$(__git_refs "$remote")" "$pfx" "$cur_"
+			__git_complete_refs --remote="$remote" --pfx="$pfx" --cur="$cur_"
 		else
-			__gitcomp_nl "$(__git_refs)" "$pfx" "$cur_"
+			__git_complete_refs --pfx="$pfx" --cur="$cur_"
 		fi
 		;;
 	push)
 		if [ $lhs = 1 ]; then
-			__gitcomp_nl "$(__git_refs)" "$pfx" "$cur_"
+			__git_complete_refs --pfx="$pfx" --cur="$cur_"
 		else
-			__gitcomp_nl "$(__git_refs "$remote")" "$pfx" "$cur_"
+			__git_complete_refs --remote="$remote" --pfx="$pfx" --cur="$cur_"
 		fi
 		;;
 	esac
@@ -1061,7 +1093,7 @@ _git_bisect ()
 
 	case "$subcommand" in
 	bad|good|reset|skip|start)
-		__gitcomp_nl "$(__git_refs)"
+		__git_complete_refs
 		;;
 	*)
 		;;
@@ -1083,7 +1115,7 @@ _git_branch ()
 
 	case "$cur" in
 	--set-upstream-to=*)
-		__gitcomp_nl "$(__git_refs)" "" "${cur##--set-upstream-to=}"
+		__git_complete_refs --cur="${cur##--set-upstream-to=}"
 		;;
 	--*)
 		__gitcomp "
@@ -1097,7 +1129,7 @@ _git_branch ()
 		if [ $only_local_ref = "y" -a $has_r = "n" ]; then
 			__gitcomp_nl "$(__git_heads)"
 		else
-			__gitcomp_nl "$(__git_refs)"
+			__git_complete_refs
 		fi
 		;;
 	esac
@@ -1140,18 +1172,18 @@ _git_checkout ()
 	*)
 		# check if --track, --no-track, or --no-guess was specified
 		# if so, disable DWIM mode
-		local flags="--track --no-track --no-guess" track=1
+		local flags="--track --no-track --no-guess" track_opt="--track"
 		if [ -n "$(__git_find_on_cmdline "$flags")" ]; then
-			track=''
+			track_opt=''
 		fi
-		__gitcomp_nl "$(__git_refs '' $track)"
+		__git_complete_refs $track_opt
 		;;
 	esac
 }
 
 _git_cherry ()
 {
-	__gitcomp_nl "$(__git_refs)"
+	__git_complete_refs
 }
 
 _git_cherry_pick ()
@@ -1166,7 +1198,7 @@ _git_cherry_pick ()
 		__gitcomp "--edit --no-commit --signoff --strategy= --mainline"
 		;;
 	*)
-		__gitcomp_nl "$(__git_refs)"
+		__git_complete_refs
 		;;
 	esac
 }
@@ -1216,7 +1248,7 @@ _git_commit ()
 {
 	case "$prev" in
 	-c|-C)
-		__gitcomp_nl "$(__git_refs)"
+		__git_complete_refs
 		return
 		;;
 	esac
@@ -1229,7 +1261,7 @@ _git_commit ()
 		;;
 	--reuse-message=*|--reedit-message=*|\
 	--fixup=*|--squash=*)
-		__gitcomp_nl "$(__git_refs)" "" "${cur#*=}"
+		__git_complete_refs --cur="${cur#*=}"
 		return
 		;;
 	--untracked-files=*)
@@ -1267,7 +1299,7 @@ _git_describe ()
 			"
 		return
 	esac
-	__gitcomp_nl "$(__git_refs)"
+	__git_complete_refs
 }
 
 __git_diff_algorithms="myers minimal patience histogram"
@@ -1453,7 +1485,7 @@ _git_grep ()
 		;;
 	esac
 
-	__gitcomp_nl "$(__git_refs)"
+	__git_complete_refs
 }
 
 _git_help ()
@@ -1621,7 +1653,7 @@ _git_merge ()
 			--rerere-autoupdate --no-rerere-autoupdate --abort --continue"
 		return
 	esac
-	__gitcomp_nl "$(__git_refs)"
+	__git_complete_refs
 }
 
 _git_mergetool ()
@@ -1646,7 +1678,7 @@ _git_merge_base ()
 		return
 		;;
 	esac
-	__gitcomp_nl "$(__git_refs)"
+	__git_complete_refs
 }
 
 _git_mv ()
@@ -1684,7 +1716,7 @@ _git_notes ()
 	,*)
 		case "$prev" in
 		--ref)
-			__gitcomp_nl "$(__git_refs)"
+			__git_complete_refs
 			;;
 		*)
 			__gitcomp "$subcommands --ref"
@@ -1693,7 +1725,7 @@ _git_notes ()
 		;;
 	add,--reuse-message=*|append,--reuse-message=*|\
 	add,--reedit-message=*|append,--reedit-message=*)
-		__gitcomp_nl "$(__git_refs)" "" "${cur#*=}"
+		__git_complete_refs --cur="${cur#*=}"
 		;;
 	add,--*|append,--*)
 		__gitcomp '--file= --message= --reedit-message=
@@ -1712,7 +1744,7 @@ _git_notes ()
 		-m|-F)
 			;;
 		*)
-			__gitcomp_nl "$(__git_refs)"
+			__git_complete_refs
 			;;
 		esac
 		;;
@@ -1750,10 +1782,10 @@ __git_complete_force_with_lease ()
 	--*=)
 		;;
 	*:*)
-		__gitcomp_nl "$(__git_refs)" "" "${cur_#*:}"
+		__git_complete_refs --cur="${cur_#*:}"
 		;;
 	*)
-		__gitcomp_nl "$(__git_refs)" "" "$cur_"
+		__git_complete_refs --cur="$cur_"
 		;;
 	esac
 }
@@ -1829,7 +1861,7 @@ _git_rebase ()
 
 		return
 	esac
-	__gitcomp_nl "$(__git_refs)"
+	__git_complete_refs
 }
 
 _git_reflog ()
@@ -1840,7 +1872,7 @@ _git_reflog ()
 	if [ -z "$subcommand" ]; then
 		__gitcomp "$subcommands"
 	else
-		__gitcomp_nl "$(__git_refs)"
+		__git_complete_refs
 	fi
 }
 
@@ -1986,7 +2018,7 @@ _git_config ()
 		return
 		;;
 	branch.*.merge)
-		__gitcomp_nl "$(__git_refs)"
+		__git_complete_refs
 		return
 		;;
 	branch.*.rebase)
@@ -2460,7 +2492,7 @@ _git_remote ()
 
 _git_replace ()
 {
-	__gitcomp_nl "$(__git_refs)"
+	__git_complete_refs
 }
 
 _git_reset ()
@@ -2473,7 +2505,7 @@ _git_reset ()
 		return
 		;;
 	esac
-	__gitcomp_nl "$(__git_refs)"
+	__git_complete_refs
 }
 
 _git_revert ()
@@ -2489,7 +2521,7 @@ _git_revert ()
 		return
 		;;
 	esac
-	__gitcomp_nl "$(__git_refs)"
+	__git_complete_refs
 }
 
 _git_rm ()
@@ -2597,7 +2629,7 @@ _git_stash ()
 			;;
 		branch,*)
 			if [ $cword -eq 3 ]; then
-				__gitcomp_nl "$(__git_refs)";
+				__git_complete_refs
 			else
 				__gitcomp_nl "$(__git stash list \
 						| sed -n -e 's/:.*//p')"
@@ -2755,7 +2787,7 @@ _git_tag ()
 		fi
 		;;
 	*)
-		__gitcomp_nl "$(__git_refs)"
+		__git_complete_refs
 		;;
 	esac
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index d711bef24..50c534072 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -775,6 +775,112 @@ test_expect_success '__git_refs - unique remote branches for git checkout DWIMer
 	test_cmp expected "$actual"
 '
 
+test_expect_success '__git_complete_refs - simple' '
+	sed -e "s/Z$//g" >expected <<-EOF &&
+	HEAD Z
+	master Z
+	matching-branch Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	matching-tag Z
+	EOF
+	(
+		cur= &&
+		__git_complete_refs &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__git_complete_refs - matching' '
+	sed -e "s/Z$//g" >expected <<-EOF &&
+	matching-branch Z
+	matching-tag Z
+	EOF
+	(
+		cur=mat &&
+		__git_complete_refs &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__git_complete_refs - remote' '
+	sed -e "s/Z$//g" >expected <<-EOF &&
+	HEAD Z
+	branch-in-other Z
+	master-in-other Z
+	EOF
+	(
+		cur=
+		__git_complete_refs --remote=other &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__git_complete_refs - track' '
+	sed -e "s/Z$//g" >expected <<-EOF &&
+	HEAD Z
+	master Z
+	matching-branch Z
+	other/branch-in-other Z
+	other/master-in-other Z
+	matching-tag Z
+	branch-in-other Z
+	master-in-other Z
+	EOF
+	(
+		cur=
+		__git_complete_refs --track &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__git_complete_refs - current word' '
+	sed -e "s/Z$//g" >expected <<-EOF &&
+	matching-branch Z
+	matching-tag Z
+	EOF
+	(
+		cur="--option=mat" &&
+		__git_complete_refs --cur="${cur#*=}" &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__git_complete_refs - prefix' '
+	sed -e "s/Z$//g" >expected <<-EOF &&
+	v1.0..matching-branch Z
+	v1.0..matching-tag Z
+	EOF
+	(
+		cur=v1.0..mat &&
+		__git_complete_refs --pfx=v1.0.. --cur=mat &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__git_complete_refs - suffix' '
+	cat >expected <<-EOF &&
+	HEAD.
+	master.
+	matching-branch.
+	other/branch-in-other.
+	other/master-in-other.
+	matching-tag.
+	EOF
+	(
+		cur= &&
+		__git_complete_refs --sfx=. &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
 test_expect_success 'teardown after ref completion' '
 	git branch -d matching-branch &&
 	git tag -d matching-tag &&
-- 
2.11.0.555.g967c1bcb3

