Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923E2EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 15:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjFUP5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 11:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbjFUP5G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 11:57:06 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB3C1A1
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 08:57:03 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-543a89d0387so2650120a12.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687363023; x=1689955023;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PgUthIPRWetdNVfXhjZ1jIvbeX4FHosRk5VM4ObQ8mQ=;
        b=xajZq/JCaG46my0Ma5rJu0gkZH1nCv8cy2mtMUA0peG61njzvkEFvgoPFTU2Mj43fb
         pgl09DW4lbRNqS9Ynvb+d/BBLIPYALMKHypbSAMXT8/yMY9ezUtRgTCmGrPtl042QqyM
         MdwjGfBFvG7zq//k2LPGX19bu9T0k6Kc5xRw6jgzdE2ahgQ/6946+E7+TOklUjBVbnL5
         exP9UqJE9eqBnj/LMxKaKWaiBfXYIbFLI8aJuYd2zd/m2zNagK58RNv4fCyRFlxERVBw
         RSds7JTkB7FZfuW5sL3pEQwkkLdOuRaHq9sn/GUM98BSC86OO6zXWNdLTjam/sD811RP
         nlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687363023; x=1689955023;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PgUthIPRWetdNVfXhjZ1jIvbeX4FHosRk5VM4ObQ8mQ=;
        b=cIouDoBo3ADbuQQuYqOoxgmESUY7QGe+6HPbGG4H4fLOEupMUJmTazUyXxVujTvRs0
         vbFa2sYsr53aWltuvppKAS7XI5L48MIerl1gbUEhtPEgDBHj8xXkg8rLdxsHBNZwg23N
         p9ajgkxXb8ZlI/pBeP4irvy5a05KY4Yny+xwaWXdB3wSOaYhIJBFVG+osw+M1af3EIAh
         21+4Ugp5K087u9pnlDxmPi3ffn+cXJNKy4bFIS9j9HJHvbG6laPn3z69TG0SKvNVnrf7
         P7HDaS0GlytpYWDoqknNc9lwFxcmCdjQE0zd3P7ZpvlOOKGokV0aOpf4Uq+Dli8EAFrH
         dRPw==
X-Gm-Message-State: AC+VfDx58l6C6Kv2S2WGWZxXU1avax2VVZjgItuNniNYRgSJPzCzrU6c
        jOs4zt2nJj4ltCUfKkPEMgGt5AdHqeA=
X-Google-Smtp-Source: ACHHUZ6kwxI9SmHVTqEDxmPe/SIFHNcJaKzy1hWXZV19Z6qy5ITtcQMXhPfZaedhlCEx4Id2HA99BC0Gp6I=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a63:dc04:0:b0:53f:f4c5:e81e with SMTP id
 s4-20020a63dc04000000b0053ff4c5e81emr1813155pgg.6.1687363022729; Wed, 21 Jun
 2023 08:57:02 -0700 (PDT)
Date:   Wed, 21 Jun 2023 08:57:01 -0700
In-Reply-To: <c902a166-98ce-afba-93f2-ea6027557176@gmail.com>
Mime-Version: 1.0
References: <20230427175007.902278-1-calvinwan@google.com> <20230427175007.902278-2-calvinwan@google.com>
 <afd3e80f-99d9-7472-36e7-335f86263d09@gmail.com> <CAFySSZCQfeGnrMPKHwsrT+UvaH_+t=nGhUPUtdVuijOmrrWejA@mail.gmail.com>
 <c902a166-98ce-afba-93f2-ea6027557176@gmail.com>
Message-ID: <owly8rcc3j1u.fsf@fine.c.googlers.com>
Subject: Re: [RFC PATCH 1/2] Add C TAP harness
From:   Linus Arver <linusa@google.com>
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Calvin Wan <calvinwan@google.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Phillip Wood <phillip.wood123@gmail.com> writes:
> I'd be interested to hear what you think of the alternative
> approach in the patch below. The patch can be fetched with
>
> git fetch https://github.com/phillipwood/git unit-tests

I tried out your unit testing framework to see how it works in practice.
It has most of what I'd expect in a test framework, e.g. showing file
and line number in a test failure. Here are some changes I'd like to
see:

- Make the 'TEST' macro accept the test description first. Or, keep the
  'TEST' macro but also name a new macro 'IT' that accepts the
  description first, to encourage usage that reads in a
  behavior-driven-development (BDD) style, like 'IT("should accept foo",
  t_bar(...))'. I find some test descriptions easier to write this way.
- The 'check_int(result, ==, expected)' usage would be better without
  the commas, like 'check_int(result == expected)'. Is this possible?
- It would be nice to report the test name for failing tests, so that
  this output can be parsed to check for the failing test name.

There are other smaller changes I'd like (such as optional
colorization), but I think these bits can be sorted out much later.

My patch can be found at

   git fetch https://github.com/listx/git trailer-unit-tests

and also inline at the bottom of this email message.

