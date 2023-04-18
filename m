Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C78C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 19:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjDRTUC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 15:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjDRTT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 15:19:59 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E63AAF03
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:19:34 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54fe82d8bf5so157684467b3.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681845525; x=1684437525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=343Qxla/tclrYjEObik0B5i3+pGcL9+BeFxi6fybwzc=;
        b=LHuvD/zHsQj+kwqoLgFudFsY6IIIQvciJgHpZeL+gd4xpidzwRpOQ4aw6bAGFZwAkW
         rCLUEa3rq+6VYJim/ImQ9YC4jwy3czdBYMdBhsOD0A83JvQ+M2TJSQhTrqgYAuCaKonf
         csVyLNFi8EjVYJcehHEp4Ak2v/lebeVt8SH1z76n/eEVn/WD54G22Knu1eYD0kCYtjAI
         D6WdHrnr1eMLsC2w3a/cbXg+2lYEHI8fXDQ+xCLDEXipLhCY9T/zYV08fBllZ/oMIrr6
         nN1YVnRHcj6FupJ7+PdOGm0VvbXuxLuZNEfqO6quO9G7R21YVygt1VJ2d4pWbRCGXMY9
         HNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845525; x=1684437525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=343Qxla/tclrYjEObik0B5i3+pGcL9+BeFxi6fybwzc=;
        b=Jl3DcG88OFzvddgms63mtbGM/YiN83mJP5TjjAua8S5EO4n3+9DHpsC9EZzpB3774/
         cckMPfVeESYYqUsOVYi8ut9KN+joibhy0kGQeC2VV6QpJg1IhsaoZLcvzbAhQTVC/8b1
         5z0ISsI+DlSqyX/kYfZx2ORXTlqyckltMoID59+7uP/xUPH78+6fZoDJ/xAUJNcOb9B6
         EZ8qqiZZpHkmukjKRqJTtq3dH72i6IV+gi+Jkjku2WzxW0f51pT3rb8QVWfL852uPx6p
         4W1MfdvP/TAzkUI9u363q/JacM8SAA/S/gS0xRNeUK+/Xzvm+/JetbHgy/AG9vVGvMp1
         3IwA==
X-Gm-Message-State: AAQBX9dQ1HB2K84OWNEE8IdC7V8W9Y6fWEekWkraQMvvFkaUJpn49W1a
        E5tw8VaNc98Yy4pHFHPfsZDleyujEW8OWjbvp8piuw==
X-Google-Smtp-Source: AKy350ZmV+HAYJrvigNMmiaIjWLq6iRoQisuKVZqtXosOsIwLSA/FblwuwfCKme3PDbo1/wUWLivvA==
X-Received: by 2002:a0d:ca0f:0:b0:54f:ae60:867e with SMTP id m15-20020a0dca0f000000b0054fae60867emr951217ywd.7.1681845524854;
        Tue, 18 Apr 2023 12:18:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3-20020a811203000000b00545a08184f3sm4004875yws.131.2023.04.18.12.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:18:44 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:18:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/6] string-list: introduce
 `string_list_split_in_place_multi()`
Message-ID: <6658b231a906dde6acbe7ce156da693ef7dc40e6.1681845518.git.me@ttaylorr.com>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1681845518.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681845518.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a variant of the `string_list_split_in_place()` function that
takes a string of accepted delimiters.

By contrast to its cousin `string_list_split_in_place()` which splits
the given string at every instance of the single character `delim`, the
`_multi` variant splits the given string any any character appearing in
the string `delim`.

Like `strtok()`, the `_multi` variant skips past sequential delimiting
characters. For example:

    string_list_split_in_place(&xs, xstrdup("foo::bar::baz"), ":", -1);

would place in `xs` the elements "foo", "bar", and "baz".

Instead of using `strchr(2)` to locate the first occurrence of the given
delimiter character, `string_list_split_in_place_multi()` uses
`strcspn(2)` to move past the initial segment of characters comprised of
any characters in the delimiting set.

When only a single delimiting character is provided, `strcspn(2)` has
equivalent performance to `strchr(2)`. Modern `strcspn(2)`
implementations treat an empty delimiter or the singleton delimiter as a
special case and fall back to calling strchrnul(). Both glibc[1] and
musl[2] implement `strcspn(2)` this way.

