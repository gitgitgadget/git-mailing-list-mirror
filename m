Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17D9C2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034412AbcJ1S5F (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:57:05 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:34396 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966271AbcJ1Szw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:55:52 -0400
Received: by mail-pf0-f172.google.com with SMTP id n85so41591426pfi.1
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AzH5usinP36M3w7EgJ745MqFNYi18BZnLRH8WCqM2HU=;
        b=Wz27SQD9GRYnH70UlIOQoJHz+DraiwOaiI24s3vgLb8ak5k8jPqmo3kFk1+Iw+64EJ
         60A3qGPqpUf+ch/Q2ejA8Hl42VuoCQ7BJqyMlAnTwEw0JnZmt5KkDtC4+k/UrHq8lS9x
         B/iUVczUyyO3H2A2wMtv2d6K6v2BLEeLry3q0rqGCuwQmseKL+3MJbLCuIOMR1PGEUB6
         DJhcM0Tr+xG3ARy/ASU4pQpMuQOUu0bQ8qoz+J9FXiSlmmPptAmcYx04gvk3H27wh65B
         4PdVa7mnNHqlcDy2Lze/JBIB65OJl+17LuTZN+l9R618PMwAEPNF8EFABqtrfomDy9JZ
         Hjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AzH5usinP36M3w7EgJ745MqFNYi18BZnLRH8WCqM2HU=;
        b=bBXnp7Hlu251uDAmGw1SF/4t7RofL/Na5Z+ALE+XmnTLJgOrYYknWeoLxBP09r1EVF
         gj7NCfVdLrnNrMsBDHRyzS14fB+1WrcUvSU0q3UEV6V0zy3FILX6rI61VMhTwwttIjWn
         yXdcQ01jqXIkSnLPUdliXdGEBoQOFB8gEdGEoXDdPk99qJsxaPcjhCy+WKf26OYKFM3w
         397qbDwUiRE7FPAyZ7ZdHlqTOcWdnqnWwq+NbKRXSlWqm22dXpTtVttmfeBcjxAFUtb6
         MG+TzIuwo9S4wsAlFfFi/QmcW2R6LSe8GWWLnW5CuNLDpwa2nPGEFYStURlRMAknjgxc
         msGQ==
X-Gm-Message-State: ABUngvcwZxRLFDLI6oGoICct6o1zy/4/81b8qFf7bS6hLLJtFXCRrf4Yk/TJ1q++IaowFynu
X-Received: by 10.98.93.83 with SMTP id r80mr27151960pfb.17.1477680951818;
        Fri, 28 Oct 2016 11:55:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id xk6sm20595455pab.26.2016.10.28.11.55.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:55:51 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 17/36] attr: expose validity check for attribute names
Date:   Fri, 28 Oct 2016 11:54:43 -0700
Message-Id: <20161028185502.8789-18-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Export attr_name_valid() function, and a helper function that
returns the message to be given when a given <name, len> pair
is not a good name for an attribute.

We could later update the message to exactly spell out what the
rules for a good attribute name are, etc.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 39 +++++++++++++++++++++++++--------------
 attr.h | 10 ++++++++++
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/attr.c b/attr.c
index 7058e1c9fa..33021cc857 100644
--- a/attr.c
+++ b/attr.c
@@ -59,23 +59,38 @@ static unsigned hash_name(const char *name, int namelen)
 	return val;
 }
 
-static int invalid_attr_name(const char *name, int namelen)
+int attr_name_valid(const char *name, size_t namelen)
 {
 	/*
 	 * Attribute name cannot begin with '-' and must consist of
 	 * characters from [-A-Za-z0-9_.].
 	 */
 	if (namelen <= 0 || *name == '-')
-		return -1;
+		return 0;
 	while (namelen--) {
 		char ch = *name++;
 		if (! (ch == '-' || ch == '.' || ch == '_' ||
 		       ('0' <= ch && ch <= '9') ||
 		       ('a' <= ch && ch <= 'z') ||
 		       ('A' <= ch && ch <= 'Z')) )
-			return -1;
+			return 0;
 	}
-	return 0;
+	return 1;
+}
+
+void invalid_attr_name_message(struct strbuf *err, const char *name, int len)
+{
+	strbuf_addf(err, _("%.*s is not a valid attribute name"),
+		    len, name);
+}
+
+static void report_invalid_attr(const char *name, size_t len,
+				const char *src, int lineno)
+{
+	struct strbuf err = STRBUF_INIT;
+	invalid_attr_name_message(&err, name, len);
+	fprintf(stderr, "%s: %s:%d\n", err.buf, src, lineno);
+	strbuf_release(&err);
 }
 
 struct git_attr *git_attr_counted(const char *name, size_t len)
@@ -90,7 +105,7 @@ struct git_attr *git_attr_counted(const char *name, size_t len)
 			return a;
 	}
 
-	if (invalid_attr_name(name, len))
+	if (!attr_name_valid(name, len))
 		return NULL;
 
 	FLEX_ALLOC_MEM(a, name, name, len);
@@ -176,17 +191,15 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 			cp++;
 			len--;
 		}
-		if (invalid_attr_name(cp, len)) {
-			fprintf(stderr,
-				"%.*s is not a valid attribute name: %s:%d\n",
-				len, cp, src, lineno);
+		if (!attr_name_valid(cp, len)) {
+			report_invalid_attr(cp, len, src, lineno);
 			return NULL;
 		}
 	} else {
 		/*
 		 * As this function is always called twice, once with
 		 * e == NULL in the first pass and then e != NULL in
-		 * the second pass, no need for invalid_attr_name()
+		 * the second pass, no need for attr_name_valid()
 		 * check here.
 		 */
 		if (*cp == '-' || *cp == '!') {
@@ -229,10 +242,8 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		name += strlen(ATTRIBUTE_MACRO_PREFIX);
 		name += strspn(name, blank);
 		namelen = strcspn(name, blank);
-		if (invalid_attr_name(name, namelen)) {
-			fprintf(stderr,
-				"%.*s is not a valid attribute name: %s:%d\n",
-				namelen, name, src, lineno);
+		if (!attr_name_valid(name, namelen)) {
+			report_invalid_attr(name, namelen, src, lineno);
 			goto fail_return;
 		}
 	}
diff --git a/attr.h b/attr.h
index bcedf928b5..fe26f3a588 100644
--- a/attr.h
+++ b/attr.h
@@ -13,6 +13,16 @@ extern struct git_attr *git_attr(const char *);
 /* The same, but with counted string */
 extern struct git_attr *git_attr_counted(const char *, size_t);
 
+/*
+ * Return the name of the attribute represented by the argument.  The
+ * return value is a pointer to a null-delimited string that is part
+ * of the internal data structure; it should not be modified or freed.
+ */
+extern const char *git_attr_name(const struct git_attr *);
+
+extern int attr_name_valid(const char *name, size_t namelen);
+extern void invalid_attr_name_message(struct strbuf *, const char *, int);
+
 /* Internal use */
 extern const char git_attr__true[];
 extern const char git_attr__false[];
-- 
2.10.1.714.ge3da0db

