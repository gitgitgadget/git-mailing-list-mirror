Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDD5C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 22:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjDXWUU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 18:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDXWUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 18:20:16 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8130B6185
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 15:20:13 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b98434b5311so6993815276.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 15:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1682374812; x=1684966812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I1WIlbyh5VPpGVg7Ssl9PuHGafr3ZYUMF2sL7AwCXDU=;
        b=XON0J7pRSZ2/cSXk37crkTJjpKp+fIE5BMXjdNKeh9CwFNSpdjm1Ak3lkuVDix+iXa
         b1xKW65i+G9aW74PkoopTqnl58vGJj4GHevOV01Qi7hFjn+913eslReBXjMviez0kT6N
         ZSfkUjq0XRDmiNQ2q7XdudZxC+mSBKCZ49wsRrwk5FGaW3yrmBLc9JhGDngjWZO4oDL5
         trqNqEB6Lu4VXMI64+jg3L76NwZsGLlHAP3CovzK0VTFSqplYiOdGK72/mR71HMWeoG0
         nTgYMh/mM3/D8UUQOkZd5wMVRX9nZ8sefCHqi1vxErR59C5no4ZTjxpt0tuqm2d93L5B
         dRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374812; x=1684966812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1WIlbyh5VPpGVg7Ssl9PuHGafr3ZYUMF2sL7AwCXDU=;
        b=RtMK/J4CYrLSCM+qCehC6S00Zv111PVKLqX2lQqVG8RWQ6ZJP07ni0I24Vz9mEyGWt
         Uan41oLf3PuuWFzAcomxIgQrX4jJn9joS4l2TdjQ6BOFbioYJHnQnV9o3xxZ7nGR32D6
         rZ3iYbRP3VNPvONYrqNROPh1nckoW/UWkE/3FOzX7AdxNgxAexoElvfu1+tGJXVc+fDB
         93L66cx4IO4HIyyFwh5qdz2oA1CaKyYr70FiSh/3xl0U+jg+SFCsfckL7gUvDC2Hr5lq
         fnW9xx3uoLK/P3LTcPP3TLzutjcWM/x1oiymSd/vBJmgvbYxoE2eIajlLUfcXvBWh8lW
         pzVQ==
X-Gm-Message-State: AAQBX9cacl2QWS4XedZmHZW7Q2pHJadyIEX2NhFF+ni2S79mpeOGEKha
        YwTWgedRoOEqM2oITLaiuJ0HemPiGYkdgIET7cdFjQ==
X-Google-Smtp-Source: AKy350ZHS9Y+DgyIuHwIq68FrKBlj2G73WdHuZcdUSWQXCj8emH1jiNTVfkfB+A8jfVcmK3GU7z4JA==
X-Received: by 2002:a25:d049:0:b0:b8f:9b8:ceb7 with SMTP id h70-20020a25d049000000b00b8f09b8ceb7mr11130447ybg.44.1682374812577;
        Mon, 24 Apr 2023 15:20:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p71-20020a0de64a000000b00552e1d1ac1esm3207823ywe.13.2023.04.24.15.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 15:20:12 -0700 (PDT)
Date:   Mon, 24 Apr 2023 18:20:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 1/6] string-list: multi-delimiter
 `string_list_split_in_place()`
Message-ID: <59d3e778b6c80b6bd10c1126cdc3f7e86558f3e7.1682374789.git.me@ttaylorr.com>
References: <cover.1681428696.git.me@ttaylorr.com>
 <cover.1682374789.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1682374789.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Enhance `string_list_split_in_place()` to accept multiple characters as
delimiters instead of a single character.

Instead of using `strchr(2)` to locate the first occurrence of the given
delimiter character, `string_list_split_in_place_multi()` uses
`strcspn(2)` to move past the initial segment of characters comprised of
any characters in the delimiting set.

