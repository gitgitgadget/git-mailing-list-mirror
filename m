Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70044C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 13:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55B21604D7
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 13:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhHKNtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 09:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhHKNto (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 09:49:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DA2C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 06:49:20 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g138so1986474wmg.4
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 06:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=zFw6rYBmbYMdfmJIGD8uxaFf5FTepY29C1L7eOsLkdM=;
        b=GcDBSDDtdQWjYdstvy2KaMhRt2ntwkOhCP3io3VkbUy3d2fTHCeuLeQpsfHAB/OiA8
         5mtKNzuYUCA4C4q/34eGZ2/BH2usT4rF/fHpQ9BEVq07Gb/A8Sp+iib5zKuy68wncBrm
         1AICv6v+DD4CEx36Cd2i6cOTJgs1wHEzJJWzqouHSm4PY5D8rNDV2RlyFpNUS9uB7T30
         rR/y3jYB/tM05x+Dg/h4ItuR9fNiXBRK6rC0aTKn62yWFYKVvguUWSruM7NT/+ay+9Hs
         tUoMqGaP4JPOao/cNbEvezyl8r4GKtUDu+ZTmu6fK4BTg4O9YTeylf0W3orgX3FxFDD1
         Gsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zFw6rYBmbYMdfmJIGD8uxaFf5FTepY29C1L7eOsLkdM=;
        b=YFCBOU9vlAnlRQCsoBVfb/BehnCfwab48FXCdrVpfkQeHoRtC70lDinsvxia6INF7c
         VUbeaHJIgEiXphltKshPd5YXAKO7pjVtsrzKOFvfX/UEyG1EftzsNWOfvHKYtrxISVXl
         dLtN3tPEbKUPCtDtfRVFDVYFz6C8u4gr/J8kfuJt4EP+RFluT3keqFC0wShChrBRVt0W
         Dyj7ujHB9iDnWA3wBi8N/zBbK62enZZyoM8sNfhvZGRzKevyoar/m/qYNQjDGNFwBlbJ
         ndkvjaFBW2Dwi5skBUr7/eF3QlS88MaICT809wg7j3LxGxcAuXzNJs8HO4CB2DEdXAqw
         I4uQ==
X-Gm-Message-State: AOAM532QrFGzPGuDEZIYPyX0l3e7e1QUoz4NAypvOYx0w8Xi+AkFsdZN
        TiwsNTUDSpz3DCGHdxjI3XuW6ddzCKY=
X-Google-Smtp-Source: ABdhPJxrZoW0L0rX8KQ5u+jhu02wfbzLhQ1YQ0EN5cAB96R1NNTglOFZP5wV6ytaWwJEuH2duMkiPw==
X-Received: by 2002:a7b:c94c:: with SMTP id i12mr10307768wml.148.1628689759440;
        Wed, 11 Aug 2021 06:49:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j194sm6275888wmj.3.2021.08.11.06.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 06:49:19 -0700 (PDT)
Message-Id: <pull.1014.git.1628689758413.gitgitgadget@gmail.com>
From:   "Joel Klinghed via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 11 Aug 2021 13:49:18 +0000
Subject: [PATCH] commit: restore --edit when combined with --fixup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Joel Klinghed <the_jk@spawned.biz>,
        Joel Klinghed <the_jk@spawned.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Klinghed <the_jk@spawned.biz>

Recent changes to --fixup, adding amend suboption, caused the
--edit flag to be ignored as use_editor was always set to zero.

Restore edit_flag having higher priority than fixup_message when
deciding the value of use_editor by only changing the default
if edit_flag is not set.

Signed-off-by: Joel Klinghed <the_jk@spawned.biz>
---
    commit: restore --edit when combined with --fixup
    
    Recent changes to --fixup, adding amend suboption, caused the --edit
    flag to be ignored as use_editor was always set to zero.
    
    Restore edit_flag having higher priority than fixup_message when
    deciding the value of use_editor by only changing the default if
    edit_flag is not set.
    
    Signed-off-by: Joel Klinghed the_jk@spawned.biz

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1014%2Fthejk%2Ffixup_edit-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1014/thejk/fixup_edit-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1014

 builtin/commit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 190d215d43b..4c5286840c5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1333,7 +1333,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		} else {
 			fixup_commit = fixup_message;
 			fixup_prefix = "fixup";
-			use_editor = 0;
+			if (0 > edit_flag)
+				use_editor = 0;
 		}
 	}
 

base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
-- 
gitgitgadget
