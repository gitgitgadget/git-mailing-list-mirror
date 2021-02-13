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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F05DC433E9
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CA064EAC
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhBMBxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 20:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhBMBx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 20:53:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833AAC0613D6
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 17:52:47 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 7so1615873wrz.0
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 17:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fsQBiIZcQH8JGGQguYV0c/NEq5ZAJTXvRc+DDzxgLh8=;
        b=KhPFCtjXWqhakLGOVObGzKPUaPIngLzhMjMma6+RhgjqBu65mNAp+cjRxBdgVYkzX+
         1SHChaNBCLmABnlfpFSNRqKt+cdLD0wNgtDOmCB2kYYeXLVGYezOmLqZ/4RkZxKEgDAQ
         D8Lwc0Bo0yS8fsy/qGV2NiZT69Bol1taysGraXvtWeJr1/BP4Gqxp91C4TycN6inr5mT
         R/EOxIRYxBh6PZqXqwSeJgbeTpxVK3KIloX6Ibeyo9vF2awTV19VwarKZh55IdZYkg3c
         xXbW8Veqskuf2qxMRtlKYAfzTvBc3E5sjziP4Qmga7jBecYri0XW1HSafxPYvEn8QUWt
         C3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fsQBiIZcQH8JGGQguYV0c/NEq5ZAJTXvRc+DDzxgLh8=;
        b=JLa/7KUSR4eV/CTEOE5+E+7t8+5GFsAmszuurV3bJlqsFxs1KAGQcH5c2RJdcgXSlI
         8Yb0CpyZVYXf6J54kAUp0Swlzgt9KYBXSzGwO7QAZvgT/5bhOnsIHt6cJ+nS1VJ+oSY5
         E7XGBu7nscyMlWJQ2DaSZD+oEpfURkFgjw9OvetomflKouh5/cLtKwE3GXvj0V0+oGE2
         arfm2NCCZFi0FMXZH0SPu9zzS/3/3TpgJjSJtBml18jzJWs4fxmIqFFPSORmn/1dZry7
         sgyhvpmsLhl2oD24y6wdQK0v9KIUNxxMii+L47edwhlqhc2uc0GjDhPQIgCm6rRo4tF7
         3Q/w==
X-Gm-Message-State: AOAM531bXc1AeZGl1OEtUEoxNDT/TTc52yvTPHq0D4QSHcnEP4Q/TCGz
        jUC/yM51tpGDLYbecRKMwJWOYZhNLgo=
X-Google-Smtp-Source: ABdhPJz4+X5o40WhKXqwJALG9c3vGWce86jScZjDeD7r03vZAGAtwgKI56XfuRMdFfuanbF0vCzjmQ==
X-Received: by 2002:adf:cd0b:: with SMTP id w11mr6217438wrm.327.1613181166356;
        Fri, 12 Feb 2021 17:52:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k1sm6891460wrx.77.2021.02.12.17.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 17:52:46 -0800 (PST)
Message-Id: <fd275fed834780514a7026ee64468b31496d72cc.1613181163.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v4.git.1613181163.gitgitgadget@gmail.com>
References: <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
        <pull.726.v4.git.1613181163.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Feb 2021 01:52:41 +0000
Subject: [PATCH v4 2/4] pretty.c: refactor trailer logic to
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
index b4ff3f602f9b..304b73068bc4 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1149,6 +1149,54 @@ static int format_trailer_match_cb(const struct strbuf *key, void *ud)
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
@@ -1429,45 +1477,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
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

