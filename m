Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31DBC4167B
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 08:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLOIxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 03:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiLOIw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 03:52:57 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A458A40448
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:38 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id m14so2286930wrh.7
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bsH0VOQ3xWDuA3bBjbiD1H28OOmyN+4twPZjDwMPgKE=;
        b=do7RQQqoVjib7z1JuCgyqWKzPvNAeBVBPnptT+diNMGFXAqH7SqaenL71PAhKgRxHZ
         Sq5iYwLLpq3pNwfGxUgHzs2AUzMuUOA+JxmgLdyZxv7fiHLMRXji1jTiA5wglaijQuza
         EPgXAeopl6otDC32YlcmBZD79CIyMKMr5EFH2ydUgB1O9cMLStaJXiRoNoQuxy+sR0UR
         psKUITDMFfHn68ZVZt4xUPrpaa90TuHFAf0Lm3rDXc77KQx8uB9sHLKBQYyPoJO4r4XD
         TQzbYyrGjYxkKD3tPIuPpMHCKG8hmJucemLDNiwPbeD+/e3SMFXXQpUed2bTv35ebevE
         SdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsH0VOQ3xWDuA3bBjbiD1H28OOmyN+4twPZjDwMPgKE=;
        b=CtxJJIyhVaDKjztnxw9Zp0avRkEtSXH+iGCcAd0rHdS2Iundl/PW0efE20zAgzLKPM
         FudQ1dw35U5MmK2B4+sm4FTK/8SBJce0Gf+j+R4vNBwnmEvFmgj4cQzzogfGNp0qInVM
         JppnwiN9ireWPS9nmxcrn37X7pBj+2c+o9z3Ad7cqjbD1PiyWUB9UaF+HdueQJ5PKVAZ
         MBEv7/GQXriZX7Dm2SIsJ9mhTgjMC9BNNJUuo/p1BS5svIclUXDU+X8X0VezQ2VDtEIs
         mgtL5LHS5yDG2GQjZFCWCKYJec52vvu19rrF4EOxRgtPl8UbRfVSckMkpGovMFrnUuZE
         5g/g==
X-Gm-Message-State: ANoB5pkvpKShlFB/WrFB+2EzrCqQjPfk4c9jWjTM7MzP0yIv/geAUB7w
        xYgqZe+H8IWsTbRRhmWhOrJ0bnZR/jZZtg==
X-Google-Smtp-Source: AA0mqf6EL0asOxSdqPbkoAA3SjCsldeB8Cyi0OGEe9oHrEwyW3k/QeBUH7qlEXYdUrR9hTSQOQNcSw==
X-Received: by 2002:adf:f0c3:0:b0:242:12cd:d73b with SMTP id x3-20020adff0c3000000b0024212cdd73bmr17557402wro.33.1671094356404;
        Thu, 15 Dec 2022 00:52:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r10-20020a0560001b8a00b0024274a5db0asm5464905wru.2.2022.12.15.00.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:52:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 12/12] merge-index: make the argument parsing sensible & simpler
Date:   Thu, 15 Dec 2022 09:52:16 +0100
Message-Id: <patch-v10-12.12-40b6d296f3a-20221215T084803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
References: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com> <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a preceding commit when we migrated to parse_options() we took
pains to be bug-for-bug compatible with the existing command-line
interface, if possible.

I.e. we forbade forms like:

	git merge-index -a <program>
	git merge-index <program> <opts> -a

But allowed:

	git merge-index <program> -a
	git merge-index <opts> <program> -a

As the "-a" argument was considered be provided for the "<program>",
but not a part of "<opts>".

We don't really need this strictness, as we don't have two "-a"
options. It's much simpler to implement a schema where the first
non-option argument is the <program>, and the rest are the
"<file>...". We only allow that rest if the "-a" option isn't
supplied.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge-index.c  | 28 ++++++++--------------------
 t/t6060-merge-index.sh | 12 +++++++++---
 2 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index d679272391b..d8b62e4f663 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -59,21 +59,14 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 		N_("git merge-index [-o] [-q] <merge-program> (-a | ([--] <file>...))"),
 		NULL
 	};
-#define OPT__MERGE_INDEX_ALL(v) \
-	OPT_BOOL('a', NULL, (v), \
-		 N_("merge all files in the index that need merging"))
 	struct option options[] = {
 		OPT_BOOL('o', NULL, &one_shot,
 			 N_("don't stop at the first failed merge")),
 		OPT__QUIET(&quiet, N_("be quiet")),
-		OPT__MERGE_INDEX_ALL(&all), /* include "-a" to show it in "-bh" */
+		OPT_BOOL('a', NULL, &all,
+			 N_("merge all files in the index that need merging")),
 		OPT_END(),
 	};
-	struct option options_prog[] = {
-		OPT__MERGE_INDEX_ALL(&all),
-		OPT_END(),
-	};
-#undef OPT__MERGE_INDEX_ALL
 	struct mofs_data data = { 0 };
 
 	/* Without this we cannot rely on waitpid() to tell
@@ -81,20 +74,15 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	 */
 	signal(SIGCHLD, SIG_DFL);
 
-	if (argc < 3)
-		usage_with_options(usage, options);
-
-	/* Option parsing without <merge-program> options */
-	argc = parse_options(argc, argv, prefix, options, usage,
-			     PARSE_OPT_STOP_AT_NON_OPTION);
-	if (all)
-		usage_msg_optf(_("'%s' option can only be provided after '<merge-program>'"),
-			      usage, options, "-a");
-	/* <merge-program> and its options */
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	if (!argc)
 		usage_msg_opt(_("need a <merge-program> argument"), usage, options);
 	data.program = argv[0];
-	argc = parse_options(argc, argv, prefix, options_prog, usage, 0);
+	argv++;
+	argc--;
+	if (!argc && !all)
+		usage_msg_opt(_("need '-a' or '<file>...'"),
+			      usage, options);
 	if (argc && all)
 		usage_msg_opt(_("'-a' and '<file>...' are mutually exclusive"),
 			      usage, options);
diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index bc201a69552..4ff9ace7f73 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -22,7 +22,7 @@ test_expect_success 'usage: 2 arguments' '
 
 test_expect_success 'usage: -a before <program>' '
 	cat >expect <<-\EOF &&
-	fatal: '\''-a'\'' option can only be provided after '\''<merge-program>'\''
+	fatal: '\''-a'\'' and '\''<file>...'\'' are mutually exclusive
 	EOF
 	test_expect_code 129 git merge-index -a b program >out 2>actual.raw &&
 	grep "^fatal:" actual.raw >actual &&
@@ -34,7 +34,7 @@ for opt in -q -o
 do
 	test_expect_success "usage: $opt after -a" '
 		cat >expect <<-EOF &&
-		fatal: '\''-a'\'' option can only be provided after '\''<merge-program>'\''
+		fatal: need a <merge-program> argument
 		EOF
 		test_expect_code 129 git merge-index -a $opt >out 2>actual.raw &&
 		grep "^fatal:" actual.raw >actual &&
@@ -43,7 +43,13 @@ do
 	'
 
 	test_expect_success "usage: $opt program" '
-		test_expect_code 0 git merge-index $opt program
+		cat >expect <<-EOF &&
+		fatal: need '\''-a'\'' or '\''<file>...'\''
+		EOF
+		test_expect_code 129 git merge-index $opt program 2>actual.raw &&
+		grep "^fatal:" actual.raw >actual &&
+		test_must_be_empty out &&
+		test_cmp expect actual
 	'
 done
 
-- 
2.39.0.rc2.1048.g0e5493b8d5b

