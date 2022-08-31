Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A82ECAAD5
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiHaXTO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiHaXSg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:36 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182A2B028D
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k9so20176238wri.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FfrI6GnAoSrICtgUM4sFV9tb+e+x671HUJS/qc8qptU=;
        b=aO2EmzfDwgUdlgjbuLRfjbOBNa/D/p6kuEZ4DRxIfeQBKmHl8itOlBgLPf53s0ET/j
         /AYPwWnQfL2C27GfXQEFS4Bts8U3LVs3RXjRajFBbhmvFlWoDUInV7E2+PcmygAaTTE5
         z88Qb0VpnowaKIIXVAHoMGJNiP9d+1qTMuddkZH2C++V1YojuGRC7xjAX4VX7Pf2T64A
         8eQQd6+JmNNYqI0UYHR3CX4fV5LCuX1tLwttNQRrAcCUTXUnZRdGp56UhAANB6R+n/CB
         nVrHfTRBXpzRkdAjgal0/ehzbws3ONZxgv7ft8oHErb18M15E5mZ/Cgmui4/0du14vmH
         B4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FfrI6GnAoSrICtgUM4sFV9tb+e+x671HUJS/qc8qptU=;
        b=3oawdVaYqiurUN6qpV6uGZUS3MA258jd8Rcklid93S6uIwAk56/P6uhsf0bswRdwvg
         HXHMDssuvBRFomUEoaLg0Dv6aM6UDjgsHuZvXnJu9l6um51+WVwf3MWpbCEY4Lm9ABCj
         AWopVLa1xQFW/b+Y66O8RfOpmYKO4or9FM0JHcDgktPmh4+0HHrazTI9qSqO71Ix66l7
         IuzwKJIIN0HSjxNHMFLNwBKqkwXeeewhA4YYERWpO8C0lL3+YMp6Wf9pTNy55xaci3OX
         GVX334DsmdkrGUnMKHf+xYRWW0Tm7BYad5MxUhq61TariB65t2sTOLJU2UtZR2B5qzuv
         jjKA==
X-Gm-Message-State: ACgBeo3LnQDPK6wyawfiDzKNsTWVvpcT+G0l5kLGhdm01WyUd9afnOlQ
        m5qlLYsSkDA7YhSutTJvLFiQDNnO7HlcsQ==
X-Google-Smtp-Source: AA6agR5ZekWohqbhv6gEYFlioXUnGtFhEIyN8L81+hgc37tKayDqnkRJFeug1Lul62VsyHGZbERAiQ==
X-Received: by 2002:a5d:6911:0:b0:226:f5d9:d545 with SMTP id t17-20020a5d6911000000b00226f5d9d545mr220925wru.469.1661987914523;
        Wed, 31 Aug 2022 16:18:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 18/33] submodule--helper: don't redundantly check "else if (res)"
Date:   Thu,  1 Sep 2022 01:18:00 +0200
Message-Id: <patch-v4-18.33-1786e40ec99-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
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
can return unconditionally at this point. See b3c5f5cb048 (submodule:
move core cmd_update() logic to C, 2022-03-15) for the initial
introduction of this code, this check of "res" has always been
redundant.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 07a918f7373..93ab49defb1 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2448,8 +2448,7 @@ static int update_submodule(struct update_data *update_data)
 			    update_data->displaypath);
 		if (res == 128)
 			exit(res);
-		else if (res)
-			return 1;
+		return 1;
 	}
 
 	return 0;
-- 
2.37.3.1420.g76f8a3d556c

