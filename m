Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0554BC4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 07:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiKBHye (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 03:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiKBHyY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 03:54:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2402326569
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 00:54:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id f27so43092306eje.1
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 00:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp7bhXI9suWL/LjIHe8Mthr+OoQZNzzW8PMTQaf7ksY=;
        b=o30dZI9Y28pUgq9MQu2VW9G410Q0I27RPu+MQJZlJ9wImS2g5zzSserH6l2o9gNcIr
         nUcqB7qntR7pMeI9vHEidEUhnvsErieNAvPXIpAmyOldofuIwE++dpzFBgCNJLs6zZ1I
         KP6f/qE1PiCIFXKii87/dpdCVGLS+5wzpgXXPE7fKa/0U4omcyP8GTixX9scphAtOLiU
         XH3vc7yMdDH4QkVFFqWOUdo+UFGDr13a44/UEsq8tTnKlmvdn5Ft/tgQGu2QJYz1QsFs
         9Jbz3+rIvyye7IQPc8oo/zp5CJ1sgx4cQQb/6rR+kEtGQGwBowfNKZObjfmfHhKBw3ME
         f8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sp7bhXI9suWL/LjIHe8Mthr+OoQZNzzW8PMTQaf7ksY=;
        b=pYQbl3JZWg2YSfPcgX/E6qBuH0x6o10nsVnpvgPMfYHrSCnj8QD4ilztHCQJohwfwY
         Ood1vuCEzaemgPJdqDpuN/NV/wRexqMUKT+n9FDGo+rJhb9lilc/c8j3vu/DHTFrpO8S
         oViVcwxyUhDaycKCkx06VEzAmNEuGODqT6VSBrqdUdrx279s0/YOnzGHlHl19Cp1Xfb1
         xylygJZvlhlFRmcbFWaY8WGOnydZl6RxC9yt7oEclwOIoQ5OV7GA5adUNBd5feslHe2J
         7oJSfrz3iT99D181PM+Zr0UA1s45bsOUm5OdQu8NHoXtla9/7qQPCX3SZQf1U3zDyzts
         Awrg==
X-Gm-Message-State: ACrzQf2YODdAKo8jm/GTqYuBvrKLZmj5SUW3DrjKWmb3sRYTx2slZkkA
        dO9GepjN7buI0Dnm+59bI7Qg1OrJmTb68g==
X-Google-Smtp-Source: AMsMyM6gBBNUVp6rvuxtFK1aKZjC0GE2FAYCGRUg1kW+ew0XvhKHeJ/5746jB2IXanQMFaChduhwLg==
X-Received: by 2002:a17:907:3ea4:b0:78e:25e2:c33b with SMTP id hs36-20020a1709073ea400b0078e25e2c33bmr21406101ejc.603.1667375654433;
        Wed, 02 Nov 2022 00:54:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ku11-20020a170907788b00b0073d84a321c8sm5045466ejc.166.2022.11.02.00.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 00:54:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/8] submodule--helper: drop "update --prefix <pfx>" for "-C <pfx> update"
Date:   Wed,  2 Nov 2022 08:54:04 +0100
Message-Id: <patch-7.8-77d4d5a6c09-20221102T074148Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 29a5e9e1ffe (submodule--helper update-clone: learn --init,
2022-03-04) we've been passing "-C <prefix>" from "git-submodule.sh"
whenever we pass "--prefix <prefix>", so the latter is redundant to
the former. Let's drop the "--prefix" option.

Suggested-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 4 +---
 git-submodule.sh            | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6bbefd34374..2012ad31d7f 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2642,9 +2642,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 			 N_("traverse submodules recursively")),
 		OPT_BOOL('N', "no-fetch", &opt.nofetch,
 			 N_("don't fetch new objects from the remote site")),
-		OPT_STRING(0, "prefix", &opt.prefix,
-			   N_("path"),
-			   N_("path into the working tree")),
 		OPT_SET_INT(0, "checkout", &opt.update_default,
 			N_("use the 'checkout' update strategy (default)"),
 			SM_UPDATE_CHECKOUT),
@@ -2700,6 +2697,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	}
 
 	opt.filter_options = &filter_options;
+	opt.prefix = prefix;
 
 	if (opt.update_default)
 		opt.update_strategy.type = opt.update_default;
diff --git a/git-submodule.sh b/git-submodule.sh
index d359f171379..9a50f2e9124 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -343,7 +343,6 @@ cmd_update()
 		${recursive:+--recursive} \
 		${init:+--init} \
 		${nofetch:+--no-fetch} \
-		${wt_prefix:+--prefix "$wt_prefix"} \
 		${rebase:+--rebase} \
 		${merge:+--merge} \
 		${checkout:+--checkout} \
-- 
2.38.0.1280.g8136eb6fab2

