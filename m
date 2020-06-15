Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D74C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95C672068E
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 10:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InP1dmHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgFOK5t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbgFOK5s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 06:57:48 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDA3C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 03:57:47 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dr13so16906500ejc.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 03:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ARei2LqkFyVelfdtxqJoaUio3VxaK9Y4RVW8yNynZv0=;
        b=InP1dmHiG9iMVGN4pA/7jiUjGBVT9UUKlVVb82CkINbkUNsusOEVhN1F96LKOatCIo
         ++jaJKQqeeaUQ8OUuc2XtvSQZYUQnmBdp1YTSqWZLsTwRsEs6Ljjf0oi1hJtgoCags5x
         nt7pAIHL8zpN7nMSItVhlgVUZeQWBdHT+5KZCZcApUOPhUoxhC67yGB5av5iEs/XHrP6
         LIyRI/RokygLz3h+hfvwvrHQUePQoS7dvnMnPl9tSg6OKHoahX/BAkNg30HCu+HYxOuZ
         7oaSKIrLjALjoy1FJ369Olm4p0Fi+yHQ4MSzPOllBD3fLhMDNgiHgSJ4IoGQXvnyMJ1e
         mIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ARei2LqkFyVelfdtxqJoaUio3VxaK9Y4RVW8yNynZv0=;
        b=lSA4PcIRs+ecJblP5m3no+wKVrKB3BHZ5/5zoYuYx2txMBnnbt8S1Hb9nh/uzGHkf5
         SZ6eG63AAxU0CZuzFVRud4wxhPMh3PI71MIcUBMgG/BYHjfIrBN3y05xpHrz3ge7S7pp
         U6IuuHzwqpw71RZv7whVayUxMFe/wr8439YGaJMIKlGta0SzoDs5iCaTikhmqSMK8QlG
         gVCxolQAVVhCNLPxXSwUUCfjskQ14n9WYvHhyPDRnsMqbVzWFykIcdY/tuebPXy0UIYG
         tTUcn4xGEA/YnYAFyiy/ka0ZVOF2BdLJMFHwPzoYBeNVhrzrsMHqpdmNaz+5n0WSAebv
         8bPA==
X-Gm-Message-State: AOAM531n4YqyMqS3RR59xMDHeK8M0f3E7rTG/EU8925hCTKqYOTS8Atv
        NLyCRDqivsSt8zGFLT1WgUgzhj3R
X-Google-Smtp-Source: ABdhPJy9yVw/Q1pTGWzmIkNSHtRXFG6GbwpRUNeap5AXsBjoMvaWFRBpIDINSCPu9caGdJkysecrmA==
X-Received: by 2002:a17:906:2655:: with SMTP id i21mr13021638ejc.18.1592218666100;
        Mon, 15 Jun 2020 03:57:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z38sm4787552ede.96.2020.06.15.03.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 03:57:45 -0700 (PDT)
Message-Id: <b568d097159ff9d89bc4fc7c9076d9a8a1e29a1e.1592218662.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.658.git.1592218662.gitgitgadget@gmail.com>
References: <pull.658.git.1592218662.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 10:57:40 +0000
Subject: [PATCH 3/5] pretty: introduce `get_user_format()`
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

In the quest of porting pretty formats to use ref-filters logic,
user_format must need to interact with other functions too.
So, to get user_format, introduced `const char *get_user_format()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Heba Waly <heba.waly@gmail.com>
Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 pretty.c | 5 +++++
 pretty.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/pretty.c b/pretty.c
index 2a3d46bf42f..3767c144b0a 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2016,3 +2016,8 @@ void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
 	pp.fmt = fmt;
 	pretty_print_commit(&pp, commit, sb);
 }
+
+const char *get_user_format(void)
+{
+	return user_format;
+}
diff --git a/pretty.h b/pretty.h
index 071f2fb8e44..517450f72f8 100644
--- a/pretty.h
+++ b/pretty.h
@@ -139,4 +139,7 @@ const char *format_subject(struct strbuf *sb, const char *msg,
 /* Check if "cmit_fmt" will produce an empty output. */
 int commit_format_is_empty(enum cmit_fmt);
 
+/* Returns user_format */
+const char *get_user_format(void);
+
 #endif /* PRETTY_H */
-- 
gitgitgadget

