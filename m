Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97AFC33C9E
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3A2206D8
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrSlHRWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKUWFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:05:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45763 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfKUWFO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:05:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id z10so6259880wrs.12
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PnSPKH4Kk5DgwiPdWmgPEHDSjBOF7JG5Q8SvcQS2vJo=;
        b=FrSlHRWIyTVl/bQDObBFW5KMweBKWYakyuzje9wBKsz0I4xrvL8BgnOS/sApQ5FxNm
         7/3UfYtthSsG+6XCX6fdgadr4NdkXurwT4dEr0XsORoylKE9kRAxvd70qkprFU/x8Ae1
         fLrPksfVIMurABqi1i9I2yZTDMNaaKLujjjk1eUyn6tdyP3zMVEGATY40sjq+ghjCE68
         T7+a3OCpyM115XdXqNPKvQERmXJZp2zWXwr07nABRYM+n0TiAOb6t+daHBkxToZSsrM/
         P4pFTfuW6SlC1j9qAeSSukLB0DtRibVx5SFiCzOF4DkmyapAqsYOKb7XSbm1bknBMzt6
         i7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PnSPKH4Kk5DgwiPdWmgPEHDSjBOF7JG5Q8SvcQS2vJo=;
        b=rIy0o6Z4a6hmiwIla2Hh/LnnEltUP5odHmXRPFIaH1cCbL8bLVxfjOcqVgEf/UOGv8
         fdwXFDNi87F2BwKoib782UEsrhRYzymL+R59NCFedTLNbcHk7eswONj4cJZurAlxIKmb
         4U4AdUrz37On9hFC1bSaGvxtsmDh7MMv9/Yoaw64yBn5YerDrJjN9tQy8H1EMYQq2756
         fK7Glm/xy9rg9KYIpTIptCRczwDjLNCTe7kqXRFSKrxPVl1ct4LQHIcrsFyMo2vjgREp
         cxhT5Lzlp6sJSn73L12mZbL40BwC2i2lXNbHqRvYai7U9Wi3Z5qMn0JZvP/TWzMSU33r
         X01Q==
X-Gm-Message-State: APjAAAUJH3DTXB4PlGps9jm1Nmc8osyhiHRI5yVxRSAnrI7pohs4pHag
        GVg0tM8CCg6NYtfHxaaXHwL6sGxd
X-Google-Smtp-Source: APXvYqy/Gb8Z3QrxbEvxZfjfcACtrsGelroUUeswqS04c76xyFnTURM5F3STQmu6W4ZoPCnz5KXzYw==
X-Received: by 2002:adf:c00a:: with SMTP id z10mr13747667wre.81.1574373912324;
        Thu, 21 Nov 2019 14:05:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w7sm4903102wru.62.2019.11.21.14.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:05:11 -0800 (PST)
Message-Id: <2703b344f6f7195ec309454cda46f642df31a3d9.1574373892.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:45 +0000
Subject: [PATCH v6 13/19] sparse-checkout: sanitize for nested folders
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If a user provides folders A/ and A/B/ for inclusion in a cone-mode
sparse-checkout file, the parsing logic will notice that A/ appears
both as a "parent" type pattern and as a "recursive" type pattern.
This is unexpected and hence will complain via a warning and revert
to the old logic for checking sparse-checkout patterns.

Prevent this from happening accidentally by sanitizing the folders
for this type of inclusion in the 'git sparse-checkout' builtin.
This happens in two ways:

1. Do not include any parent patterns that also appear as recursive
   patterns.

2. Do not include any recursive patterns deeper than other recursive
   patterns.

In order to minimize duplicate code for scanning parents, create
hashmap_contains_parent() method. It takes a strbuf buffer to
avoid reallocating a buffer when calling in a tight loop.

Helped-by: Eric Wong <e@80x24.org>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 22 ++++++++++++++++++----
 t/t1091-sparse-checkout-builtin.sh | 11 +++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 85cc801f03..55b337ad8e 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -81,9 +81,17 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 	struct pattern_entry *pe;
 	struct hashmap_iter iter;
 	struct string_list sl = STRING_LIST_INIT_DUP;
+	struct strbuf parent_pattern = STRBUF_INIT;
 
-	hashmap_for_each_entry(&pl->parent_hashmap, &iter, pe, ent)
-		string_list_insert(&sl, pe->pattern);
+	hashmap_for_each_entry(&pl->parent_hashmap, &iter, pe, ent) {
+		if (hashmap_get_entry(&pl->recursive_hashmap, pe, ent, NULL))
+			continue;
+
+		if (!hashmap_contains_parent(&pl->recursive_hashmap,
+					     pe->pattern,
+					     &parent_pattern))
+			string_list_insert(&sl, pe->pattern);
+	}
 
 	string_list_sort(&sl);
 	string_list_remove_duplicates(&sl, 0);
@@ -99,8 +107,14 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 
 	string_list_clear(&sl, 0);
 
-	hashmap_for_each_entry(&pl->recursive_hashmap, &iter, pe, ent)
-		string_list_insert(&sl, pe->pattern);
+	hashmap_for_each_entry(&pl->recursive_hashmap, &iter, pe, ent) {
+		if (!hashmap_contains_parent(&pl->recursive_hashmap,
+					     pe->pattern,
+					     &parent_pattern))
+			string_list_insert(&sl, pe->pattern);
+	}
+
+	strbuf_release(&parent_pattern);
 
 	string_list_sort(&sl);
 	string_list_remove_duplicates(&sl, 0);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index fbd46c3f61..b88d08da98 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -237,4 +237,15 @@ test_expect_success 'cone mode: init and set' '
 	test_cmp expect dir
 '
 
+test_expect_success 'cone mode: set with nested folders' '
+	git -C repo sparse-checkout set deep deep/deeper1/deepest 2>err &&
+	test_line_count = 0 err &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+		/deep/
+	EOF
+	test_cmp repo/.git/info/sparse-checkout expect
+'
+
 test_done
-- 
gitgitgadget

