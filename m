Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C8FC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiGUTPJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbiGUTO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:14:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F928D5E9
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p26-20020a1c545a000000b003a2fb7c1274so3920102wmi.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aqWlHNlN2hfcBaap+tKLkkWT1gjuPPB+lAQMe+hl1D4=;
        b=A6MCq04YFjCZgFFFDq9EJDaF314qtxXgvZzNGp5nfAMWnitDT6M2faBx0XfauvCVqa
         vL2TPWoLm0LAfU5ebo7kVHGxWamIMRWPczGPEQ3zrL8/CbSd1G/8JvqtF3u3A9Fp0Os7
         S6R+kBbCAjm9JFH9uvHR1YJSCkoJxKEf8+FjX5USb5U2Ex1rqvQ71pEnDvzrSCwirSf3
         G5h3oB/ejJ3GI+w/pobOc4rIBdxYPT4O3ZCOiLLW8nJTuw5daC4iyqcgqZL+flPmcw24
         crllwM4ymsADWlyYnH5YfrslmjsXklu1hWuHdQTR+SuBCejSXbCv4Xya9f0fBRZokwR3
         diKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aqWlHNlN2hfcBaap+tKLkkWT1gjuPPB+lAQMe+hl1D4=;
        b=vDJUlkZsdhoYOK8NNQpncU/6gxM4i5JJBLFblUMsr2DrymB3GOxD2Mykp8+vwOth66
         Y2Zx9ukW6BwX1q3EfCcgeh/bdJYQKOVqeXB7w4j7z4LNEZQExgrEqqObYEOhjCLDI0HB
         69sW6R9cL45CXrxMj2VsnCKN2H/V6RztsPrpTRLCdPNJicJESk9TtqDOW7JAPyTQx4pB
         DYKsYla716cww7qInNZ4Hx7n0uZyoWvpg2neX/IJ4+smt9NXUMN3rhpV9XSl5OKdtlZA
         /JFjrqsRaZBhmIiZJ5fyMf9I530llyw85HzfuHV+o+pDPVN+9sh1eJQ9UgMUDkkYrDlJ
         OESQ==
X-Gm-Message-State: AJIora8YIyawEnRIjg2y7RKR0tgN94Q/Ga9TQ4PyS5CHph+7/oBopVOT
        Yh3YnBenFk0yIQ+8wN4K67Ywvp2kDlQKyQ==
X-Google-Smtp-Source: AGRyM1v5i+ira/N8dLqctN314ce+bWsTWzCmi8jNR34tMRVCM+2QLJYsqcSLv58IOfwJrvWTQ7dg/g==
X-Received: by 2002:a05:600c:4f05:b0:3a3:18ed:6cda with SMTP id l5-20020a05600c4f0500b003a318ed6cdamr9754277wmq.34.1658430857885;
        Thu, 21 Jul 2022 12:14:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:14:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 21/26] submodule--helper: rename "int res" to "int ret"
Date:   Thu, 21 Jul 2022 21:13:17 +0200
Message-Id: <patch-v3-21.26-4fb17f0dff1-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
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
index 378f85e37fa..94eec34c595 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2588,7 +2588,7 @@ static int update_submodule(struct update_data *update_data)
 	if (update_data->recursive) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		struct update_data next = *update_data;
-		int res;
+		int ret;
 
 		next.prefix = NULL;
 		oidcpy(&next.oid, null_oid());
@@ -2600,14 +2600,14 @@ static int update_submodule(struct update_data *update_data)
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
2.37.1.1095.g0bd6f54ba8a

