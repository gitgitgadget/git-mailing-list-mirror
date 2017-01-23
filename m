Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E77720A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751702AbdAWUgd (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:36:33 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34631 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751642AbdAWUgF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:36:05 -0500
Received: by mail-pf0-f177.google.com with SMTP id e4so43646466pfg.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AptfrOUTbTjNnxnl88JhwNt54jzAFhmw32I+VNfpRsQ=;
        b=dt4OhzQtje7R0lYM0FKQrLS1+dbaqqP1JC7vTlzetMDz5fg1cCVglzs5tP20ee3V/G
         lOrWQqwa+WL48OCcjvtORZEI7NG4fQ01PCH2rJy3OjMGIbJmeMTZxrBcZ8hGFU5cqZo8
         6DShrVR5x1c8Gf6EIOuoWsSzJigwk97clB70LZAg6fWYkGOniqpBOU8XJwYFurNM40BU
         zFH6YtyoQm/Vt3d0MZ4D3LG0mQ4puXbrvSMGnElVrdBD7qWNF8chyOBHYaRj6X1CBLla
         p3nL9T4HXYH6RaYvQw78MzY5SF7o8Ttk7OsrzbVIvVD0lK5oqwHfduPuwvPAKCENqVfy
         6ueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AptfrOUTbTjNnxnl88JhwNt54jzAFhmw32I+VNfpRsQ=;
        b=tA40CygJe/sq7RNFdstSS7OCdGuftbS9vxzPPMkBnlZWbvhO1SWeOvg8ym9JQOrVkc
         WpMES/uF4rOGYJHsMCX+kPjX1VLLZq3lnQ7Dgjp5N2fUPGaT1Qt6P38iQBGfJwH+afHm
         g5LTFiyYxB1oSvqjgNJiWTWJ/93Z4jb0vlwhtKbfIRAqECrOubiRe42VnVM9GY9TlooS
         6KKqwRSsHJb0N1MxNT2kKd1nB10kzsp6PwOM4s5oN2OTgKQQM0cRYgkPcZZLSjFCg4YT
         q5V4SQ/DRyfXP0nTc0TdNLrnZ2vLsFSArY+q6WAe89Rms7cVHaL9/Ee8hg4x9MdxA/y7
         934w==
X-Gm-Message-State: AIkVDXJ+NIZ1ktNoUjJHmR9AcMwf/kTCkp4kKVRdXpypa2YbyH1EdM/6RAGdXNkuuC8xTkRa
X-Received: by 10.84.128.33 with SMTP id 30mr46273483pla.128.1485203764134;
        Mon, 23 Jan 2017 12:36:04 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:36:03 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 18/27] attr: retire git_check_attrs() API
Date:   Mon, 23 Jan 2017 12:35:16 -0800
Message-Id: <20170123203525.185058-19-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Since nobody uses the old API, make it file-scope static, and update
the documentation to describe the new API.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/technical/api-gitattributes.txt | 86 +++++++++++++++++----------
 attr.c                                        |  3 +-
 attr.h                                        |  1 -
 3 files changed, 58 insertions(+), 32 deletions(-)

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index 260266867..82f5130e7 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -16,10 +16,15 @@ Data Structure
 	of no interest to the calling programs.  The name of the
 	attribute can be retrieved by calling `git_attr_name()`.
 
-`struct git_attr_check`::
+`struct attr_check_item`::
 
-	This structure represents a set of attributes to check in a call
-	to `git_check_attr()` function, and receives the results.
+	This structure represents one attribute and its value.
+
+`struct attr_check`::
+
+	This structure represents a collection of `attr_check_item`.
+	It is passed to `git_check_attr()` function, specifying the
+	attributes to check, and receives their values.
 
 
 Attribute Values
