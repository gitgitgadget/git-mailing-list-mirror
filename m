Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99D412079E
	for <e@80x24.org>; Sun, 15 Jan 2017 18:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbdAOSr2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 13:47:28 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33661 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbdAOSr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 13:47:27 -0500
Received: by mail-qk0-f195.google.com with SMTP id 11so13855685qkl.0
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 10:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=esE+CqVAlH1HaPv1rk9rxMUCrHvpy4Cdqz+Va+1SoXA=;
        b=XziqvPJ/Tn1eysrJh8oo1t23SS5cSb1Kjz2bkbvlgGLEhCftVWoFqlECVuyoC+FfZ3
         AVINNDZCyULpu88516NT4GeiRaZ3Dmjkk4uMvv8BQGnaWTXh/H81DlGaV35CDHHspTDB
         9bOKzusbNsYZFCCBwwZ4fDp9a6Xm6eLS++9EzUSC9Nv13QH+UzQIsMCm+4DBZg5W7wCu
         +UAA6redH3TXD3ygu4oMMt8xy1LmOH6u7Dqm8DKHicGzFJcykIXEAs5rcPJ6B2Pks8nA
         tPi3UDsDWP70mM5+8bcW3ulCNeWTJ4ZWDo/ZeQoIiP3OOlTGuzE9zwKcOSkBL5UfIF1C
         g8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=esE+CqVAlH1HaPv1rk9rxMUCrHvpy4Cdqz+Va+1SoXA=;
        b=EOZ6mGBVn8SPjKyGU4xTu90sMzEu7YGh3m/6wQrl0nxl1tLBuUvG6xtsrALlI1QV7L
         nA4uBTmNwA03fkM1157tPl7eWX17tRdyLS10OsccMUckyyIjZEUPqRwVmtOtoVFMAt/h
         oO9RKaMpa9upFMZ2Uq9Ruh4xKhankuLgihuhLeg1QKuIgx2vKDXqUjhf+muzdpT59sTk
         8HSY+9i3bRHR4fXm/1AldqxVxhqP53nSS264BwjjDNFFWRiWgr7jEz5ilKt2nF95BK/V
         AdikRr78DZYnzaZIgYAHgNTqx6YkFIYnA5Wf4fEfeYG44qMb2HOp/PSYtlEdrYQMA9e5
         WfCw==
X-Gm-Message-State: AIkVDXKK9NUi1Ny5xiiGp0rq33DD551TYpHOwAPK3fQde66clu+l2rB7KHZfqVB4u5FOzHNX
X-Received: by 10.55.113.7 with SMTP id m7mr12144985qkc.270.1484506046219;
        Sun, 15 Jan 2017 10:47:26 -0800 (PST)
Received: from localhost.localdomain ([2604:2000:8183:da00::3])
        by smtp.gmail.com with ESMTPSA id x40sm14362243qtx.12.2017.01.15.10.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jan 2017 10:47:25 -0800 (PST)
From:   santiago@nyu.edu
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: [PATCH v5 2/7] ref-filter: add function to print single ref_array_item
Date:   Sun, 15 Jan 2017 13:47:00 -0500
Message-Id: <20170115184705.10376-3-santiago@nyu.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170115184705.10376-1-santiago@nyu.edu>
References: <20170115184705.10376-1-santiago@nyu.edu>
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

