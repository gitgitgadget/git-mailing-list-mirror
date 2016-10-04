Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EA8620986
	for <e@80x24.org>; Tue,  4 Oct 2016 22:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbcJDWOl (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 18:14:41 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35712 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753217AbcJDWOk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 18:14:40 -0400
Received: by mail-pa0-f52.google.com with SMTP id ik13so23929206pac.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 15:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=gAO9hAYF5NBVJHv9a1jjVl7DjlOGFppW3K8/q1dXnk0=;
        b=MOSdvx4BYsyKWb5jrsiFovvXO4ehFzhad5nzPzlWDDFQsAOO8Kxg3s1S4NCO2GPA1w
         WC3JUSuqOyWNDnPCv3W6o347RX67MDPOhU9R7DUJzO8XITh/z4h/7EtJH3etCceZzb/v
         fVM5kcvYvx7gb8u3s8WArhEPckOd3r6FU1Y/xoljdoH/QIV/m2XRaqHZjXvIhg3VBme+
         M0AqcOVZW5SpCPOUBrMd6rj0/JF/KbGxvqmDdqV016z/ka9CeNPcgq1s5oTwor5PaEwx
         QYc10NPz3NAOXTrftlNlVRpyzSmNo318SxJpUWjRNbkls5yjVmZpnm16KqGv4sR95ll7
         r/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gAO9hAYF5NBVJHv9a1jjVl7DjlOGFppW3K8/q1dXnk0=;
        b=esrIRfui5MhMdoTXwAuPjglzHgV007q1MdGeU6d/6nb2a5jNjdwcQ40BYJwkD4vJLR
         IxNGga+8/SGmBxNzjvxHetYkPr6xMswcD2hTnjcbEyOk3fi/VYLxaYO+zFpAA9Dl6/Td
         +gG10N9jpm036TaFNPqWqcI+Xk98J/G2/QT45zn8EDFMKfcj7hocIdYGWnBEwhDibLPu
         e07Je7aHf4Po7sxjnU5DuLE1qDz8d0FcqciPzTHcri5dYpo4rfnojknGxNpmMYIRz+FB
         ZqkdBTumrimFCyfME4/Wn0/GEfIW5OrrF8JAcVDjaoaFfbl6mj0FtdzWDWnFZRKygNBq
         DiNw==
X-Gm-Message-State: AA6/9RlislM93VAlRwMJdWFUUQxlz6PLJueMsywdhSgS4NRb3wlxNJaugY3pjY9EZk0pIZoI
X-Received: by 10.66.189.194 with SMTP id gk2mr8374446pac.211.1475619279772;
        Tue, 04 Oct 2016 15:14:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:d1d:42df:48d7:33a4])
        by smtp.gmail.com with ESMTPSA id h82sm57616180pfh.22.2016.10.04.15.14.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 04 Oct 2016 15:14:39 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH] attr: Document a new possible thread safe API
Date:   Tue,  4 Oct 2016 15:14:33 -0700
Message-Id: <20161004221433.23747-1-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.129.g35f6318
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is what we want to see at the end of the refactoring session
to enable the attr subsystem to be thread safe.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Junio wrote:  
>> So how would we go about git_all_attrs then?
>
> I think you arrived the same conclusion, but ...
  
I think the changes as proposed are minimal to be able to use attrs in a
multithreaded environment. 
  
This patch applies on top of jc/attr-more.
A complete diff between origin/master..HEAD for the documentation is
appended below.
  
Thanks,
Stefan

 Documentation/technical/api-gitattributes.txt | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index 92fc32a..940617e 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -59,7 +59,10 @@ Querying Specific Attributes
   empty `struct git_attr_check` can be prepared by calling
   `git_attr_check_alloc()` function and then attributes you want to
   ask about can be added to it with `git_attr_check_append()`
-  function.
+  function. git_attr_check_initl is thread safe, i.e. you can call it
+  from different threads at the same time; internally however only one
+  call at a time is processed. If the calls from different threads have
+  the same arguments, the returned `git_attr_check` may be the same.
 
 * Call `git_check_attr()` to check the attributes for the path.
 
@@ -89,15 +92,21 @@ static void setup_check(void)
 
 ------------
 	const char *path;
+	struct git_attr_check *result;
 
 	setup_check();
-	git_check_attr(path, check);
+	result = git_check_attr(path, check);
 ------------
 
-. Act on `.value` member of the result, left in `check->check[]`:
+The result may be the same as `check` (in a single threaded application),
+but generally assume it is not. The `result` must not be free'd as it is
+owned by the attr subsystem. It is reused by the same thread, so a subsequent
+call to git_check_attr in the same thread will overwrite the result.
+
+. Act on `.value` member of the `result->check[]`:
 
 ------------
