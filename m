Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3231ECAAD4
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiHaXPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiHaXOy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:14:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EBFBF8
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b16so12501362wru.7
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=o0gld5eRk48ZnzQWDrnNIcWWdmLkaozT9ViqvnlbBqM=;
        b=hQN1wMO/rzNt07rMepX4fbAm+C1eCqMRztLt4dX8YEi/zWhoc8FWxm8+ZlGXkFrY27
         vVmQIjEErc61wy2vo0fbir2H+pbCYuqVxL5Z5+S5o4YpijELhyMrr5E74GAu5XvULd1v
         hZBhuMorW0+12IZ2m1ByyCZy8gBDU6FOMt0CIl54X6LzRIchKx3g1E7grEHUh2OK+YFl
         Lby0T2oSENvXjqbmMx4hiCqHGd/lRZ7whKkoJpl6+tjz7/tj1jmpY44kcz2z3NFuOovL
         Vq153615Oe4YyTCLMCOMAvR/DVkzwsTzjAS/CEkS76HxgIQ2tCaXzfJkm2EvVOaXBYSS
         OwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=o0gld5eRk48ZnzQWDrnNIcWWdmLkaozT9ViqvnlbBqM=;
        b=RnEfxu80S/ILDs2O9WE9EkykiVsie/AIFc9/Yec+gznhCaSfHa3iWBtGwW8iYKai4w
         kqcijLs+n6AiFdsFuMztJPD7teOi7JHkBkZtJQwnmIPGNuFCHscPT3Wsg5XIq45yyUXz
         cmF+rduVE58st2qDhQREaPjP4+BQRCNbbaRUneP932hxSVfLaMFTvhTyTNd6p2NB4QYN
         ZliP+1Q926J1aOEheAdsOFx9MP7NApgeJxzV0s24wHMhEvyDqbyrvEWarWSQnKuDJWKc
         adqia7dp1lLRC/W/ivm8N1Vwwc3KF63td/lpTnJSltBhW1TUqN3XqP5aiplzaHq3j1an
         TG2g==
X-Gm-Message-State: ACgBeo1ztR7dh83lIjk5sczgltj+RKuD9VIhQhjbsrtzaGEk7OBj6asR
        yt8SWEFSa3bcnQUC0pk/ALeKiBVthxj/qg==
X-Google-Smtp-Source: AA6agR7CLD6TN+/grnKvcPJkiAwtakdKleEvx4rxS6DnE0cuBIVKii861dC5saRb/OEja9iuatmkDA==
X-Received: by 2002:a5d:5272:0:b0:226:eedb:ee59 with SMTP id l18-20020a5d5272000000b00226eedbee59mr2166510wrc.668.1661987684550;
        Wed, 31 Aug 2022 16:14:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c058e00b003a5ad7f6de2sm3484666wmd.15.2022.08.31.16.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:14:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 02/17] submodule--helper: fix trivial get_default_remote_submodule() leak
Date:   Thu,  1 Sep 2022 01:14:09 +0200
Message-Id: <patch-v7-02.17-104f0777d50-20220831T231003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak in code added in 1012a5cbc3f (submodule--helper
run-update-procedure: learn --remote, 2022-03-04), we need to free()
the xstrdup()'d string. This gets e.g. t/t7419-submodule-set-branch.sh
closer to passing under SANITIZE=leak.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2e042c8a043..b51a5074b42 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2451,6 +2451,8 @@ static int update_submodule(struct update_data *update_data)
 			return code;
 		remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
 
+		free(remote_name);
+
 		if (!update_data->nofetch) {
 			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
 					      0, NULL))
-- 
2.37.3.1420.g76f8a3d556c

