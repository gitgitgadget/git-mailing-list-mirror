Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81D0C35240
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC841214D8
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jthcIwlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgAaUQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:16:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33989 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgAaUQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:16:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so10175459wrr.1
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 12:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bWLb+llRKMp4j/agNI8PJG44bIIzb45hS/gZZJAh7Os=;
        b=jthcIwlcilZ6BZEocyH8VOcw+Jfy5yLNL9RBg5L1+TXrf1Pdcv2jrOj7obNXLl3NaD
         CDqDK73KPtjY2ZVEaOd5GAzdiIbLm0Wkf/yY0yLNKCDRbUuzDQsn/pq3TsoKGJ25UI/A
         rfUeaUfLOggtDJR9zK30y/nkHsv2hsdZVD4q+PIs18fnF+Fwd0IOyPb05VS6rfxOvodE
         U6grgoRXRobE0f1LjMVP0N1FR2Zn2bLGvY3wvwCh0yrb3po4nBshAgRisvH0rlPXuYVf
         ugoXl0fRGOuFBZeQ2SdYhTsb94hwEZDo+Nsrs2z/Pj0TRbVqaRYpw1hVuwwh4n+TYghb
         b1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bWLb+llRKMp4j/agNI8PJG44bIIzb45hS/gZZJAh7Os=;
        b=h/F/xmwCQKR3GhqOdOGvSjKmqtTeYvc3sr8sp6mBq6M9j4zRUHBjz90nil3tqfqmCR
         E/43y2dzDkWAtWq5e+Tu7z6TXPlNRupXU8gLZSIfuTv1UQeEenzGznYGu3venBzJaKM+
         fDDLBJUsvTFDTEgoasVNutoebdgJJ61qWLd0pWIu1lrLBgSL1ispZlvVAs/UHbT477v3
         Y++e3aMG8kui0OI/McE1LBZUkSZZo896X9pK/kza1FrLLR5H6tgY9+zxBN3nVx2eQpU6
         N7hBMWv9JsK/s5w2HexxUjbSJUPk29fMKvHrJghgs4Upk8fdqAA15JRg5JLtwGT4sK6j
         KrhQ==
X-Gm-Message-State: APjAAAVkjHcLCanKGlv/cDUv4E4S6xXHCZPHjfFcQlrLstGrKD+bozfF
        nKYfMcn5DmDFXRbOLmwNAkzc7r7i
X-Google-Smtp-Source: APXvYqyAgrzIK2gTbpsOBXt7ekCxq7CueVCfba1FWNpRxmLlntNxhh8tW8dSDUmUDY5534slqQIJWw==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr143319wrn.29.1580501783753;
        Fri, 31 Jan 2020 12:16:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n28sm13496865wra.48.2020.01.31.12.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:16:23 -0800 (PST)
Message-Id: <0b9346f67b207d9495ea5223bddf7b517291455e.1580501775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
        <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 20:16:10 +0000
Subject: [PATCH v4 10/15] sparse-checkout: write escaped patterns in cone mode
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

If a user somehow creates a directory with an asterisk (*) or backslash
(\), then the "git sparse-checkout set" command will struggle to provide
the correct pattern in the sparse-checkout file. When not in cone mode,
the provided pattern is written directly into the sparse-checkout file.
However, in cone mode we expect a list of paths to directories and then
we convert those into patterns.

However, there is some care needed for the timing of these escapes. The
in-memory pattern list is used to update the working directory before
writing the patterns to disk. Thus, we need the command to have the
unescaped names in the hashsets for the cone comparisons, then escape
the patterns later.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 23 +++++++++++++++++++++--
 t/t1091-sparse-checkout-builtin.sh | 10 ++++++++--
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 3cee8ab46e..cc86b8a014 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -13,6 +13,7 @@
 #include "resolve-undo.h"
 #include "unpack-trees.h"
 #include "wt-status.h"
+#include "quote.h"
 
 static const char *empty_base = "";
 
@@ -140,6 +141,22 @@ static int update_working_directory(struct pattern_list *pl)
 	return result;
 }
 
+static char *escaped_pattern(char *pattern)
+{
+	char *p = pattern;
+	struct strbuf final = STRBUF_INIT;
+
+	while (*p) {
+		if (*p == '*' || *p == '\\')
+			strbuf_addch(&final, '\\');
+
+		strbuf_addch(&final, *p);
+		p++;
+	}
+
+	return strbuf_detach(&final, NULL);
+}
+
 static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 {
 	int i;
@@ -164,10 +181,11 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 	fprintf(fp, "/*\n!/*/\n");
 
 	for (i = 0; i < sl.nr; i++) {
-		char *pattern = sl.items[i].string;
+		char *pattern = escaped_pattern(sl.items[i].string);
 
 		if (strlen(pattern))
 			fprintf(fp, "%s/\n!%s/*/\n", pattern, pattern);
+		free(pattern);
 	}
 
 	string_list_clear(&sl, 0);
@@ -185,8 +203,9 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 	string_list_remove_duplicates(&sl, 0);
 
 	for (i = 0; i < sl.nr; i++) {
-		char *pattern = sl.items[i].string;
+		char *pattern = escaped_pattern(sl.items[i].string);
 		fprintf(fp, "%s/\n", pattern);
+		free(pattern);
 	}
 }
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 9ea700896d..fb8718e64a 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -309,6 +309,9 @@ check_read_tree_errors () {
 	REPO=$1
 	FILES=$2
 	ERRORS=$3
+	git -C $REPO -c core.sparseCheckoutCone=false read-tree -mu HEAD 2>err &&
+	test_must_be_empty err &&
+	check_files $REPO "$FILES" &&
 	git -C $REPO read-tree -mu HEAD 2>err &&
 	if test -z "$ERRORS"
 	then
@@ -391,14 +394,17 @@ test_expect_success BSLASHPSPEC 'pattern-checks: escaped "*"' '
 	git -C escaped reset --hard $COMMIT &&
 	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" &&
 	git -C escaped sparse-checkout init --cone &&
-	cat >escaped/.git/info/sparse-checkout <<-\EOF &&
+	git -C escaped sparse-checkout set zbad\\dir/bogus "zdoes*not*exist" "zdoes*exist" &&
+	cat >expect <<-\EOF &&
 	/*
 	!/*/
 	/zbad\\dir/
 	!/zbad\\dir/*/
-	/zdoes\*not\*exist/
+	/zbad\\dir/bogus/
 	/zdoes\*exist/
+	/zdoes\*not\*exist/
 	EOF
+	test_cmp expect escaped/.git/info/sparse-checkout &&
 	check_read_tree_errors escaped "a zbad\\dir zdoes*exist"
 '
 
-- 
gitgitgadget

