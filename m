Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FDDC19F28
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbiHBPrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237001AbiHBPrC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:47:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948962655D
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z12so8296343wrs.9
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zx7/zJHy5u6GAYACiB9EAPicbrOagBHOmgAdJUjKydo=;
        b=AFfr4f3NLAl7xw0/JBa2O38aLYY+ILIZ96uJI8pxHWlX1TSh2g7zWmjZxRWCh01HT3
         vSmp+AtIASyIEsd5t96slCD08FAzs0MtmqNMEx0iE9cVRhgBABZobrlqaQFJqWDijjJB
         znkfhf/Elop6ADXsTpGmI0Al1/MF9p6qf4S1bksRHZEn6hmlLafMG4mdRHbZT4ddKS1A
         w1eI7p6oRkJ5x6HqlVUi6EGOUt1J5SV6lvfwjuvBRaaWvdVOLXwbFH0tgOl74o2Bmr7Q
         0r4idN6I1FheANyk4qGcIAFLwFA40VVoDF0uqR9wj0dxWxjFbtVi4Odoy3oFhSo9+i3S
         gPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zx7/zJHy5u6GAYACiB9EAPicbrOagBHOmgAdJUjKydo=;
        b=BHC5EWZFLsRiogNWNPybku4W2/XBZl27RX0j0Vu8oVkZUXzhQmE5hS1l9Yz0+jrIPw
         C8xRvasOGb0re49CUdrQNinrLY2R++87mxtsMwvfid2u33zTMzNBOiF/d96v1qyIa7+Z
         TM+CWVBhXIYM+fvfDQ6HJipXU/mbNljLneJCuPJm86a0bQ2mGUemTCAiz7FvOFZ5vy3K
         +VkvqujXTBluVwpKb5pZPthCizZ44kC+SjL/ZEyvOGtsiWQCF7/Tj/GirBS6iwDzFxw/
         pKUmSQbcPGfWElxwK4TQuzfQ1Cbi4sgLAqwsGPg0ibZo/84APJ5FIJ66bevl+TqyH7jQ
         rVKA==
X-Gm-Message-State: ACgBeo2kAOE9WosO9Q6ry4VQST2ymE0wPAAG2yeqInvMUc3mOQxteWRz
        dhULrSe2inuGB+xfbFtVatKCEWwyCshAZg==
X-Google-Smtp-Source: AA6agR72/xHTN4uT+ZvuXi2MOYG2Giq/iqAIdI2PHpcBm3RGka9hUnQ72Tp4ykDNRywikppfw1U94g==
X-Received: by 2002:a5d:5955:0:b0:21e:98d2:bd92 with SMTP id e21-20020a5d5955000000b0021e98d2bd92mr13482264wri.547.1659455196834;
        Tue, 02 Aug 2022 08:46:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 20/28] submodule--helper: add missing braces to "else" arm
Date:   Tue,  2 Aug 2022 17:46:04 +0200
Message-Id: <patch-v2-20.28-70f030cca4e-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing braces to an "else" arm in init_submodule(), this
stylistic change makes this code conform to the CodingGuidelines, and
makes a subsequent commit smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0fb780a724c..955deb375ee 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -480,8 +480,9 @@ static void init_submodule(const char *path, const char *prefix,
 			fprintf(stderr, _("warning: command update mode suggested for submodule '%s'\n"),
 				sub->name);
 			upd = xstrdup("none");
-		} else
+		} else {
 			upd = xstrdup(submodule_strategy_to_string(&sub->update_strategy));
+		}
 
 		if (git_config_set_gently(sb.buf, upd))
 			die(_("Failed to register update mode for submodule path '%s'"), displaypath);
-- 
2.37.1.1233.ge8b09efaedc

