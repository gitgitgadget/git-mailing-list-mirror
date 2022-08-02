Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04475C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbiHBPr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbiHBPq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8760823BC4
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v3so17488382wrp.0
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=mtNatpiKfILw6BnDcFReiCWnNT09sukSbzSSdcx3OEM=;
        b=chZKUXR3+O/cNnN9WepDFNgdo/fxGbr02DC6WO6Wv+ensPIlgBvMLNM0MEv4plZfYM
         Mt2F3xcYlHuS/yTZcvoGkABTT4/TnlUdOhupftuXz6VYVXaRDSyCgq0zmzu5dC52DRuC
         N+xfIAZinT6fqs/y9oMmV0wudk+TKyg8rEO5Ig6ZKcePoUCKoH5vvaws9skkw8Xi1ksK
         F/VEtZbwcnBGm/Bvab4qBjyVlaXXCIAC0Zk0INDFu6wONrH/1fGY00we9M6xIMF3jegi
         BNjsLkLjEfO9pl0hfTOtfS2d9drf3r/LV38JP9yk7MLCmd0lF/rDYDhGUYw+EbIUWf7d
         z/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=mtNatpiKfILw6BnDcFReiCWnNT09sukSbzSSdcx3OEM=;
        b=XxTbLvj7EtkkFNm3gpkNBv+gkZNjJelgkY0qnKq7gANrqExcXmA1O3ekzy/DFxmxIu
         R9GILQKKy2yxZyi8X51xAAsQWvUgYL/senPBFU2TDYTICPNuubZRF7yStdlM+uW8P7hU
         11VHr6YPgBVL5CpplkoOfc4RqyWH3k7/V5rpOAUGMxa5gDFESV1HjsIkuX7o06ubYatV
         eGqzUPWiPrtTez+7JB7IwbXqmTMQL3Vb0PYLeiQLc4CnZyShpo14AzzZoLiWjNNAcXGg
         iWWqPIjOnDBZNnGrZMuosn0bHr1zTkdZF8XIlH4kZDchB9Tjei5pHF0D5dhGljLQN0V9
         p5Tw==
X-Gm-Message-State: ACgBeo3YQ2y8Dw3SRIhz0TnHx8cgeD/pfE6jQzcaejvbwiImKSzkKWyX
        hcCp7tzhVRog8rmss0gpEEMho5b8KFT2+g==
X-Google-Smtp-Source: AA6agR66IwWRjMvb9MNftYVKHV5EG15trB9IIpe9rVmGmpffxSQm0zwnYs+AuZQ0PmtLmUqhtWP35w==
X-Received: by 2002:adf:fecd:0:b0:21f:d78:743f with SMTP id q13-20020adffecd000000b0021f0d78743fmr13668374wrs.704.1659455193777;
        Tue, 02 Aug 2022 08:46:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 17/28] submodule--helper: don't redundantly check "else if (res)"
Date:   Tue,  2 Aug 2022 17:46:01 +0200
Message-Id: <patch-v2-17.28-23eb07176d9-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
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
index 5ea308273f4..1a19723f596 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2443,8 +2443,7 @@ static int update_submodule(struct update_data *update_data)
 			    update_data->displaypath);
 		if (res == 128)
 			exit(res);
-		else if (res)
-			return 1;
+		return 1;
 	}
 
 	return 0;
-- 
2.37.1.1233.ge8b09efaedc

