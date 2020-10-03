Return-Path: <SRS0=BObu=DK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8ABAC4363D
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 18:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69DFB206DD
	for <git@archiver.kernel.org>; Sat,  3 Oct 2020 18:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkXoI6U4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgJCSd3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Oct 2020 14:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgJCSd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Oct 2020 14:33:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF8EC0613D0
        for <git@vger.kernel.org>; Sat,  3 Oct 2020 11:33:28 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id t17so4943486wmi.4
        for <git@vger.kernel.org>; Sat, 03 Oct 2020 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=05RcirL3x+pySjkh9Uh0YiX0PKkSyqwsAlHdUJEZWkE=;
        b=fkXoI6U4PZAU3XO2XaGthrU+yCwAHoSS0szg5COYS6Eyf52t1JnDENq7TV57S1mRr5
         5xut1xKpAYpSCoEItgcdlkyJPRj79cN89xkyuAMYRQILXFRHStDG5Df0HCgadE8VAtyK
         NqQqjW4DR7k8XLNQJTUk77VcHEXE6qWUigaf27GoIlxm6KxC3zIKWuNSSaj+BvM2oH6W
         HDnPqnZcJEVtJyEEq67DZgSCIQDmuR81gwsJ8XWLjo2I8D4UVwu0XGqwGs7ueFmGqIx5
         D5Vg4Mc1ISbpgJNfjrXijy8Z0Ah8EsgO4jP7or6u2+aeq53ZWMU7lHjnS1yF/wV6cUvX
         fe5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=05RcirL3x+pySjkh9Uh0YiX0PKkSyqwsAlHdUJEZWkE=;
        b=FDTmpOSE5yFhKVWEQsLg4aknGhmevh/Yi/BJmzAgpx5XB84JhN9YiEBFKoiWx23Pz6
         GQc40wO2pWruICf3o0tUoOAckh5Zu4FAaRsbyrW0cofXYEuT5j6jhx5JC0JtkCiJ97o7
         SbfnaZc9gjFOjYsaGBR/eqpufAYE2ccu1DcG5m+sqHgWkYveGo4VxTOdTlIsNxxIJufE
         7Txsb6Qjx8UFGum7ZMObjgdtNE0vJDKzv9dSEaFgC5wMdwcFBdEri7IcT9JqIAQ2VV4J
         cMp650Kg8d6EKEk3Zy+Te7z9zVqGGGjjUuCFewBV26dMzrQHmz/vf14LLSEKEXkyb5YD
         Trxg==
X-Gm-Message-State: AOAM533/KywK+n9LOb7RkHChNmEJkn+lFgY9yR37NRwva8361ZSj7sad
        Gf/U8y5YuBqmvwaEy9mw3U7lMfk9tIQ=
X-Google-Smtp-Source: ABdhPJy2kY5WqVTMrwFq06hjA4LO+mgPW/xNoEsoR+vnJ56aW+qBjDV3CtBH+YaMJE/qHI/jVbwv5Q==
X-Received: by 2002:a1c:4c05:: with SMTP id z5mr8340324wmf.47.1601750005485;
        Sat, 03 Oct 2020 11:33:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y1sm6038182wmi.36.2020.10.03.11.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 11:33:24 -0700 (PDT)
Message-Id: <pull.741.git.1601750003858.gitgitgadget@gmail.com>
From:   "Nico Weber via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 03 Oct 2020 18:33:23 +0000
Subject: [PATCH] bisect: add a --verify flag to `bisect run`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nico Weber <thakis@chromium.org>, Nico Weber <thakis@chromium.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nico Weber <thakis@chromium.org>

If it's passed, then `git bisect run --verify script` will first
check out the good revision and verify that the script passes there,
then check out the bad revision and verify that it fails there,
and only then start the actual `git bisect run script`.

We use `git bisect run` heavily for bisecting bugs in LLVM when using
clang to build Chromium. We sometimes end up with run scripts that are
broken in some way, either by missing the +x bit, or in more subtle
ways, and this adds a simple, low conceptual overhead way to smoke check
the run script before starting a bisect that could run for a day or two.

