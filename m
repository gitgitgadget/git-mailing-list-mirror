Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56819C432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 09:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 383A2610CD
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 09:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239574AbhHYJJq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 05:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbhHYJJm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 05:09:42 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11508C0613C1
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 02:08:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h4so5107221wro.7
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 02:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TxgZ6MG6jeycLd8+efH9Z8+HyeeiY47xyNkuHo2M6K8=;
        b=b2GykZJWgL2Y3O7GkPClNMpKM5xGq97GtG37+vdq+lE7a4FIbeXJjTPopRQ3L8Qt2z
         ercOqHUBbnjYp8VNUSJWHmsfZ7HBptZqxJ6Q/8wgYYR9TytzOoSLCD/nqm1WR+1zEkGn
         eQoTZfW13ddrLwHM60cY2dotNt9W6FmpmoIL6aA53ac0LrqMbfdXndr2f/Naf/t1K9vD
         OoJYiTktRxGuE70VLSBVx5GY2NJ5nDYJ90ke4uiNEt7I6ZUZbneCQLbTiLH1/cHKQZo/
         Nzlgj9tVFIHJcD9EqSMa9ob1jq9bk2gRChGd+JaqYsElvKBkyv/Rwe7X1F+9IZOr39MR
         9qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TxgZ6MG6jeycLd8+efH9Z8+HyeeiY47xyNkuHo2M6K8=;
        b=bvT5aN1N8bYUR+Bc7exPnc3fTxYE2RYXoK6WeRY5sNNvgSlUB0/osiXIuGGZz5nNwm
         dBjM48vyAmhbBykyrvMoOUkk9/cMlR3l2eYD9c8Q0/jvKU1dQvKgxQmy2s9ovNJkaeWR
         pgkBqPbhZgLj6M/YKYKxXuDgz9+FLRrv1EXntjTleGpkA3GFTKUJezY7Ki5ZOcAEOIT3
         ubhxap7mRvLxOKXq56jHUwwm5vIH+2aNJNmFQKjQY07dzRffzbypw0smTG14LskETCQA
         Q0u1WCUwVkDDwM5uWltpbi7Dc0PrdsA3pfiJoxWJopLKP/qkblylitvD/PrD4r90Wzw4
         QcJw==
X-Gm-Message-State: AOAM533Pnmd88mZ/0plulFVgNj8Fcx5F5SLE9SbeKHvmCIha0x0yfFCm
        VMYbrJDcT1Mfy110tklOkvjQeo1QsqQ=
X-Google-Smtp-Source: ABdhPJyM+3rb/J1+IxH4lH5wyMNGQmVo5VkwQAWPkYbA/wNcMZ6RTRwGy5UXMFpZ7ns0GmsMwQnBCQ==
X-Received: by 2002:a5d:55cd:: with SMTP id i13mr7221520wrw.366.1629882535742;
        Wed, 25 Aug 2021 02:08:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v13sm13957231wrf.55.2021.08.25.02.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 02:08:55 -0700 (PDT)
Message-Id: <54c95b0386ea7238b09931cecabc71dc1b9c0d21.1629882532.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1025.git.1629882532.gitgitgadget@gmail.com>
References: <pull.1025.git.1629882532.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Aug 2021 09:08:48 +0000
Subject: [PATCH 4/8] [GSOC] ref-filter: clean up verify_ref_format()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Because we may not use the real ref_format when using
parse_ref_filter_atom() before, we have to perform some
atom checks in verify_ref_format() (instead of the parsing
function of each atom), which is very inelegant.

Since we have eliminated dummy ref_format, we can freely put
some of the check logic from verify_ref_format() to their
corresponding atom parsing functions.

Introduce raw_atom_reject_quote_style() to check if there is
any incompatibility quote style with the %(raw) atom.