When only a single delimiting character is provided, `strpbrk(2)` (which
is implemented with `strcspn(2)`) has equivalent performance to
`strchr(2)`. Modern `strcspn(2)` implementations treat an empty
delimiter or the singleton delimiter as a special case and fall back to
calling strchrnul(). Both glibc[1] and musl[2] implement `strcspn(2)`
this way.

This change is one step to removing `strtok(2)` from the tree. Note that
`string_list_split_in_place()` is not a strict replacement for
`strtok()`, since it will happily turn sequential delimiter characters
into empty entries in the resulting string_list. For example:

    string_list_split_in_place(&xs, "foo:;:bar:;:baz", ":;", -1)

would yield a string list of:

    ["foo", "", "", "bar", "", "", "baz"]

Callers that wish to emulate the behavior of strtok(2) more directly
should call `string_list_remove_empty_items()` after splitting.

To avoid regressions for the new multi-character delimter cases, update
t0063 in this patch as well.

[1]: https://sourceware.org/git/?p=glibc.git;a=blob;f=string/strcspn.c;hb=glibc-2.37#l35
[2]: https://git.musl-libc.org/cgit/musl/tree/src/string/strcspn.c?h=v1.2.3#n11

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/gc.c                |  4 +--
 diff.c                      |  2 +-
 notes.c                     |  2 +-
 refs/packed-backend.c       |  2 +-
 string-list.c               |  4 +--
 string-list.h               |  2 +-
 t/helper/test-string-list.c |  4 +--
 t/t0063-string-list.sh      | 51 +++++++++++++++++++++++++++++++++++++
 8 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index edd98d35a5..f68e976704 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1687,11 +1687,11 @@ static int get_schedule_cmd(const char **cmd, int *is_available)
 	if (is_available)
 		*is_available = 0;
 
