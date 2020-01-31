Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B17BC33CB7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBBB215A4
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uw3RsHqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgAaUQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:16:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36788 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgAaUQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:16:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so10172254wma.1
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 12:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eZA3Y8V0DI7Y6OfhZpE3M38qZIRLUorKn3RyVp8rUpU=;
        b=Uw3RsHqqLceO7W6RxE8VwUSrV4QO1wljrlBouEb7g3FjZb9pYUezJdn0XBtE6zZxfh
         3zn5+olsLV6FPCzM1PZgC0wpJHAr94IAbCC81QYtxJFje6y28skvQfG0q7JRIEGZS7do
         hoc28UTZVUmChosrQcrqAez6Z8h61NhA72rVmp7oBbF3RTzKHEnfKOOfrT9aH43JllFG
         dog3VCGUoCPXAP9DrCNzLe+Em4NLj6z/xFCfEprLdmcDrhDheC1UwkOe6FfOLaJNsFCQ
         /xpw4YvEELUTXZ/IjZ2wlyyzft+ZhiWQLumi4+91LSrTAyO1HrKaGL4kH3LAoqyVirt3
         xarg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eZA3Y8V0DI7Y6OfhZpE3M38qZIRLUorKn3RyVp8rUpU=;
        b=U6tbOcHdXvPazi4+Awxv2b6K8qBF4h4kjiubNiGqJUNmTvDyDLXuEN2SpJCbWaXZkc
         vtm3rrcYJbTyfsnLuFE+BvDWr84rVWIkcUenSL1EahjV95YMY8Cc2wdfx1imw/kL45Kk
         ewkhojJQPqFFjY00SuuMcsE3E3SK4HkWS0xDfCZodZGZKI0gKDONTNMrzyJsge2Zq2QC
         AAxAcfBOTGNpvyRAtjH04uZV+aMM7cJlPopzNBe2brzvQCq5iYZWjFyajdchFasNauXT
         AuL+saTz1HuTklmHiFaKNQQD28kaSUDYdHh+2sYzIiem/6D0LXmFgjMA5CIY0Ufr4oKH
         KSYw==
X-Gm-Message-State: APjAAAXySxGyFDAndeUjS24w+pxl2zGiwU9ng7aXeTGxQAmpbyki65iG
        dYKNIeaySrYOTfoVVVY6lzs8XFAi
X-Google-Smtp-Source: APXvYqwWOwZc4pUtzP4H7OVGL0qeklucrM+VKHyP/WnqPDQZUYeLdo73mITE40o+n6tousiCf78zeg==
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr13309501wma.62.1580501782977;
        Fri, 31 Jan 2020 12:16:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c141sm12318954wme.41.2020.01.31.12.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:16:22 -0800 (PST)
Message-Id: <4c86d01f0e965db0285336a88f2dc34cbcd0c073.1580501775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
        <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 20:16:09 +0000
Subject: [PATCH v4 09/15] sparse-checkout: properly match escaped characters
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
builtin/sparse-checkout.c in a later change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c                              | 35 +++++++++++++++++++++++++++---
 t/t1091-sparse-checkout-builtin.sh | 23 ++++++++++++++++----
 2 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index 71d28331f3..7ac0920b71 100644
--- a/dir.c
+++ b/dir.c
@@ -630,6 +630,36 @@ int pl_hashmap_cmp(const void *unused_cmp_data,
 	return strncmp(ee1->pattern, ee2->pattern, min_len);
 }
 
+static char *dup_and_filter_pattern(const char *pattern)
+{
+	char *set, *read;
+	size_t count  = 0;
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
+		count++;
+	}
+	*set = 0;
+
+	if (count > 2 &&
+	    *(set - 1) == '*' &&
+	    *(set - 2) == '/')
+		*(set - 2) = 0;
+
+	return result;
+}
+
 static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern *given)
 {
 	struct pattern_entry *translated;
@@ -702,8 +732,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 			goto clear_hashmaps;
 		}
 
-		truncated = xstrdup(given->pattern);
-		truncated[given->patternlen - 2] = 0;
+		truncated = dup_and_filter_pattern(given->pattern);
 
 		translated = xmalloc(sizeof(struct pattern_entry));
 		translated->pattern = truncated;
@@ -737,7 +766,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 
 	translated = xmalloc(sizeof(struct pattern_entry));
 
-	translated->pattern = xstrdup(given->pattern);
+	translated->pattern = dup_and_filter_pattern(given->pattern);
 	translated->patternlen = given->patternlen;
 	hashmap_entry_init(&translated->ent,
 			   ignore_case ?
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index c732abeacd..9ea700896d 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -378,13 +378,28 @@ test_expect_success 'pattern-checks: contained glob characters' '
 	done
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
+	!/zbad\\dir/*/
+	/zdoes\*not\*exist/
+	/zdoes\*exist/
 	EOF
-	check_read_tree_errors repo "a" ""
+	check_read_tree_errors escaped "a zbad\\dir zdoes*exist"
 '
 
 test_done
-- 
gitgitgadget

