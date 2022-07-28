Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C627EC19F2C
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiG1QRe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiG1QRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:17:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8436FA38
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:14 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d8so2848349wrp.6
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=f8ggMpTc7Q8B5tQBrqpLfWC+RYna49F/8V+/K45pQk4=;
        b=VLywTTlWwt+poRNPgrtsbRvsKUzfExTwPzK1MePd9pzyNv0ozPLA4keYAMAHk15ZLD
         EqALTnlo66sBmfQcentV62xhteblnhgqcsPQOmEGFffQxGC49KioyYII3ltHiXm72o1b
         9rLr/r++iS6MC4dG0HXB7c+US4wM78V77R8RD9hoUb8W/MgkUPhXmCZtn/vWaLi+PX8Y
         8j0kiDbN1FHC0p1timAGZWtR6lRV2IxszL8icDfKxfrBAuIgIvCvWQ310/bKXeG2GWuI
         AZxrjGw44TXgyKvtp1U/IvG7pGOfFpavk1oeKUCgEHcPazim8KC0Jz8MdQAIMEhqNUbN
         IV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=f8ggMpTc7Q8B5tQBrqpLfWC+RYna49F/8V+/K45pQk4=;
        b=eedXBH1oJEgdjCOq5E39N6c1GtPojOcA1Rtmr7QiAgztb83sRqnq4ByFUITLZtiC5F
         rN4r7r6FZACsJKrqFMX7lE3ISqqEyiG9EjHr+ZX6RpKYSpwY254AhYwFJVBIJ/MCbXLO
         eSDj1/pQMYwL7bebIl5WRmctbIeJO/JTN97tDSzmBf9uGd/eJQ5dBEPbxIG6V7j+EogB
         j3C293gDHzB/c659/V1+9U2dpSubI8P19tmxpg23i2xvabH5Kb3Pvfj7JOuNVn1wsPxm
         nD9i4UNZycEwkWKw6vl1HnAi+yh+11cI2Wvl8QFElOVXlaEtyzuejsV+1Vv7kjEiZedR
         +1XQ==
X-Gm-Message-State: AJIora83GH5ykLNSNuwZlHyvXRDCv4xVr3XtKxg21cmaRpC4UpBO3mkj
        2GXZ9CNmyIHcLDuiWqGti/cofrSF7mviRg==
X-Google-Smtp-Source: AGRyM1s/XMeEf0f9JNQ/5w3mAM98Oke2Tuw4Fuv7ZUXvt4/L7WCXJoClbWSBNwM49+h2qGdTR2aK6w==
X-Received: by 2002:a5d:456c:0:b0:21e:40f5:aaef with SMTP id a12-20020a5d456c000000b0021e40f5aaefmr18154381wrc.396.1659025032676;
        Thu, 28 Jul 2022 09:17:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm1220117wro.91.2022.07.28.09.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:17:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/20] submodule--helper: remove unused "name" helper
Date:   Thu, 28 Jul 2022 18:16:48 +0200
Message-Id: <patch-03.20-7aa9c14251b-20220728T161116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1167.g38fda70d8c4
In-Reply-To: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "name" helper has not been used since e83e3333b57 (submodule: port
submodule subcommand 'summary' from shell to C, 2020-08-13).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fac52ade5e1..ac2553ba9d3 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -771,24 +771,6 @@ static int module_status(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int module_name(int argc, const char **argv, const char *prefix)
-{
-	const struct submodule *sub;
-
-	if (argc != 2)
-		usage(_("git submodule--helper name <path>"));
-
-	sub = submodule_from_path(the_repository, null_oid(), argv[1]);
-
-	if (!sub)
-		die(_("no submodule mapping found in .gitmodules for path '%s'"),
-		    argv[1]);
-
-	printf("%s\n", sub->name);
-
-	return 0;
-}
-
 struct module_cb {
 	unsigned int mod_src;
 	unsigned int mod_dst;
@@ -3359,7 +3341,6 @@ struct cmd_struct {
 
 static struct cmd_struct commands[] = {
 	{"list", module_list, 0},
-	{"name", module_name, 0},
 	{"clone", module_clone, SUPPORT_SUPER_PREFIX},
 	{"add", module_add, 0},
 	{"update", module_update, SUPPORT_SUPER_PREFIX},
-- 
2.37.1.1167.g38fda70d8c4