Build and test with

    make unit-tests && t/unit-tests/t-trailer

Sample output:

    $ make -j47 unit-tests && t/unit-tests/t-trailer
        CC t/unit-tests/t-trailer.o
        LINK t/unit-tests/t-trailer
    ok 1 - empty trailer_item and arg_item
    ok 2 - identical
    ok 3 - case should not matter
    ok 4 - arg_item is longer than trailer_item
    ok 5 - trailer_item is longer than arg_item
    ok 6 - no similarity
    ok 7 - accept WHERE_AFTER
    ok 8 - accept WHERE_END
    ok 9 - reject WHERE_END
    ok 10 - token with trailing punctuation (colon)
    ok 11 - token without trailing punctuation
    ok 12 - token with spaces with trailing punctuation (colon)
    ok 13 - token with spaces without trailing punctuation
    ok 14 - token with leading non-separator punctuation
    ok 15 - token with leading non-separator punctuation and space
    ok 16 - one-letter token
    ok 17 - token with punctuation in-between
    ok 18 - token with multiple leading punctuation chars
    # check "result == expected" failed at t/unit-tests/t-trailer.c:25
    #    left: 1
    #   right: 0
    not ok 19 - empty trailer_item
    # check "result == expected" failed at t/unit-tests/t-trailer.c:25
    #    left: 1
    #   right: 0
    not ok 20 - empty arg_item
    1..20

Note that some of the tests I expect to fail are passing. These may be
bugs but I am not sure because I don't fully understand the
interpret-trailers machinery yet.

Linus

---- >8 ----
From e5907b328d35eb37cfd1feb3a2431cb672beb4c8 Mon Sep 17 00:00:00 2001
From: Linus Arver <linusa@google.com>
Date: Thu, 15 Jun 2023 18:25:47 -0700
Subject: [PATCH] add some unit tests for interpret-trailers

Signed-off-by: Linus Arver <linusa@google.com>
---
 Makefile                 |  5 +++
 t/unit-tests/t-trailer.c | 77 ++++++++++++++++++++++++++++++++++++++++
 trailer.c                | 33 ++---------------
 trailer.h                | 32 +++++++++++++++++
 4 files changed, 117 insertions(+), 30 deletions(-)
 create mode 100644 t/unit-tests/t-trailer.c

diff --git a/Makefile b/Makefile
index f0ca5bae4b..9d68518168 100644
--- a/Makefile
+++ b/Makefile
@@ -2668,6 +2668,7 @@ scalar-objs: $(SCALAR_OBJS)
 
 UNIT_TEST_PROGRAMS += t-basic
 UNIT_TEST_PROGRAMS += t-strbuf
