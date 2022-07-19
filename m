Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2838C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbiGSUsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbiGSUr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D7B5C9DF
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bk26so23337406wrb.11
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZBrW404BmB8jf3qLGo5zxITbgtiLCs5gEcFs/saT74=;
        b=h1mxb/EeZbdNUgJ9gIICZZNo+KyR3NMCHWCc5WLIGjhaW0e6XTz2MX1Ji646LU4QKk
         EocoxfbIo1lDeEmgW0Kcwhde2hCGFFVdwq8amfrZb76NrmrYwBugBUHxBIcJ9TPqH8ef
         or9PVYdVVwfc1bc6ZwDZ71slTu2j8SZI5qaWbkHarwWNAV624uYuSAeaoCMUNJTP6OLF
         kK1L8pmG58pjdi0iNKirpVydV/uD9ETQ9rVzarJBU1S4Obab5t6sgZOvaRBn4U/MBEfP
         +uyXSc9DYoWSwsG45QpfQWoigAppmpLb4r8cU2w3xU1KaAnAXS8FG5Fo4V5jiL5FERvW
         dm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZBrW404BmB8jf3qLGo5zxITbgtiLCs5gEcFs/saT74=;
        b=MCLIqAroijg910fNikmbfDICa2qrYsZRqm3DvrN93FVaEsl1SFaFN1Lajlc71b/lnl
         w+dSeHNfWI9iixkSwE5GTuddmNL/ZkfDeePUuA+i12I4TRPWuRkmNG6gxIum3XM+6fqF
         2bwPTBFcuayTY0n2OyzGrXiAPn5Q+U0yIGMMilKd9hmEWUiEvIS2DgvMz7I5Hgojd1GX
         lbW7kxcVanigXBTDouSI3uKMzosG9HOd1buPiZriAmv2nGKOHWipeiKkc4HIMHH0coFP
         IrzI5pIYJQ3FII3dAOYoy20B+Fi4t0C3uHf2HqKELCVQm5fKYtZ6fQQ1GbFZiB0y2lki
         crNg==
X-Gm-Message-State: AJIora/xw0CRHMMz3tfjN2+IAdTgbiAfKZ7BJg4WQnPCbIm7+11oIyNz
        Yg6j6c90UibjYoC37RbFNM50gocX+INz3Q==
X-Google-Smtp-Source: AGRyM1uOWhDEN3MJ0H5J9E7bjWqbfuGGxZ+ogf9TEvo8sQiKP3sq5DFA1bBFv2N4HzlhyJj93vIC9Q==
X-Received: by 2002:a05:6000:2c6:b0:21d:be55:d311 with SMTP id o6-20020a05600002c600b0021dbe55d311mr26608512wry.154.1658263667338;
        Tue, 19 Jul 2022 13:47:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 22/24] submodule--helper: free rest of "displaypath" in "struct update_data"
Date:   Tue, 19 Jul 2022 22:47:13 +0200
Message-Id: <patch-v2-22.24-a2168cf1378-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 707c5027961..37d414258cc 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2550,10 +2550,11 @@ static int update_submodule(struct update_data *update_data,
 			    int *must_die_on_failure)
 {
 	int ret;
+	char *to_free, *restore = update_data->displaypath;
 
 	ensure_core_worktree(update_data->sm_path);
 
-	update_data->displaypath = get_submodule_displaypath(
+	update_data->displaypath = to_free = get_submodule_displaypath(
 		update_data->sm_path, update_data->prefix);
 
 	determine_submodule_update_strategy(the_repository, update_data->just_cloned,
@@ -2627,6 +2628,9 @@ static int update_submodule(struct update_data *update_data,
 
 	ret = 0;
 cleanup:
+	free(to_free);
+	update_data->displaypath = restore;
+
 	return ret;
 }
 
-- 
2.37.1.1062.g385eac7fccf