Since the `_multi` variant is a generalization of the original
implementation, reimplement `string_list_split_in_place()` in terms of
the more general function by providing a single-character string for the
list of accepted delimiters.

To avoid regressions, update t0063 in this patch as well. Any "common"
test cases (i.e., those that produce the same result whether you call
`string_list_split()` or `string_list_split_in_place_multi()`) are
grouped into a loop which is parameterized over the function to test.

Any cases which aren't common (of which there is one existing case, and
a handful of new ones added which are specific to the `_multi` variant)
are tested independently.

[1]: https://sourceware.org/git/?p=glibc.git;a=blob;f=string/strcspn.c;hb=glibc-2.37#l35
[2]: https://git.musl-libc.org/cgit/musl/tree/src/string/strcspn.c?h=v1.2.3#n11

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 string-list.c               |  26 +++++++--
 string-list.h               |   7 +++
 t/helper/test-string-list.c |  15 ++++++
 t/t0063-string-list.sh      | 105 +++++++++++++++++++++++++-----------
 4 files changed, 118 insertions(+), 35 deletions(-)

diff --git a/string-list.c b/string-list.c
index db473f273e..b27a53f2e1 100644
--- a/string-list.c
+++ b/string-list.c
@@ -300,8 +300,9 @@ int string_list_split(struct string_list *list, const char *string,
 	}
 }
 
