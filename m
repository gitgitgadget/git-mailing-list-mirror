Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F36620248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDFLgU (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:36:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34114 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLgT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:36:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so4491991plt.1
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aTA8uZjHYmU6mFrJRdjj2PyQx8+QjT2oIRRXCztOqnU=;
        b=CYgS575fssy3oe7Rvwjvb6Cz1wwAG16IdQAu8vo2CQ4Wnio2nXcBjpdF2ot60fQ8Be
         jZ+/F9K7BZCDdMs8RdohPZg6o3M5hq63dR7xLjkT3e/mb67a8ssiZ9ReNBRo6nYf4hmz
         F9CZA+XmBudtoyqZ5bcqkTRptI1LtcD3WgY4vnjUs8F6M2wYq2SetQNtDHVhYwxsLo8s
         ogStnGMUMJHaTQDVriLyvXqDmK58AKtvolPHUyO+wEmNeXC5BRZb/d0t9uNKJKBIsUFg
         2hIXyOC5nmha1OJ4YGqTKgo0Leg5OkL4sWzCmoOHB8gzIbXxuADsDs6tDbmuuu+KLo/l
         niKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aTA8uZjHYmU6mFrJRdjj2PyQx8+QjT2oIRRXCztOqnU=;
        b=S5BT8BEFsORAtgTF+i1fFxW6ug/6X296l04cq36B2DLTGb238gRTMtCEleGvaXJMhk
         6DRlgM6yOh+mvLtJF9K4wLUKZq3hcdfx23fS+vm0ZYb6KLvKxFfzVxosskWyegVdrhtH
         CrU4junDyDrTY74nRxse+/NObIxLiBp8f650QQVC/4KbC5VSdmI4HlskMw9K8XmUQVAG
         MYVhYEj1k5XfIrC5a9yeCAw6vU5kEZc7wTm5WtwtVba6O2bLyHel+5LGClnl1HjHkbug
         t3svd4XaCyO1DWQ55oqGHmmM/taKut69s/0BzTYUZKSFuglLMbrYwYbl2DQAHRBryplb
         PPYg==
X-Gm-Message-State: APjAAAXEHfFFOSqC8RdEInekBwrnVw/h4YlGhv/+OLHx53mz4n2fc4Ba
        vczLOyqab2oPHI0R6Z4TCVU=
X-Google-Smtp-Source: APXvYqwcwibXh4XpYxk+Pq6Ew+ObhLtGuxhpE384Va0U0MIm96YCv2sJo4XHIR6F7iKGVmw9eXyobg==
X-Received: by 2002:a17:902:2a2b:: with SMTP id i40mr2436064plb.80.1554550579272;
        Sat, 06 Apr 2019 04:36:19 -0700 (PDT)
Received: from ash ([116.102.217.71])
        by smtp.gmail.com with ESMTPSA id e13sm40588864pgb.37.2019.04.06.04.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 04:36:18 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 06 Apr 2019 18:36:14 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        szeder.dev@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 12/33] sha1-name.c: remove the_repo from sort_ambiguous()
Date:   Sat,  6 Apr 2019 18:34:32 +0700
Message-Id: <20190406113453.5149-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190406113453.5149-1-pclouds@gmail.com>
References: <20190403113457.20399-1-pclouds@gmail.com>
 <20190406113453.5149-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 sha1-name.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 15a1107998..7558ce51a3 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -383,10 +383,11 @@ static int collect_ambiguous(const struct object_id *oid, void *data)
 	return 0;
 }
 
+static struct repository *sort_ambiguous_repo;
 static int sort_ambiguous(const void *a, const void *b)
 {
-	int a_type = oid_object_info(the_repository, a, NULL);
-	int b_type = oid_object_info(the_repository, b, NULL);
+	int a_type = oid_object_info(sort_ambiguous_repo, a, NULL);
+	int b_type = oid_object_info(sort_ambiguous_repo, b, NULL);
 	int a_type_sort;
 	int b_type_sort;
 
@@ -411,6 +412,14 @@ static int sort_ambiguous(const void *a, const void *b)
 	return a_type_sort > b_type_sort ? 1 : -1;
 }
 
+static void sort_ambiguous_oid_array(struct repository *r, struct oid_array *a)
+{
+	/* mutex will be needed if this code is to be made thread safe */
+	sort_ambiguous_repo = r;
+	QSORT(a->oid, a->nr, sort_ambiguous);
+	sort_ambiguous_repo = NULL;
+}
+
 static enum get_oid_result get_short_oid(const char *name, int len,
 					 struct object_id *oid,
 					 unsigned flags)
@@ -458,7 +467,7 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 
 		advise(_("The candidates are:"));
 		for_each_abbrev(ds.hex_pfx, collect_ambiguous, &collect);
-		QSORT(collect.oid, collect.nr, sort_ambiguous);
+		sort_ambiguous_oid_array(the_repository, &collect);
 
 		if (oid_array_for_each(&collect, show_ambiguous_object, &ds))
 			BUG("show_ambiguous_object shouldn't return non-zero");
-- 
2.21.0.479.g47ac719cd3

