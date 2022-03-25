Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9B6C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiCYTgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiCYTfg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:35:36 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE07A27AD41
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:23:48 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u3so12153887wrg.3
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4LwKVX9O1UplD/MnZKsWbyp150ysL7RwzJnUfZ/ZoJA=;
        b=kRXickC3PnWBO3JjpFG7gX3nvUG+6H7ClcgW8HQRtvIDZowbNPppY54fEElPcR0qke
         DpbgT8x5v49l1KZ4CngUeHIIqnVOT5qTlyIOnr7LENrpZoj4C55NwuI8aeXmEh19g88s
         WCRleI66Ltt8X4i2hBhqVuEw08TE7uu7/nnVhdv5MBpbNNmpIMxqZnUkgbB2JH4ELLQK
         tnrwiJWODwECSKxomYdOUcqlY/Yq7iwxQN79JkTymlICKlZGLaIvP/bSA3pUaT+eYMzg
         8nZ+xH2k6Q1r9rz7/lQAOtBOn/s0sIaKONlcifi8kJDEIKao8zBa/2OILJRg70XHAn5G
         UjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4LwKVX9O1UplD/MnZKsWbyp150ysL7RwzJnUfZ/ZoJA=;
        b=cTMMXUxeNWKpTB3hn95I4Lj/ApKN97oF/yo5wol+O0Olf29rmAUn0sk87ZYUdIWqXs
         W2p3VkxilI+HBMmzxFWbLAPJOMkw/3QB7VCjH8RrFpOBkfLqquCidOlX/z3SZ64aX/7+
         md3UPOgTQX2/rT+rSPwAQv3/sw2TqkGt+HnIHmaItWWc18VMI9uChnA/ueT9WwHXX+As
         q3vhd9hCqUoB9i8J0tDMWfzAZ24jdR2KIGAIRYA9iqEdT2I/W6hcgmUYvZORZygsp7ax
         1M/WIoqzoD7M3eDyjpaTUMfYrwUt12fPT6kfeugTcRlLRVfQRSMzbiDwowcckCFgisK6
         EoPg==
X-Gm-Message-State: AOAM5336Yo9dtjeBTXqofeu7VP5rFrb2PsAnV997QrtoQoJQB6TE8lrU
        VFY6OkUMXAfBt/04HfSb2whQIF++a/vMTw==
X-Google-Smtp-Source: ABdhPJy/2hvoEp2GYeQ7NCCucnvX88AjU8clxh2aR4bZL15nGhaZlsx/NBl9/17DsOQ3+YQTqOE4Ag==
X-Received: by 2002:adf:df8c:0:b0:203:e4f3:920 with SMTP id z12-20020adfdf8c000000b00203e4f30920mr10039021wrl.461.1648228772917;
        Fri, 25 Mar 2022 10:19:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/27] blame: use "goto cleanup" for cleanup_scoreboard()
Date:   Fri, 25 Mar 2022 18:18:26 +0100
Message-Id: <patch-v3-02.27-515bacc8f27-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend a freeing pattern added in 0906ac2b54b (blame: use changed-path
Bloom filters, 2020-04-16) to use a "goto cleanup", so that we can be
sure that we call cleanup_scoreboard().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/blame.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 8d15b68afc9..885b381ab83 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1167,7 +1167,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	if (!incremental)
 		setup_pager();
 	else
-		return 0;
+		goto cleanup;
 
 	blame_sort_final(&sb);
 
@@ -1201,6 +1201,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		printf("num commits: %d\n", sb.num_commits);
 	}
 
+cleanup:
 	cleanup_scoreboard(&sb);
 	return 0;
 }
-- 
2.35.1.1509.ge4eeb5bd39e