-	const char *value = check->check[0].value;
+	const char *value = result->check[0].value;
 
 	if (ATTR_TRUE(value)) {
 		The attribute is Set, by listing only the name of the
@@ -138,10 +147,7 @@ Querying All Attributes
 
 To get the values of all attributes associated with a file:
 
-* Prepare an empty `git_attr_check` structure by calling
-  `git_attr_check_alloc()`.
-
-* Call `git_all_attrs()`, which populates the `git_attr_check`
+* Call `git_all_attrs()`, which returns a `git_attr_check`
   with the attributes attached to the path.
 
 * Iterate over the `git_attr_check.check[]` array to examine
-- 
2.10.0.129.g35f6318






The following is `git diff origin/master Documentation/technical/api-gitattributes.txt`:

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index 2602668..940617e 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -16,10 +16,15 @@ Data Structure
 	of no interest to the calling programs.  The name of the
 	attribute can be retrieved by calling `git_attr_name()`.
 
+`struct git_attr_check_elem`::
+
+	This structure represents one attribute and its value.
+
 `struct git_attr_check`::
 
-	This structure represents a set of attributes to check in a call
-	to `git_check_attr()` function, and receives the results.
+	This structure represents a collection of `git_attr_check_elem`.
+	It is passed to `git_check_attr()` function, specifying the
+	attributes to check, and receives their values.
 
 
 Attribute Values
@@ -48,49 +53,60 @@ value of the attribute for the path.
 Querying Specific Attributes
 ----------------------------
 
-* Prepare an array of `struct git_attr_check` to define the list of
-  attributes you would want to check.  To populate this array, you would
-  need to define necessary attributes by calling `git_attr()` function.
+* Prepare `struct git_attr_check` using git_attr_check_initl()
+  function, enumerating the names of attributes whose values you are
+  interested in, terminated with a NULL pointer.  Alternatively, an
+  empty `struct git_attr_check` can be prepared by calling
+  `git_attr_check_alloc()` function and then attributes you want to
+  ask about can be added to it with `git_attr_check_append()`
+  function. git_attr_check_initl is thread safe, i.e. you can call it
+  from different threads at the same time; internally however only one
+  call at a time is processed. If the calls from different threads have
+  the same arguments, the returned `git_attr_check` may be the same.
 
 * Call `git_check_attr()` to check the attributes for the path.
 
-* Inspect `git_attr_check` structure to see how each of the attribute in
-  the array is defined for the path.
+* Inspect `git_attr_check` structure to see how each of the
+  attribute in the array is defined for the path.
 
 
 Example
 -------
 
-To see how attributes "crlf" and "indent" are set for different paths.
+To see how attributes "crlf" and "ident" are set for different paths.
 
-. Prepare an array of `struct git_attr_check` with two elements (because
-  we are checking two attributes).  Initialize their `attr` member with
-  pointers to `struct git_attr` obtained by calling `git_attr()`:
+. Prepare a `struct git_attr_check` with two elements (because
+  we are checking two attributes):
 
 ------------
-static struct git_attr_check check[2];
+static struct git_attr_check *check;
 static void setup_check(void)
 {
-	if (check[0].attr)
+	if (check)
 		return; /* already done */
-	check[0].attr = git_attr("crlf");
-	check[1].attr = git_attr("ident");
+	check = git_attr_check_initl("crlf", "ident", NULL);
 }
 ------------
 
-. Call `git_check_attr()` with the prepared array of `struct git_attr_check`:
+. Call `git_check_attr()` with the prepared `struct git_attr_check`:
 
 ------------
 	const char *path;
+	struct git_attr_check *result;
 
 	setup_check();
-	git_check_attr(path, ARRAY_SIZE(check), check);
+	result = git_check_attr(path, check);
 ------------
 
-. Act on `.value` member of the result, left in `check[]`:
+The result may be the same as `check` (in a single threaded application),
+but generally assume it is not. The `result` must not be free'd as it is
+owned by the attr subsystem. It is reused by the same thread, so a subsequent
+call to git_check_attr in the same thread will overwrite the result.
+
+. Act on `.value` member of the `result->check[]`:
 
 ------------
-	const char *value = check[0].value;
+	const char *value = result->check[0].value;
 
 	if (ATTR_TRUE(value)) {
 		The attribute is Set, by listing only the name of the
@@ -109,20 +125,36 @@ static void setup_check(void)
 	}
 ------------
 
+To see how attributes in argv[] are set for different paths, only
+the first step in the above would be different.
+
+------------
+static struct git_attr_check *check;
+static void setup_check(const char **argv)
+{
+	check = git_attr_check_alloc();
+	while (*argv) {
+		struct git_attr *attr = git_attr(*argv);
+		git_attr_check_append(check, attr);
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
+* Call `git_all_attrs()`, which returns a `git_attr_check`
+  with the attributes attached to the path.
 
-* Iterate over the `git_attr_check` array to examine the attribute
-  names and values.  The name of the attribute described by a
-  `git_attr_check` object can be retrieved via
-  `git_attr_name(check[i].attr)`.  (Please note that no items will be
-  returned for unset attributes, so `ATTR_UNSET()` will return false
-  for all returned `git_array_check` objects.)
+* Iterate over the `git_attr_check.check[]` array to examine
+  the attribute names and values.  The name of the attribute
+  described by a  `git_attr_check.check[]` object can be retrieved via
+  `git_attr_name(check->check[i].attr)`.  (Please note that no items
+  will be returned for unset attributes, so `ATTR_UNSET()` will return
+  false for all returned `git_array_check` objects.)
 
-* Free the `git_array_check` array.
+* Free the `git_array_check` by calling `git_attr_check_free()`.