Signed-off-by: Nico Weber <thakis@chromium.org>
---
    bisect: add a --verify flag to bisect run
    
    If it's passed, then git bisect run --verify script will first check out
    the good revision and verify that the script passes there, then check
    out the bad revision and verify that it fails there, and only then start
    the actual git bisect run script.
    
    We use git bisect run heavily for bisecting bugs in LLVM when using
    clang to build Chromium. We sometimes end up with run scripts that are
    broken in some way, either by missing the +x bit, or in more subtle
    ways, and this adds a simple, low conceptual overhead way to smoke check
    the run script before starting a bisect that could run for a day or two.
    
    Signed-off-by: Nico Weber thakis@chromium.org [thakis@chromium.org]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-741%2Fnico%2Frunverifyforupstreaming-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-741/nico/runverifyforupstreaming-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/741

 Documentation/git-bisect.txt |  12 +++-
 git-bisect.sh                | 110 ++++++++++++++++++++++++++++++++++-
 t/t6030-bisect-porcelain.sh  |  16 +++++
 3 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index fbb39fbdf5..37658d8ed8 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -26,7 +26,7 @@ on the subcommand:
  git bisect (visualize|view)
  git bisect replay <logfile>
  git bisect log
- git bisect run <cmd>...
+ git bisect run [--verify] <cmd>...
  git bisect help
 
 This command uses a binary search algorithm to find which commit in
@@ -93,7 +93,6 @@ Eventually there will be no more revisions left to inspect, and the
 command will print out a description of the first bad commit. The
 reference `refs/bisect/bad` will be left pointing at that commit.
 
-
 Bisect reset
 ~~~~~~~~~~~~
 
@@ -317,7 +316,7 @@ If you have a script that can tell if the current source code is good
 or bad, you can bisect by issuing the command:
 
 ------------
-$ git bisect run my_script arguments
+$ git bisect run [--verify] my_script arguments
 ------------
 
 Note that the script (`my_script` in the above example) should exit
@@ -376,6 +375,13 @@ ignored.
 This option is particularly useful in avoiding false positives when a merged
 branch contained broken or non-buildable commits, but the merge itself was OK.
 
+--verify::
++
+Before the actual bisect run, check out the current bad revision and
+verify that the script exits with a code between 1 and 127 (inclusive),
+except 125, then check out the current good revision and verify that
+the script exits with code 0. If not, abort the bisect run.
+
 EXAMPLES
 --------
 
diff --git a/git-bisect.sh b/git-bisect.sh
index 2f60fefcfa..99ac01fb55 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -26,7 +26,7 @@ git bisect replay <logfile>
 	replay bisection log.
 git bisect log
 	show bisect log.
-git bisect run <cmd>...
+git bisect run [--verify | --no-verify] <cmd>...
 	use <cmd>... to automatically bisect.
 
 Please use "git help bisect" to get the full man page.'
@@ -38,6 +38,8 @@ _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 TERM_BAD=bad
 TERM_GOOD=good
