Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79759C43217
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbiKHOL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbiKHOLN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:11:13 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BED377238
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:10:58 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id n12so38843176eja.11
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 06:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKoIN2MpvZAeXL7eqCrXaWpvINCaarh4oWrg9C2pHCE=;
        b=DqZBzyeoZCGaKpLGWw/ObN1UzSoWbmPf6AbnUT/2mJWm9OEdoJx/zDSBgcyyigBrOP
         emkS1zV68qyojJVBZVVNZ/YeTvJCTfLn49t4G/uob9DGJNibp+5CbW5aTPPwE/mJuLjy
         FS3xYHnUhRv4024rGsLJSE4D8shJUdetIW/w4nwJS3dP/7OtnEPIx2i/8INO1bAPGFGP
         YSwfpw6AVa8pQoUScJCz9PyMLpWKLm1Cr8aHxHXHdzCcMwDsRht5JAOijn/KWSrX9CB3
         w4xAM3UbtUT+IbOQHAEWS9jpRjg2XAnvHyTMvbr5SjixZziJMjQ0DYpo2lfkm8DANQCi
         Sj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKoIN2MpvZAeXL7eqCrXaWpvINCaarh4oWrg9C2pHCE=;
        b=RnxvtrXdZt8YSEkk/7ziu9nDkRymyO/WUXTVkfh84AlX+8DomTk5IEkjydSxRZJBsV
         J3SZbfN/VaaIoGmSfUtkrv30L8Ml9AtCH2RH7I/XFCt/BxvVHLmhVT6aqeu87NQk4izi
         JzM+aVmuT52/1HGIfbPEzuvVZmNW7cUXOs+QoI1OvCRV/ygVuK/6rFlGVeAH0H+Yu1c8
         qXpjrM7gBq1y/iPYsdGRpodw+Yde2A3kEIzKKuXxpGx0HUx49b5cdx4Q39MfrcdnkwgB
         BGCXQilXsE2OBDLp96/r890AVyCBAIH32wESCAvrGW4wuwxtjgvahFNSJjM5QfYKT2F7
         UPFg==
X-Gm-Message-State: ACrzQf3eVONHU/DZ91Gmi50zjmwb3kTmRDIGCgenmdUGwsdMtU/7Zm84
        VMnnJ2hRdqTmWM73xSEStU3O2OZ1iHKf1w==
X-Google-Smtp-Source: AMsMyM5ts3oqkeP5q2RGCd2j9tjXJFP78PRVqpEztNrZiHSwdm9Of86G9zHReRz6yAPgopnEBN+avg==
X-Received: by 2002:a17:906:eb09:b0:7ad:d271:e5aa with SMTP id mb9-20020a170906eb0900b007add271e5aamr46159108ejb.182.1667916656663;
        Tue, 08 Nov 2022 06:10:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a16-20020a170906369000b0078d9c2c8250sm4683666ejc.84.2022.11.08.06.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:10:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 8/9] submodule--helper: drop "update --prefix <pfx>" for "-C <pfx> update"
Date:   Tue,  8 Nov 2022 15:10:39 +0100
Message-Id: <patch-v2-8.9-ac9ff05ef68-20221108T140501Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
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
index fefedcf8097..03d1b58acaa 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2643,9 +2643,6 @@ static int module_update(int argc, const char **argv, const char *prefix)
 			 N_("traverse submodules recursively")),
 		OPT_BOOL('N', "no-fetch", &opt.nofetch,
 			 N_("don't fetch new objects from the remote site")),
-		OPT_STRING(0, "prefix", &opt.prefix,
-			   N_("path"),
-			   N_("path into the working tree")),
 		OPT_SET_INT(0, "checkout", &opt.update_default,
 			N_("use the 'checkout' update strategy (default)"),
 			SM_UPDATE_CHECKOUT),
@@ -2701,6 +2698,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
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
2.38.0.1464.gea6794aacbc

