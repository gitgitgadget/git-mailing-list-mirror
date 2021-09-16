Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DDDC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF1A6120E
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 10:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236631AbhIPKef (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 06:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbhIPKed (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 06:34:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA068C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:33:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id j1so4217856pjv.3
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 03:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dm16lt3N3la3Rsj8BnLp3eWLyTCyeeHI76VyVOgUN78=;
        b=OAP1eZbKvLKujTVg+NJtGS5u4iopfwqfngQTQkt3g85TI+LXdjmGokDOj2Ovr6RcUC
         bzmxRO4GKlYLOiDPhg4c4DVMl1jDWmcBz8eC3J7ap/qo/IM961JzsMTzJggOn9SghbBy
         0cLCFauX84on9HfBzO7FXdrWNH0DWHCyZGUK5hewAp+Zz2bHCbNsLORs8Sdn0iGwaEJi
         E9DNquFMRBt0O3XQrM3dTFfYBslSR9whafp3yA61dt+Cn9jXtwntukMJIDLDkurt64wz
         4CAHCBxjNkb9KdPg0wNkE1Fa6jtAu+9Xd9AK4BtI/nEInIOgg2ICsb/HA5d4PJUcKZB5
         emSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dm16lt3N3la3Rsj8BnLp3eWLyTCyeeHI76VyVOgUN78=;
        b=DvSf+5ww1rpeqAaGNbw50LWEMO5MnAZhx1TlEi0u5v7X048RfwMVRITePlSbh+3JPn
         fMXWRrxlbwQSr65eFtrOue08+7t/g9FQPW3Hm6HNNJ8xfM1uZwrvos1uaoSt0YPLb58/
         r5IWU30bxRIaH8HoxXjaQkSJdANbuG6dQw9Idu7N5uFtGNd2bo+ggDpWLZ7UfdCJC3/7
         ePeiN9wleRq6CSGM8EivEG/hYTcWOkVSgNmDMAktKeQ/Xyd/zFb+UVFC74WcnZUV5tro
         Yb+b/qqyzbiRW/KatO0kvx213FpJuQF5Li9KIUtofVPJCr5QKvXe/IDtqicQ7iHciSJi
         HuEA==
X-Gm-Message-State: AOAM533Tw1f0rvbUB/aAmAVCycWgJZmj8AMjJJcbLD1bO00VI95YIHy1
        gU7j4tRIXsgddTe3vFCaU7M=
X-Google-Smtp-Source: ABdhPJxxXE7zlCi2YaKys/j36xYKg+uXLKXxi11mYi43s+zvnSY5R82rv6BH05XCIRqlx+i59Jw7ng==
X-Received: by 2002:a17:902:6ac4:b0:13c:856f:9511 with SMTP id i4-20020a1709026ac400b0013c856f9511mr4240182plt.23.1631788393406;
        Thu, 16 Sep 2021 03:33:13 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.182])
        by smtp.gmail.com with ESMTPSA id c199sm2642605pfb.152.2021.09.16.03.33.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 03:33:13 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: [PATCH v2 3/8] submodule--helper: rename helpers for update-clone
Date:   Thu, 16 Sep 2021 16:02:36 +0530
Message-Id: <20210916103241.62376-4-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210916103241.62376-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
 <20210916103241.62376-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `update-clone` subcommand helpers that perform the parallel clone
and printing to stdout for shell script consumption, are renamed.

This lets us use the names `update_submodules()` and
`update_submodule()` for the helpers in the next patch, when we create
an `update` subcommand that does a full conversion.

We will get rid of these helpers in a cleanup patch at the end of this
series, when the `update-clone` command is no longer useful to us.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f6c4fc349b..b0336b0377 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2499,7 +2499,7 @@ static int do_run_update_procedure(struct update_data *ud)
 	return run_update_command(ud, subforce);
 }
 
-static void update_submodule(struct update_clone_data *ucd)
+static void update_clone_submodule(struct update_clone_data *ucd)
 {
 	fprintf(stdout, "dummy %s %d\t%s\n",
 		oid_to_hex(&ucd->oid),
@@ -2507,7 +2507,7 @@ static void update_submodule(struct update_clone_data *ucd)
 		ucd->sub->path);
 }
 
-static int update_submodules(struct submodule_update_clone *suc)
+static int update_clone_submodules(struct submodule_update_clone *suc)
 {
 	int i;
 
@@ -2528,7 +2528,7 @@ static int update_submodules(struct submodule_update_clone *suc)
 		return 1;
 
 	for (i = 0; i < suc->update_clone_nr; i++)
-		update_submodule(&suc->update_clone[i]);
+		update_clone_submodule(&suc->update_clone[i]);
 
 	return 0;
 }
@@ -2593,7 +2593,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	if (pathspec.nr)
 		suc.warn_if_uninitialized = 1;
 
-	return update_submodules(&suc);
+	return update_clone_submodules(&suc);
 }
 
 static int run_update_procedure(int argc, const char **argv, const char *prefix)
-- 
2.32.0

