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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FAFC433E0
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 09:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3771C64E24
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 09:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhBFJQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Feb 2021 04:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhBFJQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Feb 2021 04:16:29 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFFDC061756
        for <git@vger.kernel.org>; Sat,  6 Feb 2021 01:15:49 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m13so10431378wro.12
        for <git@vger.kernel.org>; Sat, 06 Feb 2021 01:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LwrB6uZOwo1xu8HwwI+9mKXDoOZa/32TzwWJ0WpgVuo=;
        b=r3rM264OF/XBwX591v62DHWkRYrH7BjIGo1P5zNmaaXXnSpGgGEH0I1TqpQ8NULORI
         H0SLMlqWi8PNUFIb7vAVoKzQo0z9DUjh92gIIayqvqJVI8LTnQd+el1QLSMel9zOZM0P
         Sp4YGVWTXe4F+esTcVQURAICezwFIRegZ7E+kQGVE614kNhYKeXvmPtIXXpQJhDzA2nv
         NuhYfsyHDxEP1xRCVsY4Ug2nHbA88HHeTjqsCHebIeI2twtVcr1ck10Zys+BHF1rE5n0
         BxL2VtntrivOmU/nxkl5AwlGo7YZJYfKOZk6pImmNEebdtMTMFBU5uGQOWb3/xhWgzz2
         Tbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LwrB6uZOwo1xu8HwwI+9mKXDoOZa/32TzwWJ0WpgVuo=;
        b=lxMBA77/5kjlOIw6ZWQoVeirK0pDeRQKt1rp+Q0lBsEWPBGE1xGf2CLoSYwvq5gToR
         iF8Ivx15RpIi9Cn51MlXGE/IS0s9Ye8Z6C0dWyrl5iTk/SlP2YUrQ/kGmnnaZDyu0SgJ
         68XNO3UBa/DSHrgmuC8QHnW1MOTYLIfSBzdsqH7iWHE8Zlm1iuhV/OAVQP/aPKoukw5q
         857Fj1kLOt2R5FoKujEzbg0QmXVWsauWBhOrcrgM0phHjdl/C0nJ2uDW4FdFJ7HlFWzZ
         GhnBvg4Jp7Rvnjhx+WEONxJhk0CR0q3Vwe8M8HT3ywMaoEkraY0iXue1jyuSyItwW3wn
         G+0Q==
X-Gm-Message-State: AOAM53343cCfmS/0Wh2O8efaanesE+oCAAjLr5JK/MIR7metNqcJjMau
        d4nhAVdk7e+L/oSUstAKQMHbSTlIwLA=
X-Google-Smtp-Source: ABdhPJzR9+TisRPAxVNGSeuIwqpX0bIWa0p1aLkS5+6gq2OBbYLqC0pJla/M1516HQE+3nHGPxbaFg==
X-Received: by 2002:a5d:4bc2:: with SMTP id l2mr9528958wrt.204.1612602947960;
        Sat, 06 Feb 2021 01:15:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e10sm14824001wro.65.2021.02.06.01.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 01:15:47 -0800 (PST)
Message-Id: <81030f00b11b39d7fa665c71d3bbe61203e84b54.1612602945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
References: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
        <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 06 Feb 2021 09:15:42 +0000
Subject: [PATCH v3 1/3] pretty.c: refactor trailer logic to
 `format_set_trailers_options()`
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

Refactored trailers formatting logic inside pretty.c to a new function
`format_set_trailers_options()`. This new function returns the non-zero
in case of unusual. The caller handles the non-zero by "goto trailers_out".

This change will allow us to reuse the same logic in other places.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 pretty.c | 89 +++++++++++++++++++++++++++++++-------------------------
 pretty.h | 11 +++++++
 2 files changed, 61 insertions(+), 39 deletions(-)

diff --git a/pretty.c b/pretty.c
index 3922f6f9f249..59cefdddf674 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1148,6 +1148,54 @@ static int format_trailer_match_cb(const struct strbuf *key, void *ud)
 	return 0;
 }
 
