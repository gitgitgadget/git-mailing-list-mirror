Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B340FC433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 04:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbhLNEJT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 23:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhLNEJQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 23:09:16 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE829C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:15 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 133so13395328wme.0
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 20:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mAOerwPUMrfnXbLVjrNgMJnuirc3MJ3a20wdnsiRbIw=;
        b=WVxOhP6S4d86OQf2ambdGjJDDJHm62neY5xuSWL+rlrwAyMOZn/lwI/gXzGJzVwoq7
         AwajCWDisrdQBw4bQ/s8gpoMTg/lY5+RVfZ8N/CcRN7qPWecjjebYS0gLYrBjPG1hljB
         AJDAEWGEvaOYfxvntzWhiRsmxnb9Sgh7K0gFJA2imdr0ffDVrivg8ifrX+nS5c2kbnsK
         VHbR+8lirHN0YsnMY8QEJxMlfF8kYp7QFMF+p3imsbexEdIe6qVLvb5xHcT6MPSyGbok
         SqYEx/sHPUEQBQR4hHsxvB4La2rcujVF0MQokiyYOJcLbW6XkaB3wBgYWNuol+ZGCkji
         fEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mAOerwPUMrfnXbLVjrNgMJnuirc3MJ3a20wdnsiRbIw=;
        b=bpHElFyTnwuv3tY9OHhb+aDcFAn7lpww7XHTM02UkKuH61Lg06RSVT+KX59ATkRgeV
         QlEvo/nXee89V9cSt/dAb6v+fEFWbHrHu6y6Hcl/4ZKs6TS7eFIj9Ih0mrQy+rIuypJf
         gtv9DwAtenhZ5EC90mtC9YP2wkQXkcUP3d08L3fJAIcSp9XLJJvU63UNGQZtJoA0Q+dc
         A8VgAmBsVIoTwku7sxqBU/hj9WbzFGk/yOgd8FGhRjXZ/GqemK5ZOh1vvyIZnZJe9YzD
         eaZFvG9g/nWdMqzqOIB4TYb2OnPNtCRvkKjVQdK963PsNCsI7FEDNhaCvnrARLuSFaSD
         SSPA==
X-Gm-Message-State: AOAM532XpoGUQVmpIufJDM9/IIoJ6r2rJVSUaZ6RX0kykeay9UcTChkK
        kTtPmioUWgecXiERSA2Eop7W43L6W/c=
X-Google-Smtp-Source: ABdhPJxtQotLMRiul+j37yMnuAOtbE9Ikqs6afV+lP6PSz58IA68ik6410J66izdrL50Rfn+NLkaiA==
X-Received: by 2002:a05:600c:154f:: with SMTP id f15mr42902143wmg.86.1639454954389;
        Mon, 13 Dec 2021 20:09:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1sm11097618wri.100.2021.12.13.20.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 20:09:14 -0800 (PST)
Message-Id: <04cd57592e9331985db2e827459775ed9bc8a22b.1639454952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
References: <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com>
        <pull.1151.v4.git.git.1639454952.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 04:09:04 +0000
Subject: [PATCH v4 02/10] sparse-checkout: break apart functions for
 sparse_checkout_(set|add)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

sparse_checkout_set() was reused by sparse_checkout_add() with the only
difference being a single parameter being passed to that function.
However, we would like sparse_checkout_set() to do the same work that
sparse_checkout_init() does if sparse checkouts are not already enabled.
To facilitate this transition, give each mode their own copy of the
function.  This does not introduce any behavioral changes; that will
come in a subsequent patch.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Victoria Dye <vdye@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 54 +++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 8612328e5dd..e252b82136e 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -515,15 +515,6 @@ static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
 	insert_recursive_pattern(pl, line);
 }
 
-static char const * const builtin_sparse_checkout_set_usage[] = {
-	N_("git sparse-checkout (set|add) (--stdin | <patterns>)"),
-	NULL
-};
-
-static struct sparse_checkout_set_opts {
-	int use_stdin;
-} set_opts;
-
 static void add_patterns_from_input(struct pattern_list *pl,
 				    int argc, const char **argv,
 				    int use_stdin)
@@ -663,8 +654,43 @@ static int modify_pattern_list(int argc, const char **argv, int use_stdin,
 	return result;
 }
 
-static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
-			       enum modify_type m)
+static char const * const builtin_sparse_checkout_add_usage[] = {
+	N_("git sparse-checkout add (--stdin | <patterns>)"),
+	NULL
+};
+
+static struct sparse_checkout_add_opts {
+	int use_stdin;
+} add_opts;
+
+static int sparse_checkout_add(int argc, const char **argv, const char *prefix)
+{
+	static struct option builtin_sparse_checkout_add_options[] = {
+		OPT_BOOL(0, "stdin", &add_opts.use_stdin,
+			 N_("read patterns from standard in")),
+		OPT_END(),
+	};
+
+	repo_read_index(the_repository);
+
+	argc = parse_options(argc, argv, prefix,
+			     builtin_sparse_checkout_add_options,
+			     builtin_sparse_checkout_add_usage,
+			     PARSE_OPT_KEEP_UNKNOWN);
+
+	return modify_pattern_list(argc, argv, add_opts.use_stdin, ADD);
+}
+
+static char const * const builtin_sparse_checkout_set_usage[] = {
+	N_("git sparse-checkout set (--stdin | <patterns>)"),
+	NULL
+};
+
+static struct sparse_checkout_set_opts {
+	int use_stdin;
+} set_opts;
+
+static int sparse_checkout_set(int argc, const char **argv, const char *prefix)
 {
 	static struct option builtin_sparse_checkout_set_options[] = {
 		OPT_BOOL(0, "stdin", &set_opts.use_stdin,
@@ -679,7 +705,7 @@ static int sparse_checkout_set(int argc, const char **argv, const char *prefix,
 			     builtin_sparse_checkout_set_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	return modify_pattern_list(argc, argv, set_opts.use_stdin, m);
+	return modify_pattern_list(argc, argv, set_opts.use_stdin, REPLACE);
 }
 
 static char const * const builtin_sparse_checkout_reapply_usage[] = {
@@ -762,9 +788,9 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
 		if (!strcmp(argv[0], "init"))
 			return sparse_checkout_init(argc, argv);
 		if (!strcmp(argv[0], "set"))
-			return sparse_checkout_set(argc, argv, prefix, REPLACE);
+			return sparse_checkout_set(argc, argv, prefix);
 		if (!strcmp(argv[0], "add"))
-			return sparse_checkout_set(argc, argv, prefix, ADD);
+			return sparse_checkout_add(argc, argv, prefix);
 		if (!strcmp(argv[0], "reapply"))
 			return sparse_checkout_reapply(argc, argv);
 		if (!strcmp(argv[0], "disable"))
-- 
gitgitgadget

