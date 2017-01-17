Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5170A20756
	for <e@80x24.org>; Tue, 17 Jan 2017 23:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751610AbdAQXjB (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 18:39:01 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34683 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751418AbdAQXhc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 18:37:32 -0500
Received: by mail-qk0-f196.google.com with SMTP id e1so17318103qkh.1
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 15:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=esE+CqVAlH1HaPv1rk9rxMUCrHvpy4Cdqz+Va+1SoXA=;
        b=S3BIBeamBB2L2VL/x+YvH4/zC0kL+0dcUH0SCugp7wuPIcVdGQ0JAzdI0+9QQMd6FI
         yA3ZasoRen82ca7feXUtqR2cLnDB6GBoHoeiJjiZVDZhgKopKGRBQo++ze+SEn7v847Z
         b2mVaBDQVT+YstUT/5VNUB3TWeBkP9Lf5pTegxaHtTB2SYpRDMOp7UvdzWZqghBIelAX
         WFbs87/N9lAJKXF242yn3KqaeQ/bvEJiDSpoZlo4stgTBIsW4bq0SnpLoUajn1i+ElXY
         aF7KOllUDMDqI8PuelUgU4+zJqywlr2QULmMt9GzP6TJrr9BgiaUo7JNn6Wi3hUCcdhl
         u9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=esE+CqVAlH1HaPv1rk9rxMUCrHvpy4Cdqz+Va+1SoXA=;
        b=UZ39l3vZN1AqYVFN2rrPWz+FmgHvySOIAtOjqgRginYgHv1+WJ19wLgvwZxq0oPOYo
         Y8BeFMDliOpQSiurTVODCj0pOoJZj/FI5GOiHyIVq/42rDYsVD8VMYtftkvFlzuGlRFg
         k1SKVFr7152hwxWqNJ8ZlsRXonuTBrkjsijQA+ddyNYl53KFl2720M4+WSAr49LBCU8U
         6SlriTy94gXsdfcDxqUH6Z1Y6ronGUB89Gkmt8HoPW+vA3WcgxX0MrTllv/0UvKp50+z
         UA/8ZZpSiWVcVO3rcro5CFp85hQcFCsjU0bLHWkgqThazAviuYl72lbeD5f1/3iabaEf
         5NcQ==
X-Gm-Message-State: AIkVDXI6K5IJ9fyo8bnRJb7jeZqhk47LsZ9A43hp3OZuBeeFH6bcitxJnzYalByyLC6fq3kW
X-Received: by 10.55.155.88 with SMTP id d85mr249551qke.90.1484696251507;
        Tue, 17 Jan 2017 15:37:31 -0800 (PST)
Received: from localhost.localdomain (NYUFWA-WLESSAUTHCLIENTS-17.NATPOOL.NYU.EDU. [216.165.95.6])
        by smtp.gmail.com with ESMTPSA id c1sm3405814qke.36.2017.01.17.15.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jan 2017 15:37:31 -0800 (PST)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: [PATCH v6 2/6] ref-filter: add function to print single ref_array_item
Date:   Tue, 17 Jan 2017 18:37:19 -0500
Message-Id: <20170117233723.23897-3-santiago@nyu.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170117233723.23897-1-santiago@nyu.edu>
References: <20170117233723.23897-1-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lukas Puehringer <luk.puehringer@gmail.com>

ref-filter functions are useful for printing git object information
using a format specifier. However, some other modules may not want to use
this functionality on a ref-array but only print a single item.

Expose a pretty_print_ref function to create, pretty print and free
individual ref-items.

Signed-off-by: Lukas Puehringer <luk.puehringer@gmail.com>
---
 ref-filter.c | 27 +++++++++++++++++++++------
 ref-filter.h |  7 +++++++
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1a978405e..5f4b08792 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1361,7 +1361,7 @@ static struct ref_array_item *new_ref_array_item(const char *refname,
 	return ref;
 }
 
-static int filter_ref_kind(struct ref_filter *filter, const char *refname)
+static int ref_kind_from_refname(const char *refname)
 {
 	unsigned int i;
 
@@ -1374,11 +1374,7 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 		{ "refs/tags/", FILTER_REFS_TAGS}
 	};
 
-	if (filter->kind == FILTER_REFS_BRANCHES ||
-	    filter->kind == FILTER_REFS_REMOTES ||
-	    filter->kind == FILTER_REFS_TAGS)
-		return filter->kind;
-	else if (!strcmp(refname, "HEAD"))
+	if (!strcmp(refname, "HEAD"))
 		return FILTER_REFS_DETACHED_HEAD;
 
 	for (i = 0; i < ARRAY_SIZE(ref_kind); i++) {
@@ -1389,6 +1385,15 @@ static int filter_ref_kind(struct ref_filter *filter, const char *refname)
 	return FILTER_REFS_OTHERS;
 }
 
+static int filter_ref_kind(struct ref_filter *filter, const char *refname)
+{
+	if (filter->kind == FILTER_REFS_BRANCHES ||
+	    filter->kind == FILTER_REFS_REMOTES ||
+	    filter->kind == FILTER_REFS_TAGS)
+		return filter->kind;
+	return ref_kind_from_refname(refname);
+}
+
 /*
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
@@ -1671,6 +1676,16 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
 	putchar('\n');
 }
 
+void pretty_print_ref(const char *name, const unsigned char *sha1,
+		const char *format)
+{
+	struct ref_array_item *ref_item;
+	ref_item = new_ref_array_item(name, sha1, 0);
+	ref_item->kind = ref_kind_from_refname(name);
+	show_ref_array_item(ref_item, format, 0);
+	free_array_item(ref_item);
+}
+
 /*  If no sorting option is given, use refname to sort as default */
 struct ref_sorting *ref_default_sorting(void)
 {
diff --git a/ref-filter.h b/ref-filter.h
index fc55fa357..7b05592ba 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -109,4 +109,11 @@ struct ref_sorting *ref_default_sorting(void);
 /*  Function to parse --merged and --no-merged options */
 int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
 
+/*
+ * Print a single ref, outside of any ref-filter. Note that the
+ * name must be a fully qualified refname.
+ */
+void pretty_print_ref(const char *name, const unsigned char *sha1,
+		const char *format);
+
 #endif /*  REF_FILTER_H  */
-- 
2.11.0