+CURRENT_BISECT_BAD=
+CURRENT_BISECT_GOOD=
 
 bisect_head()
 {
@@ -215,6 +217,7 @@ bisect_replay () {
 		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
 		if test "$git" = "git-bisect"
 		then
+			tail="$rev"
 			rev="$command"
 			command="$bisect"
 		fi
@@ -237,7 +240,112 @@ bisect_replay () {
 	bisect_auto_next
 }
 
+get_current_bisect_bounds () {
+	test -s "$GIT_DIR/BISECT_LOG" || die "$(gettext "We are not bisecting.")"
+	oIFS="$IFS" IFS="$IFS$(printf '\015')"
+	while read git bisect command rev tail
+	do
+		test "$git $bisect" = "git bisect" || test "$git" = "git-bisect" || continue
+		if test "$git" = "git-bisect"
+		then
+			tail="$rev"
+			rev="$command"
+			command="$bisect"
+		fi
+		get_terms
+		git bisect--helper --check-and-set-terms "$command" "$TERM_GOOD" "$TERM_BAD" || exit
+		get_terms
+		case "$command" in
+		skip)
+			;;
+		start)
+			CURRENT_BISECT_BAD="$rev"
+			CURRENT_BISECT_GOOD="$tail"
+			;;
+		"$TERM_GOOD")
+			CURRENT_BISECT_GOOD="$rev" ;;
+		"$TERM_BAD")
+			CURRENT_BISECT_BAD="$rev" ;;
+		*)
+			die "$(gettext "?? what are you talking about?")" ;;
+		esac
+	done <"$GIT_DIR/BISECT_LOG"
+	IFS="$oIFS"
+}
+
 bisect_run () {
+	verify=
+	while test $# -ne 0
+	do
+		case "$1" in
+		--verify)
+			verify=t
+			;;
+		--no-verify)
+			verify=
+			;;
+	--)
+			shift
+			break
+			;;
+		-*)
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
+	if [ -n "$verify" ]; then
+		git rev-parse --verify -q BISECT_HEAD > /dev/null && die "$(gettext "bisect run --verify is incompatible with --no-checkout")"
+
+		get_current_bisect_bounds
+		test -n "$CURRENT_BISECT_BAD" || die "$(gettext "bisect run --verify: no current bad revision")"
+		test -n "$CURRENT_BISECT_GOOD" || die "$(gettext "bisect run --verify: no current good revision")"
+
+		bisected_head=$(bisect_head)
+		rev=$(git rev-parse --verify "$bisected_head") ||
+			die "$(eval_gettext "Bad rev input: \$bisected_head")"
+
+		trap "git checkout -q $rev" 0
+
+		# Check script passes for good rev.
+		command="$@"
+		eval_gettextln "verifying script passes at \$TERM_GOOD rev"
+		eval git checkout -q "$CURRENT_BISECT_GOOD" || die "$(eval_gettext "failed to check out \$TERM_GOOD rev")"
+		"$@"
+		res=$?
+		if [ $res -ne 0 ]
+		then
+			die_with_status $res "$(eval_gettext "aborting: run script fails for \$TERM_GOOD rev")"
+		fi
+
+		# Check script fails orderly for bad rev.
+		command="$@"
+		eval_gettextln "verifying script fails at \$TERM_BAD rev"
+		eval git checkout -q "$CURRENT_BISECT_BAD" || die "$(eval_gettext "failed to check out \$TERM_BAD rev")"
+		"$@"
+		res=$?
+		if [ $res -lt 0 -o $res -ge 128 ]
+		then
+			die "$(eval_gettext "aborting: exit code \$res is < 0 or >= 128")"
+		fi
+		if [ $res -eq 0 ]
+		then
+			die "$(eval_gettext "aborting: run script passes for \$TERM_BAD rev")"
+		fi
+		if [ $res -eq 125 ]
+		then
+			die "$(eval_gettext "aborting: run sript returns 125 (skip) for \$TERM_BAD rev")"
+		fi
+
+		# Check out pre-verify rev again.
+		git checkout -q "$rev"
+		trap '-' 0
+	fi
+
 	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD fail || exit
 
 	test -n "$*" || die "$(gettext "bisect run failed: no command provided.")"
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index b886529e59..acb01dcfff 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -321,6 +321,22 @@ test_expect_success 'bisect run & skip: find first bad' '
 	grep "$HASH6 is the first bad commit" my_bisect_log.txt
 '
 
+test_expect_success 'bisect run --verify: script fails for good rev' '
+	git bisect reset &&
+	git bisect start $HASH7 $HASH1 &&
+	test_must_fail git bisect run --verify false >my_bisect_log3.txt 2>&1 &&
+	test_i18ngrep "aborting: run script fails for good rev" my_bisect_log3.txt
+'
+
+test_expect_success 'bisect run --verify: script passes for bad rev' '
+	git bisect reset &&
+	git bisect start &&
+	git bisect bad $HASH7 &&
+	git bisect good $HASH1 &&
+	test_must_fail git bisect run --verify true >my_bisect_log5.txt 2>&1 &&
+	test_i18ngrep "aborting: run script passes for bad rev" my_bisect_log5.txt
+'
+
 test_expect_success 'bisect skip only one range' '
 	git bisect reset &&
 	git bisect start $HASH7 $HASH1 &&

base-commit: 9bc233ae1cf19a49e51842c7959d80a675dbd1c0
-- 
gitgitgadget
