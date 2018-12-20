Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 255A31F405
	for <e@80x24.org>; Thu, 20 Dec 2018 19:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389486AbeLTTpL (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 14:45:11 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38561 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389287AbeLTTpD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 14:45:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so3516191wml.3
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 11:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K+0ukJY62ilbYzGfOmqQX2KF/iHJSOtry09abN810cY=;
        b=llGJd427pGmXBnYFYC9fCvYdTEvvjsqFgJvayuT0f81gnCiqlgjnsoLL2Awg1oxI7f
         u388Tk/fcFj/LaPI6vQD5XHY+avli5j5uGCX/iVRyJT+jwjdqBcAtG4zqjrsxrr9crGF
         Jm7NTTGUJu41ZDlbzlY2a+caNzsvwGDmugswIf/YftiFAODLmO2mRjvwkaQs++8LY47v
         VSN1e+xnMv5AFL57uzM+wJW4uVt+840r07zOGieYELAUrAUYxVk7CeURyY8AbuWu8qKm
         UjoQDF2J2y/tk9x1dDE7NQaeAvV9sama4ZgEz4b23YpuV04LdWdXTJuE4oK6C4/rlOcd
         IiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K+0ukJY62ilbYzGfOmqQX2KF/iHJSOtry09abN810cY=;
        b=l3XNuKnBwP4bWV0JKSEhtGDXXB9Cev95ShTQft9O7N/KZ0CQiw1wlEN1IPOi6sole2
         akoux1CzrZfvpbwZVJF1gkdUNrT5duJ07lMeFoA/Y5m6PEkiSUwSoU910AAzsJ4QQl2T
         0r272NxsLOGiM2jbqF6F0cfACCYW/s7VFHLlFCdLFeg8CVrXlxN8SuD+XweUfCvL+oEM
         wuEpIGveJanDXnRm/T5eTjyVnvNc2BvENNtmjzLXYi14sKzEbxYjvPgzw3X7SZEoigHn
         O4yGwtzS+eVSmaRgDVk16y2KfEKzdw9/fgAByaVKO3f+u1cVMqqlp53ooY+KWY48O2WL
         HM+w==
X-Gm-Message-State: AA+aEWb4M+gI617y/5kklEWk96hj9j8bJNvaiZ+7qqElIob/X3HJK6sT
        UbmATGoBNYqf7X3RIHBkDyi9E/7ehas=
X-Google-Smtp-Source: AFSGD/WglduUu2p3nYFd7a+CpeF8g5JjzzbJSsrDPABmKrkS6QQttX1LL3F/fGTiDKSiWew7uYfUdA==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr12444646wmc.87.1545335100992;
        Thu, 20 Dec 2018 11:45:00 -0800 (PST)
Received: from sebi-laptop.tendawifi.com ([188.24.227.76])
        by smtp.gmail.com with ESMTPSA id j129sm7587267wmb.39.2018.12.20.11.45.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 11:45:00 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH v12 13/26] stash: convert pop to builtin
Date:   Thu, 20 Dec 2018 21:44:29 +0200
Message-Id: <08bacf490dfa766fd5f6b35ac3fd96f37242c52b.1545331726.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.20.1.336.g43b67505b2.dirty
In-Reply-To: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Teichroeb <joel@teichroeb.net>

Add stash pop to the helper and delete the pop_stash, drop_stash,
assert_stash_ref functions from the shell script now that they
are no longer needed.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 builtin/stash--helper.c | 39 +++++++++++++++++++++++++++++++++-
 git-stash.sh            | 47 ++---------------------------------------
 2 files changed, 40 insertions(+), 46 deletions(-)

diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
index 68b65165e4..d7ff78784b 100644
--- a/builtin/stash--helper.c
+++ b/builtin/stash--helper.c
@@ -13,7 +13,7 @@
 
 static const char * const git_stash_helper_usage[] = {
 	N_("git stash--helper drop [-q|--quiet] [<stash>]"),
-	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
+	N_("git stash--helper ( pop | apply ) [--index] [-q|--quiet] [<stash>]"),
 	N_("git stash--helper branch <branchname> [<stash>]"),
 	N_("git stash--helper clear"),
 	NULL
@@ -24,6 +24,11 @@ static const char * const git_stash_helper_drop_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_helper_pop_usage[] = {
+	N_("git stash--helper pop [--index] [-q|--quiet] [<stash>]"),
+	NULL
+};
+
 static const char * const git_stash_helper_apply_usage[] = {
 	N_("git stash--helper apply [--index] [-q|--quiet] [<stash>]"),
 	NULL
@@ -543,6 +548,36 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int pop_stash(int argc, const char **argv, const char *prefix)
+{
+	int ret;
+	int index = 0;
+	int quiet = 0;
+	struct stash_info info;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
+		OPT_BOOL(0, "index", &index,
+			 N_("attempt to recreate the index")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_helper_pop_usage, 0);
+
+	if (get_stash_info(&info, argc, argv))
+		return -1;
+
+	assert_stash_ref(&info);
+	if ((ret = do_apply_stash(prefix, &info, index, quiet)))
+		printf_ln(_("The stash entry is kept in case "
+			    "you need it again."));
+	else
+		ret = do_drop_stash(prefix, &info, quiet);
+
+	free_stash_info(&info);
+	return ret;
+}
+
 static int branch_stash(int argc, const char **argv, const char *prefix)
 {
 	int ret;
@@ -607,6 +642,8 @@ int cmd_stash__helper(int argc, const char **argv, const char *prefix)
 		return !!clear_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "drop"))
 		return !!drop_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "pop"))
+		return !!pop_stash(argc, argv, prefix);
 	else if (!strcmp(argv[0], "branch"))
 		return !!branch_stash(argc, argv, prefix);
 
diff --git a/git-stash.sh b/git-stash.sh
index 67db321a4c..8a9f907aa9 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -571,50 +571,6 @@ assert_stash_like() {
 	}
 }
 
-is_stash_ref() {
-	is_stash_like "$@" && test -n "$IS_STASH_REF"
-}
-
-assert_stash_ref() {
-	is_stash_ref "$@" || {
-		args="$*"
-		die "$(eval_gettext "'\$args' is not a stash reference")"
-	}
-}
-
-apply_stash () {
-	cd "$START_DIR"
-	git stash--helper apply "$@"
-	res=$?
-	cd_to_toplevel
-	return $res
-}
-
-pop_stash() {
-	assert_stash_ref "$@"
-
-	if apply_stash "$@"
-	then
-		drop_stash "$@"
-	else
-		status=$?
-		say "$(gettext "The stash entry is kept in case you need it again.")"
-		exit $status
-	fi
-}
-
-drop_stash () {
-	assert_stash_ref "$@"
-
-	git reflog delete --updateref --rewrite "${REV}" &&
-		say "$(eval_gettext "Dropped \${REV} (\$s)")" ||
-		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
-
-	# clear_stash if we just dropped the last stash entry
-	git rev-parse --verify --quiet "$ref_stash@{0}" >/dev/null ||
-	clear_stash
-}
-
 test "$1" = "-p" && set "push" "$@"
 
 PARSE_CACHE='--not-parsed'
@@ -672,7 +628,8 @@ drop)
 	;;
 pop)
 	shift
-	pop_stash "$@"
+	cd "$START_DIR"
+	git stash--helper pop "$@"
 	;;
 branch)
 	shift
-- 
2.20.1.441.g764a526393

