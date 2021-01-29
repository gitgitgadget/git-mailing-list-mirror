Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFCDC433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 21:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E450C64E06
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 21:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbhA2VKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 16:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbhA2VJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 16:09:57 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7537C0613ED
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 13:09:09 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id g10so10187057wrx.1
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 13:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9L5tYd1zDSsXacY/l8HMxPiegMGQWdMmroNXlEoEons=;
        b=WM+qNKsjvKwwILRPi5vp33RaVTe4LJG1SPjxDlIAPMJR1+wI77GEaivicgnnggAJ/m
         zMvaMvPUuEN43c9wiTlPieAi/ih4rfyOT0BYMsJbErab2f+55/+FFlpxA2CKATfC5KgO
         fldqvfqups5ZoXff6RZCWy3HYPPtrPMn05rmQak5VO1/mtOnVirfDGwCoNzk4ySUUMvE
         U8Sa1hPfyoHMT6HAgxrl4V/2EYB4bzq+xT250a4ojED84Qq9OTgLKSc64eldR3OTxh7b
         wPcgxHjEwChOiN9NGuRcGYXq81UeJaVbcaMRVovZqkVPTK54KbGASy80eRUHK3Z3ddQe
         zs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9L5tYd1zDSsXacY/l8HMxPiegMGQWdMmroNXlEoEons=;
        b=JRr85ofFk/92D7J6ub8bzABnzQlo3vqyuo6A5GFANMHALuB0P8XiM0YnLzwXAB2QFt
         INnOxvDwb5Rfhie5PibxuHloat1Ih4Pay12mfCMYWAzkIvczCnIB3c6cafGRKRXQZ8Rc
         /XB4e69uxjV7bwOUje6+PeYkn8dOGeTa3nwjOlDUOpijLYmc/bSDXm7CtJOkszQk/ERG
         H9lVi3apezozoVfCs+lGwKpjPPd/5nbRHEuukm2rG6NRTyi2emkiOQ5tg02bCLRcmwrj
         JEYrYd0swqFjGx0stkJyW9EYjofGKyBNyGubjPsONw30mvUJ0q2AgZeclcvTkhUGfBos
         yNAg==
X-Gm-Message-State: AOAM531e2i9zIaPtGYV753PRIT2tQpppVLRAGfzXKPXd2AoIM4tZ5b7t
        q0eukK2JNvuz3+q4MeAnLvDU4ZXsvyM=
X-Google-Smtp-Source: ABdhPJwRmPsMq1VJ7snz07RCEKG2s59DVrCiP0HCe9cYTki0c5bK5688zKI6IDeI+F1dRP5eoQqI9g==
X-Received: by 2002:adf:ffce:: with SMTP id x14mr6759065wrs.390.1611954548352;
        Fri, 29 Jan 2021 13:09:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y20sm11121398wmj.44.2021.01.29.13.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 13:09:07 -0800 (PST)
Message-Id: <7b8cfb2721c349f2bcebec98f84291b1cffd3b49.1611954543.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
        <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jan 2021 21:09:03 +0000
Subject: [PATCH v2 3/3] ref-filter: use pretty.c logic for trailers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

Now, ref-filter is using pretty.c logic for setting trailer options.

New to ref-filter:
  :key=<K> - only show trailers with specified key.
  :valueonly[=val] - only show the value part.
  :separator=<SEP> - inserted between trailer lines.
  :key_value_separator=<SEP> - inserted between trailer lines

Enhancement to existing options(now can take value and its optional):
  :only[=val]
  :unfold[=val]

'val' can be: true, on, yes or false, off, no.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 Documentation/git-for-each-ref.txt |  39 ++++++++--
 ref-filter.c                       |  36 +++++----
 t/t6300-for-each-ref.sh            | 119 +++++++++++++++++++++++++----
 3 files changed, 160 insertions(+), 34 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 2962f85a502..ea1f8417176 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -260,11 +260,40 @@ contents:lines=N::
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
+   the literal formatting codes. To use comma as separator one must use
+   `%x2C` as it would otherwise be parsed as next option. If separator
+   option is given multiple times only the last one is used.
+   E.g., `%(trailers:key=Ticket,separator=%x2C)` shows all trailer lines
+   whose key is "Ticket" separated by a comma.
+** 'key_value_separator=<SEP>': specify a separator inserted between
+   key and value. The string SEP may contain the literal formatting codes.
+   E.g., `%(trailers:key=Ticket,key_value_separator=%x2C)` shows all trailer
+   lines whose key is "Ticket" with key and value separated by a comma.
+** 'unfold[=val]': make it behave as if interpret-trailer's `--unfold`
+   option was given. In same way as to for `only` it can be followed
+   by an equal sign and explicit value. E.g.,
+   `%(trailers:only,unfold=true)` unfolds and shows all trailer lines.
+** 'valueonly[=val]': skip over the key part of the trailer line and only
+   show the value part. Also this optionally allows explicit value.
 
 For sorting purposes, fields with numeric values sort in numeric order
 (`objectsize`, `authordate`, `committerdate`, `creatordate`, `taggerdate`).
diff --git a/ref-filter.c b/ref-filter.c
index ee337df232a..2b1c61eadf4 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -67,6 +67,12 @@ struct refname_atom {
 	int lstrip, rstrip;
 };
 
