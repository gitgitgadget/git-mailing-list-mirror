Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457E8C19F29
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237498AbiHBPzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbiHBPyz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:54:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB63B1A83E
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:54:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j15so10355812wrr.2
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=oTyCdz2Hkqj3c16yxVgZw5vJd6s79xLtf72YJ2/svn0=;
        b=WAx9qv00bcbG1YKyDp4TH9SbMNfM1IDyzAiwa1cmI36auMuEuM5/7i4ParHc2x5tzK
         odXaC96087pdwfPv80vtfnaXKvCjbdkuBj8tf6hDcD9hloMsLueEUmR+NgJYLgqUpsVW
         3OgQh69WJn2/mVtRCorwvOJYGt0X46PxyriqD8qi6JCRTLMG6QPr+vdLv5KYkTXrTwq7
         LmTVTZRaxASxV3TO0919BSB5tlIJ9lsB8F7kItjjemw0ZeN36/cYdtNx+SBnuXR9dsMf
         KFiuNAlv9iYrfh7C/f8x+TWHpbWWY54YEJF3psp3WxL7YuOO29qqvM2Qk+oBKy+24axI
         65kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=oTyCdz2Hkqj3c16yxVgZw5vJd6s79xLtf72YJ2/svn0=;
        b=fsSCa6b3hjXkC9ZrL6BLvjOShO8Ta+IMKmSpV54fCocCwf/2QiAthhpa3stLeMm8pH
         KXeUKD+BG+69ddxZRg/YlU4hbL8b9bBgPgG8XxBNY0Mmu2ifCvqTydBrBbc5r+mtcn73
         d1piszQQNRKY/XH3MEHXMmh2OEP1Fjr7wpQvcxHScWo3q+YnZ+o9TvtCWgdULyF4qWpH
         wI4gdJWfyJLG2Vgbxktu3M0/+sWxMGjL742OSqo8yIyCVNXkL+PK0k6KuDYnOqEwH/39
         OxclccbcQtBbnG4fjq49AyLj636JrhjhjimiurmA/a/4IZPQ5JwhQlUA0S8JmeaRL6Tv
         hF9A==
X-Gm-Message-State: ACgBeo2GuzHPj8CEFwILvO9fWq8lK30kSiTX1CmXE2xHuQqZ3g0EeNxC
        U78UGeBYBNV9lV5hhYN8rfYZBL7/PiS8TA==
X-Google-Smtp-Source: AA6agR7P6D35M93IU9jU4sgBO/KICrNAnstiE3SuEOOFDSwCzcp1OYSAdg1zCmDxhD0/S9OBb1Atig==
X-Received: by 2002:a5d:64c7:0:b0:21d:a743:394 with SMTP id f7-20020a5d64c7000000b0021da7430394mr13098367wri.628.1659455694043;
        Tue, 02 Aug 2022 08:54:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b003a327b98c0asm23562286wmb.22.2022.08.02.08.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:54:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 09/17] submodule--helper: fix a leak with repo_clear()
Date:   Tue,  2 Aug 2022 17:54:33 +0200
Message-Id: <patch-v5-09.17-3aebff9f8e3-20220802T155002Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call repo_clear() in ensure_core_worktree() to free the "struct
repository". Fixes a leak that's been here since
74d4731da1f (submodule--helper: replace connect-gitdir-workingtree by
ensure-core-worktree, 2018-08-13).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f332627d19e..4e964a2c29c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2396,6 +2396,7 @@ static int ensure_core_worktree(const char *path)
 		strbuf_release(&sb);
 	}
 
+	repo_clear(&subrepo);
 	return 0;
 }
 
-- 
2.37.1.1233.ge8b09efaedc

