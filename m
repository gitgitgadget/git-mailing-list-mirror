Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD778C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiGUTPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiGUTOl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:14:41 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F838E4F2
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so3900647wmb.5
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2MN89kynP+OI7l+sbC7jW/yKXu8GTXx757i9WAu1IM0=;
        b=qkf/lGD8FuhoLZyCjhI/y6xx8+l1G9t9QZF/0swjXyQic6U6ajOFRubbQ5erwPX4zo
         71COtqkqnOZRyTibvDVb5Q47ruUgL5RzLR9aaGpjcijE5iOsT9gEvx7MdEAEeEZPIZXT
         GoWSvsnvJcMvpNs+mRaLjpZEui6hht2prebOJsNw3znMnBpNex0vNkR3C53tJ0VzSEkL
         mJ51kPenMQzOfMg8PTq+YMLBSUPhkpfBurrjuF0e//XT0htch1NEgaE4mKhIK0LCGBNh
         Iqxi9NhzEm/z5U49a7PxZ3hV6UQs+N1A7cXhd2pHXqrKOUT9UjIqyQwrsOG5Ul4fI5oT
         wWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2MN89kynP+OI7l+sbC7jW/yKXu8GTXx757i9WAu1IM0=;
        b=gqxHXsLcwV/rw46bE7sUR3iV9xFtQUmtXh4Pa+DFTb4CODTjftBfjd2B7BXRmfsu49
         Kt/maancixM6qXrYcel1NK8LVyeukC2bZvCn1ssxSbVK1cVfZvPcCZ0Xni+Qy0uErQhJ
         28GrSF3ox42TnzNs2+rNEgWifgb8Y8wSTTOrux7weTdgpZ/Qg3gnsvtVGksjW+gkKPDz
         mBGXRo8PhXGyvpMezOCyg0/6x8eellOjDqv2u0Kcj1Z1jCC0pVqNdbSzT1P/5fIXh063
         ZZa0qqZt7JrANbAoXhEcBq710ahRKNNvbB6h/7TzosJz+atgUJ378QK4dJTxuLLPKEQk
         ieFA==
X-Gm-Message-State: AJIora/e3Hushb2wxv+eR174bCuFcjCpp0KnXuCpZr2sNqWZ0WFywJRO
        I1Iz1gxdv9kut/E6oi6a2ys6cEimUZAg6w==
X-Google-Smtp-Source: AGRyM1vpYK+7Fchk97TzasMRKXWSjao234Ypu3PwbNPnrQpPhbVehgUahSXQuvyzNUamYe2CMB341A==
X-Received: by 2002:a05:600c:3510:b0:3a3:34e7:cff5 with SMTP id h16-20020a05600c351000b003a334e7cff5mr2770483wmq.191.1658430862895;
        Thu, 21 Jul 2022 12:14:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:14:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 24/26] submodule--helper: free rest of "displaypath" in "struct update_data"
Date:   Thu, 21 Jul 2022 21:13:20 +0200
Message-Id: <patch-v3-24.26-7551af195ad-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
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
index b65665105e7..4e70a74357c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2551,10 +2551,11 @@ static int update_submodule(struct update_data *update_data,
 			    int *must_die_on_failure)
 {
 	int ret = 1;
+	char *to_free, *restore = update_data->displaypath;
 
 	ensure_core_worktree(update_data->sm_path);
 
-	update_data->displaypath = get_submodule_displaypath(
+	update_data->displaypath = to_free = get_submodule_displaypath(
 		update_data->sm_path, update_data->prefix);
 
 	determine_submodule_update_strategy(the_repository, update_data->just_cloned,
@@ -2628,6 +2629,9 @@ static int update_submodule(struct update_data *update_data,
 
 	ret = 0;
 cleanup:
+	free(to_free);
+	update_data->displaypath = restore;
+
 	return ret;
 }
 
-- 
2.37.1.1095.g0bd6f54ba8a

