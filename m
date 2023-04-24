Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C71C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 22:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjDXWUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 18:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjDXWUN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 18:20:13 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFC15FD8
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 15:20:10 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-54fbee69fc4so57116587b3.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 15:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682374809; x=1684966809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxwwfImNnj+9b/j/EhYPibLkg8peISpyYK9RWJQD9wc=;
        b=KBMi8G4+4OO0bH2OtA/9zKb84FBxm3LMLBFUiLQxiUgQsBjNoNMzMx+7Kuwq8PZL1Y
         klzGnaOX8y1nxBiVGt3HY8pC/lSLbHBvcuGTMRR7ofqbQPYmI3xGQ9hcNM3u8hYR2w7W
         j/p2IG+VrK3PCF7xP9ghmjjS+MaOVI0NFXFKVRfHRTg49A6g3UxK6r+uR1frUfHN2j+3
         HDH0gAkBMsakBgtoWPDV1ENp31J95WioiU/UpkKnc73YGmDKpW2sg+ftKGhlJAo2d625
         jH9xUoKQBJ3Z0IOR4t4+AxxnBqrgKf22LitNgc2NNzqo3YOGYRtymIVX31zKnjLkh0M+
         lTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374809; x=1684966809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxwwfImNnj+9b/j/EhYPibLkg8peISpyYK9RWJQD9wc=;
        b=Ew587gRbv2DNldWz7AhjWWoOebWuPe4gsKuUfgDytdTPHRQBZA/MvL9yutpyuFnAMx
         2pM/kQCMK1S5fYLxiU7yRDFaAfx+Yfvm6160pTq9hiSuqdjouNsLme9aO3cqRjIo+/bR
         J9mKI4OKUmdGFmhQRnHWhvqJGvDpOghPZ4srbn8QYS2KvOnHowzEAccaQnhlSQHJ2aBe
         67Ynr3j5+WV3dMXpIfw2LgerS6rlX6Yky9vqr8Ayd50JBzu+lpIZQtXkje3vodgCzB0G
         E7YUl6hcWSeO3LlfpqTOaIsAMaHHa+3aFHi2qs6KgQW/7I2RGuPTy8u9+zCmY5oR1usn
         tSQw==
X-Gm-Message-State: AAQBX9d9mLQN+/XTAOxSKby5xZQwzEbvWJMLreeMbJwoZZvlRAvqEW0b
        EQYX0WQVpZ0WsiLrVf2Rw1lo2654cC8hgxiswBGN3w==
X-Google-Smtp-Source: AKy350Yt00vVlhm2UNIoOKdTx+n+nXksDcVwxqJW/Bbbi7job8bqQNq2NLMBPyEc3Wm4DhPcsypC+g==
X-Received: by 2002:a0d:d0c5:0:b0:551:213:9c24 with SMTP id s188-20020a0dd0c5000000b0055102139c24mr9095253ywd.41.1682374809086;
        Mon, 24 Apr 2023 15:20:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t1-20020a0dea01000000b00545a08184fesm3158388ywe.142.2023.04.24.15.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 15:20:08 -0700 (PDT)
Date:   Mon, 24 Apr 2023 18:20:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 0/6] banned: mark `strok()`, `strtok_r()` as banned
Message-ID: <cover.1682374789.git.me@ttaylorr.com>
References: <cover.1681428696.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681428696.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is another medium-sized reroll of my series to add `strtok()` (and
`strtok_r()`!) to the list of banned functions.

Notable changes include:

  - Dropped `string_list_split_in_place_multi()` in favor of a
    combination of `string_list_split_in_place()` and
    `string_list_remove_empty_items()`.

  - `strtok_r()` is back on the banned list, with a more realistic sales
    pitch.

As always, a range-diff is included below for convenience. Thanks in
advance for your review!

[1]: https://lore.kernel.org/git/cover.1681428696.git.me@ttaylorr.com/

