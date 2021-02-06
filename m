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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A209FC433E6
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 09:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB2A64FAE
	for <git@archiver.kernel.org>; Sat,  6 Feb 2021 09:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhBFJQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Feb 2021 04:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhBFJQa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Feb 2021 04:16:30 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEE6C061786
        for <git@vger.kernel.org>; Sat,  6 Feb 2021 01:15:50 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id c12so10461244wrc.7
        for <git@vger.kernel.org>; Sat, 06 Feb 2021 01:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IlKi+lddo3zJGdm0gOZSgHyoO2vFDvbFhYZtEC/xwQs=;
        b=VHU6XlGNLK8LLszAXMlClCqEmUTbyLKA6BhHEpACwppP6pbPj6SVwlI9AYBeV/Auj8
         zg0OrHuCBKDgbEjYQUdLOQ/fSTBYiJXaDZc2+NzQ2l9LDECppELfxTfSFiFUxTvzhnR5
         V3EVmCjBky6S2vwwy61DQ/ej93Wwh0m+fPhinzSJgJ0SgsMLUmg4IAKb7CDVAiRN5DTK
         aVcqDWStiNaKJYz6TmjZL20SYnyNM+dn5aVfzVNzE9Bdo2NGGR+eplPRYZJBwoQEn3HU
         Qm+qB+pt4hc2ENNxg6u7T7QKhfgtvF71nwzc5rZIAxBSb2yNexdBKGkzZi+giVUUkLZX
         dA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IlKi+lddo3zJGdm0gOZSgHyoO2vFDvbFhYZtEC/xwQs=;
        b=nBrJYWoL3rWJJnxVQshUMaSbyGZiH0XjlC2lh/nObev/fJo7Og+9z6FiaCP+Hgskoz
         QYHaCcw4aNSlcF/micF4VhfkqTUzOzWQmPSesUZv7xAH8C+ppKM9JlMIkRdk7cvAImsZ
         ZKJCIrKED2HDUZkKsQvvFfbhNx5MBBHHt70S9U7QofGlJBvDDO6x1vPxi5dt2TWxFTpu
         C9jm7EwDbpEFHHTpN+LCfU95DCupH56WebfTdvrmj91dKIiS8enO8n9fQxwEjYWv1noC
         IoApguhdunzwez+o0RS6lwJeyjN5UsXNgJssw5LNms5evKkaZVEDk5xofQYf8B3iD7rZ
         MsIw==
X-Gm-Message-State: AOAM532y97JVu59eI5Dd6LImL0WbdoF69ZyCv57TkGmfb/Tde/UblhsC
        Iik7c6GzCbLqpww3pkhE/oWmkyi5lWI=
X-Google-Smtp-Source: ABdhPJw2jzfOUiYr8fAESLgQSYf79xQBehNPiNtCj/pTZtE6TYebGaCpBCTetsYsufFHelNRK8yE1Q==
X-Received: by 2002:adf:ce10:: with SMTP id p16mr9569297wrn.97.1612602948988;
        Sat, 06 Feb 2021 01:15:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12sm9640018wmg.44.2021.02.06.01.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 01:15:48 -0800 (PST)
Message-Id: <f4a6b2df14443e9a010b86066c6dad043966ab44.1612602945.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
References: <pull.726.v2.git.1611954543.gitgitgadget@gmail.com>
        <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 06 Feb 2021 09:15:43 +0000
Subject: [PATCH v3 2/3] pretty.c: capture invalid trailer argument
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

As we would like to use this trailers logic in the ref-filter, it's
nice to get an invalid trailer argument. This will allow us to print
precise error message while using `format_set_trailers_options()` in
ref-filter.

For capturing the invalid argument, we changed the working of
`format_set_trailers_options()` a little bit.
Original logic does "break" and fell through in mainly 2 cases -
    1. unknown/invalid argument
    2. end of the arg string

But now instead of "break", we capture invalid argument and return
non-zero. And non-zero is handled by the caller.
(We prepared the caller to handle non-zero in the previous commit).

Capturing invalid arguments this way will also affects the working
of current logic. As at the end of the arg string it will return non-zero.
So in order to make things correct, introduced an additional conditional
statement i.e if encounter ")", do 'break'.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 pretty.c | 17 +++++++++++++----
 pretty.h |  3 ++-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/pretty.c b/pretty.c
index 59cefdddf674..ed16b32df922 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1152,12 +1152,16 @@ int format_set_trailers_options(struct process_trailer_options *opts,
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
 
+		if (**arg == ')')
+			break;
+
 		if (match_placeholder_arg_value(*arg, "key", arg, &argval, &arglen)) {
 			uintptr_t len = arglen;
 
@@ -1190,8 +1194,13 @@ int format_set_trailers_options(struct process_trailer_options *opts,
 		} else if (!match_placeholder_bool_arg(*arg, "only", arg, &opts->only_trailers) &&
 			   !match_placeholder_bool_arg(*arg, "unfold", arg, &opts->unfold) &&
 			   !match_placeholder_bool_arg(*arg, "keyonly", arg, &opts->key_only) &&
-			   !match_placeholder_bool_arg(*arg, "valueonly", arg, &opts->value_only))
-			break;
+			   !match_placeholder_bool_arg(*arg, "valueonly", arg, &opts->value_only)) {
+			if (invalid_arg) {
+				size_t len = strcspn(*arg, ",)");
+				*invalid_arg = xstrndup(*arg, len);
+			}
+			return -1;
+		}
 	}
 	return 0;
 }
@@ -1473,7 +1482,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 		if (*arg == ':') {
 			arg++;
-			if (format_set_trailers_options(&opts, &filter_list, &sepbuf, &kvsepbuf, &arg))
+			if (format_set_trailers_options(&opts, &filter_list, &sepbuf, &kvsepbuf, &arg, NULL))
 				goto trailer_out;
 		}
 		if (*arg == ')') {
diff --git a/pretty.h b/pretty.h
index 7369cf7e1484..d902cdd70a95 100644
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

