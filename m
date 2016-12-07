Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 908D320259
	for <e@80x24.org>; Wed,  7 Dec 2016 16:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753380AbcLGQKS (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 11:10:18 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:35380 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752362AbcLGQKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 11:10:16 -0500
Received: by mail-wj0-f194.google.com with SMTP id he10so36434910wjc.2
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 08:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iN6oxjhb68vV7bc4Uml0pY38i3ZvX1RwE9jdIxvzk9o=;
        b=Cs7+qosmpyiXDH65j9MG9CccoZ1GMh5OC0b5PklV53gsbfziiGE080VNgOJLK+MOm9
         x0u+vTTkgqeODvM0KXe4xbwnBSYamEIGznPznbF/x6jGMYPZVt+cBqvD27m1d0DkysLe
         M7Sh8OIbLjyT3HbrKAOs02bKWA6rDDGPl6rDIXVuIi5nF+6VCqnKWN1UyMY9JZaPmiGS
         65HN7VX1O8/aI5T6+qHi1XCy7HY7ZLKGGdEFcSBU/tosTjz/OhkOHtKQwf2c81cqdL5k
         xpM2HWnSa3S7oCc73WhYEVv/KzjfixdqS3zrl3n5JHnWTMXGyugH3haX1JQT+hEDU4b8
         kIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iN6oxjhb68vV7bc4Uml0pY38i3ZvX1RwE9jdIxvzk9o=;
        b=QAcneElTPfD64fQN8Ae0l0QBfbgjYe+IiXoubBHLQEFKLi5uXKJDbox+ZaK7LGW0f8
         nO+15cQO8nqJnvREQ/XA9oVMR+BGKM4zUKPIb4YPsn6vc5sr6VjWmw2T7Lj+Qkq0LZH7
         u2Im6j6K54XagePYcLvkM71rCMfqm/seq6329ivAt7uZjn7TZVMf9ZlkRXGqS9FOUUvM
         8pziMdvfwKAfL+jEPWcvYJPeLrLlCvxqRVomtdbjnRnuatcccP0ZeKvOkbh1RydfU4Mt
         5oxloUPcO44B/HDDgILr85+0K3maGnzlu/SQMcT++2s3a4dOBn9BgBucF/V0VNNuz1NP
         irVg==
X-Gm-Message-State: AKaTC00iF0uZnjJvFrK1Kq0bBqRzt6IToLH4LWV2Z/46HOVk7evwRP5fvVvhdcWh8aE0Xg==
X-Received: by 10.194.116.66 with SMTP id ju2mr3298990wjb.223.1481127014335;
        Wed, 07 Dec 2016 08:10:14 -0800 (PST)
Received: from localhost.localdomain (x590e0b3d.dyn.telefonica.de. [89.14.11.61])
        by smtp.gmail.com with ESMTPSA id 6sm32140379wjt.5.2016.12.07.08.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 08:10:13 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] ref-filter, tag: eliminate duplicated sorting option parsing
Date:   Wed,  7 Dec 2016 17:09:22 +0100
Message-Id: <20161207160923.7028-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.11.0.78.g5a2d011
In-Reply-To: <20161207160923.7028-1-szeder.dev@gmail.com>
References: <20161207160923.7028-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorting options are either specified on the command line, which is
handled by parse_opt_ref_sorting() in ref-filter.c, or via the
'tag.sort' config variable, which is handled by parse_sorting_string()
in builtin/tag.c.  These two functions are nearly identical, the
difference being only their signature and the former having a couple
of extra lines at the beginning.

Eliminate the code duplication by making parse_sorting_string() part
of the public ref-filter API, and turning parse_opt_ref_sorting() into
a thin wrapper around that function.  This way builtin/tag.c can
continue using it as before (and it might be useful if there ever will
be a 'branch.sort' config variable).  Change its return type from int
to void, because it always returned zero and none of its callers cared
about it (the actual error handling is done inside
parse_ref_filter_atom() by die()ing on error).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/tag.c | 24 ------------------------
 ref-filter.c  | 16 +++++++++++-----
 ref-filter.h  |  2 ++
 3 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 50e4ae567..6fe723bee 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -122,30 +122,6 @@ static const char tag_template_nocleanup[] =
 	"Lines starting with '%c' will be kept; you may remove them"
 	" yourself if you want to.\n");
 
-/* Parse arg given and add it the ref_sorting array */
-static int parse_sorting_string(const char *arg, struct ref_sorting **sorting_tail)
-{
-	struct ref_sorting *s;
-	int len;
-
-	s = xcalloc(1, sizeof(*s));
-	s->next = *sorting_tail;
-	*sorting_tail = s;
-
-	if (*arg == '-') {
-		s->reverse = 1;
-		arg++;
-	}
-	if (skip_prefix(arg, "version:", &arg) ||
-	    skip_prefix(arg, "v:", &arg))
-		s->version = 1;
-
-	len = strlen(arg);
-	s->atom = parse_ref_filter_atom(arg, arg+len);
-
-	return 0;
-}
-
 static int git_tag_config(const char *var, const char *value, void *cb)
 {
 	int status;
diff --git a/ref-filter.c b/ref-filter.c
index bc551a752..dfadf577c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1667,15 +1667,11 @@ struct ref_sorting *ref_default_sorting(void)
 	return sorting;
 }
 
-int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
+void parse_sorting_string(const char *arg, struct ref_sorting **sorting_tail)
 {
-	struct ref_sorting **sorting_tail = opt->value;
 	struct ref_sorting *s;
 	int len;
 
-	if (!arg) /* should --no-sort void the list ? */
-		return -1;
-
 	s = xcalloc(1, sizeof(*s));
 	s->next = *sorting_tail;
 	*sorting_tail = s;
@@ -1689,6 +1685,16 @@ int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
 		s->version = 1;
 	len = strlen(arg);
 	s->atom = parse_ref_filter_atom(arg, arg+len);
+}
+
+int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset)
+{
+	struct ref_sorting **sorting_tail = opt->value;
+
+	if (!arg) /* should --no-sort void the list ? */
+		return -1;
+
+	parse_sorting_string(arg, sorting_tail);
 	return 0;
 }
 
diff --git a/ref-filter.h b/ref-filter.h
index 14d435e2c..49466a17d 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -100,6 +100,8 @@ int verify_ref_format(const char *format);
 void ref_array_sort(struct ref_sorting *sort, struct ref_array *array);
 /*  Print the ref using the given format and quote_style */
 void show_ref_array_item(struct ref_array_item *info, const char *format, int quote_style);
+/* Parse given arg and append it to the ref_sorting list */
+void parse_sorting_string(const char *arg, struct ref_sorting **sorting_tail);
 /*  Callback function for parsing the sort option */
 int parse_opt_ref_sorting(const struct option *opt, const char *arg, int unset);
 /*  Default sort option based on refname */
-- 
2.11.0.78.g5a2d011