Taylor Blau (6):
  string-list: multi-delimiter `string_list_split_in_place()`
  string-list: introduce `string_list_setlen()`
  t/helper/test-hashmap.c: avoid using `strtok()`
  t/helper/test-oidmap.c: avoid using `strtok()`
  t/helper/test-json-writer.c: avoid using `strtok()`
  banned.h: mark `strtok()` and `strtok_r()` as banned

 banned.h                    |  4 ++
 builtin/gc.c                |  4 +-
 diff.c                      |  2 +-
 notes.c                     |  2 +-
 refs/packed-backend.c       |  2 +-
 string-list.c               | 13 ++++++-
 string-list.h               | 12 +++++-
 t/helper/test-hashmap.c     | 22 +++++++----
 t/helper/test-json-writer.c | 76 +++++++++++++++++++++++--------------
 t/helper/test-oidmap.c      | 20 +++++++---
 t/helper/test-string-list.c |  4 +-
 t/t0063-string-list.sh      | 51 +++++++++++++++++++++++++
 12 files changed, 161 insertions(+), 51 deletions(-)

Range-diff against v2:
1:  6658b231a9 ! 1:  59d3e778b6 string-list: introduce `string_list_split_in_place_multi()`
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    string-list: introduce `string_list_split_in_place_multi()`
    +    string-list: multi-delimiter `string_list_split_in_place()`
     
    -    Introduce a variant of the `string_list_split_in_place()` function that
    -    takes a string of accepted delimiters.
    -
    -    By contrast to its cousin `string_list_split_in_place()` which splits
    -    the given string at every instance of the single character `delim`, the
    -    `_multi` variant splits the given string any any character appearing in
    -    the string `delim`.
    -
    -    Like `strtok()`, the `_multi` variant skips past sequential delimiting
    -    characters. For example:
    -
    -        string_list_split_in_place(&xs, xstrdup("foo::bar::baz"), ":", -1);
    -
    -    would place in `xs` the elements "foo", "bar", and "baz".
    +    Enhance `string_list_split_in_place()` to accept multiple characters as
    +    delimiters instead of a single character.
     
         Instead of using `strchr(2)` to locate the first occurrence of the given
         delimiter character, `string_list_split_in_place_multi()` uses
         `strcspn(2)` to move past the initial segment of characters comprised of
         any characters in the delimiting set.
     
    -    When only a single delimiting character is provided, `strcspn(2)` has
    -    equivalent performance to `strchr(2)`. Modern `strcspn(2)`
    -    implementations treat an empty delimiter or the singleton delimiter as a
    -    special case and fall back to calling strchrnul(). Both glibc[1] and
    -    musl[2] implement `strcspn(2)` this way.
    +    When only a single delimiting character is provided, `strpbrk(2)` (which
    +    is implemented with `strcspn(2)`) has equivalent performance to
    +    `strchr(2)`. Modern `strcspn(2)` implementations treat an empty
    +    delimiter or the singleton delimiter as a special case and fall back to
    +    calling strchrnul(). Both glibc[1] and musl[2] implement `strcspn(2)`
    +    this way.
     
    -    Since the `_multi` variant is a generalization of the original
    -    implementation, reimplement `string_list_split_in_place()` in terms of
    -    the more general function by providing a single-character string for the
    -    list of accepted delimiters.
    +    This change is one step to removing `strtok(2)` from the tree. Note that
    +    `string_list_split_in_place()` is not a strict replacement for
    +    `strtok()`, since it will happily turn sequential delimiter characters
    +    into empty entries in the resulting string_list. For example:
     
    -    To avoid regressions, update t0063 in this patch as well. Any "common"
    -    test cases (i.e., those that produce the same result whether you call
    -    `string_list_split()` or `string_list_split_in_place_multi()`) are
    -    grouped into a loop which is parameterized over the function to test.
    +        string_list_split_in_place(&xs, "foo:;:bar:;:baz", ":;", -1)
     
    -    Any cases which aren't common (of which there is one existing case, and
    -    a handful of new ones added which are specific to the `_multi` variant)
    -    are tested independently.
    +    would yield a string list of:
    +
    +        ["foo", "", "", "bar", "", "", "baz"]
    +
    +    Callers that wish to emulate the behavior of strtok(2) more directly
    +    should call `string_list_remove_empty_items()` after splitting.
    +
    +    To avoid regressions for the new multi-character delimter cases, update
    +    t0063 in this patch as well.
     
         [1]: https://sourceware.org/git/?p=glibc.git;a=blob;f=string/strcspn.c;hb=glibc-2.37#l35
         [2]: https://git.musl-libc.org/cgit/musl/tree/src/string/strcspn.c?h=v1.2.3#n11
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    + ## builtin/gc.c ##
    +@@ builtin/gc.c: static int get_schedule_cmd(const char **cmd, int *is_available)
    + 	if (is_available)
    + 		*is_available = 0;
    + 
    +-	string_list_split_in_place(&list, testing, ',', -1);
    ++	string_list_split_in_place(&list, testing, ",", -1);
    + 	for_each_string_list_item(item, &list) {
    + 		struct string_list pair = STRING_LIST_INIT_NODUP;
    + 
    +-		if (string_list_split_in_place(&pair, item->string, ':', 2) != 2)
    ++		if (string_list_split_in_place(&pair, item->string, ":", 2) != 2)
    + 			continue;
    + 
    + 		if (!strcmp(*cmd, pair.items[0].string)) {
    +
    + ## diff.c ##
    +@@ diff.c: static int parse_dirstat_params(struct diff_options *options, const char *params
    + 	int i;
    + 
    + 	if (*params_copy)
    +-		string_list_split_in_place(&params, params_copy, ',', -1);
    ++		string_list_split_in_place(&params, params_copy, ",", -1);
    + 	for (i = 0; i < params.nr; i++) {
    + 		const char *p = params.items[i].string;
    + 		if (!strcmp(p, "changes")) {
    +
    + ## notes.c ##
    +@@ notes.c: void string_list_add_refs_from_colon_sep(struct string_list *list,
    + 	char *globs_copy = xstrdup(globs);
    + 	int i;
    + 
    +-	string_list_split_in_place(&split, globs_copy, ':', -1);
    ++	string_list_split_in_place(&split, globs_copy, ":", -1);
    + 	string_list_remove_empty_items(&split, 0);
    + 
    + 	for (i = 0; i < split.nr; i++)
    +
    + ## refs/packed-backend.c ##
    +@@ refs/packed-backend.c: static struct snapshot *create_snapshot(struct packed_ref_store *refs)
    + 					 snapshot->buf,
    + 					 snapshot->eof - snapshot->buf);
    + 
    +-		string_list_split_in_place(&traits, p, ' ', -1);
    ++		string_list_split_in_place(&traits, p, " ", -1);
    + 
    + 		if (unsorted_string_list_has_string(&traits, "fully-peeled"))
    + 			snapshot->peeled = PEELED_FULLY;
    +
      ## string-list.c ##
     @@ string-list.c: int string_list_split(struct string_list *list, const char *string,
    - 	}
      }
      
    --int string_list_split_in_place(struct string_list *list, char *string,
    + int string_list_split_in_place(struct string_list *list, char *string,
     -			       int delim, int maxsplit)
    -+static int string_list_split_in_place_1(struct string_list *list, char *string,
    -+					const char *delim, int maxsplit,
    -+					unsigned runs)
    ++			       const char *delim, int maxsplit)
      {
      	int count = 0;
      	char *p = string, *end;
     @@ string-list.c: int string_list_split_in_place(struct string_list *list, char *string,
    - 		die("internal error in string_list_split_in_place(): "
    - 		    "list->strdup_strings must not be set");
    - 	for (;;) {
    -+		if (runs)
    -+			p += strspn(p, delim);
    -+
    - 		count++;
    - 		if (maxsplit >= 0 && count > maxsplit) {
      			string_list_append(list, p);
      			return count;
      		}
     -		end = strchr(p, delim);
    --		if (end) {
    -+		end = p + strcspn(p, delim);
    -+		if (end && *end) {
    ++		end = strpbrk(p, delim);
    + 		if (end) {
      			*end = '\0';
      			string_list_append(list, p);
    - 			p = end + 1;
    -@@ string-list.c: int string_list_split_in_place(struct string_list *list, char *string,
    - 		}
    - 	}
    - }
    -+
    -+int string_list_split_in_place_multi(struct string_list *list, char *string,
    -+				     const char *delim, int maxsplit)
    -+{
    -+	return string_list_split_in_place_1(list, string, delim, maxsplit, 1);
    -+}
    -+
    -+int string_list_split_in_place(struct string_list *list, char *string,
    -+			       int delim, int maxsplit)
    -+{
    -+	char delim_s[2] = { delim, 0 };
    -+
    -+	return string_list_split_in_place_1(list, string, delim_s, maxsplit, 0);
    -+}
     
      ## string-list.h ##
     @@ string-list.h: int string_list_split(struct string_list *list, const char *string,
    -  * new string_list_items point into string (which therefore must not
    -  * be modified or freed while the string_list is in use).
       * list->strdup_strings must *not* be set.
    -+ *
    -+ * The "_multi" variant splits the given string on any character
    -+ * appearing in "delim", and the non-"_multi" variant splits only on the
    -+ * given character. The "_multi" variant behaves like `strtok()` where
    -+ * no element contains the delimiting byte(s).
       */
    -+int string_list_split_in_place_multi(struct string_list *list, char *string,
    -+				     const char *delim, int maxsplit);
      int string_list_split_in_place(struct string_list *list, char *string,
    - 			       int delim, int maxsplit);
    +-			       int delim, int maxsplit);
    ++			       const char *delim, int maxsplit);
      #endif /* STRING_LIST_H */
     
      ## t/helper/test-string-list.c ##
     @@ t/helper/test-string-list.c: int cmd__string_list(int argc, const char **argv)
    - 		return 0;
    - 	}
    - 
    -+	if (argc == 5 && !strcmp(argv[1], "split_in_place_multi")) {
    -+		struct string_list list = STRING_LIST_INIT_NODUP;
    -+		int i;
    -+		char *s = xstrdup(argv[2]);
    + 		struct string_list list = STRING_LIST_INIT_NODUP;
    + 		int i;
    + 		char *s = xstrdup(argv[2]);
    +-		int delim = *argv[3];
     +		const char *delim = argv[3];
    -+		int maxsplit = atoi(argv[4]);
    -+
    -+		i = string_list_split_in_place_multi(&list, s, delim, maxsplit);
    -+		printf("%d\n", i);
    -+		write_list(&list);
    -+		string_list_clear(&list, 0);
    -+		free(s);
    -+		return 0;
    -+	}
    -+
    - 	if (argc == 4 && !strcmp(argv[1], "filter")) {
    - 		/*
    - 		 * Retain only the items that have the specified prefix.
    + 		int maxsplit = atoi(argv[4]);
    + 
    + 		i = string_list_split_in_place(&list, s, delim, maxsplit);
    +@@ t/helper/test-string-list.c: int cmd__string_list(int argc, const char **argv)
    + 		 */
    + 		if (sb.len && sb.buf[sb.len - 1] == '\n')
    + 			strbuf_setlen(&sb, sb.len - 1);
    +-		string_list_split_in_place(&list, sb.buf, '\n', -1);
    ++		string_list_split_in_place(&list, sb.buf, "\n", -1);
    + 
    + 		string_list_sort(&list);
    + 
     
      ## t/t0063-string-list.sh ##
     @@ t/t0063-string-list.sh: test_split () {
      	"
      }
      
    --test_split "foo:bar:baz" ":" "-1" <<EOF
    --3
    --[0]: "foo"
    --[1]: "bar"
    --[2]: "baz"
    --EOF
    -+test_split_in_place_multi () {
    ++test_split_in_place() {
     +	cat >expected &&
    -+	test_expect_success "split_in_place_multi $1 at $2, max $3" "
    -+		test-tool string-list split_in_place_multi '$1' '$2' '$3' >actual &&
    ++	test_expect_success "split (in place) $1 at $2, max $3" "
    ++		test-tool string-list split_in_place '$1' '$2' '$3' >actual &&
     +		test_cmp expected actual
     +	"
     +}
    - 
    --test_split "foo:bar:baz" ":" "0" <<EOF
    --1
    --[0]: "foo:bar:baz"
    --EOF
    -+for test_fn in test_split test_split_in_place_multi
    -+do
    -+	$test_fn "foo:bar:baz" ":" "-1" <<-\EOF
    -+	3
    -+	[0]: "foo"
    -+	[1]: "bar"
    -+	[2]: "baz"
    -+	EOF
    - 
    --test_split "foo:bar:baz" ":" "1" <<EOF
    --2
    --[0]: "foo"
    --[1]: "bar:baz"
    --EOF
    -+	$test_fn "foo:bar:baz" ":" "0" <<-\EOF
    -+	1
    -+	[0]: "foo:bar:baz"
    -+	EOF
    - 
    --test_split "foo:bar:baz" ":" "2" <<EOF
    --3
    --[0]: "foo"
    --[1]: "bar"
    --[2]: "baz"
    --EOF
    -+	$test_fn "foo:bar:baz" ":" "1" <<-\EOF
    -+	2
    -+	[0]: "foo"
    -+	[1]: "bar:baz"
    -+	EOF
    - 
    --test_split "foo:bar:" ":" "-1" <<EOF
    --3
    --[0]: "foo"
    --[1]: "bar"
    --[2]: ""
    --EOF
    -+	$test_fn "foo:bar:baz" ":" "2" <<-\EOF
    -+	3
    -+	[0]: "foo"
    -+	[1]: "bar"
    -+	[2]: "baz"
    -+	EOF
    - 
    --test_split "" ":" "-1" <<EOF
    --1
    --[0]: ""
    --EOF
    -+	$test_fn "foo:bar:" ":" "-1" <<-\EOF
    -+	3
    -+	[0]: "foo"
    -+	[1]: "bar"
    -+	[2]: ""
    -+	EOF
     +
    -+	$test_fn "" ":" "-1" <<-\EOF
    -+	1
    -+	[0]: ""
    -+	EOF
    -+done
    - 
    - test_split ":" ":" "-1" <<EOF
    - 2
    + test_split "foo:bar:baz" ":" "-1" <<EOF
    + 3
    + [0]: "foo"
     @@ t/t0063-string-list.sh: test_split ":" ":" "-1" <<EOF
      [1]: ""
      EOF
      
    -+test_split_in_place_multi "foo:;:bar:;:baz" ":;" "-1" <<-\EOF
    -+3
    ++test_split_in_place "foo:;:bar:;:baz:;:" ":;" "-1" <<EOF
    ++10
     +[0]: "foo"
    -+[1]: "bar"
    -+[2]: "baz"
    ++[1]: ""
    ++[2]: ""
    ++[3]: "bar"
    ++[4]: ""
    ++[5]: ""
    ++[6]: "baz"
    ++[7]: ""
    ++[8]: ""
    ++[9]: ""
     +EOF
     +
    -+test_split_in_place_multi "foo:;:bar:;:baz" ":;" "0" <<-\EOF
    ++test_split_in_place "foo:;:bar:;:baz" ":;" "0" <<EOF
     +1
     +[0]: "foo:;:bar:;:baz"
     +EOF
     +
    -+test_split_in_place_multi "foo:;:bar:;:baz" ":;" "1" <<-\EOF
    ++test_split_in_place "foo:;:bar:;:baz" ":;" "1" <<EOF
     +2
     +[0]: "foo"
    -+[1]: "bar:;:baz"
    ++[1]: ";:bar:;:baz"
     +EOF
     +
    -+test_split_in_place_multi "foo:;:bar:;:baz" ":;" "2" <<-\EOF
    ++test_split_in_place "foo:;:bar:;:baz" ":;" "2" <<EOF
     +3
     +[0]: "foo"
    -+[1]: "bar"
    -+[2]: "baz"
    ++[1]: ""
    ++[2]: ":bar:;:baz"
     +EOF
     +
    -+test_split_in_place_multi "foo:;:bar:;:" ":;" "-1" <<-\EOF
    -+3
    ++test_split_in_place "foo:;:bar:;:" ":;" "-1" <<EOF
    ++7
     +[0]: "foo"
    -+[1]: "bar"
    ++[1]: ""
     +[2]: ""
    ++[3]: "bar"
    ++[4]: ""
    ++[5]: ""
    ++[6]: ""
     +EOF
     +
      test_expect_success "test filter_string_list" '
2:  2a20ad8bc5 = 2:  ae8d0ce1f2 string-list: introduce `string_list_setlen()`
3:  0ae07dec36 ! 3:  78ecf13cb0 t/helper/test-hashmap.c: avoid using `strtok()`
    @@ Commit message
     
         Avoid using the non-reentrant `strtok()` to separate the parts of each
         incoming command. Instead of replacing it with `strtok_r()`, let's
    -    instead use the more friendly `string_list_split_in_place_multi()`.
    +    instead use the more friendly pair of `string_list_split_in_place()` and
    +    `string_list_remove_empty_items()`.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ t/helper/test-hashmap.c: int cmd__hashmap(int argc, const char **argv)
      		unsigned int hash = 0;
      		struct test_entry *entry;
      
    -+		/*
    -+		 * Because we memdup() the arguments out of the
    -+		 * string_list before inserting them into the hashmap,
    -+		 * it's OK to set its length back to zero to avoid
    -+		 * re-allocating the items array once per line.
    -+		 *
    -+		 * By doing so, we'll instead overwrite the existing
    -+		 * entries and avoid re-allocating.
    -+		 */
    -+		string_list_setlen(&parts, 0);
      		/* break line into command and up to two parameters */
     -		cmd = strtok(line.buf, DELIM);
    -+		string_list_split_in_place_multi(&parts, line.buf, DELIM, 2);
    ++		string_list_setlen(&parts, 0);
    ++		string_list_split_in_place(&parts, line.buf, DELIM, 2);
    ++		string_list_remove_empty_items(&parts, 0);
     +
      		/* ignore empty lines */
     -		if (!cmd || *cmd == '#')
4:  a659431e9c ! 4:  c9b929406a t/helper/test-oidmap.c: avoid using `strtok()`
    @@ t/helper/test-oidmap.c: int cmd__oidmap(int argc UNUSED, const char **argv UNUSE
      		struct test_entry *entry;
      		struct object_id oid;
      
    -+		/* see the comment in cmd__hashmap() */
    -+		string_list_setlen(&parts, 0);
      		/* break line into command and up to two parameters */
     -		cmd = strtok(line.buf, DELIM);
    -+		string_list_split_in_place_multi(&parts, line.buf, DELIM, 2);
    ++		string_list_setlen(&parts, 0);
    ++		string_list_split_in_place(&parts, line.buf, DELIM, 2);
    ++		string_list_remove_empty_items(&parts, 0);
     +
      		/* ignore empty lines */
     -		if (!cmd || *cmd == '#')
5:  fc6cd23698 ! 5:  201fcac6c4 t/helper/test-json-writer.c: avoid using `strtok()`
    @@ t/helper/test-json-writer.c: static int scripted(void)
     +		state.nr = ++line_nr;
      
     -		verb = strtok(line, " ");
    -+		/* see the comment in cmd__hashmap() */
    -+		string_list_setlen(&parts, 0);
     +		/* break line into command and zero or more tokens */
    -+		string_list_split_in_place(&parts, line, ' ', -1);
    ++		string_list_setlen(&parts, 0);
    ++		string_list_split_in_place(&parts, line, " ", -1);
    ++		string_list_remove_empty_items(&parts, 0);
     +
     +		/* ignore empty lines */
     +		if (!parts.nr || !*parts.items[0].string)
6:  56d2318a6d ! 6:  da896aa358 banned.h: mark `strtok()` as banned
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    banned.h: mark `strtok()` as banned
    -
    -    `strtok_r()` is reentrant, but `strtok()` is not, meaning that using it
    -    is not thread-safe.
    +    banned.h: mark `strtok()` and `strtok_r()` as banned
     
         `strtok()` has a couple of drawbacks that make it undesirable to have
         any new instances. In addition to being thread-unsafe, it also
    @@ Commit message
     
         Now that we have removed all instances of `strtok()` from the tree,
         let's ban `strtok()` to avoid introducing new ones in the future. If new
    -    callers should arise, they can either use:
    +    callers should arise, they are encouraged to use
    +    `string_list_split_in_place()` (and `string_list_remove_empty_items()`,
    +    if applicable).
     
    -      - `string_list_split_in_place()`,
    -      - `string_list_split_in_place_multi()`, or
    -      - `strtok_r()`.
    +    string_list_split_in_place() is not a perfect drop-in replacement
    +    for `strtok_r()`, particularly if the caller is processing a string with
    +    an arbitrary number of tokens, and wants to process each token one at a
    +    time.
     
    -    Callers are encouraged to use either of the string_list functions when
    -    appropriate over `strtok_r()`, since the latter suffers from the same
    -    confusing data-flow problem as `strtok()` does.
    -
    -    But callers may prefer `strtok_r()` when the number of tokens in a given
    -    string is unknown, and they want to split and process them one at a
    -    time, so `strtok_r()` is left off the banned.h list.
    +    But there are no instances of this in Git's tree which are more
    +    well-suited to `strtok_r()` than the friendlier
    +    `string_list_in_place()`, so ban `strtok_r()`, too.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ banned.h
      #define strncat(x,y,n) BANNED(strncat)
     +#undef strtok
     +#define strtok(x,y) BANNED(strtok)
    ++#undef strtok_r
    ++#define strtok_r(x,y,z) BANNED(strtok_r)
      
      #undef sprintf
      #undef vsprintf
-- 
2.40.0.380.gd2df7d2365
