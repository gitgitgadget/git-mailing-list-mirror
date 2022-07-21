Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5B4C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiGUTOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiGUTOT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:14:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193998E1F4
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id k11so3161807wrx.5
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3RNlS1TR4hBewdyukg+RzozAukrveUc4ncZ7hug1a3Q=;
        b=LhjmClWdd1bfHaHtUca8XaS9Ct0z39JeZgPVhfX7Vjd2rRDDFkslLXQIRjqQjI4bMY
         Ihp3uDgTGgRyPgdrl/WKtJ3DeK91Zz+TD3s/hOUf2fMkXj57A5Wi3j0McvOOYUKiCZoc
         w/zd14F09dD9b8Jl6zBm++mVFSvCLINVlLArXF1MmstDF9sT+hWwaSXj+/ohd0oLFKHi
         f4j+sXH0bp+6ZqkybJPvz8R9GGEyCXYKcN4RzYrb9J3MvfMzEEXwQvwuHsdjXaMNpRsu
         lXnzphxHwGnYRjf7Jx2kiFZ4wkQ/v8klFSjt3uwblh+I9tBvTzoRijpuzkYwBa9zA555
         NkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3RNlS1TR4hBewdyukg+RzozAukrveUc4ncZ7hug1a3Q=;
        b=xtZTJSaqsLeFGcmqWJIKf28HPlUscujEAgA03DEGzG0/AmqjNWWFw8U/DNsujL+Lhw
         vf53ZqZs4BttHMyi+CR9cbd3dNKvSH0f8uQGjw4lAIlHQJLNbuZp8MgFI9hW/trvzeHJ
         16A7t7s16zBfhlsynvtnPusU2hDJLM/2eOWgCIUiry4KuE6W6SORkoYOoVu+SUP8ln4m
         cyYai9uaDdgh+hcRZ/13EO3kc29hTJAvrdANCiqHq9i5LnbHRk0Y4Lqy8DJGpIuMIGVz
         27IzyBTkrKfRB7V+GmG3uz89O5naxxCPtP5Kaf3SSsrTegr5jdrx3nbIXUFYYMMsLlNm
         CfIQ==
X-Gm-Message-State: AJIora+2YPyzJ+XKk+z8P7D+U+KYCrCdlFZzfY4NZB/MeO7lCjoaBdoq
        JVLWQvM4piRHVgwiky4k/IpCzFcFRb9p/Q==
X-Google-Smtp-Source: AGRyM1tAAE/cE0gZTL5pLumK4CKmgqbfOVZqbAeNmCBDpQbagdH6RWdwhRX1ve7+dQKmz6dl58+PBw==
X-Received: by 2002:adf:f548:0:b0:21e:4348:3991 with SMTP id j8-20020adff548000000b0021e43483991mr10290306wrp.130.1658430851184;
        Thu, 21 Jul 2022 12:14:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:14:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 18/26] submodule--helper: fix a leak in module_add()
Date:   Thu, 21 Jul 2022 21:13:14 +0200
Message-Id: <patch-v3-18.26-01566d63926-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak in module_path(), since a6226fd772b (submodule--helper:
convert the bulk of cmd_add() to C, 2021-08-10), we've been freeing
add_data.sm_path, but in this case we clobbered it, and didn't free
the value we clobbered.

This makes test 28 of "t/t7400-submodule-basic.sh" ("submodule add in
subdirectory") pass when we're compiled with SANITIZE=leak..

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 04b5141c0f9..0fb720d3a16 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3395,8 +3395,11 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	else
 		add_data.sm_path = xstrdup(argv[1]);
 
-	if (prefix && *prefix && !is_absolute_path(add_data.sm_path))
-		add_data.sm_path = xstrfmt("%s%s", prefix, add_data.sm_path);
+	if (prefix && *prefix && !is_absolute_path(add_data.sm_path)) {
+		char *sm_path = add_data.sm_path;
+		add_data.sm_path = xstrfmt("%s%s", prefix, sm_path);
+		free(sm_path);
+	}
 
 	if (starts_with_dot_dot_slash(add_data.repo) ||
 	    starts_with_dot_slash(add_data.repo)) {
-- 
2.37.1.1095.g0bd6f54ba8a

