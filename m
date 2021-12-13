Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3156C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 22:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241345AbhLMWDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 17:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242870AbhLMWDl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 17:03:41 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5F1C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 14:03:41 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id k26so16133086pfp.10
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 14:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ghpEcN/aBL16KHkdNgegYzui+CZl6aVvHhD7Ps/emxI=;
        b=mxW1pEN8tXtQHB92T7XqwtlVmypuwPJmMwjhqxFDWDEsPUQ3ikSVriwCVcHO+dIFeT
         /MfJbergY+hvgt3a6Gf7sxHyFMBI/0pxkEXQz1aegsgvdDUutxuszQuh41CtQSbAC4Og
         VRojz6U5u5T5wGs9cKKmUfxjWU1ahCsLQaFWOkiLzEub0xiC00b+KssQqjppiau7eDhQ
         LbCql/Ynfu2AXOmqplJUGxZB5Pakh4cQMzC70UgcMfdlyc31eG+fydBagvG+3AZalVp5
         HMmSVuCrJg5NxCM5kZcrGWUckBglouOlUl9CfjuXKHJQhnictouRXD8nOhPVsOPXXbY9
         J5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ghpEcN/aBL16KHkdNgegYzui+CZl6aVvHhD7Ps/emxI=;
        b=QNJN8q+8+BQ7FfaVvNnyo7wO1atrTMBDukr/iIZFBrt5Dwe9ZnCLwoIrqpZQQv3OH4
         KTz/zHDzB5OcBx6ySRBjP118mYx0GpQ2/VY6P7/V1OtuXHKSMv7xappbQmQLAXCfnaIV
         Ub5ec8unsdHRxU0t5AbrTxEMGmsJoWgtC1RPuB9+zZlfr1iihz6/FA2qAR9b9/DBp/KY
         CasWh0/Blyqdzs0d5oE4tc5F09rZyADh7n6Iu73JLX6oNpj0xyLTDf5rNZrIetAgZsY1
         m+PTmsQl1gPcoJhVBjk3oeOi6BOS4OfVk19EcO9dhkSJ/hyIGR+LtqE/kXjgyGp0mPbs
         emOQ==
X-Gm-Message-State: AOAM532iY6LM+Tgg2kjSn/q88kthLgWeHBPxlnEGcTcvefpHUNDxAqdF
        Gb7tjwTVRUzFdk7Or0EUbReH5N9BZtDirg==
X-Google-Smtp-Source: ABdhPJztvF6qwZMoRksJyZhPcOOYbfcZAZ83KpC9hq56fv//bAO45NLCrVNGioTus/TTFR8O9qYDbQ==
X-Received: by 2002:a63:f90d:: with SMTP id h13mr997963pgi.3.1639433020185;
        Mon, 13 Dec 2021 14:03:40 -0800 (PST)
Received: from jerry-desktop2.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id e14sm14691905pfv.18.2021.12.13.14.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 14:03:39 -0800 (PST)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Jerry Zhang <jerry@skydio.com>
Subject: [PATCH V5 2/2] git-apply: add --allow-empty flag
Date:   Mon, 13 Dec 2021 14:03:27 -0800
Message-Id: <20211213220327.16042-2-jerry@skydio.com>
X-Mailer: git-send-email 2.34.1.186.g7a78fc126e
In-Reply-To: <20211213220327.16042-1-jerry@skydio.com>
References: <20211213220327.16042-1-jerry@skydio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some users or scripts will pipe "git diff"
output to "git apply" when replaying diffs
or commits. In these cases, they will rely
on the return value of "git apply" to know
whether the diff was applied successfully.

However, for empty commits, "git apply" will
fail. This complicates scripts since they
have to either buffer the diff and check
its length, or run diff again with "exit-code",
essentially doing the diff twice.

Add the "--allow-empty" flag to "git apply"
which allows it to handle both empty diffs
and empty commits created by "git format-patch
--always" by doing nothing and returning 0.

