Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5CAC4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 11:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241612AbiKRLTP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 06:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241677AbiKRLSz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 06:18:55 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531BA27DDB
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:46 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id t25so12210139ejb.8
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 03:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyQUUDJzUS7qPfmDjUbm1Ri3+Ge1ynUxLBCOdhQgtxk=;
        b=j6Qs2+VWBtqRlzYW+3Kj6GDouzEUG72K9OBCSIQBFbZLBO52U0mWmnTjuRwJ9ZS+Qv
         Qmso704SFNN/hb95VxYodlV777aagbd8HWrSD2mR3zuIgjyo4SpGTZwDqZ6OhLtSnPzk
         kByC2bQks4jX2bSqftIvPtSFbPGc1PSB+MbNEK/jaTtT2H5VD87+I/rG4NM/nNVSEQIs
         tKmQP/fDpzBU6rF146/Wl9VbeFWbCR0yf2uWsMzZHG6VhMW8RHxE8MUQ4QEdb1Jb+RSs
         1GU5u4kAzdSe+KkmNveBEXtEGuHtj+gGh1q641wXdDfZQxfw6g9BDtikeOK6gXOzTLnf
         FbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyQUUDJzUS7qPfmDjUbm1Ri3+Ge1ynUxLBCOdhQgtxk=;
        b=nkxEHbAM9qeDZsb+lsjl659GCwlLO/Nv+AUD416Z4wB49G81ntZFCnapCssGMisH37
         SqeAqrE90Z4X7PNIP93E4SFjiA750pqvWIi5IMx6WxYtUxTcII9P3ue6B2lITC7EQ0uH
         6A8pMotQeVxceUF7Cak9YlcuQ8JYm4fPSEoBkUx1tn2yDEcAk19yQpiKshfWsOgSrmoO
         CK/cUofRvY+yJuJBoqY5hJyWNyRtlwNJ6zig1qFIa4+Tbni24rilP2kK7ZPvyvztwSX1
         N/8JSFumGXBicdZRMgRz28Po6BfdBDCwdht5LN9PcOeztXOcFinqqYdsxWdRLDxsINMI
         vxhg==
X-Gm-Message-State: ANoB5png7WYD0ahzuAh9sa7EB6s07wvtfDPDhXyJmDUOFDR1E1idqeVW
        seSr9NT5+LdLcszhVTkmOkT34m+ka2Dz4A==
X-Google-Smtp-Source: AA0mqf6AeYKAicIj40Q+NEsmLq5TQH7ARYjnKY1v+wi3diMiwsvyfOyROJbID1ljXomfUzpjbyl8pg==
X-Received: by 2002:a17:906:cd10:b0:7ad:c0e7:7a99 with SMTP id oz16-20020a170906cd1000b007adc0e77a99mr5333926ejb.689.1668770324326;
        Fri, 18 Nov 2022 03:18:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id fy20-20020a1709069f1400b00788c622fa2csm1558955ejc.135.2022.11.18.03.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 03:18:43 -0800 (PST)
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
Subject: [PATCH v9 12/12] merge-index: make the argument parsing sensible & simpler
Date:   Fri, 18 Nov 2022 12:18:29 +0100
Message-Id: <patch-v9-12.12-f0368560140-20221118T110058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1511.gcdcff1f1dc2
In-Reply-To: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
References: <20220809185429.20098-1-alban.gruin@gmail.com> <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com>
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
2.38.0.1511.gcdcff1f1dc2

