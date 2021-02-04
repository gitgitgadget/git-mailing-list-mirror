Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D669C433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F03F64FA7
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 21:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhBDVHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhBDVGz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 16:06:55 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78E3C06178A
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 13:06:14 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id t142so2150875wmt.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 13:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2x+6fBGe6X4YeDVGOhgxbAWi+iNw2jGFwEwAGRWfI4M=;
        b=obSUYekUqUfgGxt7DPbqn+4HtcM2eeXzRfXPT40rPc6iw/mwAmFjLbZ7SMfGKWBY9K
         Ubu/2rupc4eK9kf6fPLxa2JYJOr2BBPnmVAkDuKOhzjGCAqEvcTr22WIVmnEaWH8wXcf
         5zQlINhYVnbWsj1LLUxSwUc3+xOLDuCZR3xdD1kE4DlwauHvowrXdl6jXlTFi1EP5pBD
         ohIIGanHhCkDD3mI3kMRL5OB7D2eIQJHD7k7/oI+ByJW7n0GrVeirWrL8J9h6nNeVxry
         R+ur+9NmmBydjv5SL6Qx9qIzFcrX2XDDZjBsMi3o1+sCKSiimyte+BTEJk1cPzUPR8gU
         O6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2x+6fBGe6X4YeDVGOhgxbAWi+iNw2jGFwEwAGRWfI4M=;
        b=dWBtPG9c0foEJHInpt55C2nLg1yv0x5rU5P4WX6b/LgIoi6FMl6K+Il2KEyGHOAY89
         jmkhbToJ5m/hrvdXf9kaNGEZRA0QcSDBugYrMPjFaFD+HfI2hGtsxuBM1+lfUDfcemgQ
         2kqRTLY8YzyPrb+YB5cDUorCqbsWtsU9E0GyGM0KNP25UkJmXGJWxzoucn5SKP+hyHAD
         E/kSFFpQSlXCXTfxq0pvVISZIJ1canmzk8cc3xa9Fwrq+7mPqTq/3wwf5iV24ZzEB8vx
         ac081+t0ERjoMSWGdyoq+Whk1FMYV443cbOvUx5mZkciwXA2j8max3HOr4ytvdxnTZpO
         xnvw==
X-Gm-Message-State: AOAM532nUxbGXOJ+IVgp78OV87mluseb3TwpNPL2ZTkfvhBeTuuSocLd
        ot7o6joJ9uK9ssqkkN3P/d/2gkKC6RnbTQ==
X-Google-Smtp-Source: ABdhPJy3irpTjxI+AF7U3o/nLl2bk9YQKpMriUgFIa1dKFnRTfo3DJxTgZ69/bSw0q2+dOrhS761+w==
X-Received: by 2002:a1c:750e:: with SMTP id o14mr898146wmc.60.1612472773297;
        Thu, 04 Feb 2021 13:06:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n5sm6779318wmq.7.2021.02.04.13.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:06:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/10] grep/pcre2: correct reference to grep_init() in comment
Date:   Thu,  4 Feb 2021 22:05:49 +0100
Message-Id: <20210204210556.25242-4-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
References: <191d3a2280232ff98964fd42bfe0bc85ee3708f5.1571227824.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Correct a comment added in 513f2b0bbd4 (grep: make PCRE2 aware of
custom allocator, 2019-10-16). This comment was never correct in
git.git, but was consistent with an older version of the patch[1].

1. https://lore.kernel.org/git/20190806163658.66932-3-carenas@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index f27c5de7f5..b9adcd83e7 100644
--- a/grep.c
+++ b/grep.c
@@ -373,7 +373,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	int patinforet;
 	size_t jitsizearg;
 
-	/* pcre2_global_context is initialized in append_grep_pattern */
+	/* pcre2_global_context is initialized in grep_init */
 	if (opt->ignore_case) {
 		if (!opt->ignore_locale && has_non_ascii(p->pattern)) {
 			if (!pcre2_global_context)
-- 
2.30.0.284.gd98b1dd5eaa7