Add tests for both with and without --allow-empty.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
V4->V5
- Reorganized into a patch series to capture
dependencies between 2 git apply changes.

 Documentation/git-apply.txt |  6 +++++-
 apply.c                     |  8 ++++++--
 apply.h                     |  1 +
 t/t4126-apply-empty.sh      | 22 ++++++++++++++++++----
 4 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index a32ad64718..b6d77f4206 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -14,11 +14,11 @@ SYNOPSIS
 	  [--allow-binary-replacement | --binary] [--reject] [-z]
 	  [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
 	  [--ignore-space-change | --ignore-whitespace]
 	  [--whitespace=(nowarn|warn|fix|error|error-all)]
 	  [--exclude=<path>] [--include=<path>] [--directory=<root>]
-	  [--verbose | --quiet] [--unsafe-paths] [<patch>...]
+	  [--verbose | --quiet] [--unsafe-paths] [--allow-empty] [<patch>...]
 
 DESCRIPTION
 -----------
 Reads the supplied diff output (i.e. "a patch") and applies it to files.
 When running from a subdirectory in a repository, patched paths
@@ -254,10 +254,14 @@ running `git apply --directory=modules/git-gui`.
 +
 When `git apply` is used as a "better GNU patch", the user can pass
 the `--unsafe-paths` option to override this safety check.  This option
 has no effect when `--index` or `--cached` is in use.
 
+--allow-empty::
+	Don't return error for patches containing no diff. This includes
+	empty patches and patches with commit text only.
+
 CONFIGURATION
 -------------
 
 apply.ignoreWhitespace::
 	Set to 'change' if you want changes in whitespace to be ignored by default.
diff --git a/apply.c b/apply.c
index 9f00f882a2..afc1c6510e 100644
--- a/apply.c
+++ b/apply.c
@@ -4752,12 +4752,14 @@ static int apply_patch(struct apply_state *state,
 		}
 		offset += nr;
 	}
 
 	if (!list && !skipped_patch) {
-		error(_("unrecognized input"));
-		res = -128;
+		if (!state->allow_empty) {
+			error(_("No valid patches in input (allow with \"--allow-empty\")"));
+			res = -128;
+		}
 		goto end;
 	}
 
 	if (state->whitespace_error && (state->ws_error_action == die_on_ws_error))
 		state->apply = 0;
@@ -5081,10 +5083,12 @@ int apply_parse_options(int argc, const char **argv,
 			N_("do not trust the line counts in the hunk headers"),
 			APPLY_OPT_RECOUNT),
 		OPT_CALLBACK(0, "directory", state, N_("root"),
 			N_("prepend <root> to all filenames"),
 			apply_option_parse_directory),
+		OPT_BOOL(0, "allow-empty", &state->allow_empty,
+			N_("don't return error for empty patches")),
 		OPT_END()
 	};
 
 	return parse_options(argc, argv, state->prefix, builtin_apply_options, apply_usage, 0);
 }
diff --git a/apply.h b/apply.h
index da3d95fa50..16202da160 100644
--- a/apply.h
+++ b/apply.h
@@ -64,10 +64,11 @@ struct apply_state {
 	int apply_with_reject;
 	int no_add;
 	int threeway;
 	int unidiff_zero;
 	int unsafe_paths;
+	int allow_empty;
 
 	/* Other non boolean parameters */
 	struct repository *repo;
 	const char *index_file;
 	enum apply_verbosity apply_verbosity;
diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
index ceb6a79fe0..949e284d14 100755
--- a/t/t4126-apply-empty.sh
+++ b/t/t4126-apply-empty.sh
@@ -7,10 +7,12 @@ test_description='apply empty'
 test_expect_success setup '
 	>empty &&
 	git add empty &&
 	test_tick &&
 	git commit -m initial &&
+	git commit --allow-empty -m "empty commit" &&
+	git format-patch --always HEAD~ >empty.patch &&
 	for i in a b c d e
 	do
 		echo $i
 	done >empty &&
 	cat empty >expect &&
@@ -23,34 +25,46 @@ test_expect_success setup '
 	>empty &&
 	git update-index --refresh
 '
 
 test_expect_success 'apply empty' '
-	git reset --hard &&
 	rm -f missing &&
+	test_when_finished "git reset --hard" &&
 	git apply patch0 &&
 	test_cmp expect empty
 '
 
+test_expect_success 'apply empty patch fails' '
+	test_when_finished "git reset --hard" &&
+	test_must_fail git apply empty.patch &&
+	test_must_fail git apply - </dev/null
+'
+
+test_expect_success 'apply with --allow-empty succeeds' '
+	test_when_finished "git reset --hard" &&
+	git apply --allow-empty empty.patch &&
+	git apply --allow-empty - </dev/null
+'
+
 test_expect_success 'apply --index empty' '
-	git reset --hard &&
 	rm -f missing &&
+	test_when_finished "git reset --hard" &&
 	git apply --index patch0 &&
 	test_cmp expect empty &&
 	git diff --exit-code
 '
 
 test_expect_success 'apply create' '
-	git reset --hard &&
 	rm -f missing &&
+	test_when_finished "git reset --hard" &&
 	git apply patch1 &&
 	test_cmp expect missing
 '
 
 test_expect_success 'apply --index create' '
-	git reset --hard &&
 	rm -f missing &&
+	test_when_finished "git reset --hard" &&
 	git apply --index patch1 &&
 	test_cmp expect missing &&
 	git diff --exit-code
 '
 
-- 
2.32.0.1314.g6ed4fcc4cc

