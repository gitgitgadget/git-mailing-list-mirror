Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048D7CCA483
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbiGSUsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240249AbiGSUrx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:53 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E0D5A88C
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:46 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso79539wma.2
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6cVFMwe7+NsCTCf9AID9XAVEeLHQG/Mz7falO7OgEBg=;
        b=jgHvV1gQyd+ObRXw/EMVRHyTP7h2Bwh/U33Fv5Zk9d/yTDpR8Comafa+VcaB01HDtv
         41YtSN+JY8qU32olXWnKkmq5BDMYZaaipHn7JRsaTnEJAQXyBJOgu+wnCnfc+IwOnSNo
         8uNw+TrRZ1C9NtV79oEh1sJWnUgXEU3f4N1ioy0zfYi4kULbfO38twdL+6UexW/E3gWB
         5UZWOxQXphZciYJK+Dw/jn4F5Xyi1kM1XARFPOsSJtdIGiFIv3lCchFaa+H9S/J0NAbj
         8l4gD1Ef3AXb1nb1PtRGfb/s3AnrU5SuWtPbmeUOwLchmz/A4f9jYma9eePHNkeK9+36
         kaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6cVFMwe7+NsCTCf9AID9XAVEeLHQG/Mz7falO7OgEBg=;
        b=sNVAC0IqoI1InDLOvlhgzigw5JzGREODCDcCCnXvwbAEatECMlIrYo51cjq3lkwtS1
         5dj3CKDxTjQI/4rt3FCFiFn6+xZu/DbtWJYVzJp6gKUOI3hRqH5D3tCOW265xWt6LM81
         MiEg3WNvKZ1QLS/0i9U7f4XcGHnub7mBg7PrxcILot6d1k+3DdfPQGWGNP+p/S1N6tH7
         LVgtf84dsU4IFX/VFsvG/ehmLVKhZOQWwCZ3/aS2WgLUMxS9+qnQN8KJpEnuuPe4Kl68
         Wz5N/GIq+rTVvrRdsf10ynyJT/ZTo5UyslJt12pThtcvhbwwtpxfsR2xsxzAGBU33nrZ
         50zw==
X-Gm-Message-State: AJIora9/dMUHwmsiSt/47keh0rcQYSwMGCJ/PbW3vo1tKgd3Ie2fynEz
        LbliyDhgbES4smBLXLDWBLjj7xsMl6sWoQ==
X-Google-Smtp-Source: AGRyM1th5HGc4qRXepzJFlP2mvtvxPQ0vvRrbvuE0OddmVy8C6F/zcsT/8tYPh8eE8El/v2JN7owSw==
X-Received: by 2002:a05:600c:4e0d:b0:3a3:bc7:e9ec with SMTP id b13-20020a05600c4e0d00b003a30bc7e9ecmr885959wmq.167.1658263664094;
        Tue, 19 Jul 2022 13:47:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 19/24] submodule--helper: rename "int res" to "int ret"
Date:   Tue, 19 Jul 2022 22:47:10 +0200
Message-Id: <patch-v2-19.24-cf0c8851954-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the "res" variable added in b3c5f5cb048 (submodule: move core
cmd_update() logic to C, 2022-03-15) to "ret", which is the convention
in the rest of this file. Subsequent commits will change this code to
a "goto cleanup" pattern, let's have the post image look consistent
with the rest.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index dc27e28e98c..900f89f549d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2587,7 +2587,7 @@ static int update_submodule(struct update_data *update_data)
 	if (update_data->recursive) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		struct update_data next = *update_data;
-		int res;
+		int ret;
 
 		next.prefix = NULL;
 		oidcpy(&next.oid, null_oid());
@@ -2599,14 +2599,14 @@ static int update_submodule(struct update_data *update_data)
 		update_data_to_args(&next, &cp.args);
 
 		/* die() if child process die()'d */
-		res = run_command(&cp);
-		if (!res)
+		ret = run_command(&cp);
+		if (!ret)
 			return 0;
 		die_message(_("Failed to recurse into submodule path '%s'"),
 			    update_data->displaypath);
-		if (res == 128)
-			exit(res);
-		else if (res)
+		if (ret == 128)
+			exit(ret);
+		else if (ret)
 			return 1;
 	}
 
-- 
2.37.1.1062.g385eac7fccf

