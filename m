Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD0FECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiHaXQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiHaXPO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:15:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D311275B
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:15:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so425097wms.5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=l6vfCrlMMcS38yTxJXWM2QQyvGXQ4csCQID3UHfoRxc=;
        b=UuigeML0snWmPu30DrIrsTlxM5MgTYj6rLUcessrouzRpkvrfZKFDYEQd69ONygm8E
         HvKOU1BqoUq+t7/R7bCsBfDgtYVEW9Egpksm6w2IJMMYzRgetlnY0yLtVqlSeOF984IQ
         G5GY9hy7xe9D9wMzYmM7BisLjoX55pOhkJYHcetdDpdfXbUrbhi1vpDhi6YATFD0q6/k
         Q+9pY+L5v4PkUkYJ2VFLcbl2Tim9cH1wYlctp3+YxUOWwsZRHZYxRsb84YEVfRkuQkN4
         6yiPp6D/Wbr5o6onNo1/nbWdBmNYMQZtBZjVK1RG3qJxRd5bcoyq9D2e3c2sHDaOrQk6
         t5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=l6vfCrlMMcS38yTxJXWM2QQyvGXQ4csCQID3UHfoRxc=;
        b=Wnd+hE/KwSdvADcVHE93DJoes0Lfq5UWCx3tatgRT9d4WoXcGZsp0trK6tT9QT3icC
         YqtZb0VSWJJhrSY5IaPPz89kyGWrpcu8u3hbcP23UCYYDlB348ZOeC6nS2VMrds0J1mL
         /McHzFbjiJLYnKfJ+amtkBr0ZJk3VCrHcoKZuInVrFz6DJzHdBxLKodCMm3+1zVvyv3+
         vaAjovyF5i0Iuu7dxYctmzHWlMiSb/BG4MH9ywX9HXgy9DTuyf8YqE5itlCTqq2VS76i
         CE+SrVixwEODvJEWkzMRawv/m/2jI2Vg7cQYSbjU9heE5luG1E3jp7gUk9BOGoilqMh7
         KpTg==
X-Gm-Message-State: ACgBeo105pGz4Gt9DW22gTn+12pDzqrarYlD7GsFZhqJYphkYKS4jT3S
        U7K2uxk1wSxi9Qa30D4F5YghtnBukFpyHQ==
X-Google-Smtp-Source: AA6agR4y+M/csMcjUpAVw8/u96Jvtkz2kGKTgv3ZkVWU0NrQL6MG8MVbBgS8jarYHZapxxzo8cBvMw==
X-Received: by 2002:a1c:3584:0:b0:3a5:fb0e:102e with SMTP id c126-20020a1c3584000000b003a5fb0e102emr3405244wma.105.1661987700495;
        Wed, 31 Aug 2022 16:15:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c058e00b003a5ad7f6de2sm3484666wmd.15.2022.08.31.16.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:14:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 16/17] submodule--helper: free rest of "displaypath" in "struct update_data"
Date:   Thu,  1 Sep 2022 01:14:23 +0200
Message-Id: <patch-v7-16.17-63ff554e306-20220831T231003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
References: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak in code added in c51f8f94e5b (submodule--helper: run update
procedures from C, 2021-08-24), we clobber the "displaypath" member of
the passed-in "struct update_data" both so that die() messages in this
update_submodule() function itself can use it, and for the
run_update_procedure() called within this function.

Fix a leak in code added in 51f8f94e5b (submodule--helper: run update
procedures from C, 2021-08-24). We'd always clobber the old
"displaypath" member of the previously passed-in "struct update_data".

A better fix for this would be to remove the "displaypath" member from
the "struct update_data" entirely. Along with "oid", "suboid",
"just_cloned" and "sm_path" it's managing members that mainly need to
be passed between 1-3 stack frames of functions adjacent to this
code. But doing so would be a much larger change (I have it locally,
and fully untangling that in an incremental way is a 10 patch
journey).

So let's go for this much more isolated fix suggested by Glen. We
FREE_AND_NULL() the "update_data->displaypath", the "AND_NULL()" part
of that is needed due to the later "free(ud->displaypath)" in
"update_data_release()" introduced in the preceding commit

Moving ensure_core_worktree() out of update_submodule() may not be
strictly required, but in doing so we are left with the exact same
ordering as before, making this a smaller functional change.

Helped-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 94ebd8ea38e..1650bf0070b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2487,13 +2487,6 @@ static int update_submodule(struct update_data *update_data)
 {
 	int ret;
 
-	ret = ensure_core_worktree(update_data->sm_path);
-	if (ret)
-		return ret;
-
-	update_data->displaypath = get_submodule_displaypath(
-		update_data->sm_path, update_data->prefix);
-
 	ret = determine_submodule_update_strategy(the_repository,
 						  update_data->just_cloned,
 						  update_data->sm_path,
@@ -2599,7 +2592,15 @@ static int update_submodules(struct update_data *update_data)
 		update_data->just_cloned = ucd.just_cloned;
 		update_data->sm_path = ucd.sub->path;
 
+		code = ensure_core_worktree(update_data->sm_path);
+		if (code)
+			goto fail;
+
+		update_data->displaypath = get_submodule_displaypath(
+			update_data->sm_path, update_data->prefix);
 		code = update_submodule(update_data);
+		FREE_AND_NULL(update_data->displaypath);
+fail:
 		if (!code)
 			continue;
 		ret = code;
-- 
2.37.3.1420.g76f8a3d556c

