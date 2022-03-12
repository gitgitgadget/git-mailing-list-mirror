Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59EDC433F5
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 00:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiCLAKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 19:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiCLAKB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 19:10:01 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BBD2272DA
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 16:08:56 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u10so15208332wra.9
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 16:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=837qGVpXFZzM+0YUSLB3JsjOQ4eE6KaJGG+jcxv7f0o=;
        b=OO18tJjhNZuJRM29oVvg2jOXGCnEKzU0wSuug/VEvtanwyb3hanZm5TVCnHrK6N4DN
         J7BLTN3rtOTieT1ALewiQtMrF54OmQk0ZRjvLerK1l5EJ+dZRaP9mKHse/NVGSpKPo4Z
         wpVA4CXmcQEF8xfNCuOPQcc4cHReWTkck9E5Wjd/KgdQJ2J2EOa00IXTmSKqkacKB6h/
         5VzvRJN66zayXvTWL0W72s98OEljtRaa9JKhb4CiaEzJ6JB8RZ780SaVQQFUIxs15SGf
         17PR9IYarS9oUpDtSK0Tf2tNFjvrVRiB+5fY/l46ft6Y4Z5t068c9nP8seF6DWH02Nlu
         bR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=837qGVpXFZzM+0YUSLB3JsjOQ4eE6KaJGG+jcxv7f0o=;
        b=hLpJ41DLffIsUV6Ivduo0OM/Z7VZWzoXJOYO+kqSsQqY9J4HAlaTlN6tXt7CCjfpUu
         MXKXg1ltDt/znSZsgCRGs+J3Ox3+eRm+gPR3Yzi8rYeZ5Gr4noIZfEBW6m/YQJBDmCI/
         exG8H1mOoGLHtYiwxpYeF2o9JOjkOGB8QnrXYDMcYmlgsV/qB8mM30yW1qeBx2aI5tUx
         LfhDDf7HXu133KwAjlRsiGe/tQ6NlChky5gpBpK7syeRv6dy2QLLRhmoxL5ffaF5v1Xt
         n1iUro3ypP5COfljzxeMQJwn305URMCDcZMlmYoTmE8tJDD2BykQ0BVijVuiihcoDoAs
         ozRg==
X-Gm-Message-State: AOAM533u/W5KrGB6ju3Psmon2Y6e6fHBEvSOhpc5N/0hxBgXZl68pnOz
        5I/LLRtq3Th0CUHBc2KzcKlgZhgve3I=
X-Google-Smtp-Source: ABdhPJzOPWOYkCV+vhvxkH8JMugGSlK0EobhqkbM9ZwI7MqJxHOqclAK/5aF5PSG0Yf9lQN4CV9ORw==
X-Received: by 2002:adf:b1da:0:b0:1f0:1205:89c1 with SMTP id r26-20020adfb1da000000b001f0120589c1mr8729778wra.27.1647043734516;
        Fri, 11 Mar 2022 16:08:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m34-20020a05600c3b2200b00380e3225af9sm8697962wms.0.2022.03.11.16.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 16:08:54 -0800 (PST)
Message-Id: <3c65a9f19936548883522a4795048a7cf756c6bd.1647043729.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Mar 2022 00:08:48 +0000
Subject: [PATCH 4/5] reset: suppress '--no-refresh' advice if logging is
 silenced
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

If using '--quiet' or 'reset.quiet=true', do not print the 'resetnoRefresh'
advice string. For applications that rely on '--quiet' disabling all
non-error logs, the advice message should be suppressed accordingly.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index feab85e03de..c8a356ec5b0 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -535,7 +535,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				refresh_index(&the_index, flags, NULL, NULL,
 					      _("Unstaged changes after reset:"));
 				t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
-				if (advice_enabled(ADVICE_RESET_NO_REFRESH_WARNING) && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
+				if (!quiet && advice_enabled(ADVICE_RESET_NO_REFRESH_WARNING) && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
 					advise(_("It took %.2f seconds to refresh the index after reset.  You can use\n"
 						 "'--no-refresh' to avoid this.  Set the config setting reset.refresh to false\n"
 						 "to make this the default."), t_delta_in_ms / 1000.0);
-- 
gitgitgadget

