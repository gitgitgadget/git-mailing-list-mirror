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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C329C433DB
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 09:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52CEC64FAD
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 09:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhBFJQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Feb 2021 04:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhBFJQc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Feb 2021 04:16:32 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB18C061788
        for <git@vger.kernel.org>; Sat,  6 Feb 2021 01:15:51 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id 7so10547519wrz.0
        for <git@vger.kernel.org>; Sat, 06 Feb 2021 01:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qhcNMb+THj0XqC35PkuB9B/JBzdE/jH5KhZ2Xa2snrE=;
        b=o/EyGptYKZON/ArNmbvJ5aWtehmqUeqhM6Uuik2dxx2QZiLF52cg9uVZ8iCuNgpaMN
         3v3K1+9IyF/20YYZnGckt5v/knVqu4bNo40+ae9f929Ri9hz3e1JsSzVjzfzdEi3qGnK
         UHU/revZSyfqlwcAkjQw6SQZhUBCcofpT5EO3DAgik4/hDJk7jC0dspeTkttrdsZ+swB
         zIElcyVH2NEO3s38gWHyVlKWhbTw57vuePUAjJrC6xkEIRJp2LQTOTNfKxRhOgvx6iUG
         lqbDkYPqY+sbrzz7y8r1Kt98+y8J9Ap9G22oyMkC+4GaQEcmwUQiGOrNuwPxPDsvj/df
         fXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qhcNMb+THj0XqC35PkuB9B/JBzdE/jH5KhZ2Xa2snrE=;
        b=JZRJoCQi1fiidGghCtPb7rq8wG2Gmr/Bs+L66XA/vRhHq0oGPhoLkJ1QsQtR+t0bsW
         Jmx3WuagF3NNgLinnLEM2GjlKPQd9JrTEP/l0z+f9L/gD5PgYVqTg/FmNr3b1brGKQvV
         0E0Rs1pgWkCSJSH0t2Ws+Oi+HoskRKnflS38LmpGNGKnf6oerQPc/j3GcOB4uLkdKHRo
         eMo8YKD8rD3Quvl1Htf8it5/SDXf3T+HQKJKs/tqBZAV1FpYfIlYqpR+2cIOrWgLyDRy
         VipEl/v2U45Tg8Hz1zfOwtCPNc3BgTKeVk6NgamiEocHJVXY5petHtXo6OBgupJMlh8P
         YbHw==
X-Gm-Message-State: AOAM532CVy6MG5I8VF8UWyu08siAGEUdDvZ1Q6lPMjCr/qAoglWCcWCD
        /gmvY36dZkvqNQaHna27bAIwZnyZXt0=
X-Google-Smtp-Source: ABdhPJy14IlCri28XeiJWh/cS//ur4iaxH8Io7gY1kXfCx0FMdUEYbaGiNEXcY48UthERk81q6RReA==
X-Received: by 2002:a05:6000:104:: with SMTP id o4mr9295729wrx.419.1612602950245;
        Sat, 06 Feb 2021 01:15:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w25sm11196159wmc.42.2021.02.06.01.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 01:15:49 -0800 (PST)
Message-Id: <47d89f872314cad6dc6010ff3c8ade43a70bc540.1612602945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
References: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
        <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 06 Feb 2021 09:15:44 +0000
Subject: [PATCH v3 3/3] ref-filter: use pretty.c logic for trailers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
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
  :key_value_separator=<SEP> - inserted between key and value in trailer lines

Enhancement to existing options(now can take value and its optional):
  :only[=val]
  :unfold[=val]

'val' can be: true, on, yes or false, off, no.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 Documentation/git-for-each-ref.txt |   8 +-
 ref-filter.c                       |  36 +++++----
 t/t6300-for-each-ref.sh            | 119 +++++++++++++++++++++++++----
 3 files changed, 129 insertions(+), 34 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 2962f85a502a..2ae2478de706 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -260,11 +260,9 @@ contents:lines=N::
 	The first `N` lines of the message.
 
 Additionally, the trailers as interpreted by linkgit:git-interpret-trailers[1]
-are obtained as `trailers` (or by using the historical alias
-`contents:trailers`).  Non-trailer lines from the trailer block can be omitted
-with `trailers:only`. Whitespace-continuations can be removed from trailers so
-that each trailer appears on a line by itself with its full content with
-`trailers:unfold`. Both can be used together as `trailers:unfold,only`.
+are obtained as `trailers[:options]` (or by using the historical alias
+`contents:trailers[:options]`). For valid [:option] values see `trailers`
+section of linkgit:git-log[1].
 
 For sorting purposes, fields with numeric values sort in numeric order
 (`objectsize`, `authordate`, `committerdate`, `creatordate`, `taggerdate`).
diff --git a/ref-filter.c b/ref-filter.c
index ee337df232a5..4dc4882cc768 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -67,6 +67,12 @@ struct refname_atom {
 	int lstrip, rstrip;
 };
 
+static struct ref_trailer_buf {
+	struct string_list filter_list;
+	struct strbuf sepbuf;
+	struct strbuf kvsepbuf;
+} ref_trailer_buf = {STRING_LIST_INIT_NODUP, STRBUF_INIT, STRBUF_INIT};
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
+		    &ref_trailer_buf.filter_list,
+		    &ref_trailer_buf.sepbuf,
+		    &ref_trailer_buf.kvsepbuf,
+		    &argbuf, &invalid_arg)) {
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
index ca62e764b586..4b3745839c86 100755
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
+		printf "$expect\n" >expect &&
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
