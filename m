Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF22C43381
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F58764E8E
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhBMBxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 20:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbhBMBx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 20:53:29 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2989DC061788
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 17:52:49 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o24so1500082wmh.5
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 17:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Hai9aTv6kH+slevzrTwkB5WpAOfiscriXAwCQcaluGU=;
        b=cQnjAd4AW25YVZE7jhjyh588PrlL9p4GvMdB5hr5uJX2FQ+mncjsg25KryTSd5nm+0
         +AsuzWyo+yrLlFhwmJmCGbUMC6aVgOxYxER7BNpSDtflulfQbjvGJkM3yWFixG3e0A/C
         YIUFJGpsNI+Vax0jHf+oSslXE7Wxw3ctJwgrRQhwtDcmCu5gmImaBPvdB+r2OFZSPkbM
         RKzrP5B6ldku5MIvIwd5nisvLqLNKhRpL3z2zz5MbDjUVCGk6jXOeOXm55wcT/maC2qd
         vZcRT/rMyYiv3xJM6LWSbyCCt853bQpi/bqa15qKcb4KCCha3tVFyEYiIEKjoCFJW6R9
         MWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Hai9aTv6kH+slevzrTwkB5WpAOfiscriXAwCQcaluGU=;
        b=JpZynyWI7h3M1qvNQx+bmNCWnMwDtTZ5ui4/C7GatKwf2okA5+GCTSz6BV+ABb/1Nz
         lZ/jqZj9ACJUghnf39VwYwqDYK0mEus5unAsWAJkxNrkOj7WrgZNOdM8AqFNDK0iDLPR
         qIuNgXNAGfr0fOpdc/JbP6y6kYsZlPrkPxgrSjc30y6BvW2HBDrfmqgcF1ZcSOfJzzav
         kBV1BPxI3a8zgDhZ1bsuLJ0wOWTmPzX9Pr0nH3I07pKB7jrvrMJ5bXL1XmK1c4D5Vcos
         xshq/2YgVHPeh2EYt6DF93S8Uo0pd5859/U1cnc8Ld1BxgmxuSIJ14ZUQOWTQgqVG9wI
         5qfw==
X-Gm-Message-State: AOAM5301droNVIV6lp1dXjpYjFFHQ5tTFFPu/TzkppVc8eL21/oiIOFe
        JkMBmrU4Dq9b614jVet2VdfeR+CnBLM=
X-Google-Smtp-Source: ABdhPJxLnmkce5li9u7Y9G/h5wZYFqyxWNKxaLGf9zjAO6ZIFSTcQlzr7Q5RWiNicVoErpO8ztMn5A==
X-Received: by 2002:a1c:7e85:: with SMTP id z127mr4939269wmc.131.1613181167922;
        Fri, 12 Feb 2021 17:52:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c22sm14839479wrb.91.2021.02.12.17.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 17:52:47 -0800 (PST)
Message-Id: <9ec98917699382c2a43b29e1c552d3685f63f29a.1613181163.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v4.git.1613181163.gitgitgadget@gmail.com>
References: <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
        <pull.726.v4.git.1613181163.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Feb 2021 01:52:43 +0000
Subject: [PATCH v4 4/4] ref-filter: use pretty.c logic for trailers
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
 Documentation/git-for-each-ref.txt |  8 +--
 ref-filter.c                       | 36 ++++++-----
 t/t6300-for-each-ref.sh            | 95 ++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+), 21 deletions(-)

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
index fd994e18744c..5224037d3da4 100644
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
index a8faddd18a9b..cac7f443d004 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -837,6 +837,24 @@ test_trailer_option '%(trailers:only) shows only "key: value" trailers' \
 
 	EOF
 
+test_trailer_option '%(trailers:only=no,only=true) shows only "key: value" trailers' \
+	'trailers:only=no,only=true' <<-EOF
+	$(grep -v patch.description <trailers)
+
+	EOF
+
+test_trailer_option '%(trailers:only=yes) shows only "key: value" trailers' \
+	'trailers:only=yes' <<-EOF
+	$(grep -v patch.description <trailers)
+
+	EOF
+
+test_trailer_option '%(trailers:only=no) shows all trailers' \
+	'trailers:only=no' <<-EOF
+	$(cat trailers)
+
+	EOF
+
 test_trailer_option '%(trailers:only) and %(trailers:unfold) work together' \
 	'trailers:only,unfold' <<-EOF
 	$(grep -v patch.description <trailers | unfold)
