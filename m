Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55FBC6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 19:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjDRTUA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 15:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjDRTT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 15:19:57 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C995D337
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:19:33 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54fa9da5e5bso271209957b3.1
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681845522; x=1684437522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VRTVuudbk0wsOG4Y5mQke5HCSm7KwSpSrNIY/Cv7xuc=;
        b=XggUOVwBvJzXG9HmeZUMNXbTztWkpUMOBdnzhqydZocuHScRyZwFKHX2dXsVdH97r/
         OV4I4zUf654TXibBk26XlyOJkiEDVAtcm2sobDEa39SBi5J0+TFWyf8HMrM6E3jeBGtR
         lSW1qSxjVUaw9PBdqM5T/l/4k2626moA77sG/2BsHpyuBSTc6ieC+6oWPcllvIy6qQ/X
         z4xL6hwmwiR2TOj8EZzT/73lqtH4RiMdU3cjRjRW8wkJJX9SN4rdhR4CwtUhpPh5M3xU
         vlxmpV+Vz3lMwTB5P7G4QtV6558USSMGaS01CKP/lE3AdmBLEQRd3hnmGs6+2+AMW5Ln
         aJMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845522; x=1684437522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRTVuudbk0wsOG4Y5mQke5HCSm7KwSpSrNIY/Cv7xuc=;
        b=FWJgs/cYGJtIAT13N8MEEGnMQcmwH51D5pK7lAMaKa230bISTxreFNlkoYydeRoRWL
         uN92gc2R86+LRSJ4SXNOFzIoD7vY7aeVHXbs61I70KGNHFahC32KAjOeRrYIZYhQN1P5
         fN8k8jhAHJdKj+TkhkELH2wJ6SnvouJK6KlOv7PY10x7YYcRXkRGX2rAo53oyt/c0iAU
         AzPOeJDP77+eyPmzyIilyLUAifUhxjYLjFZE0oNJpiQmldxbF3v+Ybtrtqwoxi9Pw6Ta
         ZVfUDZrgzCadiBYJdZ06e/j7CnIF1tRHMKFogOeXnL/alB7ySy+0TOwq/vIpMCyR5og8
         fSug==
X-Gm-Message-State: AAQBX9c1uKFjL1qUUosea71cmrZ3Uxq39tBFnb1nCU/5GuskpttTZ1Rb
        YDotG4EKOKbSSq/Tdelj0L6NcAv1bkEzStkGhfe8+g==
X-Google-Smtp-Source: AKy350Y0WIvchvjz6KK28GGsndsU82hYmiIsOsptfIn28QkBnWX2+4ZNeYS65yFvxxOw9ACEf+J0OA==
X-Received: by 2002:a0d:cc4a:0:b0:54f:895e:70f7 with SMTP id o71-20020a0dcc4a000000b0054f895e70f7mr961750ywd.9.1681845521667;
        Tue, 18 Apr 2023 12:18:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d64-20020a811d43000000b0054c055b8ffcsm4024959ywd.41.2023.04.18.12.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:18:41 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:18:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/6] banned: mark `strok()` as banned
Message-ID: <cover.1681845518.git.me@ttaylorr.com>
References: <cover.1681428696.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681428696.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a medium-sized reroll of my series to add `strtok()` to the list
of banned functions.

Some notable things that have changed since the first round[1] include:

  - The behavior of `string_list_split_in_place()` is unchanged, and
    `string_list_split_in_place_multi()` now has the more sane behavior
    of removing all delimiter characters from its output, similar to
    strtok().

  - We now guard against dangerous cases of assigning `list->nr` with a
    new `string_list_setlen()` function.

  - More test cases are added in t0063.

  - `strtok_r()` is no longer on the banned list, and `strtok()` now
    *is* on the list, after I forgot to remove a stray `#if 0` left over
    from debugging.

As always, a range-diff is included below for convenience. Thanks in
advance for your review!

