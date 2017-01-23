Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ADAA20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751665AbdAWUgL (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:36:11 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36566 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbdAWUgH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:36:07 -0500
Received: by mail-pg0-f47.google.com with SMTP id t6so47713752pgt.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P5bUG6mAL/aCA6ZMEj1aG8OizUCBvChg3bDrE+LSdQU=;
        b=gsOeQyfaCH0bFnOkYYGivfm9ycvN2cWMymcJN5eFAQuWK9BgdR50wqHfPQHYaJL7bJ
         yLBk7KGDtA8nvqTDUkB5cyRYOl8rU3kJ4CvGJ9xdhqOsR4PGGxGKBaqgpEu159sxjqmM
         +FSl/mMolgU9odp23HEcGwPk765lxbSdpNWtrBs2Ktvj/7iVPqDa9VH2O3uUNXtgN5Cy
         PyZ3jFXvKRUGGvrEItVBMeSS4y2BzgjLPI5qpkLTQ7KvXCIEzGgYxzRE/bBp1OVx78tm
         fCRnYTQixHdXl5p0eECgqdBjcjIq3zDdp+6leNlErLjxHrniNyFnxo0lvQ+n5X+crR3s
         fqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P5bUG6mAL/aCA6ZMEj1aG8OizUCBvChg3bDrE+LSdQU=;
        b=uGdzqPfhnThf52Lg88Xqu+uUp5r/wsKSOslI3Q08i/gupe13uu1A6d6+6KaKeFOafx
         y1Mzz5kLPkP3yAOLZzV96da2Pk/oe7w0h2kj6hCX+yW0jUf198OwcfsZsIBtQjsKvwot
         JFl5a/GXOFRp/+QsQjYGULyHtORfka0AB3GpEWiUSoOuXwj+rkjoCeEDIDlxTtFCGOZz
         xYaY1sV+5jo3M/ToMHE6rr5C/pTQvyxalsWO5S0PZtxFjx6YkQQ6kkneTCHRjFRkWyov
         17DTGdPorGadtqX5RhizqKkDm+l33om6PlECJdt5SlS1IuhZ7YEmVeLf8RsDrVnmr2iy
         G6Vw==
X-Gm-Message-State: AIkVDXJ/TfEUeYMeskzKUz+qgipfMHRv9a0uyvUkQHyOECWFvP8ga6Jb0xkY7WLgZZc0Q2sy
X-Received: by 10.98.108.196 with SMTP id h187mr33884057pfc.176.1485203767023;
        Mon, 23 Jan 2017 12:36:07 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:36:05 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 20/27] attr: change validity check for attribute names to use positive logic
Date:   Mon, 23 Jan 2017 12:35:18 -0800
Message-Id: <20170123203525.185058-21-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Convert 'invalid_attr_name()' to 'attr_name_valid()' and use positive
logic for the return value.  In addition create a helper function that
prints out an error message when an invalid attribute name is used.

We could later update the message to exactly spell out what the
rules for a good attribute name are, etc.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 attr.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/attr.c b/attr.c
index e58fa340c..5399e1cb3 100644
--- a/attr.c
+++ b/attr.c
@@ -74,23 +74,33 @@ static unsigned hash_name(const char *name, int namelen)
 	return val;
 }
 
-static int invalid_attr_name(const char *name, int namelen)
+static int attr_name_valid(const char *name, size_t namelen)
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
+static void report_invalid_attr(const char *name, size_t len,
+				const char *src, int lineno)
+{
+	struct strbuf err = STRBUF_INIT;
+	strbuf_addf(&err, _("%.*s is not a valid attribute name"),
+		    (int) len, name);
+	fprintf(stderr, "%s: %s:%d\n", err.buf, src, lineno);
+	strbuf_release(&err);
 }
 
 static struct git_attr *git_attr_internal(const char *name, int len)
@@ -105,7 +115,7 @@ static struct git_attr *git_attr_internal(const char *name, int len)
 			return a;
 	}
 
-	if (invalid_attr_name(name, len))
+	if (!attr_name_valid(name, len))
 		return NULL;
 
 	FLEX_ALLOC_MEM(a, name, name, len);
@@ -196,17 +206,15 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
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
@@ -258,10 +266,8 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
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
-- 
2.11.0.483.g087da7b7c-goog