@@ -849,6 +867,78 @@ test_trailer_option '%(trailers:unfold) and %(trailers:only) work together' \
 
 	EOF
 
+test_trailer_option '%(trailers:key=foo) shows that trailer' \
+	'trailers:key=Signed-off-by' <<-EOF
+	Signed-off-by: A U Thor <author@example.com>
+
+	EOF
+
+test_trailer_option '%(trailers:key=foo) is case insensitive' \
+	'trailers:key=SiGned-oFf-bY' <<-EOF
+	Signed-off-by: A U Thor <author@example.com>
+
+	EOF
+
+test_trailer_option '%(trailers:key=foo:) trailing colon also works' \
+	'trailers:key=Signed-off-by:' <<-EOF
+	Signed-off-by: A U Thor <author@example.com>
+
+	EOF
+
+test_trailer_option '%(trailers:key=foo) multiple keys' \
+	'trailers:key=Reviewed-by:,key=Signed-off-by' <<-EOF
+	Reviewed-by: A U Thor <author@example.com>
+	Signed-off-by: A U Thor <author@example.com>
+
+	EOF
+
+test_trailer_option '%(trailers:key=nonexistent) becomes empty' \
+	'trailers:key=Shined-off-by:' <<-EOF
+
+	EOF
+
+test_trailer_option '%(trailers:key=foo) handles multiple lines even if folded' \
+	'trailers:key=Acked-by' <<-EOF
+	$(grep -v patch.description <trailers | grep -v Signed-off-by | grep -v Reviewed-by)
+
+	EOF
+
+test_trailer_option '%(trailers:key=foo,unfold) properly unfolds' \
+	'trailers:key=Signed-Off-by,unfold' <<-EOF
+	$(unfold <trailers | grep Signed-off-by)
+
+	EOF
+
+test_trailer_option '%(trailers:key=foo,only=no) also includes nontrailer lines' \
+	'trailers:key=Signed-off-by,only=no' <<-EOF
+	Signed-off-by: A U Thor <author@example.com>
+	$(grep patch.description <trailers)
+
+	EOF
+
+test_trailer_option '%(trailers:key=foo,valueonly) shows only value' \
+	'trailers:key=Signed-off-by,valueonly' <<-EOF
+	A U Thor <author@example.com>
+
+	EOF
+
+test_trailer_option '%(trailers:separator) changes separator' \
+	'trailers:separator=%x2C,key=Reviewed-by,key=Signed-off-by:' <<-EOF
+	Reviewed-by: A U Thor <author@example.com>,Signed-off-by: A U Thor <author@example.com>
+	EOF
+
+test_trailer_option '%(trailers:key_value_separator) changes key-value separator' \
+	'trailers:key_value_separator=%x2C,key=Reviewed-by,key=Signed-off-by:' <<-EOF
+	Reviewed-by,A U Thor <author@example.com>
+	Signed-off-by,A U Thor <author@example.com>
+
+	EOF
+
+test_trailer_option '%(trailers:separator,key_value_separator) changes both separators' \
+	'trailers:separator=%x2C,key_value_separator=%x2C,key=Reviewed-by,key=Signed-off-by:' <<-EOF
+	Reviewed-by,A U Thor <author@example.com>,Signed-off-by,A U Thor <author@example.com>
+	EOF
+
 test_failing_trailer_option () {
 	title=$1 option=$2
 	cat >expect
@@ -866,6 +956,11 @@ test_failing_trailer_option '%(trailers) rejects unknown trailers arguments' \
 	fatal: unknown %(trailers) argument: unsupported
 	EOF
 
+test_failing_trailer_option '%(trailers:key) without value is error' \
+	'trailers:key' <<-\EOF
+	fatal: expected %(trailers:key=<value>)
+	EOF
+
 test_expect_success 'if arguments, %(contents:trailers) shows error if colon is missing' '
 	cat >expect <<-EOF &&
 	fatal: unrecognized %(contents) argument: trailersonly
-- 
gitgitgadget