@@ -27,7 +32,7 @@ Attribute Values
 
 An attribute for a path can be in one of four states: Set, Unset,
 Unspecified or set to a string, and `.value` member of `struct
-git_attr_check` records it.  There are three macros to check these:
+attr_check_item` records it.  There are three macros to check these:
 
 `ATTR_TRUE()`::
 
@@ -48,49 +53,51 @@ value of the attribute for the path.
 Querying Specific Attributes
 ----------------------------
 
-* Prepare an array of `struct git_attr_check` to define the list of
-  attributes you would want to check.  To populate this array, you would
-  need to define necessary attributes by calling `git_attr()` function.
+* Prepare `struct attr_check` using attr_check_initl()
+  function, enumerating the names of attributes whose values you are
+  interested in, terminated with a NULL pointer.  Alternatively, an
+  empty `struct attr_check` can be prepared by calling
+  `attr_check_alloc()` function and then attributes you want to
+  ask about can be added to it with `attr_check_append()`
+  function.
 
 * Call `git_check_attr()` to check the attributes for the path.
 
-* Inspect `git_attr_check` structure to see how each of the attribute in
-  the array is defined for the path.
+* Inspect `attr_check` structure to see how each of the
+  attribute in the array is defined for the path.
 
 
 Example
 -------
 
-To see how attributes "crlf" and "indent" are set for different paths.
+To see how attributes "crlf" and "ident" are set for different paths.
 
-. Prepare an array of `struct git_attr_check` with two elements (because
-  we are checking two attributes).  Initialize their `attr` member with
-  pointers to `struct git_attr` obtained by calling `git_attr()`:
+. Prepare a `struct attr_check` with two elements (because
+  we are checking two attributes):
 
 ------------
-static struct git_attr_check check[2];
+static struct attr_check *check;
 static void setup_check(void)
 {
-	if (check[0].attr)
+	if (check)
 		return; /* already done */
-	check[0].attr = git_attr("crlf");
-	check[1].attr = git_attr("ident");
+	check = attr_check_initl("crlf", "ident", NULL);
 }
 ------------
 
-. Call `git_check_attr()` with the prepared array of `struct git_attr_check`:
+. Call `git_check_attr()` with the prepared `struct attr_check`:
 
 ------------
 	const char *path;
 
 	setup_check();
-	git_check_attr(path, ARRAY_SIZE(check), check);
+	git_check_attr(path, check);
 ------------
 
-. Act on `.value` member of the result, left in `check[]`:
+. Act on `.value` member of the result, left in `check->check[]`:
 
 ------------
-	const char *value = check[0].value;
+	const char *value = check->check[0].value;
 
 	if (ATTR_TRUE(value)) {
 		The attribute is Set, by listing only the name of the
@@ -109,20 +116,39 @@ static void setup_check(void)
 	}
 ------------
 
+To see how attributes in argv[] are set for different paths, only
+the first step in the above would be different.
+
+------------
+static struct attr_check *check;
+static void setup_check(const char **argv)
+{
+	check = attr_check_alloc();
+	while (*argv) {
+		struct git_attr *attr = git_attr(*argv);
+		attr_check_append(check, attr);
+		argv++;
+	}
+}
+------------
+
 
 Querying All Attributes
 -----------------------
 
 To get the values of all attributes associated with a file:
 
-* Call `git_all_attrs()`, which returns an array of `git_attr_check`
-  structures.
+* Prepare an empty `attr_check` structure by calling
+  `attr_check_alloc()`.
+
+* Call `git_all_attrs()`, which populates the `attr_check`
+  with the attributes attached to the path.
 
-* Iterate over the `git_attr_check` array to examine the attribute
-  names and values.  The name of the attribute described by a
-  `git_attr_check` object can be retrieved via
-  `git_attr_name(check[i].attr)`.  (Please note that no items will be
-  returned for unset attributes, so `ATTR_UNSET()` will return false
-  for all returned `git_array_check` objects.)
+* Iterate over the `attr_check.check[]` array to examine
+  the attribute names and values.  The name of the attribute
+  described by a  `attr_check.check[]` object can be retrieved via
+  `git_attr_name(check->check[i].attr)`.  (Please note that no items
+  will be returned for unset attributes, so `ATTR_UNSET()` will return
+  false for all returned `attr_check.check[]` objects.)
 
-* Free the `git_array_check` array.
+* Free the `attr_check` struct by calling `attr_check_free()`.
diff --git a/attr.c b/attr.c
index d2eaa0410..da727e3fd 100644
--- a/attr.c
+++ b/attr.c
@@ -821,7 +821,8 @@ static void collect_some_attrs(const char *path, int num,
 		rem = fill(path, pathlen, basename_offset, stk, rem);
 }
 
-int git_check_attrs(const char *path, int num, struct attr_check_item *check)
+static int git_check_attrs(const char *path, int num,
+			   struct attr_check_item *check)
 {
 	int i;
 
diff --git a/attr.h b/attr.h
index 971bb9a38..3db9893ef 100644
--- a/attr.h
+++ b/attr.h
@@ -52,7 +52,6 @@ extern void attr_check_free(struct attr_check *check);
  */
 extern const char *git_attr_name(const struct git_attr *);
 
-int git_check_attrs(const char *path, int, struct attr_check_item *);
 extern int git_check_attr(const char *path, struct attr_check *check);
 
 /*
-- 
2.11.0.483.g087da7b7c-goog

