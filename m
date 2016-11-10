Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BE332076A
	for <e@80x24.org>; Thu, 10 Nov 2016 20:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965599AbcKJUfM (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 15:35:12 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35202 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965193AbcKJUfD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 15:35:03 -0500
Received: by mail-pf0-f172.google.com with SMTP id i88so151080634pfk.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 12:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VqePGF5XGMi2JR/cZBgfPrTLpjaPXMDBczjYAba+cKM=;
        b=AFoz00rM4pG42hAIdhaq4FOsrs/pPcaeDzs2gJV0qcSudS+z+2Q6eGThFJGrEPLQsC
         8Z+QZEnuN6xlxpG++CupBXvScwA0cElwTsCVnsU8FwignObY5CrCU1arEFklEyvZk7Uy
         HCBFMJhd1gJ4nXoEdzSO8viQ+xuH04oNjHs4wr0it1B9bgSYsmNjOVT+vCPgx1d21o7t
         A8mRzHmeKtyUyyOutuXlSMNl0gUXrub6UgUPKCd7ndLPjjyKAGFbubkexcszH6i2ju6H
         irESH+qr+TYAaFsheiVHuwaLipkzW7wI2UCpo1evEHWGP4Ufi0/f1ESJNJKzGb4BEw2a
         /bQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VqePGF5XGMi2JR/cZBgfPrTLpjaPXMDBczjYAba+cKM=;
        b=BopDP7/yt1VhI+2EPGsRAScrXIF+aLJ2Zyi9SWqWoeP4+a+X3kARM/3XzObeZXsre+
         JS++QhCX5JDnPCfWbRi173dGTNm6AKfx1WPLDFRjMnG/ex5gyQ8u0D/YBMF7hIEEBNCa
         jF/ZyHQULNMU2ZkOh90dJ2G2RvbVpQsbZhsfQPqV10mJW80NKrDBB09ichgJ+90a+0Ym
         0kDtzFWcG3Wa/V8ZKA28L5Pd+A0RePDzdStZIlUY21rYO8p3BXh9ILVbkn/92Ia6QHd0
         xHqiQnwWyjyYkRPrnkYT5tX/1grZZESoycO3uAlYOPnKMUcLaLwt9OmGcx0IDlInYU6v
         e/6Q==
X-Gm-Message-State: ABUngvfmzpntpXLo3FUdaaWvkQGm85rjjPa2qCSSoHu6NO4e3iobHlf8FFlvq2U3tIDhv+zQ
X-Received: by 10.98.35.211 with SMTP id q80mr13558890pfj.26.1478810097618;
        Thu, 10 Nov 2016 12:34:57 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:b504:dcf8:965a:7ab8])
        by smtp.gmail.com with ESMTPSA id h10sm4940584paw.37.2016.11.10.12.34.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 10 Nov 2016 12:34:57 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, bmwill@google.com, pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 16/35] attr: expose validity check for attribute names
Date:   Thu, 10 Nov 2016 12:34:09 -0800
Message-Id: <20161110203428.30512-17-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.469.g00a8914
In-Reply-To: <20161110203428.30512-1-sbeller@google.com>
References: <20161110203428.30512-1-sbeller@google.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 39 +++++++++++++++++++++++++--------------
 attr.h | 10 ++++++++++
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/attr.c b/attr.c
index 9bec243..14bbfd4 100644
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
 
 static struct git_attr *git_attr_internal(const char *name, int len)
@@ -90,7 +105,7 @@ static struct git_attr *git_attr_internal(const char *name, int len)
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
index c84f164..1c6a6d8 100644
--- a/attr.h
+++ b/attr.h
@@ -10,6 +10,16 @@ struct git_attr;
  */
 struct git_attr *git_attr(const char *);
 
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
2.10.1.469.g00a8914

