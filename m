Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5344AC433F5
	for <git@archiver.kernel.org>; Sat, 11 Dec 2021 03:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbhLKDRp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 22:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbhLKDRo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 22:17:44 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB82C061714
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 19:14:08 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id g28so9562311qkk.9
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 19:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJj5dV8l2NIWfNhSjXkbslgHfrfyUa/u0qSldHdnFE0=;
        b=tHC8gnHZ4Crz3f96vvNyVqijc/DhfiTrTd3U/tTK2WOFuH9/SEov+cvrFaGKbcEgj5
         o8kriaUpu3sQdAwflwD/3uS+26d3WxDPFVUqgPkvtBdoAB4rfGboGNzQPelERylEkdWm
         eWThPnsd79p62DZpq4B9qlWGdDbVQoSfyENvl1u8yhNTw9acLoPPjGOlH9csGA6IM5+u
         g0A6Sx5h6CMyvmtoXFRW80gw1EmdWqE3t5WR32V5gpnnQSsjL4b6EJHFikv0ny4PuMYH
         kkTeRd9SQ2vi0UMYCBijZht4SmL16gAWDIo5HoUcfP0Wtjf6gTHrNtsjx3BGGUDivWrY
         AnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJj5dV8l2NIWfNhSjXkbslgHfrfyUa/u0qSldHdnFE0=;
        b=hntokvFstiU3TE9QUddkLoa+AVsPJUgEmgdupskLsPKre36g4W8rYi+8pHt5Z9Vj/G
         POnY0rFZ69g76+kr2C4tZrNwXKSAbOuvI2v27zE26U8HLmUpWaml4GgOxSX7msDycZpl
         5WOzPr/oMPTznqbMPwXMHAtpKMvipA0r7TeFY3N4Q7t4Vt0vVGWdhrb6Ch7qHjCXL3gA
         HMVECZHvYDmUs6fdDOgj0YauizRmi8BOG99uZ/Cqbp7PVZiWSYda8o0zYx6+he3Sf1E9
         jms75ag4T5f3PAsQmDLLasaWJQJAVMZbvUQbcHbbDAlkoRwUIoxWSdUXrljKui8vcvhf
         SrvA==
X-Gm-Message-State: AOAM531sbQx7UMhmBenVVY/wky3yGQyqmhzmg6xmRqT0cgf11lD7A6+a
        rlDFZC4Kefr+BksBV+MwhB+XdyAyrOE8CQ==
X-Google-Smtp-Source: ABdhPJwZJ+qWPKH4rikHIhANdnTxE2oy8RU4JqHwANtArSqN+NO5WYPB1CJpo/0Yuj15o/Ps6lb3uQ==
X-Received: by 2002:ae9:e918:: with SMTP id x24mr24364039qkf.264.1639192447361;
        Fri, 10 Dec 2021 19:14:07 -0800 (PST)
Received: from jerry-desktop2.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id bp18sm2388524qkb.39.2021.12.10.19.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 19:14:06 -0800 (PST)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Jerry Zhang <jerry@skydio.com>
Subject: [PATCH V3] git-apply: add --allow-empty flag
Date:   Fri, 10 Dec 2021 19:13:43 -0800
Message-Id: <20211211031343.15818-1-jerry@skydio.com>
X-Mailer: git-send-email 2.34.1.186.g311317a974
In-Reply-To: <20210427194049.14399-1-jerry@skydio.com>
References: <20210427194049.14399-1-jerry@skydio.com>
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
V2->V3:
- moved lines into setup routine
- switched all tests to using "test_when_finished" rather than resetting at the end

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
index 9f00f882a2..f6029fd935 100644
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
+			error(_("unrecognized input"));
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

