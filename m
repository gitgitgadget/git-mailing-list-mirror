Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7355C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 22:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241773AbiAJWIz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 17:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240848AbiAJWIy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 17:08:54 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C29FC06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 14:08:54 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o3so29402079wrh.10
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 14:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pUW9WNGvBZvTTlRblzGZzbipo2sG6R3TBoEh0jlCZSk=;
        b=JTcEvUckWzy7wb+VcITmGGbgxVuefL9DCZQU3VRrBciM1Wpg+TDXd0Dua+BpOGM+n0
         YOG3852DTBn/TVD4l9XH6h62dDVy36k+1JHpzErAeJvNM1qvHvAMMKS6ATZPZxcrS/xk
         hBkd7DrsE3XjosUQHEgkSx8D3lkioK/dOKuYrj0lIv1dVAiSP1eHumkrEq4JK6LAoihm
         oWu+vIWbXZX9Q29NHHNPq4g0U775Y3og7KARAVeKOP7aN3B4N+KM2XPNa7nZoiap/w9Q
         UwWrYC3ksDtL/HB0hVA9XLQclJOT6++NAPxOB499+68lrmnNO+Jd1AUAdH5oYgMFRPmH
         N67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pUW9WNGvBZvTTlRblzGZzbipo2sG6R3TBoEh0jlCZSk=;
        b=tnQqoL9p5+QWTkp6yhXICUW1VWSr/EGtk9djBKZSorCrcsImKovvwP69EPdOQtyvC3
         czevpWAxH0nXOUIKCOjo/UFXFhxTnSvzWUvgRtD7TP3B+c0aZkRThwp5OMoUchNCujHH
         oTjdlDn0BXES6rk2ax+z0gxDmZEt9TpV5olO3KwEaFy3QLGkoE3lZqnAvh2HgvFFkBMc
         HYqp4LhABA1LhIMfpArMurQS6Yh/+fT36F2tGabdh4BnNZlIpMT1xcfiP5cDE2XC4O8m
         y0hdH3hL2hS4TwngE8YAaN6WnscLDq1hbupASdTvs0nEsqlyeKSZL4GlQw4DJWuIQxKK
         tleQ==
X-Gm-Message-State: AOAM532E8adT2Xu014YTK8vRFoEOwI6ZT0gyBLblLCphpssGuRHK+2zL
        IxZEUJyRpj5sVDBoEg/NIDgmEoh5qFhDyQ==
X-Google-Smtp-Source: ABdhPJwXMDthNQlmWdepzRRtWeyMIvdmRli5msmcRXVEYBNCGGXrwOtCQ/I7G0+MGnD7YXSiN7Tmuw==
X-Received: by 2002:a05:6000:2a2:: with SMTP id l2mr1293232wry.424.1641852532630;
        Mon, 10 Jan 2022 14:08:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s10sm84432wmr.30.2022.01.10.14.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 14:08:52 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] cat-file: s/_/-/ in typo'd usage_msg_optf() message
Date:   Mon, 10 Jan 2022 23:08:46 +0100
Message-Id: <patch-2.2-e3c91039d8f-20220110T220553Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1373.g062f5534af2
In-Reply-To: <cover-0.2-00000000000-20220110T220553Z-avarab@gmail.com>
References: <CANYiYbEYgSCx230S29zVhMKb8J8WQ1ScxVHn6fMvdhPOdjpBCg@mail.gmail.com> <cover-0.2-00000000000-20220110T220553Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a typo in my recent 03dc51fe849 (cat-file: fix remaining usage
bugs, 2021-10-09).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index e36492235ba..7b3f42950ec 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -727,7 +727,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		;
 	else if (batch.follow_symlinks)
 		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
-			       "--follow_symlinks");
+			       "--follow-symlinks");
 	else if (batch.buffer_output >= 0)
 		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
 			       "--buffer");
-- 
2.34.1.1373.g062f5534af2

