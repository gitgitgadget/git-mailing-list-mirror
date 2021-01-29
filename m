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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E43C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 21:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9677264E04
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 21:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbhA2VKF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 16:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbhA2VJt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 16:09:49 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A99C0613D6
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 13:09:08 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id g10so10187023wrx.1
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 13:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J6nWjVN5iKrMOdK8lXNN4DOueqgALdm0kjEvmZ4i4OA=;
        b=T567sSXoqpaXOBVfWIEsCpK1GODFylFYfAv5mx73eJnUzYFtPTNHo/fTGj5eMR8NSr
         nsUl/IKlYPk0WmKKpW356O3wlM7un3MmEL8a15AyRSZFr3AYzCyvfQzpciSXCA1o0mpD
         9vMnmOGpiFFEJYJOzGqxkrnZAMMrv7GVKtDzonKIw7FWumyVw0hW1ABBnhNcePWhF1LU
         GkjGCw4GQZYDc8nzZTU4LFgVaUkU60oF33rXSbyUVlxetFTcf/pQjfwilpZuPWnCH4t6
         dQ3Ewx3y5DRal0jn0Bxc2GJWsQ5VakC+Fy0q30bjpeoaakzYayGbs0uRyugOE+U86mlM
         46nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J6nWjVN5iKrMOdK8lXNN4DOueqgALdm0kjEvmZ4i4OA=;
        b=XGepYZwK86ZKov63pR4LnAVR/jhRcc1ncoFNUv8kqKXoOdDdtU2u02UnC2jMB0A/Ia
         mP4n7SH5li6SDul+k8rWdpYwQvB7cM34TkPtZFAlmSsIVG2HZXhd4meNe9WogcMx/ZHx
         WsrhJpBAidJ/cq6q7NwJvMwluVJx0+Vig79PpOnzfRVROdIGanHSN8Xhia9l/8gIVSsq
         lOjuDaoEh9LqidqOg3fihoVCLdPoxlGupl4wbVN16ShpVZpSlqr7HjBZV+UupOMPp0lm
         fq53XAQx5sfJQD+xAEjDEfg2Zt7VjrDdQGMwcNWvpstip8Mv4wYWyq7kle0yOfk9Q7fa
         kf3g==
X-Gm-Message-State: AOAM531gpUo1qhiJy3r1HISxFTiqFDa8alOMswtqCqG9X4+Q4sOP4791
        ZbMAA8BQormHEXzVEgsdinualQWk0ME=
X-Google-Smtp-Source: ABdhPJx0RJnArf0rBrOj7mxtFEnLBwJaziWpkklsxZStD2hajlLnjfV2KEbEbFvpRLkv02ZNw7lR5A==
X-Received: by 2002:a5d:6986:: with SMTP id g6mr6487180wru.263.1611954547491;
        Fri, 29 Jan 2021 13:09:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m12sm11794091wmc.10.2021.01.29.13.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 13:09:06 -0800 (PST)
Message-Id: <245e48eb6835cae4e61f65af780b766d990d4b5f.1611954543.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
        <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jan 2021 21:09:02 +0000
Subject: [PATCH v2 2/3] pretty.c: capture invalid trailer argument
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

As we would like to use this same logic in ref-filter, it's nice to
get invalid trailer argument. This will allow us to print precise
error message, while using `format_set_trailers_options()` in
ref-filter.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 pretty.c | 18 ++++++++++++++----
 pretty.h |  3 ++-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/pretty.c b/pretty.c
index bb6a3c634ac..b5fa7944389 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1152,12 +1152,17 @@ int format_set_trailers_options(struct process_trailer_options *opts,
 				struct string_list *filter_list,
 				struct strbuf *sepbuf,
 				struct strbuf *kvsepbuf,
-				const char **arg)
+				const char **arg,
+				char **invalid_arg)
 {
 	for (;;) {
 		const char *argval;
 		size_t arglen;
 
+		if(**arg == ')') {
+			break;
+		}
+
 		if (match_placeholder_arg_value(*arg, "key", arg, &argval, &arglen)) {
 			uintptr_t len = arglen;
 
@@ -1186,8 +1191,11 @@ int format_set_trailers_options(struct process_trailer_options *opts,
 		} else if (!match_placeholder_bool_arg(*arg, "only", arg, &opts->only_trailers) &&
 			   !match_placeholder_bool_arg(*arg, "unfold", arg, &opts->unfold) &&
 			   !match_placeholder_bool_arg(*arg, "keyonly", arg, &opts->key_only) &&
-			   !match_placeholder_bool_arg(*arg, "valueonly", arg, &opts->value_only))
-			break;
+			   !match_placeholder_bool_arg(*arg, "valueonly", arg, &opts->value_only)) {
+			size_t invalid_arg_len = strcspn(*arg, ",)");
+			*invalid_arg = xstrndup(*arg, invalid_arg_len);
+			return 1;
+		}
 	}
 	return 0;
 }
@@ -1464,12 +1472,13 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		struct strbuf sepbuf = STRBUF_INIT;
 		struct strbuf kvsepbuf = STRBUF_INIT;
 		size_t ret = 0;
+		char *unused = NULL;
 
 		opts.no_divider = 1;
 
 		if (*arg == ':') {
 			arg++;
-			if (format_set_trailers_options(&opts, &filter_list, &sepbuf, &kvsepbuf, &arg))
+			if (format_set_trailers_options(&opts, &filter_list, &sepbuf, &kvsepbuf, &arg, &unused))
 				goto trailer_out;
 		}
 		if (*arg == ')') {
@@ -1479,6 +1488,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	trailer_out:
 		string_list_clear(&filter_list, 0);
 		strbuf_release(&sepbuf);
+		free((char *)unused);
 		return ret;
 	}
 
diff --git a/pretty.h b/pretty.h
index 7369cf7e148..d902cdd70a9 100644
--- a/pretty.h
+++ b/pretty.h
@@ -151,6 +151,7 @@ int format_set_trailers_options(struct process_trailer_options *opts,
 			struct string_list *filter_list,
 			struct strbuf *sepbuf,
 			struct strbuf *kvsepbuf,
-			const char **arg);
+			const char **arg,
+			char **invalid_arg);
 
 #endif /* PRETTY_H */
-- 
gitgitgadget

