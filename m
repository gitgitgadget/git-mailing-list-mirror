Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CE7C3F68F
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 15:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259152082F
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 15:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRRjPMr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgBKPC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:02:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46423 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgBKPC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 10:02:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so12714785wrl.13
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 07:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hnx0EudCoRQG0p+4EfQjwatea4wz6uL+nIfe3LOzljo=;
        b=gRRjPMr4Xha882ZeN6yCIiXtzr20GA5qW3T+RH7LIKGtD0KFtiGIrl9cc5QvbtI1hl
         QsKoBwdHGs4eVJwgZ1b2KX3cuzD0e7SCU2/lHe0bNJ2VelP2I+Ho1aqp3KROEfoHJbnV
         v6BdqW1YUIcrlka3M3KR/J7F9rDSh6v7j4DsuYIkczWzAJe57R83Vg9yfPQFegV34Nl4
         HrKG9z+VLSv9bRRy/MRSJPXK24Xp0kI0z8ZqbHqRyQhAGqilcSGoW+ndZKuwRhi014/O
         ircuHQx26GSfFadyyH2nIKVft5vt04xrZ13NCFM2JOiKTu5szsRQ4b/+Zr44mNl3s/eO
         7SGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hnx0EudCoRQG0p+4EfQjwatea4wz6uL+nIfe3LOzljo=;
        b=N4/4cCxA9Qe0v2gHqKyVrfr5qXdBheBHyj8Hwpz0PKdKGCYs8uz5mV/SXsFe6/Onut
         uUd1zUqhMfkPDe2Nfoo9ceehn0gOpcopLjRRw7JJpFxowXk2XT6kNrKqUpPZ5r32ncYi
         4S1PKg/s1REssfXLa0kXhoYTgWajdzC1e/bnCUBsIcUbcn6QvjLCjbCNjjvo4snLcY2w
         3xaNieorB/6wFKJSH37Lg0h/F5HWdDrtAfcHKr5s4qIMa0IJYDZah/M1Vkv4H+sgnkc6
         bsHpCqqPCPe7T7ugcK/bHAC6Gy5PtoNsZTxZ+tLEriLmMl1v8Z/JIiAiNgBdqSutllVA
         j1BQ==
X-Gm-Message-State: APjAAAUilgaOmgRoCEvmbFZ1gtkV2I8epXOb+1szOOgkjeGZxueOXRhN
        h21TMZc4KX8J0kzOvjQ0ujJUECwJ
X-Google-Smtp-Source: APXvYqyCEr8TkTIoB+Xemkv254QHUjazSfWTrQS5rPkxVHmfXZxsnymJ5VcM6C9SKCrKHLzvLMUbGQ==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr9439595wrm.150.1581433346808;
        Tue, 11 Feb 2020 07:02:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w19sm3931538wmc.22.2020.02.11.07.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 07:02:26 -0800 (PST)
Message-Id: <7990916ef05c618c3246053b3e5845b316f67668.1581433344.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.546.git.1581433344.gitgitgadget@gmail.com>
References: <pull.546.git.1581433344.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Feb 2020 15:02:22 +0000
Subject: [PATCH 2/4] sparse-checkout: extract pattern update from 'set'
 subcommand
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In anticipation of adding "add" and "remove" subcommands to the
sparse-checkout builtin, extract a modify_pattern_list() method from the
sparse_checkout_set() method. This command will read input from the
command-line or stdin to construct a set of patterns, then modify the
existing sparse-checkout patterns after a successful update of the
working directory.

Currently, the only way to modify the patterns is to replace all of the
patterns. This will be extended in a later update.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c | 44 +++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 41d8aaf9a2..03915dd729 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -462,29 +462,17 @@ static void add_patterns_from_input(struct pattern_list *pl,
 	}
 }
 
-static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
+enum modify_type {
+	REPLACE,
+};
+
+static int modify_pattern_list(int argc, const char **argv, enum modify_type m)
 {
-	struct pattern_list pl;
 	int result;
 	int changed_config = 0;
-
-	static struct option builtin_sparse_checkout_set_options[] = {
-		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
-			 N_("read patterns from standard in")),
-		OPT_END(),
-	};
-
-	repo_read_index(the_repository);
-	require_clean_work_tree(the_repository,
-				N_("set sparse-checkout patterns"), NULL, 1, 0);
-
+	struct pattern_list pl;
 	memset(&pl, 0, sizeof(pl));
 
-	argc = parse_options(argc, argv, prefix,
-			     builtin_sparse_checkout_set_options,
-			     builtin_sparse_checkout_set_usage,
-			     PARSE_OPT_KEEP_UNKNOWN);
-
 	add_patterns_from_input(&pl, argc, argv);
 
 	if (!core_apply_sparse_checkout) {
@@ -502,6 +490,26 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 	return result;
 }
 
+static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
+{
+	static struct option builtin_sparse_checkout_set_options[] = {
+		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
+			 N_("read patterns from standard in")),
+		OPT_END(),
+	};
+
+	repo_read_index(the_repository);
+	require_clean_work_tree(the_repository,
+				N_("set sparse-checkout patterns"), NULL, 1, 0);
+
+	argc = parse_options(argc, argv, prefix,
+			     builtin_sparse_checkout_set_options,
+			     builtin_sparse_checkout_set_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+
+	return modify_pattern_list(argc, argv, REPLACE);
+}
+
 static int sparse_checkout_disable(int argc, const char **argv)
 {
 	struct pattern_list pl;
-- 
gitgitgadget