This can make the logic of the program more concise.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 ref-filter.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index f4fa3102da6..e42cd738c32 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -242,6 +242,7 @@ static int color_atom_parser(struct ref_format *format, struct used_atom *atom,
 	 */
 	if (!want_color(format->use_color))
 		color_parse("", atom->u.color);
+	format->need_color_reset_at_eol = !!strcmp(color_value, "reset");
 	return 0;
 }
 
@@ -432,12 +433,29 @@ static int contents_atom_parser(struct ref_format *format, struct used_atom *ato
 	return 0;
 }
 
+static int raw_atom_reject_quote_style(int quote_style) {
+	switch (quote_style) {
+	case QUOTE_PYTHON:
+	case QUOTE_SHELL:
+	case QUOTE_TCL:
+		return 1;
+	case QUOTE_PERL:
+	case 0:
+		return 0;
+	default:
+		BUG("unknown quote style %d", quote_style);
+	}
+}
+
 static int raw_atom_parser(struct ref_format *format, struct used_atom *atom,
 				const char *arg, struct strbuf *err)
 {
-	if (!arg)
+	if (!arg) {
 		atom->u.raw_data.option = RAW_BARE;
-	else if (!strcmp(arg, "size"))
+		if (raw_atom_reject_quote_style(format->quote_style))
+			return strbuf_addf_ret(err, -1, _("--format=%%(raw) cannot be used with"
+						   "--python, --shell, --tcl"));
+	} else if (!strcmp(arg, "size"))
 		atom->u.raw_data.option = RAW_LENGTH;
 	else
 		return strbuf_addf_ret(err, -1, _("unrecognized %%(raw) argument: %s"), arg);
@@ -567,7 +585,7 @@ static int rest_atom_parser(struct ref_format *format, struct used_atom *atom,
 	if (arg)
 		return strbuf_addf_ret(err, -1, _("%%(rest) does not take arguments"));
 	format->use_rest = 1;
-	return 0;
+	return strbuf_addf_ret(err, -1, _("this command reject atom %%(rest)"));
 }
 
 static int head_atom_parser(struct ref_format *format, struct used_atom *atom,
@@ -1004,11 +1022,6 @@ static const char *find_next(const char *cp)
 	return NULL;
 }
 
-static int reject_atom(enum atom_type atom_type)
-{
-	return atom_type == ATOM_REST;
-}
-
 /*
  * Make sure the format string is well formed, and parse out
  * the used atoms.
@@ -1020,7 +1033,7 @@ int verify_ref_format(struct ref_format *format)
 	format->need_color_reset_at_eol = 0;
 	for (cp = format->format; *cp && (sp = find_next(cp)); ) {
 		struct strbuf err = STRBUF_INIT;
-		const char *color, *ep = strchr(sp, ')');
+		const char *ep = strchr(sp, ')');
 		int at;
 
 		if (!ep)
@@ -1029,20 +1042,8 @@ int verify_ref_format(struct ref_format *format)
 		at = parse_ref_filter_atom(format, sp + 2, ep, &err);
 		if (at < 0)
 			die("%s", err.buf);
-		if (reject_atom(used_atom[at].atom_type))
-			die(_("this command reject atom %%(%.*s)"), (int)(ep - sp - 2), sp + 2);
-
-		if ((format->quote_style == QUOTE_PYTHON ||
-		     format->quote_style == QUOTE_SHELL ||
-		     format->quote_style == QUOTE_TCL) &&
-		     used_atom[at].atom_type == ATOM_RAW &&
-		     used_atom[at].u.raw_data.option == RAW_BARE)
-			die(_("--format=%.*s cannot be used with"
-			      "--python, --shell, --tcl"), (int)(ep - sp - 2), sp + 2);
 		cp = ep + 1;
 
-		if (skip_prefix(used_atom[at].name, "color:", &color))
-			format->need_color_reset_at_eol = !!strcmp(color, "reset");
 		strbuf_release(&err);
 	}
 	if (format->need_color_reset_at_eol && !want_color(format->use_color))
-- 
gitgitgadget

