Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F18DC43461
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4328F20757
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biSY0Cps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgIETsT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 15:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbgIETsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Sep 2020 15:48:16 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB36C061246
        for <git@vger.kernel.org>; Sat,  5 Sep 2020 12:48:16 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so10733956wrm.2
        for <git@vger.kernel.org>; Sat, 05 Sep 2020 12:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nXCAjWl+d235rfhv/nONwuPbPcDOhF6iJfXwBfAZ0k8=;
        b=biSY0CpshXbuNIeyQxkJK9kmR7IYtrfptaAdlktwmwTwuy+DOE7tcj2GHEvAnJyX6a
         cXE3iWB5a4s4c6vdD+0+atrysC/pO5pnzsXOKwKF2MEAKhNbH6P+Ef6lw8OpHmGJ8QrZ
         eYiGtMmSaUrTY7AsvO05llHlQ8hyCIvMWtMe4OvyJcoR1K7Cbf+L9QCbNBMFWHA9G4Uv
         Qn2Bu8Wo8a4D5cvvSPkSKqIr51W/r0TQXYBfgIPsDLmTCsSVAEzwk/18OZi5rVecDkfX
         c61G2JnqbUdwzoLHuL6Z6wKXvWFybjR6ifZMleoBoGnV2D723oB9SAM+mMZZwpsMzH75
         lV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nXCAjWl+d235rfhv/nONwuPbPcDOhF6iJfXwBfAZ0k8=;
        b=lWWNW7+d1auRHcd4sXAwD9WJGHls9NPXERWoeUkRw94Z4KkG1afaC+Pe6BZnBRTPEZ
         iGfcs0w6WS/nTnOuoI2i4XgyT6XT+yG99imYeBSNAVAu6RC5z/KsMHlKB6KcNYOGX1uk
         B5wnv3t6R97gM5YfsGqhwElGgGV6rakxK0n4tZxf3fnZZWtCwekdL2luWdXa/1DN37CI
         xYfzUBzuZcDVm27aPjbhZ6Im3DUX/51ovD5bHVU3xwUeA3nF3EwXcbLlYtVCE9F9TMea
         OrPt43qco/Y7puPEI7qP64Tpo42eqhr2r4NtqiModzFBbAGsDgRuFO+6qIfdfaUxQ8z8
         8fOg==
X-Gm-Message-State: AOAM533SreMiOx2v4VcfboLx52bIDEA22uKFpj6zvsdXplcQJ1Y7Z+Hu
        MaYTA9GviTKmMoXczaNohdYVs6WChZk=
X-Google-Smtp-Source: ABdhPJz51xvhuWWfVN8l9XRuTjq76AV7LMg9tU7WwBffornJ1wg8YNj43MyT5+EnNGXy9DjYIwg+sQ==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr13461466wrc.193.1599335294415;
        Sat, 05 Sep 2020 12:48:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x16sm18154862wrq.62.2020.09.05.12.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 12:48:13 -0700 (PDT)
Message-Id: <a3e1629826236c2bf7e2512af4acd13e72683687.1599335291.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.git.1599335291.gitgitgadget@gmail.com>
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Sep 2020 19:48:11 +0000
Subject: [PATCH 2/2] ref-filter: using pretty.c logic for trailers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

Now, ref-filter is using pretty.c logic for setting trailer options.

New to ref-filter:
  :key=<K> - only show trailers with specified key.
  :valueonly[=val] - only show the value part.
  :separator=<SEP> - inserted between trailer lines

Enhancement to existing options(now can take value and its optional):
  :only[=val]
  :unfold[=val]

'val' can be: true, on, yes or false, off, no.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 Documentation/git-for-each-ref.txt |  36 +++++++--
 ref-filter.c                       |  35 ++++-----
 t/t6300-for-each-ref.sh            | 115 +++++++++++++++++++++++++----
 3 files changed, 151 insertions(+), 35 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 2ea71c5f6c..f8e15916bc 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -254,11 +254,37 @@ contents:lines=N::
 	The first `N` lines of the message.
 
 Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
