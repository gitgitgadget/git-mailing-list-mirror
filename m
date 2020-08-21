Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF94AC433E3
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9098D2076E
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hsq3pWPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHUVG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgHUVGX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:06:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED98C061755
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:06:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l2so3129931wrc.7
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 14:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YrfiyumIc+dnkMX191wSa+ug66Vr1S65SLxvTcQAIsw=;
        b=Hsq3pWPHaQfrcgPceQm4INAskOGb7nIwd/MnxCe6h1mf7DIkDqh1/7UAujZXF7ZDCk
         qKaihEHvB83PFD08EYDRz31EBY1CUwR3wY296HyuukN74DEaO6776PyWsWafVaTQ6jr2
         9QlwLeA6W+Gl6wgM6sp0Ho8RRn2AQkkpzPWjcdNsgHAn3Hqm6GTvf3ncFaA5VKLgFDX6
         /u9a0qSZMZF4cvJPOX20PDrCbyTIo7QwqnxyaVCyuJPAj6ON3QUak7pljayhM9y9Huhw
         bJLewTQoqhRtgpBvl1R0Q0nPfoshE8/oGLYhommw05INiR9w4H5ekXisXChvRddPX5L0
         wWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YrfiyumIc+dnkMX191wSa+ug66Vr1S65SLxvTcQAIsw=;
        b=i0y88TZpUKhfjncECFn5ufs9Gnsqt0MOJcobT7FNP1pCusO9a0L8Q9YBfCty7C372K
         sY34n/UjL7AsJqg/zvYzlJkOZpsUj6Y1oe4GQSAdzMqq8MK4v5kpu7z4N1v6LSOCDZEj
         sOuoCryDvCM1CxuTf2MVOuYRWNFw7Eg7G1LTNSgCcntVrq25J6gihrc0isx8MLEi4lAD
         KUepWPmzAZ6kRDcHS8icvRXEHx6fjVAwCR4VKpwmxukYp1NsrRtcJZWUd8FxDFPnZric
         xvQBp7eFZCj5dLAj01A+OLZgGCOs74KrIR5QCdcs2/3y4UQbRiZpLBx4jCYIl/8yS3yQ
         2TvQ==
X-Gm-Message-State: AOAM533u3+2W2kBg2cxzQ/ccp0PwjQPTUBNKIfXdA8FNm39aJrQwdEVF
        KS7qQ4N2srzvOc/rm9zh0lz3tXVLZag=
X-Google-Smtp-Source: ABdhPJydgvCbgKKS7H3AyL7tMTK8L0FvBOiXnhHKTgefpeWKYaed3vDLKM4iYRBqtntufioQE89UYA==
X-Received: by 2002:adf:df85:: with SMTP id z5mr4142013wrl.267.1598043980692;
        Fri, 21 Aug 2020 14:06:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o3sm6160153wru.64.2020.08.21.14.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 14:06:20 -0700 (PDT)
Message-Id: <d491be5d10991189f7ec6ead739c1d1500e437a1.1598043976.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.707.v3.git.1598043976.gitgitgadget@gmail.com>
References: <pull.707.v2.git.1598004663.gitgitgadget@gmail.com>
        <pull.707.v3.git.1598043976.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Aug 2020 21:06:16 +0000
Subject: [PATCH v3 4/4] ref-filter: using pretty.c logic for trailers
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
index fdf2c442c5..664af8588a 100755
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
 test_expect_success 'if arguments, %(contents:trailers) shows error if semicolon is missing' '
 	cat >expect <<-EOF &&
 	fatal: unrecognized %(contents) argument: trailersonly
-- 
gitgitgadget
