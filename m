Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F927C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66111206F1
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="toiYWovb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbgKJVWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731795AbgKJVWC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:22:02 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03415C0613D1
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:01 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 79so111470otc.7
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 13:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DYKOgf1LrApHyUZ/n7r52EOKugri1nEYLVh0uX8lvxo=;
        b=toiYWovb6OVtPKDdy8zP8xlcpVIGXKLDmIkN+En+Wd80WzGI8vHOW+ZlhegYYjFjgg
         QwFYhwvP/4h5HXHMZ1W7ImjY4psLWDFKmGwZQDTqgDR5OjZ+koI/H0oSgk6fUsCA7xlj
         AQgQG8GvMRJ+U+Zm847/na/dTAiCGVa/gSknwyqW91HqxOPIiZ7lWJylbVaIiTzBsFEy
         ZhFJKBYBYNdFImJOZcNEt+/HPkaZm0ZmodJcmNISq1MPUVno7YKMh38vX2iOmCHOzUnE
         P/p6I363ZfvYa6+ctBaoY18QmgeW/Dsh2+20RPi8CX5XZd52VvbDVY1ovgQwKvKz5twH
         OXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DYKOgf1LrApHyUZ/n7r52EOKugri1nEYLVh0uX8lvxo=;
        b=mNvaBKR9uPqR1p/fwa2zA0cMPrxORtY8Pm07G1+HTX8Eskc5bGI0xWZ5wetjvPX/Ic
         +Eh0crqRUyq4uCiiOBXswAMVN6BQ1ZWlW6ZsPTVfrevLRZNn/JbPVbQmzOS5EBUtOsU+
         F5ZWD3bVmVZVvskyktf0s62GBuWk4mB6xizxm+an7xTwsNO7m5sxU6DhAG0shUepJ7NS
         lWYHqBb0NUpdLYGXkxolID+87MWrGm6/GWTW+fHcbJQUuDKCU6P/jTk3FaG5BHPTQRdq
         IiRqeo1y2VqGddVIxwgwvhHOxabE6erD3hUCzC7eRHJvkUTR5EYjH5TNT5ONDIeMhAne
         bglw==
X-Gm-Message-State: AOAM532IYDjI8nLz4wmrn7CJ5oTIOkFor4adoYjEN4tJ6Dnh5fkU9qUn
        lShGQWeGfAVz5SSY+ykrVYobWUQL/B7Tww==
X-Google-Smtp-Source: ABdhPJwg60REk4kU879nnVz3pmaPwm1KevnBL9qKHE/RV3+q1+kyBxKXtYrUu4J/r2KEqFGoXys/Gg==
X-Received: by 2002:a05:6830:84:: with SMTP id a4mr11938155oto.341.1605043320231;
        Tue, 10 Nov 2020 13:22:00 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id j23sm47116oos.4.2020.11.10.13.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:21:59 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 11/26] completion: bash: simplify equal suffix check
Date:   Tue, 10 Nov 2020 15:21:21 -0600
Message-Id: <20201110212136.870769-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201110212136.870769-1-felipe.contreras@gmail.com>
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We know the prefix is already '--no-', there's no need to check for the
first '--'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index bb1250f10c..3f684cfe59 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -335,7 +335,7 @@ __gitcomp ()
 			c="$c${4-}"
 			if [[ $c == "$cur_"* ]]; then
 				case $c in
-				--*=|*.) ;;
+				*=|*.) ;;
 				*) c="$c " ;;
 				esac
 				COMPREPLY[i++]="${2-}$c"
-- 
2.29.2

