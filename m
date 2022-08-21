Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13E9C28D13
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiHUN70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbiHUN64 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:58:56 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F2A11145
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so4720893wmb.4
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=UETBDGHxON93iX2/uc2BL9CuytcjVdLo+av/+YvxHlc=;
        b=X8wdkdY7TnQD5911sbtArZVuae3YnRPwQlgmnkxRFYatQThI1WtRKqZ1EYgdT5LACB
         9MkN7empF4TW0uvEPj4kZw9Nh0EKvCaDNXOykAKYUaYjJJxvRNmuewX+XLyb3Ldadnul
         VHlsD0QeZ1aX7kQC/TksRUSDKx21TCd1xuCpDo+xwmQAxmRX/mZ+9+2UxR0TbJnX+cBM
         YuYUa1MWFiMeKOrt+FREJlcjPB+wFQL9kMhsha7JmZPgILvILHtX+zHYjNDW527VTOwV
         LoeYR7upWU8OLKOjGzwP3EQkTwssY37SI5BJofG2J5XFulLwwoa2RWjfYl0IhUNHf4/j
         VBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=UETBDGHxON93iX2/uc2BL9CuytcjVdLo+av/+YvxHlc=;
        b=nsXoM4V7qR7zq9fDwoJTyrgcgIePz7AC1bpzW3fyNXFQZQL5fjDWtkQiQ+VxIdxgs+
         3/T1KcdMiR/9wkZ+YH035QChrtnRrNrVeHfkDsS6RN5zHt9m8Quz3LJeT9/hP7J3gYFh
         sOGdJdRxr9zf5iXd0/IpCrr3zzkgmY/4jk9BODb/P3AtBr6ttZNA99VE8cCf8Gd084+y
         SmCPPhFBOFav+JOGVPlRM+zbgTAlKkh7qkCITarJAfjcOlJCdfbARSZL7f8S6lc+T6z0
         WxjUoVabfM8e8yjryYaAY/24rRiPAAJHf9G8zFFMNu2ZrYHY0eC9hwdWOqQaQ37efTWF
         8XSg==
X-Gm-Message-State: ACgBeo20MDkya6UukVhRF+TPgGqFIOq08OGU3+C3Ytu2C/WgyffvQKoz
        KYH9dsCII6pLbQvICV88ynMIfxbWxW3CPHy2
X-Google-Smtp-Source: AA6agR6nkvSknK5EcDTXb6Pw+gm2xWUS4/INL4Ggq8qmoQN4l1lbQpa4BQjHT/lUR1mdJfbUmjfK2g==
X-Received: by 2002:a05:600c:3d12:b0:3a5:f600:4fe9 with SMTP id bh18-20020a05600c3d1200b003a5f6004fe9mr12962136wmb.98.1661090322889;
        Sun, 21 Aug 2022 06:58:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 17/32] submodule--helper: don't redundantly check "else if (res)"
Date:   Sun, 21 Aug 2022 15:57:26 +0200
Message-Id: <patch-v3-17.32-fa2417c7a17-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "res" variable must be true at this point in update_submodule(),
as just a few lines above this we've unconditionally:

	if (!res)
		return 0;

So we don't need to guard the "return 1" with an "else if (res)", we
an return unconditionally at this point. See b3c5f5cb048 (submodule:
move core cmd_update() logic to C, 2022-03-15) for the initial
introduction of this code, this check of "res" has always been
redundant.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a694b18b55e..a9808224f01 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2446,8 +2446,7 @@ static int update_submodule(struct update_data *update_data)
 			    update_data->displaypath);
 		if (res == 128)
 			exit(res);
-		else if (res)
-			return 1;
+		return 1;
 	}
 
 	return 0;
-- 
2.37.2.1279.g64dec4e13cf

