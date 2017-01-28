Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF6AB1F437
	for <e@80x24.org>; Sat, 28 Jan 2017 02:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbdA1CDP (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 21:03:15 -0500
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35629 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbdA1CC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 21:02:57 -0500
Received: by mail-pg0-f43.google.com with SMTP id 194so85529947pgd.2
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 18:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fI/hqMr4xKjETu7pdwececL7g1MGNKXblTyFgS4ssS8=;
        b=EWWRsUtPmf/A6QnGmn8iGwxcVtMPUJxafYP8rRENWMGBLUIoGsphyDiB/BzsA/M1JH
         Hr4q6yhIZJ/p76oj9XitVKTCJzblIWYbAk8BEvehIictCmvJmQNbG5PbDsERmPubg0d4
         aZPnA3N/N7Irpd0lrByEj43NHdPK31LZCsu2Nz9AYbgH129pbWu67zpiwbbeXVx/3tUr
         wUcIhGHRSYIgl53hTBDtudXsHSEY1u8w76cdOqEMUSjS/DN1WTSB2ccPZVwFIprURA5i
         mnmxXLK/wl96g+c16QKbomd26+GJ/wYrE7VrYdn6Zz04bvxOIhyudhl7DWTkwUnHSK/B
         NqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fI/hqMr4xKjETu7pdwececL7g1MGNKXblTyFgS4ssS8=;
        b=FBGKXB/FRHjExFjQ8zZzMV6SWgB/3lYchTc6DmkUoU/iv5OpSgQVw/KIOSoyeF1P0a
         S1AVgmcsaH1KFSgEUqeEGqoVMVb2ymTCUUNwgiIIIt32/H7pNtYdEWqoA8ZHXySG0AS+
         G8//8WQF9/cAbDRFv5eKU1KH1zi+b/0lNbB7BymjSUq4fIaZsW/1CYD9focGwisb5W9y
         K14oc+8BlTDGnzgtHLNhSKN2KwChF2LL2xSEVmWuMax615TKRq/uUhLGYw0O4z6LX7AN
         qdESqAVtgSWRvMI0mr4fQEAAhIIJmgDza8plluODUbFTFEU7gg+5jlmLmWcHBn93ntZe
         0QOA==
X-Gm-Message-State: AIkVDXLJFcc7GJrlYSWQGpX/pNO1Zo65p5wKCIgOK+m2qlQ0+9qsq/JW7H1VgE2mhRP56cju
X-Received: by 10.84.135.162 with SMTP id 31mr13924816plj.35.1485568976147;
        Fri, 27 Jan 2017 18:02:56 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id w76sm14136185pfd.74.2017.01.27.18.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jan 2017 18:02:54 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 18/27] attr: retire git_check_attrs() API
Date:   Fri, 27 Jan 2017 18:01:58 -0800
Message-Id: <20170128020207.179015-19-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170128020207.179015-1-bmwill@google.com>
References: <20170123203525.185058-1-bmwill@google.com>
 <20170128020207.179015-1-bmwill@google.com>
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
index 260266867..e7cbb7c13 100644
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
+. Act on `.value` member of the result, left in `check->items[]`:
 
 ------------
-	const char *value = check[0].value;
+	const char *value = check->items[0].value;
 
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
+* Iterate over the `attr_check.items[]` array to examine
+  the attribute names and values.  The name of the attribute
+  described by a  `attr_check.items[]` object can be retrieved via
+  `git_attr_name(check->items[i].attr)`.  (Please note that no items
+  will be returned for unset attributes, so `ATTR_UNSET()` will return
+  false for all returned `attr_check.items[]` objects.)
 
-* Free the `git_array_check` array.
+* Free the `attr_check` struct by calling `attr_check_free()`.
diff --git a/attr.c b/attr.c
index 40818246f..c0e7893b5 100644
--- a/attr.c
+++ b/attr.c
@@ -890,7 +890,8 @@ static void collect_some_attrs(const char *path, int num,
 		rem = fill(path, pathlen, basename_offset, stk, rem);
 }
 
-int git_check_attrs(const char *path, int num, struct attr_check_item *check)
+static int git_check_attrs(const char *path, int num,
+			   struct attr_check_item *check)
 {
 	int i;
 
diff --git a/attr.h b/attr.h
index 9f2729842..b2cfd8550 100644
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