-	string_list_split_in_place(&list, testing, ',', -1);
+	string_list_split_in_place(&list, testing, ",", -1);
 	for_each_string_list_item(item, &list) {
 		struct string_list pair = STRING_LIST_INIT_NODUP;
 
-		if (string_list_split_in_place(&pair, item->string, ':', 2) != 2)
+		if (string_list_split_in_place(&pair, item->string, ":", 2) != 2)
 			continue;
 
 		if (!strcmp(*cmd, pair.items[0].string)) {
diff --git a/diff.c b/diff.c
index 78b0fdd8ca..378a0248e1 100644
--- a/diff.c
+++ b/diff.c
@@ -134,7 +134,7 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
 	int i;
 
 	if (*params_copy)
-		string_list_split_in_place(&params, params_copy, ',', -1);
+		string_list_split_in_place(&params, params_copy, ",", -1);
 	for (i = 0; i < params.nr; i++) {
 		const char *p = params.items[i].string;
 		if (!strcmp(p, "changes")) {
diff --git a/notes.c b/notes.c
index 45fb7f22d1..eee806f626 100644
--- a/notes.c
+++ b/notes.c
@@ -963,7 +963,7 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 	char *globs_copy = xstrdup(globs);
 	int i;
 
-	string_list_split_in_place(&split, globs_copy, ':', -1);
+	string_list_split_in_place(&split, globs_copy, ":", -1);
 	string_list_remove_empty_items(&split, 0);
 
 	for (i = 0; i < split.nr; i++)
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 1eba1015dd..cc903baa7e 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -650,7 +650,7 @@ static struct snapshot *create_snapshot(struct packed_ref_store *refs)
 					 snapshot->buf,
 					 snapshot->eof - snapshot->buf);
 
-		string_list_split_in_place(&traits, p, ' ', -1);
+		string_list_split_in_place(&traits, p, " ", -1);
 
 		if (unsorted_string_list_has_string(&traits, "fully-peeled"))
 			snapshot->peeled = PEELED_FULLY;
diff --git a/string-list.c b/string-list.c
index db473f273e..5f5b60fe1c 100644
--- a/string-list.c
+++ b/string-list.c
@@ -301,7 +301,7 @@ int string_list_split(struct string_list *list, const char *string,
 }
 
 int string_list_split_in_place(struct string_list *list, char *string,
-			       int delim, int maxsplit)
+			       const char *delim, int maxsplit)
 {
 	int count = 0;
 	char *p = string, *end;
@@ -315,7 +315,7 @@ int string_list_split_in_place(struct string_list *list, char *string,
 			string_list_append(list, p);
 			return count;
 		}
-		end = strchr(p, delim);
+		end = strpbrk(p, delim);
 		if (end) {
 			*end = '\0';
 			string_list_append(list, p);
diff --git a/string-list.h b/string-list.h
index c7b0d5d000..77854840f7 100644
--- a/string-list.h
+++ b/string-list.h
@@ -270,5 +270,5 @@ int string_list_split(struct string_list *list, const char *string,
  * list->strdup_strings must *not* be set.
  */
 int string_list_split_in_place(struct string_list *list, char *string,
-			       int delim, int maxsplit);
+			       const char *delim, int maxsplit);
 #endif /* STRING_LIST_H */
diff --git a/t/helper/test-string-list.c b/t/helper/test-string-list.c
index 2123dda85b..63df88575c 100644
--- a/t/helper/test-string-list.c
+++ b/t/helper/test-string-list.c
@@ -62,7 +62,7 @@ int cmd__string_list(int argc, const char **argv)
 		struct string_list list = STRING_LIST_INIT_NODUP;
 		int i;
 		char *s = xstrdup(argv[2]);
-		int delim = *argv[3];
+		const char *delim = argv[3];
 		int maxsplit = atoi(argv[4]);
 
 		i = string_list_split_in_place(&list, s, delim, maxsplit);
@@ -111,7 +111,7 @@ int cmd__string_list(int argc, const char **argv)
 		 */
 		if (sb.len && sb.buf[sb.len - 1] == '\n')
 			strbuf_setlen(&sb, sb.len - 1);
-		string_list_split_in_place(&list, sb.buf, '\n', -1);
+		string_list_split_in_place(&list, sb.buf, "\n", -1);
 
 		string_list_sort(&list);
 
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index 46d4839194..1fee6d9010 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -18,6 +18,14 @@ test_split () {
 	"
 }
 
+test_split_in_place() {
+	cat >expected &&
+	test_expect_success "split (in place) $1 at $2, max $3" "
+		test-tool string-list split_in_place '$1' '$2' '$3' >actual &&
+		test_cmp expected actual
+	"
+}
+
 test_split "foo:bar:baz" ":" "-1" <<EOF
 3
 [0]: "foo"
@@ -61,6 +69,49 @@ test_split ":" ":" "-1" <<EOF
 [1]: ""
 EOF
 
+test_split_in_place "foo:;:bar:;:baz:;:" ":;" "-1" <<EOF
+10
+[0]: "foo"
+[1]: ""
+[2]: ""
+[3]: "bar"
+[4]: ""
+[5]: ""
+[6]: "baz"
+[7]: ""
+[8]: ""
+[9]: ""
+EOF
+
+test_split_in_place "foo:;:bar:;:baz" ":;" "0" <<EOF
+1
+[0]: "foo:;:bar:;:baz"
+EOF
+
+test_split_in_place "foo:;:bar:;:baz" ":;" "1" <<EOF
+2
+[0]: "foo"
+[1]: ";:bar:;:baz"
+EOF
+
+test_split_in_place "foo:;:bar:;:baz" ":;" "2" <<EOF
+3
+[0]: "foo"
+[1]: ""
+[2]: ":bar:;:baz"
+EOF
+
+test_split_in_place "foo:;:bar:;:" ":;" "-1" <<EOF
+7
+[0]: "foo"
+[1]: ""
+[2]: ""
+[3]: "bar"
+[4]: ""
+[5]: ""
+[6]: ""
+EOF
+
 test_expect_success "test filter_string_list" '
 	test "x-" = "x$(test-tool string-list filter - y)" &&
 	test "x-" = "x$(test-tool string-list filter no y)" &&
-- 
2.40.0.380.gd2df7d2365

