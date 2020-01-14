Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920DFC33CB2
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE5224670
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6KE+PVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgANT0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:26:16 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39266 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbgANT0M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 14:26:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id 20so15081329wmj.4
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 11:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eKh0l5KO1Pbpk5FhggZ2DR05+GqiKGYs+KmuFZFAj7c=;
        b=H6KE+PVRPXtGRBuIYrN2jjQFEJxXr6gHIl8hsLYx0lK9/wiwiR9XLYDtEF2ij7Uazv
         slvDak7nmbw5MyTF5j5Q6tDu24OW1wJzs+73ZoC7T6F2IwlWthdwIjdsCStd8Ofoe13L
         YL3nYYJ8QQO7ohg/MfcwSxHAoF2k8YTPBKGYeuT558bvfsrgDM0l/XbNiOi4aqN6B7RG
         mXcsQyz9VGf6Xz8MO/M79gKq/Nmt1TB8WnD0UFkuvjijCx+0t04yrdmstSA+IsrRSlxs
         hHBFetsIlLO8WXiUyYzhF1t3Tui/NN5hRcWMkLX2gxFU/5pQXOzi5c0EBpK9n2ChBrJX
         E3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eKh0l5KO1Pbpk5FhggZ2DR05+GqiKGYs+KmuFZFAj7c=;
        b=RN42ZcAWRX3AO1wmf4n/ChTaJCQEzpMTutWLAO9NTrK7E8H0+mf8yApH4vsDfkjWPl
         A9lcagpfAW6fyNBZl7QIkPBChEFunQSiQ8Bc3KNyZ7wYo+gy04tQTD/HQ5z7gv9Y24NR
         QcSbREy2asUplppgSMWAsazVlpVOIkNC+xZx13f023+oPjbPDHnDEilomccvCAvBasMR
         e9HLxNaoMv8JdHmx+XdwyTJ5REpZd4kFXX/AnRV8hxuO/5L18XLwaivSXSuLWAVpRRMK
         unGQyIXk6BS9wpYhA1y0PQbocJ5v4Wus0V80mI/CCCQDTVRFpRnub6FVgtpCRTKzRJbH
         Qwwg==
X-Gm-Message-State: APjAAAWm4U2NKn63Kg4QzW5lOlY6UpXcsv22IkGKNN6RHlmzyMCOat6l
        08kFem6zyQehmriX6kdSf0J+cSgQ
X-Google-Smtp-Source: APXvYqx+yqhVE/v4bFUGyFHzxwgpFTIJnA5H1dm5XqwPxmZSG0HZJpAzRS7UlQC1wj9DQ5i21G2n6A==
X-Received: by 2002:a1c:3803:: with SMTP id f3mr29863785wma.134.1579029969300;
        Tue, 14 Jan 2020 11:26:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x10sm20225398wrv.60.2020.01.14.11.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:26:08 -0800 (PST)
Message-Id: <09dbe1f9029d173e579b74442b02bc20e1a82437.1579029963.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.git.1579029962.gitgitgadget@gmail.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 19:26:01 +0000
Subject: [PATCH 7/8] sparse-checkout: properly match escaped characters
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

In cone mode, the sparse-checkout feature uses hashset containment
queries to match paths. Make this algorithm respect escaped asterisk
(*) and backslash (\) characters.

Create dup_and_filter_pattern() method to convert a pattern by
removing escape characters and dropping an optional "/*" at the end.
This method is available in dir.h as we will use it in
builtin/sparse-chekcout.c in a later change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c                              | 31 +++++++++++++++++++++++++++---
 dir.h                              |  1 +
 t/t1091-sparse-checkout-builtin.sh | 22 +++++++++++++++++----
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index 150c05f4de..2840bacd40 100644
--- a/dir.c
+++ b/dir.c
@@ -630,6 +630,32 @@ int pl_hashmap_cmp(const void *unused_cmp_data,
 	return strncmp(ee1->pattern, ee2->pattern, min_len);
 }
 
+char *dup_and_filter_pattern(const char *pattern)
+{
+	char *set, *read;
+	char *result = xstrdup(pattern);
+
+	set = result;
+	read = result;
+
+	while (*read) {
+		/* skip escape characters (once) */
+		if (*read == '\\')
+			read++;
+
+		*set = *read;
+
+		set++;
+		read++;
+	}
+	*set = 0;
+
+	if (*(read - 2) == '/' && *(read - 1) == '*')
+		*(read - 2) = 0;
+
+	return result;
+}
+
 static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern *given)
 {
 	struct pattern_entry *translated;
@@ -698,8 +724,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 			goto clear_hashmaps;
 		}
 
-		truncated = xstrdup(given->pattern);
-		truncated[given->patternlen - 2] = 0;
+		truncated = dup_and_filter_pattern(given->pattern);
 
 		translated = xmalloc(sizeof(struct pattern_entry));
 		translated->pattern = truncated;
@@ -733,7 +758,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 
 	translated = xmalloc(sizeof(struct pattern_entry));
 
-	translated->pattern = xstrdup(given->pattern);
+	translated->pattern = dup_and_filter_pattern(given->pattern);
 	translated->patternlen = given->patternlen;
 	hashmap_entry_init(&translated->ent,
 			   ignore_case ?
diff --git a/dir.h b/dir.h
index 77a43dbf89..6dcd9d33e7 100644
--- a/dir.h
+++ b/dir.h
@@ -304,6 +304,7 @@ int pl_hashmap_cmp(const void *unused_cmp_data,
 		   const struct hashmap_entry *a,
 		   const struct hashmap_entry *b,
 		   const void *key);
+char *dup_and_filter_pattern(const char *pattern);
 int hashmap_contains_parent(struct hashmap *map,
 			    const char *path,
 			    struct strbuf *buffer);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 5b50be53a4..051c1f3bf2 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -366,13 +366,27 @@ test_expect_success 'pattern-checks: starting "*"' '
 	check_read_tree_errors repo "a deep" "disabling cone pattern matching"
 '
 
-test_expect_success 'pattern-checks: escaped "*"' '
-	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+test_expect_success BSLASHPSPEC 'pattern-checks: escaped "*"' '
+	git clone repo escaped &&
+	TREEOID=$(git -C escaped rev-parse HEAD:folder1) &&
+	NEWTREE=$(git -C escaped mktree <<-EOF
+	$(git -C escaped ls-tree HEAD)
+	040000 tree $TREEOID	zbad\\dir
+	040000 tree $TREEOID	zdoes*exist
+	EOF
+	) &&
+	COMMIT=$(git -C escaped commit-tree $NEWTREE -p HEAD) &&
+	git -C escaped reset --hard $COMMIT &&
+	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" &&
+	git -C escaped sparse-checkout init --cone &&
+	cat >escaped/.git/info/sparse-checkout <<-\EOF &&
 	/*
 	!/*/
-	/does\*not\*exist/
+	/zbad\\dir/
+	/zdoes\*not\*exist/
+	/zdoes\*exist/
 	EOF
-	check_read_tree_errors repo "a" ""
+	check_read_tree_errors escaped "a zbad\\dir zdoes*exist"
 '
 
 test_done
-- 
gitgitgadget