+struct ref_trailer_buf {
+	struct string_list filter_list;
+	struct strbuf sepbuf;
+	struct strbuf kvsepbuf;
+} ref_trailer_buf;
+
 static struct expand_data {
 	struct object_id oid;
 	enum object_type type;
@@ -313,28 +319,26 @@ static int subject_atom_parser(const struct ref_format *format, struct used_atom
 static int trailers_atom_parser(const struct ref_format *format, struct used_atom *atom,
 				const char *arg, struct strbuf *err)
 {
-	struct string_list params = STRING_LIST_INIT_DUP;
-	int i;
-
 	atom->u.contents.trailer_opts.no_divider = 1;
 
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
+		char *invalid_arg = NULL;
+
+		if (format_set_trailers_options(&atom->u.contents.trailer_opts,
+			&ref_trailer_buf.filter_list,
+			&ref_trailer_buf.sepbuf,
+			&ref_trailer_buf.kvsepbuf,
+			&argbuf, &invalid_arg)) {
+			if (!invalid_arg)
+				strbuf_addf(err, _("expected %%(trailers:key=<value>)"));
+			else
+				strbuf_addf(err, _("unknown %%(trailers) argument: %s"), invalid_arg);
+			free((char *)invalid_arg);
+			return -1;
 		}
 	}
 	atom->u.contents.option = C_TRAILERS;
-	string_list_clear(&params, 0);
 	return 0;
 }
 
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index ca62e764b58..a8835b13915 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -825,14 +825,32 @@ test_expect_success '%(trailers:unfold) unfolds trailers' '
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
+		git for-each-ref --format="%($option)" refs/heads/main >actual &&
+		test_cmp expect actual &&
+		git for-each-ref --format="%(contents:$option)" refs/heads/main >actual &&
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
-	git for-each-ref --format="%(trailers:only)" refs/heads/main >actual &&
+	git for-each-ref --format="%(trailers:only=no)" refs/heads/main >actual &&
 	test_cmp expect actual &&
-	git for-each-ref --format="%(contents:trailers:only)" refs/heads/main >actual &&
+	git for-each-ref --format="%(contents:trailers:only=no)" refs/heads/main >actual &&
 	test_cmp expect actual
 '
 
@@ -851,17 +869,92 @@ test_expect_success '%(trailers:only) and %(trailers:unfold) work together' '
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
+		git for-each-ref --format="%($option)" refs/heads/main >actual &&
+		test_cmp expect actual &&
+		git for-each-ref --format="%(contents:$option)" refs/heads/main >actual &&
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
+	git for-each-ref --format="%(trailers:key=Acked-by)" refs/heads/main >actual &&
+	test_cmp expect actual &&
+	git for-each-ref --format="%(contents:trailers:key=Acked-by)" refs/heads/main >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '%(trailers:key=foo,unfold) properly unfolds' '
+	{
+		unfold <trailers | grep Signed-off-by &&
+		echo
+	} >expect &&
+	git for-each-ref --format="%(trailers:key=Signed-Off-by,unfold)" refs/heads/main >actual &&
+	test_cmp expect actual &&
+	git for-each-ref --format="%(contents:trailers:key=Signed-Off-by,unfold)" refs/heads/main >actual &&
+	test_cmp expect actual
 '
 
+test_expect_success 'pretty format %(trailers:key=foo,only=no) also includes nontrailer lines' '
+	{
+		echo "Signed-off-by: A U Thor <author@example.com>" &&
+		grep patch.description <trailers &&
+		echo
+	} >expect &&
+	git for-each-ref --format="%(trailers:key=Signed-off-by,only=no)" refs/heads/main >actual &&
+	test_cmp expect actual &&
+	git for-each-ref --format="%(contents:trailers:key=Signed-off-by,only=no)" refs/heads/main >actual &&
+	test_cmp expect actual
+'
+
+test_trailer_option '%(trailers:key=foo,valueonly) shows only value' \
+	'trailers:key=Signed-off-by,valueonly' 'A U Thor <author@example.com>\n'
+test_trailer_option '%(trailers:separator) changes separator' \
+	'trailers:separator=%x2C,key=Reviewed-by,key=Signed-off-by:' 'Reviewed-by: A U Thor <author@example.com>,Signed-off-by: A U Thor <author@example.com>'
+test_trailer_option '%(trailers:key_value_separator) changes key-value separator' \
+	'trailers:key_value_separator=%x2C,key=Reviewed-by,key=Signed-off-by:' 'Reviewed-by,A U Thor <author@example.com>\nSigned-off-by,A U Thor <author@example.com>\n'
+test_trailer_option '%(trailers:separator,key_value_separator) changes both separators' \
+	'trailers:separator=%x2C,key_value_separator=%x2C,key=Reviewed-by,key=Signed-off-by:' 'Reviewed-by,A U Thor <author@example.com>,Signed-off-by,A U Thor <author@example.com>'
+
+test_failing_trailer_option () {
+	title="$1"
+	option="$2"
+	error="$3"
+	test_expect_success "$title" '
+		# error message cannot be checked under i18n
+		echo $error >expect &&
+		test_must_fail git for-each-ref --format="%($option)" refs/heads/main 2>actual &&
+		test_i18ncmp expect actual &&
+		test_must_fail git for-each-ref --format="%(contents:$option)" refs/heads/main 2>actual &&
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
