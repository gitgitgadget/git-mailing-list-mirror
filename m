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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8CDC433DB
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E28FD64DE9
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhBMBxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 20:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbhBMBx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 20:53:28 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FD0C061786
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 17:52:48 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m1so1528385wml.2
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 17:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ff2AqqL3y6GxGc/eNdx+JLDjZ8NyNQopnEjHfkTd+7w=;
        b=Q9CJS32KO/wgiZ7MhNXrr3nX/DFQFz42XcI1sp0Q8tzH1nbKcocDebzLI11OgECSxn
         A12UCnrcLXzXQZcQs3BCd/cHrT7WoeEa/j4jIX7ruujpurTwdP7mj6YbLu/8tXuvrZjq
         sfw/Giz42bh0qKYWU9Tby/EI/OWfp45K3hgFK7E067Df8xuSFbcqnZ8BbguBjIjeD+n6
         6c9D8THa7ahbN7l85D/DFHg2uhFZV42gUcaTXXwG8NijJZVhAELfBh3TzpoW7Sqvo/JE
         F1HVzH7QmYRxLrDc8OE+ES/iRH74Qv+oyK8X5yejmw/Wrv6Sl2JBHstXU+4AsiRH7ovU
         Jguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ff2AqqL3y6GxGc/eNdx+JLDjZ8NyNQopnEjHfkTd+7w=;
        b=kCtq/WNy/gm967OPoi9PWu+IbY11zSK4p9SBeeutallrt1OviCQnCpq3hXqN+BHQkF
         +ztS/gKeBQPuObaMSdHvDKMjAmwYbsJUzn4KulO1c0awD3QiRKKe6pwl3TRZKS+D2LKi
         OZa8MPbEkUvwt7dzq5uqDULfqshG8Xvxf6vc1eOjqkNDvhlvXz1YGVfQLV3857HhX3IK
         tY+S7ZYCbW669ugBkm/rM0QVBjLLn8lF4+WBl/8mD/Al7LakKTozZ6QgHtk707p5k+jY
         b3GDF7seGxAISinxupBySufbf+/2CVjmGsgm4spHXBz2unIgTXSAnB8eNqecWjbB00Cm
         oKWw==
X-Gm-Message-State: AOAM5334w9A9J05flLEilaJOMoNgUrpb1ntsV4LiVRrQSX1kMk6PLGGb
        Bna8Cfc3djqslsjIPZFSfX5VOZ1SzCg=
X-Google-Smtp-Source: ABdhPJwEadeKcV8ounGMcUUqJGHo+sAPGFEj+6Q7eArb2NxN6rN3b0g4MbdejWA/3kjbeAeffZ3GCw==
X-Received: by 2002:a1c:b7d7:: with SMTP id h206mr4991526wmf.64.1613181167195;
        Fri, 12 Feb 2021 17:52:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5sm13604092wmc.25.2021.02.12.17.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 17:52:46 -0800 (PST)
Message-Id: <073c75dc4494db3074e426a751595ea83467fece.1613181163.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v4.git.1613181163.gitgitgadget@gmail.com>
References: <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
        <pull.726.v4.git.1613181163.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Feb 2021 01:52:42 +0000
Subject: [PATCH v4 3/4] pretty.c: capture invalid trailer argument
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
index 304b73068bc4..c5f5ecc40d3f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1153,12 +1153,16 @@ int format_set_trailers_options(struct process_trailer_options *opts,
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
 
@@ -1191,8 +1195,13 @@ int format_set_trailers_options(struct process_trailer_options *opts,
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
@@ -1477,7 +1486,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
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