-are obtained as `trailers` (or by using the historical alias
-`contents:trailers`).  Non-trailer lines from the trailer block can be omitted
-with `trailers:only`. Whitespace-continuations can be removed from trailers so
-that each trailer appears on a line by itself with its full content with
-`trailers:unfold`. Both can be used together as `trailers:unfold,only`.
+are obtained as `trailers[:options]` (or by using the historical alias
+`contents:trailers[:options]`). Valid [:option] are:
+** 'key=<K>': only show trailers with specified key. Matching is done
+   case-insensitively and trailing colon is optional. If option is
+   given multiple times trailer lines matching any of the keys are
+   shown. This option automatically enables the `only` option so that
+   non-trailer lines in the trailer block are hidden. If that is not
+   desired it can be disabled with `only=false`.  E.g.,
+   `%(trailers:key=Reviewed-by)` shows trailer lines with key
+   `Reviewed-by`.
+** 'only[=val]': select whether non-trailer lines from the trailer
+   block should be included. The `only` keyword may optionally be
+   followed by an equal sign and one of `true`, `on`, `yes` to omit or
+   `false`, `off`, `no` to show the non-trailer lines. If option is
+   given without value it is enabled. If given multiple times the last
+   value is used.
+** 'separator=<SEP>': specify a separator inserted between trailer
+   lines. When this option is not given each trailer line is
+   terminated with a line feed character. The string SEP may contain
+   the literal formatting codes described above. To use comma as
+   separator one must use `%x2C` as it would otherwise be parsed as
+   next option. If separator option is given multiple times only the
+   last one is used. E.g., `%(trailers:key=Ticket,separator=%x2C )`
+   shows all trailer lines whose key is "Ticket" separated by a comma
+   and a space.
+** 'unfold[=val]': make it behave as if interpret-trailer's `--unfold`
+   option was given. In same way as to for `only` it can be followed
+   by an equal sign and explicit value. E.g.,
+   `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
+** 'valueonly[=val]': skip over the key part of the trailer line and only
+   show the value part. Also this optionally allows explicit value.
 
 For sorting purposes, fields with numeric values sort in numeric order
 (`objectsize`, `authordate`, `committerdate`, `creatordate`, `taggerdate`).
diff --git a/ref-filter.c b/ref-filter.c
index 8ba0e31915..20f5b829ee 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -67,6 +67,11 @@ struct refname_atom {
 	int lstrip, rstrip;
 };
 
+struct ref_trailer_buf {
+	struct string_list filter_list;
+	struct strbuf sepbuf;
+} ref_trailer_buf;
+
 static struct expand_data {
 	struct object_id oid;
 	enum object_type type;
@@ -307,28 +312,24 @@ static int subject_atom_parser(const struct ref_format *format, struct used_atom
 static int trailers_atom_parser(const struct ref_format *format, struct used_atom *atom,
 				const char *arg, struct strbuf *err)
 {
-	struct string_list params = STRING_LIST_INIT_DUP;
-	int i;
-
 	atom->u.contents.trailer_opts.no_divider = 1;
-
 	if (arg) {
-		string_list_split(&params, arg, ',', -1);
-		for (i = 0; i < params.nr; i++) {
-			const char *s = params.items[i].string;
-			if (!strcmp(s, "unfold"))
-				atom->u.contents.trailer_opts.unfold = 1;
-			else if (!strcmp(s, "only"))
-				atom->u.contents.trailer_opts.only_trailers = 1;
-			else {
-				strbuf_addf(err, _("unknown %%(trailers) argument: %s"), s);
-				string_list_clear(&params, 0);
-				return -1;
-			}
+		const char *argbuf = xstrfmt("%s)", arg);
+		const char *err_arg = NULL;
+
+		if (format_set_trailers_options(&atom->u.contents.trailer_opts,
+			&ref_trailer_buf.filter_list,
+			&ref_trailer_buf.sepbuf,
+			&argbuf, &err_arg)) {
+			if (!err_arg)
+				strbuf_addf(err, _("expected %%(trailers:key=<value>)"));
+			else
+				strbuf_addf(err, _("unknown %%(trailers) argument: %s"), err_arg);
+			free((char *)err_arg);
+			return -1;
 		}
 	}
 	atom->u.contents.option = C_TRAILERS;
-	string_list_clear(&params, 0);
 	return 0;
 }
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 58adee7d18..aa3dc9f43b 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -786,14 +786,32 @@ test_expect_success '%(trailers:unfold) unfolds trailers' '
 	test_cmp expect actual
 '
 
-test_expect_success '%(trailers:only) shows only "key: value" trailers' '
+test_show_key_value_trailers () {
+	option="$1"
+	test_expect_success "%($option) shows only 'key: value' trailers" '
+		{
+			grep -v patch.description <trailers &&
+			echo
+		} >expect &&
+		git for-each-ref --format="%($option)" refs/heads/master >actual &&
+		test_cmp expect actual &&
+		git for-each-ref --format="%(contents:$option)" refs/heads/master >actual &&
+		test_cmp expect actual
+	'
+}
+
+test_show_key_value_trailers 'trailers:only'
+test_show_key_value_trailers 'trailers:only=no,only=true'
+test_show_key_value_trailers 'trailers:only=yes'
+
+test_expect_success '%(trailers:only=no) shows all trailers' '
 	{
-		grep -v patch.description <trailers &&
+		cat trailers &&
 		echo
 	} >expect &&
-	git for-each-ref --format="%(trailers:only)" refs/heads/master >actual &&
+	git for-each-ref --format="%(trailers:only=no)" refs/heads/master >actual &&
 	test_cmp expect actual &&
-	git for-each-ref --format="%(contents:trailers:only)" refs/heads/master >actual &&
+	git for-each-ref --format="%(contents:trailers:only=no)" refs/heads/master >actual &&
 	test_cmp expect actual
 '
 
@@ -812,17 +830,88 @@ test_expect_success '%(trailers:only) and %(trailers:unfold) work together' '
 	test_cmp actual actual
 '
 
-test_expect_success '%(trailers) rejects unknown trailers arguments' '
-	# error message cannot be checked under i18n
-	cat >expect <<-EOF &&
-	fatal: unknown %(trailers) argument: unsupported
-	EOF
-	test_must_fail git for-each-ref --format="%(trailers:unsupported)" 2>actual &&
-	test_i18ncmp expect actual &&
-	test_must_fail git for-each-ref --format="%(contents:trailers:unsupported)" 2>actual &&
-	test_i18ncmp expect actual
+test_trailer_option() {
+	title="$1"
+	option="$2"
+	expect="$3"
+	test_expect_success "$title" '
+		echo $expect >expect &&
+		git for-each-ref --format="%($option)" refs/heads/master >actual &&
+		test_cmp expect actual &&
+		git for-each-ref --format="%(contents:$option)" refs/heads/master >actual &&
+		test_cmp expect actual
+	'
+}
+
+test_trailer_option '%(trailers:key=foo) shows that trailer' \
+	'trailers:key=Signed-off-by' 'Signed-off-by: A U Thor <author@example.com>\n'
+test_trailer_option '%(trailers:key=foo) is case insensitive' \
+	'trailers:key=SiGned-oFf-bY' 'Signed-off-by: A U Thor <author@example.com>\n'
+test_trailer_option '%(trailers:key=foo:) trailing colon also works' \
+	'trailers:key=Signed-off-by:' 'Signed-off-by: A U Thor <author@example.com>\n'
+test_trailer_option '%(trailers:key=foo) multiple keys' \
+	'trailers:key=Reviewed-by:,key=Signed-off-by' 'Reviewed-by: A U Thor <author@example.com>\nSigned-off-by: A U Thor <author@example.com>\n'
+test_trailer_option '%(trailers:key=nonexistent) becomes empty' \
+	'trailers:key=Shined-off-by:' ''
+
+test_expect_success '%(trailers:key=foo) handles multiple lines even if folded' '
+	{
+		grep -v patch.description <trailers | grep -v Signed-off-by | grep -v Reviewed-by &&
+		echo
+	} >expect &&
+	git for-each-ref --format="%(trailers:key=Acked-by)" refs/heads/master >actual &&
+	test_cmp expect actual &&
+	git for-each-ref --format="%(contents:trailers:key=Acked-by)" refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(trailers:key=foo,unfold) properly unfolds' '
+	{
+		unfold <trailers | grep Signed-off-by &&
+		echo
+	} >expect &&
+	git for-each-ref --format="%(trailers:key=Signed-Off-by,unfold)" refs/heads/master >actual &&
+	test_cmp expect actual &&
+	git for-each-ref --format="%(contents:trailers:key=Signed-Off-by,unfold)" refs/heads/master >actual &&
+	test_cmp expect actual
 '
 
+test_expect_success 'pretty format %(trailers:key=foo,only=no) also includes nontrailer lines' '
+	{
+		echo "Signed-off-by: A U Thor <author@example.com>" &&
+		grep patch.description <trailers &&
+		echo
+	} >expect &&
+	git for-each-ref --format="%(trailers:key=Signed-off-by,only=no)" refs/heads/master >actual &&
+	test_cmp expect actual &&
+	git for-each-ref --format="%(contents:trailers:key=Signed-off-by,only=no)" refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_trailer_option '%(trailers:key=foo,valueonly) shows only value' \
+	'trailers:key=Signed-off-by,valueonly' 'A U Thor <author@example.com>\n'
+test_trailer_option '%(trailers:separator) changes separator' \
+	'trailers:separator=%x2C,key=Reviewed-by,key=Signed-off-by:' 'Reviewed-by: A U Thor <author@example.com>,Signed-off-by: A U Thor <author@example.com>'
+
+test_failing_trailer_option () {
+	title="$1"
+	option="$2"
+	error="$3"
+	test_expect_success "$title" '
+		# error message cannot be checked under i18n
+		echo $error >expect &&
+		test_must_fail git for-each-ref --format="%($option)" refs/heads/master 2>actual &&
+		test_i18ncmp expect actual &&
+		test_must_fail git for-each-ref --format="%(contents:$option)" refs/heads/master 2>actual &&
+		test_i18ncmp expect actual
+	'
+}
+
+test_failing_trailer_option '%(trailers:key) without value is error' \
+	'trailers:key' 'fatal: expected %(trailers:key=<value>)'
+test_failing_trailer_option '%(trailers) rejects unknown trailers arguments' \
+	'trailers:unsupported' 'fatal: unknown %(trailers) argument: unsupported'
+
 test_expect_success 'if arguments, %(contents:trailers) shows error if colon is missing' '
 	cat >expect <<-EOF &&
 	fatal: unrecognized %(contents) argument: trailersonly
-- 
gitgitgadget
