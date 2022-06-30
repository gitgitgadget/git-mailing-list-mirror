Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0F5C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiF3SAs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbiF3SAe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:00:34 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B032B180
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so2202926wma.4
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x5KFVq4Oc/TWec4m2HFI91CLhVdMAYYioKZ1+MXf0Qc=;
        b=DM3h9RWhv5KZpj9tsUKJ+1la8U/aBI+AlX+SJb48FcuYpGd3A1S/4HeivkJERu1Pbf
         tbJomhyTkK1LBkv8ve5xkieyiCCcDTaVv4aC15DPKjMkLTgVEErNJPMbMc1MeAc0pyHu
         csJamh+VKYkq8WIBs4sxlRer3untYzj3T3tqOJXfgpO55iwZDL730T6AcNrKwFc7NkmK
         vIbWAXoSZT6tv6+hJZSu3sAbMMB6wvOquJOhexgb3fXFZH1IXo979ghq149UkZAaanuv
         2aX9VhhLLdJzs68y0VXqjAC19JiARkkrQTNDgo75nTPhohfLgoAw3UgiEm4HhmIhqZST
         JX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x5KFVq4Oc/TWec4m2HFI91CLhVdMAYYioKZ1+MXf0Qc=;
        b=E4uxlIy5tXDZwq0CNeSTAdvPcGvda6tHlvuvcXhhYeDeauRoIrnbc/i/WDheMtOfLI
         UM1QLiUW3BUObJgiVSjd2JLB3zG9qv6QKIuV/Fqh6i7xyMz8NwO+CS3tCzvUf4bMmJQP
         21GRnluUidyCgA3sQDTYNH+C30JtQjMdMPAdLpZXkyJVy25xVzCxpG+fsy5zHUsrNJ7f
         ygCDYE17sAaXIZ8BoYSf1qKCk6OcinreM9YIKHp0fIwjos8aJrKxfKb8Qjuabe2p16m+
         24AC8Zn4R0Y/hBjb+rs4mYkfFDJdypGVr1lR0ApmWyXxbCX951zDIUeM85+7NOgrg5R2
         PxVg==
X-Gm-Message-State: AJIora+0A3iFI/P/1YXoMT+mx/qRSsNYLn53Zu5bVhaOJfs/jqbZoI95
        JGNDdjmwcr3DhWUo+YHOVU4yXsD+wFqKgQ==
X-Google-Smtp-Source: AGRyM1vvc9wuaPdNI+ZKXc02gZOytyrEue8K4fD4GLIqCD67zgwy9LznJHs2B6zFxo7a8X3mfQLuUw==
X-Received: by 2002:a05:600c:b46:b0:3a0:4a51:bb1d with SMTP id k6-20020a05600c0b4600b003a04a51bb1dmr11352117wmr.168.1656612032096;
        Thu, 30 Jun 2022 11:00:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v13-20020a1cf70d000000b0039747cf8354sm7363985wmh.39.2022.06.30.11.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:00:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/11] checkout: add a missing clear_unpack_trees_porcelain()
Date:   Thu, 30 Jun 2022 20:00:18 +0200
Message-Id: <patch-08.11-94e28aa7ab3-20220630T175714Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.874.g7d3439f13c4
In-Reply-To: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 1c41d2805e4 (unpack_trees_options: free messages when done,
2018-05-21) we started calling clear_unpack_trees_porcelain() on this
codepath, but missed this error path, let's also clear what we've
allocated in that case.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/checkout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2eefda81d8c..3d6762106e8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -750,6 +750,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 		refresh_cache(REFRESH_QUIET);
 
 		if (unmerged_cache()) {
+			clear_unpack_trees_porcelain(&topts);
 			error(_("you need to resolve your current index first"));
 			return 1;
 		}
-- 
2.37.0.874.g7d3439f13c4