+UNIT_TEST_PROGRAMS += t-trailer
 UNIT_TEST_PROGS = $(patsubst %,t/unit-tests/%$X,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS = $(patsubst %,t/unit-tests/%.o,$(UNIT_TEST_PROGRAMS))
 UNIT_TEST_OBJS += t/unit-tests/test-lib.o
@@ -3848,5 +3849,9 @@ t/unit-tests/t-strbuf$X: t/unit-tests/t-strbuf.o t/unit-tests/test-lib.o $(GITLI
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		 $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
+t/unit-tests/t-trailer$X: t/unit-tests/t-trailer.o t/unit-tests/test-lib.o builtin/interpret-trailers.o $(GITLIBS) GIT-LDFLAGS
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
+		 $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
+
 .PHONY: unit-tests
 unit-tests: $(UNIT_TEST_PROGS)
diff --git a/t/unit-tests/t-trailer.c b/t/unit-tests/t-trailer.c
new file mode 100644
index 0000000000..150b5606fa
--- /dev/null
+++ b/t/unit-tests/t-trailer.c
@@ -0,0 +1,77 @@
+#include "test-lib.h"
+#include "trailer.h"
+
+static void t_token_len_without_separator(const char *token, size_t expected)
+{
+	size_t result;
+	result = token_len_without_separator(token, strlen(token));
+	check_uint(result, ==, expected);
+}
+
+static void t_after_or_end(enum trailer_where where, int expected)
+{
+	size_t result;
+	result = after_or_end(where);
+	check_int(result, ==, expected);
+}
+
+
+static void t_same_token(char *a, char *b, int expected)
+{
+    struct trailer_item trailer_item = { .token = a };
+	struct arg_item arg_item = { .token = b };
+	size_t result;
+	result = same_token(&trailer_item, &arg_item);
+	check_int(result, ==, expected);
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	TEST(t_same_token("", "", 1),
+		 "empty trailer_item and arg_item");
+	TEST(t_same_token("foo", "foo", 1),
+		 "identical");
+	TEST(t_same_token("foo", "FOO", 1),
+		 "case should not matter");
+	TEST(t_same_token("foo", "foobar", 1),
+		 "arg_item is longer than trailer_item");
+	TEST(t_same_token("foobar", "foo", 1),
+		 "trailer_item is longer than arg_item");
+	TEST(t_same_token("foo", "bar", 0),
+		 "no similarity");
+
+	TEST(t_after_or_end(WHERE_AFTER, 1), "accept WHERE_AFTER");
+	TEST(t_after_or_end(WHERE_END, 1), "accept WHERE_END");
+	TEST(t_after_or_end(WHERE_DEFAULT, 0), "reject WHERE_END");
+
+	TEST(t_token_len_without_separator("Signed-off-by:", 13),
+	     "token with trailing punctuation (colon)");
+	TEST(t_token_len_without_separator("Signed-off-by", 13),
+	     "token without trailing punctuation");
+	TEST(t_token_len_without_separator("Foo bar:", 7),
+	     "token with spaces with trailing punctuation (colon)");
+	TEST(t_token_len_without_separator("Foo bar", 7),
+	     "token with spaces without trailing punctuation");
+	TEST(t_token_len_without_separator("-Foo bar:", 8),
+	     "token with leading non-separator punctuation");
+	TEST(t_token_len_without_separator("- Foo bar:", 9),
+	     "token with leading non-separator punctuation and space");
+	TEST(t_token_len_without_separator("F:", 1),
+	     "one-letter token");
+	TEST(t_token_len_without_separator("abc%de#f@", 8),
+	     "token with punctuation in-between");
+	TEST(t_token_len_without_separator(":;*%_.#f@", 8),
+	     "token with multiple leading punctuation chars");
+
+	/*
+	 * These tests fail unexpectedly. They are probably bugs, although it may be
+	 * the case that these bugs never bubble up to the user because of other
+	 * checks we do elsewhere up the stack.
+	 */
+	TEST(t_same_token("", "foo", 0),
+		"empty trailer_item");
+	TEST(t_same_token("foo", "", 0),
+		"empty arg_item");
+
+	return test_done();
+}
diff --git a/trailer.c b/trailer.c
index a2c3ed6f28..9f59d8d7a6 100644
--- a/trailer.c
+++ b/trailer.c
@@ -13,35 +13,8 @@
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
 
-struct conf_info {
-	char *name;
-	char *key;
-	char *command;
-	char *cmd;
-	enum trailer_where where;
-	enum trailer_if_exists if_exists;
-	enum trailer_if_missing if_missing;
-};
-
 static struct conf_info default_conf_info;
 
-struct trailer_item {
-	struct list_head list;
-	/*
-	 * If this is not a trailer line, the line is stored in value
-	 * (excluding the terminating newline) and token is NULL.
-	 */
-	char *token;
-	char *value;
-};
-
-struct arg_item {
-	struct list_head list;
-	char *token;
-	char *value;
-	struct conf_info conf;
-};
-
 static LIST_HEAD(conf_head);
 
 static char *separators = ":";
@@ -62,7 +35,7 @@ static const char *git_generated_prefixes[] = {
 		pos != (head); \
 		pos = is_reverse ? pos->prev : pos->next)
 
-static int after_or_end(enum trailer_where where)
+int after_or_end(enum trailer_where where)
 {
 	return (where == WHERE_AFTER) || (where == WHERE_END);
 }
@@ -73,14 +46,14 @@ static int after_or_end(enum trailer_where where)
  * 13, stripping the trailing punctuation but retaining
  * internal punctuation.
  */
-static size_t token_len_without_separator(const char *token, size_t len)
+size_t token_len_without_separator(const char *token, size_t len)
 {
 	while (len > 0 && !isalnum(token[len - 1]))
 		len--;
 	return len;
 }
 
-static int same_token(struct trailer_item *a, struct arg_item *b)
+int same_token(struct trailer_item *a, struct arg_item *b)
 {
 	size_t a_len, b_len, min_len;
 
diff --git a/trailer.h b/trailer.h
index 795d2fccfd..b2031eb305 100644
--- a/trailer.h
+++ b/trailer.h
@@ -146,4 +146,36 @@ int trailer_iterator_advance(struct trailer_iterator *iter);
  */
 void trailer_iterator_release(struct trailer_iterator *iter);
 
+int after_or_end(enum trailer_where where);
+size_t token_len_without_separator(const char *token, size_t len);
+
+struct conf_info {
+	char *name;
+	char *key;
+	char *command;
+	char *cmd;
+	enum trailer_where where;
+	enum trailer_if_exists if_exists;
+	enum trailer_if_missing if_missing;
+};
+
+struct trailer_item {
+	struct list_head list;
+	/*
+	 * If this is not a trailer line, the line is stored in value
+	 * (excluding the terminating newline) and token is NULL.
+	 */
+	char *token;
+	char *value;
+};
+
+struct arg_item {
+	struct list_head list;
+	char *token;
+	char *value;
+	struct conf_info conf;
+};
+
+int same_token(struct trailer_item *a, struct arg_item *b);
+
 #endif /* TRAILER_H */
-- 
2.41.0.162.gfafddb0af9-goog