-int string_list_split_in_place(struct string_list *list, char *string,
-			       int delim, int maxsplit)
+static int string_list_split_in_place_1(struct string_list *list, char *string,
+					const char *delim, int maxsplit,
+					unsigned runs)
 {
 	int count = 0;
 	char *p = string, *end;
@@ -310,13 +311,16 @@ int string_list_split_in_place(struct string_list *list, char *string,
 		die("internal error in string_list_split_in_place(): "
 		    "list->strdup_strings must not be set");
 	for (;;) {
+		if (runs)
+			p += strspn(p, delim);
+
 		count++;
 		if (maxsplit >= 0 && count > maxsplit) {
 			string_list_append(list, p);
 			return count;
 		}
-		end = strchr(p, delim);
-		if (end) {
+		end = p + strcspn(p, delim);
+		if (end && *end) {
 			*end = '\0';
 			string_list_append(list, p);
 			p = end + 1;
@@ -326,3 +330,17 @@ int string_list_split_in_place(struct string_list *list, char *string,
 		}
 	}
 }
+
+int string_list_split_in_place_multi(struct string_list *list, char *string,
+				     const char *delim, int maxsplit)
+{
+	return string_list_split_in_place_1(list, string, delim, maxsplit, 1);
+}
+
+int string_list_split_in_place(struct string_list *list, char *string,
+			       int delim, int maxsplit)
+{
+	char delim_s[2] = { delim, 0 };
+
+	return string_list_split_in_place_1(list, string, delim_s, maxsplit, 0);
+}
diff --git a/string-list.h b/string-list.h
index c7b0d5d000..f01bbb0bb6 100644
--- a/string-list.h
+++ b/string-list.h
@@ -268,7 +268,14 @@ int string_list_split(struct string_list *list, const char *string,
  * new string_list_items point into string (which therefore must not
  * be modified or freed while the string_list is in use).
  * list->strdup_strings must *not* be set.
+ *
+ * The "_multi" variant splits the given string on any character
+ * appearing in "delim", and the non-"_multi" variant splits only on the
+ * given character. The "_multi" variant behaves like `strtok()` where
+ * no element contains the delimiting byte(s).
  */
+int string_list_split_in_place_multi(struct string_list *list, char *string,
+				     const char *delim, int maxsplit);
 int string_list_split_in_place(struct string_list *list, char *string,
 			       int delim, int maxsplit);
 #endif /* STRING_LIST_H */
diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index 2123dda85b..119bc9e1c9 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -73,6 +73,21 @@ int cmd__string_list(int argc, const char **argv)
 		return 0;
 	}
 
+	if (argc == 5 && !strcmp(argv[1], "split_in_place_multi")) {
+		struct string_list list = STRING_LIST_INIT_NODUP;
+		int i;
+		char *s = xstrdup(argv[2]);
+		const char *delim = argv[3];
+		int maxsplit = atoi(argv[4]);
+
+		i = string_list_split_in_place_multi(&list, s, delim, maxsplit);
+		printf("%d\n", i);
+		write_list(&list);
+		string_list_clear(&list, 0);
+		free(s);
+		return 0;
+	}
+
 	if (argc == 4 && !strcmp(argv[1], "filter")) {
 		/*
 		 * Retain only the items that have the specified prefix.
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index 46d4839194..9c5094616a 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -18,42 +18,53 @@ test_split () {
 	"
 }
 
-test_split "foo:bar:baz" ":" "-1" <<EOF
-3
-[0]: "foo"
-[1]: "bar"
-[2]: "baz"
-EOF
+test_split_in_place_multi () {
+	cat >expected &&
+	test_expect_success "split_in_place_multi $1 at $2, max $3" "
+		test-tool string-list split_in_place_multi '$1' '$2' '$3' >actual &&
+		test_cmp expected actual
+	"
+}
 
-test_split "foo:bar:baz" ":" "0" <<EOF
-1
-[0]: "foo:bar:baz"
-EOF
+for test_fn in test_split test_split_in_place_multi
+do
+	$test_fn "foo:bar:baz" ":" "-1" <<-\EOF
+	3
+	[0]: "foo"
+	[1]: "bar"
+	[2]: "baz"
+	EOF
 
-test_split "foo:bar:baz" ":" "1" <<EOF
-2
-[0]: "foo"
-[1]: "bar:baz"
-EOF
+	$test_fn "foo:bar:baz" ":" "0" <<-\EOF
+	1
+	[0]: "foo:bar:baz"
+	EOF
 
-test_split "foo:bar:baz" ":" "2" <<EOF
-3
-[0]: "foo"
-[1]: "bar"
-[2]: "baz"
-EOF
+	$test_fn "foo:bar:baz" ":" "1" <<-\EOF
+	2
+	[0]: "foo"
+	[1]: "bar:baz"
+	EOF
 
-test_split "foo:bar:" ":" "-1" <<EOF
-3
-[0]: "foo"
-[1]: "bar"
-[2]: ""
-EOF
+	$test_fn "foo:bar:baz" ":" "2" <<-\EOF
+	3
+	[0]: "foo"
+	[1]: "bar"
+	[2]: "baz"
+	EOF
 
-test_split "" ":" "-1" <<EOF
-1
-[0]: ""
-EOF
+	$test_fn "foo:bar:" ":" "-1" <<-\EOF
+	3
+	[0]: "foo"
+	[1]: "bar"
+	[2]: ""
+	EOF
+
+	$test_fn "" ":" "-1" <<-\EOF
+	1
+	[0]: ""
+	EOF
+done
 
 test_split ":" ":" "-1" <<EOF
 2
@@ -61,6 +72,38 @@ test_split ":" ":" "-1" <<EOF
 [1]: ""
 EOF
 
+test_split_in_place_multi "foo:;:bar:;:baz" ":;" "-1" <<-\EOF
+3
+[0]: "foo"
+[1]: "bar"
+[2]: "baz"
+EOF
+
+test_split_in_place_multi "foo:;:bar:;:baz" ":;" "0" <<-\EOF
+1
+[0]: "foo:;:bar:;:baz"
+EOF
+
+test_split_in_place_multi "foo:;:bar:;:baz" ":;" "1" <<-\EOF
+2
+[0]: "foo"
+[1]: "bar:;:baz"
+EOF
+
+test_split_in_place_multi "foo:;:bar:;:baz" ":;" "2" <<-\EOF
+3
+[0]: "foo"
+[1]: "bar"
+[2]: "baz"
+EOF
+
+test_split_in_place_multi "foo:;:bar:;:" ":;" "-1" <<-\EOF
+3
+[0]: "foo"
+[1]: "bar"
+[2]: ""
+EOF
+
 test_expect_success "test filter_string_list" '
 	test "x-" = "x$(test-tool string-list filter - y)" &&
 	test "x-" = "x$(test-tool string-list filter no y)" &&
-- 
2.40.0.358.g56d2318a6d

