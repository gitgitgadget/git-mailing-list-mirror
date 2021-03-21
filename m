Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425CEC433E6
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE02E6194F
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 16:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhCUQ7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 12:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhCUQ6n (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 12:58:43 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8704CC061762
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 09:58:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id g20so8167111wmk.3
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 09:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GagUwiP0HL+zZ0S6XbUDvsJLMDayoR/u1iElHCEGZxE=;
        b=OXJGBX7zz39V5upBoQPgBB2QgQ0GEwFRzpKcz+r833R55F4kseZJm2McQiUajA0F1p
         j5FneX+KyGmHuGO7hHOAn81+wXX9yI44bIpE3+drIhjYbm5C3v808stJ/nIGes8l611r
         plYoJjiC7uumJZZcgexVlRD0H7uQ004KBpE4WgeHz4TRp7UA6IJM0wSt0W7FXwz+H862
         aujA7aC77ihSJrQr5QzdMefexlvCLVyYEtcPngWQ79dTLO1UQHq/donBT+h4HHYmyrEJ
         dwibbjKQdyCCLWmTjZc3HZDk0AFq5ch6Q2ODYwnTif/Sp5ekzy7lGDttWHp56Ger1HzH
         kWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GagUwiP0HL+zZ0S6XbUDvsJLMDayoR/u1iElHCEGZxE=;
        b=GeQxXlPFN/bzL93UwYq7uZcLxSQ0bOruWPBsJlH0edocPGmD9nXH0a8VU8nv3S8VaA
         PJudrSA8osZ/4WV7QfxP7G+M0JTHg6oRdGyp2SqbUHDBQpuyKo99v2/INFswmeOA9PvJ
         mYCOcymYi7ys4YMIzxPS2rbxqN/5fNwtHvnZr0VkYwR18nFYHLYbCWlAEDePc2kmaEYc
         dcZczH3oZoxzSVh9zBRmTdqgWfjwd7BPX8OqJ82m1B8wuouak5JZCnTCkCCD0C4tr2Cg
         1DUlStjpnxqBKx9UpNLjkAZNjfI1FjONy9LdHZNnccXIqbS+pVD1iEW6f+a+H66TFaK7
         xVuQ==
X-Gm-Message-State: AOAM531eaYp4fnq1w06M87HkAtiXYNvBKkebktQ98WD6m1gIcuMEEGLG
        Qu3DpzvnkAaoQRr1j/h/hyZEdpRz8dI=
X-Google-Smtp-Source: ABdhPJzyimHPluVRl0xovBbw0WY+KLofgVavGnH8XqCdzofIrxIRX/zxGBLVOk6uxzjBMXvQ22pVzA==
X-Received: by 2002:a05:600c:4f03:: with SMTP id l3mr12563369wmq.149.1616345922374;
        Sun, 21 Mar 2021 09:58:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g15sm13315538wmq.31.2021.03.21.09.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 09:58:42 -0700 (PDT)
Message-Id: <953cc8f29885305bed1690caf5e1169d7f08fd2a.1616345918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.899.v3.git.1616345918.gitgitgadget@gmail.com>
References: <pull.899.v2.git.1615747662.gitgitgadget@gmail.com>
        <pull.899.v3.git.1616345918.gitgitgadget@gmail.com>
From:   "Andrzej Hunt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Mar 2021 16:58:34 +0000
Subject: [PATCH v3 6/9] init-db: silence template_dir leak when converting to
 absolute path
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

template_dir starts off pointing to either argv or nothing. However if
the value supplied in argv is a relative path, absolute_pathdup() is
used to turn it into an absolute path. absolute_pathdup() allocates
a new string, and we then "leak" it when cmd_init_db() completes.

We don't bother to actually free the return value (instead we UNLEAK
it), because there's no significant advantage to doing so here.
Correctly freeing it would require more significant changes to code flow
which would be more noisy than beneficial.

Signed-off-by: Andrzej Hunt <ajrhunt@google.com>
---
 builtin/init-db.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index d31dbc883746..efc66523e22c 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -561,8 +561,10 @@ int cmd_init_db(int argc, const char **argv, const char *prefix)
 	if (real_git_dir && !is_absolute_path(real_git_dir))
 		real_git_dir = real_pathdup(real_git_dir, 1);
 
-	if (template_dir && *template_dir && !is_absolute_path(template_dir))
+	if (template_dir && *template_dir && !is_absolute_path(template_dir)) {
 		template_dir = absolute_pathdup(template_dir);
+		UNLEAK(template_dir);
+	}
 
 	if (argc == 1) {
 		int mkdir_tried = 0;
-- 
gitgitgadget

