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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC07C433E6
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 21:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CEF764E04
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 21:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhA2VJy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 16:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbhA2VJs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 16:09:48 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8783AC061756
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 13:09:08 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id i9so8222072wmq.1
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 13:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9Ss/PDy0tKp4OviPmOB4XTZJuQJi7ftN+z5e1y21gQE=;
        b=dsAQl4Og0o0gA6+T2WhoQ/HqnC2w/tXa117RlTdnsdSB+9s6UlPYdQ8WIHS3MlyAGr
         L/qr0ZDPibM5PFRoPVXPFRJKb28moKQ5KVlOQTAz02DRaEw3P9LYNBY3Q931O8EPnN6A
         U9hZ0k1N1ekb3h7jcZfJEltdAjGIyb5UQJyjdfaOBAMGnN6kqw1afcLtvaeHX0vXWJtf
         ojqZcRTm1Dz2cfZDXUqAxo9KIgool2QKq1E8oOZNd2eMJlRsriFHkT7oWB88rImBxn+z
         CkCOoddJs2+e9VUP1nqa328yaweGRGrB+H93xLha1NgZdtn0vqmnZu9lmZuRIFCZi/M9
         jLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9Ss/PDy0tKp4OviPmOB4XTZJuQJi7ftN+z5e1y21gQE=;
        b=XIYjAEbzwUqjfjMftKWPs7GRdfSOqthtrapL7B0SDialjyyBJZiKvQLhT14fujnfx9
         rsMR/wUKEXsLknk5dFcLSL69o3YpqMHwOUz9qsIrISR246io70hB+LdA4YDDw1QmR9j7
         LgPFjzBzFDTAP3J2DUqWU/6sVAVG2qQQMmgNdfgUEAzrY1bJlNSEF4S3baYcpKIlJ+cD
         WwJTpl6yyMwhlKArsEft960SYEc2p6ipZmkYcKVHUuYCwJ/uvahnE9xNVSZZzUCGKywQ
         3y+JyQCMlJC5eyaTDCu3q2yxN0t+AmPHL+0wNTpGUb0bfLaB4Otch/QIcAFMuot3icJC
         rZKg==
X-Gm-Message-State: AOAM530whe1wiKnWlNlAcbPHIauMpUlbHtKm8642bIxV1MRrAoAUqbik
        CXHKXlYnlFmSyHx8/cP+5OUakEeuUzo=
X-Google-Smtp-Source: ABdhPJw0XUnYOavsUp6vLfzfmQiUdZk1TFnz0mYe+VsZreXvpDtMXpvuouIXJhFYmVKa9I9gongQFw==
X-Received: by 2002:a05:600c:2905:: with SMTP id i5mr5397851wmd.28.1611954546527;
        Fri, 29 Jan 2021 13:09:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm11150429wmc.31.2021.01.29.13.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 13:09:05 -0800 (PST)
Message-Id: <fc5fd5217dfc105f3e03a9800a35209a985775a4.1611954543.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
        <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jan 2021 21:09:01 +0000
Subject: [PATCH v2 1/3] pretty.c: refactor trailer logic to
 `format_set_trailers_options()`
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

Refactored trailers formatting logic inside pretty.c to a new function
`format_set_trailers_options()`. This change will allow us to reuse
the same logic in other places.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 pretty.c | 85 ++++++++++++++++++++++++++++++--------------------------
 pretty.h | 11 ++++++++
 2 files changed, 57 insertions(+), 39 deletions(-)

diff --git a/pretty.c b/pretty.c
index 3922f6f9f24..bb6a3c634ac 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1148,6 +1148,50 @@ static int format_trailer_match_cb(const struct strbuf *key, void *ud)
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
+				return 1;
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
+			fmt = xstrndup(argval, arglen);
+			strbuf_expand(sepbuf, fmt, strbuf_expand_literal_cb, NULL);
+			free(fmt);
+			opts->separator = sepbuf;
+		} else if (match_placeholder_arg_value(*arg, "key_value_separator", arg, &argval, &arglen)) {
+			char *fmt;
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
@@ -1425,45 +1469,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
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
index 7ce6c0b437b..7369cf7e148 100644
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