[1]: https://lore.kernel.org/git/cover.1681428696.git.me@ttaylorr.com/

Taylor Blau (6):
  string-list: introduce `string_list_split_in_place_multi()`
  string-list: introduce `string_list_setlen()`
  t/helper/test-hashmap.c: avoid using `strtok()`
  t/helper/test-oidmap.c: avoid using `strtok()`
  t/helper/test-json-writer.c: avoid using `strtok()`
  banned.h: mark `strtok()` as banned

 banned.h                    |   2 +
 string-list.c               |  35 ++++++++++--
 string-list.h               |  17 ++++++
 t/helper/test-hashmap.c     |  30 ++++++++---
 t/helper/test-json-writer.c |  76 ++++++++++++++++----------
 t/helper/test-oidmap.c      |  20 ++++---
 t/helper/test-string-list.c |  15 ++++++
 t/t0063-string-list.sh      | 105 +++++++++++++++++++++++++-----------
 8 files changed, 224 insertions(+), 76 deletions(-)

Range-diff against v1:
1:  dda218c8c1 ! 1:  6658b231a9 string-list: introduce `string_list_split_in_place_multi()`
    @@ Commit message
         `_multi` variant splits the given string any any character appearing in
         the string `delim`.
     
    +    Like `strtok()`, the `_multi` variant skips past sequential delimiting
    +    characters. For example:
    +
    +        string_list_split_in_place(&xs, xstrdup("foo::bar::baz"), ":", -1);
    +
    +    would place in `xs` the elements "foo", "bar", and "baz".
    +
         Instead of using `strchr(2)` to locate the first occurrence of the given
         delimiter character, `string_list_split_in_place_multi()` uses
    -    `strpbrk(2)` to find the first occurrence of *any* character in the given
    -    delimiter string.
    +    `strcspn(2)` to move past the initial segment of characters comprised of
    +    any characters in the delimiting set.
    +
    +    When only a single delimiting character is provided, `strcspn(2)` has
    +    equivalent performance to `strchr(2)`. Modern `strcspn(2)`
    +    implementations treat an empty delimiter or the singleton delimiter as a
    +    special case and fall back to calling strchrnul(). Both glibc[1] and
    +    musl[2] implement `strcspn(2)` this way.
     
         Since the `_multi` variant is a generalization of the original
         implementation, reimplement `string_list_split_in_place()` in terms of
         the more general function by providing a single-character string for the
         list of accepted delimiters.
     
    +    To avoid regressions, update t0063 in this patch as well. Any "common"
    +    test cases (i.e., those that produce the same result whether you call
    +    `string_list_split()` or `string_list_split_in_place_multi()`) are
    +    grouped into a loop which is parameterized over the function to test.
    +
    +    Any cases which aren't common (of which there is one existing case, and
    +    a handful of new ones added which are specific to the `_multi` variant)
    +    are tested independently.
    +
    +    [1]: https://sourceware.org/git/?p=glibc.git;a=blob;f=string/strcspn.c;hb=glibc-2.37#l35
    +    [2]: https://git.musl-libc.org/cgit/musl/tree/src/string/strcspn.c?h=v1.2.3#n11
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## string-list.c ##
    @@ string-list.c: int string_list_split(struct string_list *list, const char *strin
      
     -int string_list_split_in_place(struct string_list *list, char *string,
     -			       int delim, int maxsplit)
    -+int string_list_split_in_place_multi(struct string_list *list, char *string,
    -+				     const char *delim, int maxsplit)
    ++static int string_list_split_in_place_1(struct string_list *list, char *string,
    ++					const char *delim, int maxsplit,
    ++					unsigned runs)
      {
      	int count = 0;
      	char *p = string, *end;
     @@ string-list.c: int string_list_split_in_place(struct string_list *list, char *string,
    + 		die("internal error in string_list_split_in_place(): "
    + 		    "list->strdup_strings must not be set");
    + 	for (;;) {
    ++		if (runs)
    ++			p += strspn(p, delim);
    ++
    + 		count++;
    + 		if (maxsplit >= 0 && count > maxsplit) {
      			string_list_append(list, p);
      			return count;
      		}
     -		end = strchr(p, delim);
    -+		end = strpbrk(p, delim);
    - 		if (end) {
    +-		if (end) {
    ++		end = p + strcspn(p, delim);
    ++		if (end && *end) {
      			*end = '\0';
      			string_list_append(list, p);
    + 			p = end + 1;
     @@ string-list.c: int string_list_split_in_place(struct string_list *list, char *string,
      		}
      	}
      }
     +
    ++int string_list_split_in_place_multi(struct string_list *list, char *string,
    ++				     const char *delim, int maxsplit)
    ++{
    ++	return string_list_split_in_place_1(list, string, delim, maxsplit, 1);
    ++}
    ++
     +int string_list_split_in_place(struct string_list *list, char *string,
     +			       int delim, int maxsplit)
     +{
     +	char delim_s[2] = { delim, 0 };
     +
    -+	return string_list_split_in_place_multi(list, string, delim_s,
    -+						maxsplit);
    ++	return string_list_split_in_place_1(list, string, delim_s, maxsplit, 0);
     +}
     
      ## string-list.h ##
    @@ string-list.h: int string_list_split(struct string_list *list, const char *strin
     + *
     + * The "_multi" variant splits the given string on any character
     + * appearing in "delim", and the non-"_multi" variant splits only on the
    -+ * given character.
    ++ * given character. The "_multi" variant behaves like `strtok()` where
    ++ * no element contains the delimiting byte(s).
       */
     +int string_list_split_in_place_multi(struct string_list *list, char *string,
     +				     const char *delim, int maxsplit);
      int string_list_split_in_place(struct string_list *list, char *string,
      			       int delim, int maxsplit);
      #endif /* STRING_LIST_H */
    +
    + ## t/helper/test-string-list.c ##
    +@@ t/helper/test-string-list.c: int cmd__string_list(int argc, const char **argv)
    + 		return 0;
    + 	}
    + 
    ++	if (argc == 5 && !strcmp(argv[1], "split_in_place_multi")) {
    ++		struct string_list list = STRING_LIST_INIT_NODUP;
    ++		int i;
    ++		char *s = xstrdup(argv[2]);
    ++		const char *delim = argv[3];
    ++		int maxsplit = atoi(argv[4]);
    ++
    ++		i = string_list_split_in_place_multi(&list, s, delim, maxsplit);
    ++		printf("%d\n", i);
    ++		write_list(&list);
    ++		string_list_clear(&list, 0);
    ++		free(s);
    ++		return 0;
    ++	}
    ++
    + 	if (argc == 4 && !strcmp(argv[1], "filter")) {
    + 		/*
    + 		 * Retain only the items that have the specified prefix.
    +
    + ## t/t0063-string-list.sh ##
    +@@ t/t0063-string-list.sh: test_split () {
    + 	"
    + }
    + 
    +-test_split "foo:bar:baz" ":" "-1" <<EOF
    +-3
    +-[0]: "foo"
    +-[1]: "bar"
    +-[2]: "baz"
    +-EOF
    ++test_split_in_place_multi () {
    ++	cat >expected &&
    ++	test_expect_success "split_in_place_multi $1 at $2, max $3" "
    ++		test-tool string-list split_in_place_multi '$1' '$2' '$3' >actual &&
    ++		test_cmp expected actual
    ++	"
    ++}
    + 
    +-test_split "foo:bar:baz" ":" "0" <<EOF
    +-1
    +-[0]: "foo:bar:baz"
    +-EOF
    ++for test_fn in test_split test_split_in_place_multi
    ++do
    ++	$test_fn "foo:bar:baz" ":" "-1" <<-\EOF
    ++	3
    ++	[0]: "foo"
    ++	[1]: "bar"
    ++	[2]: "baz"
    ++	EOF
    + 
    +-test_split "foo:bar:baz" ":" "1" <<EOF
    +-2
    +-[0]: "foo"
    +-[1]: "bar:baz"
    +-EOF
    ++	$test_fn "foo:bar:baz" ":" "0" <<-\EOF
    ++	1
    ++	[0]: "foo:bar:baz"
    ++	EOF
    + 
    +-test_split "foo:bar:baz" ":" "2" <<EOF
    +-3
    +-[0]: "foo"
    +-[1]: "bar"
    +-[2]: "baz"
    +-EOF
    ++	$test_fn "foo:bar:baz" ":" "1" <<-\EOF
    ++	2
    ++	[0]: "foo"
    ++	[1]: "bar:baz"
    ++	EOF
    + 
    +-test_split "foo:bar:" ":" "-1" <<EOF
    +-3
    +-[0]: "foo"
    +-[1]: "bar"
    +-[2]: ""
    +-EOF
    ++	$test_fn "foo:bar:baz" ":" "2" <<-\EOF
    ++	3
    ++	[0]: "foo"
    ++	[1]: "bar"
    ++	[2]: "baz"
    ++	EOF
    + 
    +-test_split "" ":" "-1" <<EOF
    +-1
    +-[0]: ""
    +-EOF
    ++	$test_fn "foo:bar:" ":" "-1" <<-\EOF
    ++	3
    ++	[0]: "foo"
    ++	[1]: "bar"
    ++	[2]: ""
    ++	EOF
    ++
    ++	$test_fn "" ":" "-1" <<-\EOF
    ++	1
    ++	[0]: ""
    ++	EOF
    ++done
    + 
    + test_split ":" ":" "-1" <<EOF
    + 2
    +@@ t/t0063-string-list.sh: test_split ":" ":" "-1" <<EOF
    + [1]: ""
    + EOF
    + 
    ++test_split_in_place_multi "foo:;:bar:;:baz" ":;" "-1" <<-\EOF
    ++3
    ++[0]: "foo"
    ++[1]: "bar"
    ++[2]: "baz"
    ++EOF
    ++
    ++test_split_in_place_multi "foo:;:bar:;:baz" ":;" "0" <<-\EOF
    ++1
    ++[0]: "foo:;:bar:;:baz"
    ++EOF
    ++
    ++test_split_in_place_multi "foo:;:bar:;:baz" ":;" "1" <<-\EOF
    ++2
    ++[0]: "foo"
    ++[1]: "bar:;:baz"
    ++EOF
    ++
    ++test_split_in_place_multi "foo:;:bar:;:baz" ":;" "2" <<-\EOF
    ++3
    ++[0]: "foo"
    ++[1]: "bar"
    ++[2]: "baz"
    ++EOF
    ++
    ++test_split_in_place_multi "foo:;:bar:;:" ":;" "-1" <<-\EOF
    ++3
    ++[0]: "foo"
    ++[1]: "bar"
    ++[2]: ""
    ++EOF
    ++
    + test_expect_success "test filter_string_list" '
    + 	test "x-" = "x$(test-tool string-list filter - y)" &&
    + 	test "x-" = "x$(test-tool string-list filter no y)" &&
-:  ---------- > 2:  2a20ad8bc5 string-list: introduce `string_list_setlen()`
2:  0f199468a3 ! 3:  0ae07dec36 t/helper/test-hashmap.c: avoid using `strtok()`
    @@ t/helper/test-hashmap.c: int cmd__hashmap(int argc, const char **argv)
     +		 * By doing so, we'll instead overwrite the existing
     +		 * entries and avoid re-allocating.
     +		 */
    -+		parts.nr = 0;
    ++		string_list_setlen(&parts, 0);
      		/* break line into command and up to two parameters */
     -		cmd = strtok(line.buf, DELIM);
     +		string_list_split_in_place_multi(&parts, line.buf, DELIM, 2);
3:  135222d04e ! 4:  a659431e9c t/helper/test-oidmap.c: avoid using `strtok()`
    @@ t/helper/test-oidmap.c: int cmd__oidmap(int argc UNUSED, const char **argv UNUSE
      		struct object_id oid;
      
     +		/* see the comment in cmd__hashmap() */
    -+		parts.nr = 0;
    ++		string_list_setlen(&parts, 0);
      		/* break line into command and up to two parameters */
     -		cmd = strtok(line.buf, DELIM);
     +		string_list_split_in_place_multi(&parts, line.buf, DELIM, 2);
4:  ae29d4d892 ! 5:  fc6cd23698 t/helper/test-json-writer.c: avoid using `strtok()`
    @@ t/helper/test-json-writer.c: static int scripted(void)
      
     -		verb = strtok(line, " ");
     +		/* see the comment in cmd__hashmap() */
    -+		parts.nr = 0;
    ++		string_list_setlen(&parts, 0);
     +		/* break line into command and zero or more tokens */
     +		string_list_split_in_place(&parts, line, ' ', -1);
     +
5:  1d955f8bc6 ! 6:  56d2318a6d banned.h: mark `strtok()`, `strtok_r()` as banned
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    banned.h: mark `strtok()`, `strtok_r()` as banned
    +    banned.h: mark `strtok()` as banned
     
         `strtok_r()` is reentrant, but `strtok()` is not, meaning that using it
         is not thread-safe.
     
    -    We could ban `strtok()` and force callers to use its reentrant
    -    counterpart, but there are a few drawbacks to doing so:
    +    `strtok()` has a couple of drawbacks that make it undesirable to have
    +    any new instances. In addition to being thread-unsafe, it also
    +    encourages confusing data flows, where `strtok()` may be called from
    +    multiple functions with its first argument as NULL, making it unclear
    +    from the immediate context which string is being tokenized.
     
    -      - `strtok_r()` forces the caller to maintain an extra string pointer
    -        to pass as its `saveptr` value
    +    Now that we have removed all instances of `strtok()` from the tree,
    +    let's ban `strtok()` to avoid introducing new ones in the future. If new
    +    callers should arise, they can either use:
     
    -      - `strtok_r()` also requires that its `saveptr` value be unmodified
    -        between calls.
    +      - `string_list_split_in_place()`,
    +      - `string_list_split_in_place_multi()`, or
    +      - `strtok_r()`.
     
    -      - `strtok()` (and by extension, `strtok_r()`) is confusing when used
    -        across multiple functions, since the caller is supposed to pass NULL
    -        as its first argument after the first call. This makes it difficult
    -        to determine what string is actually being tokenized without clear
    -        dataflow.
    +    Callers are encouraged to use either of the string_list functions when
    +    appropriate over `strtok_r()`, since the latter suffers from the same
    +    confusing data-flow problem as `strtok()` does.
     
    -    So while we could ban only `strtok()`, there really is no good reason to
    -    use either when callers could instead use the much friendlier
    -    `string_list_split_in_place()` API, which avoids the above issues.
    +    But callers may prefer `strtok_r()` when the number of tokens in a given
    +    string is unknown, and they want to split and process them one at a
    +    time, so `strtok_r()` is left off the banned.h list.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ banned.h
      #define strncpy(x,y,n) BANNED(strncpy)
      #undef strncat
      #define strncat(x,y,n) BANNED(strncat)
    -+#if 0
     +#undef strtok
     +#define strtok(x,y) BANNED(strtok)
    -+#undef strtok_r
    -+#define strtok_r(x,y,z) BANNED(strtok_r)
    -+#endif
      
      #undef sprintf
      #undef vsprintf
-- 
2.40.0.358.g56d2318a6d
