Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914BBC433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADEA64EBD
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 07:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhBIHbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 02:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhBIHag (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 02:30:36 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBC3C061797
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 23:29:19 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id e9so1140605pjj.0
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 23:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BjOmTy4dNmgRmOu+FOU2Diqsqn48K0alvnBzauFVVJY=;
        b=groUTex3h6hiJwNy1I79+y8Qx0DPPGuOvzHkLDjjnPkCvwzfTltaUqu6InwRTzXpUa
         bwRs5nCCky0LYeGjOfccil0prsmxgXJ9l0QtO3N9JsIN3rj2G0z4upGYD7SUYUbmQn9V
         pAWtlklihUiXKXPgdU8gjGpsyeEERLzJR7elk0IPkDkjPFuNQZN3VE283vwKhe1eCeDV
         82kA2VoJVsG7UWbs3pEry4lxp9qB6UP5+Ont2X11kS2il/TXet8qMK6D5qVaWvecZ+mA
         aVA+rg9kptkC2yonBgnAY6p3/3khU95M1nJp66ItZgUXufiD1U9eDUKZJPznDa0EwdX6
         x6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BjOmTy4dNmgRmOu+FOU2Diqsqn48K0alvnBzauFVVJY=;
        b=REV/P+ohkd/ee7j1UEyS1CHh1J09o2944foVle0AgcoNhFLhE55liJTcdJXGvU19AL
         uGJmNjlBsgUp2sRUR1gO3X+g3DzdImHWXoxfmGo9/laAulDkCSTMBVCkLLZhpsZCx0t7
         frJhqjBYpXQZvdu86OdmTj/YZpVL9JMdbpi1AXe0+ZUM004K6pPiFgxj1YYvDSVL9teX
         753BRr6OwL195fUjRIaoD26JU84RXHUhtXjIJva105H8vOawAsWlP3PsYBuAmBDuAtBT
         Tlh6HvNVGK1alMLS73/q7M39UXB+xwFn04CCnNsOnw3ycwfXUguHomxKvKzwO0FWS0K7
         RYHw==
X-Gm-Message-State: AOAM530QiIEpyvWf++AG1xnNgk3mR8eb4xtbTt3oERPRImZCi+r+9FVV
        9VsXrZXdia24io7R1bQqShzMqHunLjA=
X-Google-Smtp-Source: ABdhPJyVIwA4+nuAjbWdTHpV6JN0gCqOUb5O7+xAi7Hkh14h8S3ZYJHWEpqAH+sonr1kZJAZpu0b2A==
X-Received: by 2002:a17:90b:4a09:: with SMTP id kk9mr2937471pjb.15.1612855758937;
        Mon, 08 Feb 2021 23:29:18 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id w4sm5670443pfn.45.2021.02.08.23.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 23:29:18 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 7/9] stash: declare ref_stash as an array
Date:   Mon,  8 Feb 2021 23:28:53 -0800
Message-Id: <2f03d38b36665fe258444ce58f1e138be7b97e13.1612855690.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1612855690.git.liu.denton@gmail.com>
References: <cover.1612258145.git.liu.denton@gmail.com> <cover.1612855690.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Save sizeof(const char *) bytes by declaring ref_stash as an array
instead of having a redundant pointer to an array.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/stash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 9bc85f91cd..6f2b58f6ab 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -87,7 +87,7 @@ static const char * const git_stash_save_usage[] = {
 	NULL
 };
 
-static const char *ref_stash = "refs/stash";
+static const char ref_stash[] = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
 
 /*
-- 
2.30.0.478.g8a0d178c01