+int format_set_trailers_options(struct process_trailer_options *opts,
+				struct string_list *filter_list,
+				struct strbuf *sepbuf,
+				struct strbuf *kvsepbuf,
+				const char **arg)
+{
+	for (;;) {
+		const char *argval;
+		size_t arglen;
+
+		if (match_placeholder_arg_value(*arg, "key", arg, &argval, &arglen)) {
+			uintptr_t len = arglen;
+
+			if (!argval)
+				return -1;
+
+			if (len && argval[len - 1] == ':')
+				len--;
+			string_list_append(filter_list, argval)->util = (char *)len;
+
+			opts->filter = format_trailer_match_cb;
+			opts->filter_data = filter_list;
+			opts->only_trailers = 1;
+		} else if (match_placeholder_arg_value(*arg, "separator", arg, &argval, &arglen)) {
+			char *fmt;
+
+			strbuf_reset(sepbuf);
+			fmt = xstrndup(argval, arglen);
+			strbuf_expand(sepbuf, fmt, strbuf_expand_literal_cb, NULL);
+			free(fmt);
+			opts->separator = sepbuf;
+		} else if (match_placeholder_arg_value(*arg, "key_value_separator", arg, &argval, &arglen)) {
+			char *fmt;
+
+			strbuf_reset(kvsepbuf);
+			fmt = xstrndup(argval, arglen);
+			strbuf_expand(kvsepbuf, fmt, strbuf_expand_literal_cb, NULL);
+			free(fmt);
+			opts->key_value_separator = kvsepbuf;
+		} else if (!match_placeholder_bool_arg(*arg, "only", arg, &opts->only_trailers) &&
+			   !match_placeholder_bool_arg(*arg, "unfold", arg, &opts->unfold) &&
+			   !match_placeholder_bool_arg(*arg, "keyonly", arg, &opts->key_only) &&
+			   !match_placeholder_bool_arg(*arg, "valueonly", arg, &opts->value_only))
+			break;
+	}
+	return 0;
+}
+
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
 				void *context)
@@ -1425,45 +1473,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 		if (*arg == ':') {
 			arg++;
-			for (;;) {
-				const char *argval;
-				size_t arglen;
-
-				if (match_placeholder_arg_value(arg, "key", &arg, &argval, &arglen)) {
-					uintptr_t len = arglen;
-
-					if (!argval)
-						goto trailer_out;
-
-					if (len && argval[len - 1] == ':')
-						len--;
-					string_list_append(&filter_list, argval)->util = (char *)len;
-
-					opts.filter = format_trailer_match_cb;
-					opts.filter_data = &filter_list;
-					opts.only_trailers = 1;
-				} else if (match_placeholder_arg_value(arg, "separator", &arg, &argval, &arglen)) {
-					char *fmt;
-
-					strbuf_reset(&sepbuf);
-					fmt = xstrndup(argval, arglen);
-					strbuf_expand(&sepbuf, fmt, strbuf_expand_literal_cb, NULL);
-					free(fmt);
-					opts.separator = &sepbuf;
-				} else if (match_placeholder_arg_value(arg, "key_value_separator", &arg, &argval, &arglen)) {
-					char *fmt;
-
-					strbuf_reset(&kvsepbuf);
-					fmt = xstrndup(argval, arglen);
-					strbuf_expand(&kvsepbuf, fmt, strbuf_expand_literal_cb, NULL);
-					free(fmt);
-					opts.key_value_separator = &kvsepbuf;
-				} else if (!match_placeholder_bool_arg(arg, "only", &arg, &opts.only_trailers) &&
-					   !match_placeholder_bool_arg(arg, "unfold", &arg, &opts.unfold) &&
-					   !match_placeholder_bool_arg(arg, "keyonly", &arg, &opts.key_only) &&
-					   !match_placeholder_bool_arg(arg, "valueonly", &arg, &opts.value_only))
-					break;
-			}
+			if (format_set_trailers_options(&opts, &filter_list, &sepbuf, &kvsepbuf, &arg))
+				goto trailer_out;
 		}
 		if (*arg == ')') {
 			format_trailers_from_commit(sb, msg + c->subject_off, &opts);
diff --git a/pretty.h b/pretty.h
index 7ce6c0b437b4..7369cf7e1484 100644
--- a/pretty.h
+++ b/pretty.h
@@ -6,6 +6,7 @@
 
 struct commit;
 struct strbuf;
+struct process_trailer_options;
 
 /* Commit formats */
 enum cmit_fmt {
@@ -142,4 +143,14 @@ int commit_format_is_empty(enum cmit_fmt);
 /* Make subject of commit message suitable for filename */
 void format_sanitized_subject(struct strbuf *sb, const char *msg, size_t len);
 
+/*
+ * Set values of fields in "struct process_trailer_options"
+ * according to trailers arguments.
+ */
+int format_set_trailers_options(struct process_trailer_options *opts,
+			struct string_list *filter_list,
+			struct strbuf *sepbuf,
+			struct strbuf *kvsepbuf,
+			const char **arg);
+
 #endif /* PRETTY_H */
-- 
gitgitgadget

