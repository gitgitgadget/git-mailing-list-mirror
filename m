Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EF3C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D076610FE
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245403AbhIGMBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245377AbhIGMBM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:01:12 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AE3C061757
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 05:00:06 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c17so9725039pgc.0
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 05:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dm16lt3N3la3Rsj8BnLp3eWLyTCyeeHI76VyVOgUN78=;
        b=VbOFMDyBzs0OyvQOM69OhsHvzFE5uctnKeOykmld+2YPcuwLyBdwg+MLdB0Usn31B5
         0yOATuX1nFUu+njKRXBwjYHuWG66LkIUFISoTD2RUuEt/QIW1spoSbMC6xwNre7afDby
         dtq/mtdQKkAe7GfhB1GuqDzkmaJ6PLfnoZNLWZ9nSXkt8njKGyFBaSYdoFXg77XpHJuP
         gMqANW8e6Gd3b2JhOlAKG5Yyx+7pwYAut8cUauVcM6/0yvXXO7DpdzT6jVFSAl7ftz8H
         jOripbGN+9TxDC7q8ViFFHI+s4jIzCslrXrf3LJyCSJtEmAfUiDad9IIh1YJzyEXSZNt
         7EKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dm16lt3N3la3Rsj8BnLp3eWLyTCyeeHI76VyVOgUN78=;
        b=DqxFKrnNXW6GiU3xbKzajpQLnq8xf1ooK6Xv2BmK9mxYtZ1bbZ1rGvdUzoZC6ff0xE
         iT4md398HJOA5QMZi5dPRmFMfSDKY8Q6IwefRt1O03dtLsY8PB0XQ58hW/41YK4mmVID
         4ozHONufmcnCiG4riNYUR2J9ZsGznBaGFx/MEq5nGwzhWvM/H6K5XQ2MqGwTbLoSfSba
         e+FYjpRwBl6GE+Ra6AU8XIw4TCVKicpJhex5H4PoNKoKUs3l3E95ajynFBYRm9Spu9QZ
         lxMHSldkX5AnVS4GmK5J5XBgLejkmQzl417qzLvs6Ajcg3wWxYiaZHN7a2gOkX8RHIlv
         8r7g==
X-Gm-Message-State: AOAM532Ede6FoxUnWB0+rEdwaNtgj2BT46R/vNoXo6aJL4WHYLDWWc+B
        e6ME2h3y9bkPe15q9ldKnT62uKnjvpI=
X-Google-Smtp-Source: ABdhPJyf0eAxZlHpj7rLTXWA0hA+JNqAkhULAX7OZSRJvxlz14URSEG9niY70Yr1xxhHoskC/LzWkw==
X-Received: by 2002:a63:33cb:: with SMTP id z194mr16528807pgz.380.1631016005625;
        Tue, 07 Sep 2021 05:00:05 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id a142sm11248150pfd.172.2021.09.07.05.00.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 05:00:05 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, emilyshaffer@google.com,
        gitster@pobox.com, jrnieder@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, periperidip@gmail.com, avarab@gmail.com,
        Atharva Raykar <raykar.ath@gmail.com>
Subject: [PATCH 04/13] submodule--helper: rename helpers for update-clone
Date:   Tue,  7 Sep 2021 17:29:23 +0530
Message-Id: <20210907115932.36068-5-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210907115932.36068-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
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

