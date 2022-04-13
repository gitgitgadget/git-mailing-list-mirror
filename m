Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79B2C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbiDMUEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237901AbiDMUEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:25 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD5D7B10B
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i82-20020a1c3b55000000b0038ccb70e239so49851wma.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nesxkZYZ/0PBEoIKbE3RBattmraU2kVADCWpgCIQW5A=;
        b=HtuZElzxr5jfgaZwOQGkiaSI8bQaSzRN5UeWumzQumctnbC97/1LPOtCLX4pjjbLTb
         E6vKcBTYnMowrTUM894FIeFiEmm8GRApSXm+JQ/t9g6h3G89HrQe2eehTJyURnkVBM3z
         7W6+Y036JlULM1S/Dj/25oZjRbpltRA2r0TrvkZZo1r0hFBRXLdPCYPKXpUYRB3RazzM
         c93jmXrfeEXZL6RbemIdMRL6n2bJV/0OljRUpQnX8r8FyJySPJ8eLxUIegHOh6vLLhwD
         Nj9A4iGFN5duyVDTTtr0N5w1+wFO9Kxg0h1ueDRDVngQ5JCuNDBLxuZ1yC5eo+q6zhDY
         oXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nesxkZYZ/0PBEoIKbE3RBattmraU2kVADCWpgCIQW5A=;
        b=mYsJKRNGamF9kMn175/3rbD38ZE4XVME3b2il2ZrTG00wWLlbmU5vtLsrz24JgR7sh
         GQ5+y0YuKNcOal7/ZEsPKazKVxJCb9e+mgLQZmG8fIAIYo5pYBHzYkKJif9zQ/MBIlRu
         A/ZXF3uotOOytHRBsjplFQuwbd9DN5oZCYaxWrLf/MDzNZ4D3kc5yaN3fgiAh85sRwPO
         gBbsjcMs8ysmDONz07V6tozPc7Arv//rAi4Qk/EVN0sZEFtpoUAyk7jNl9fsBqoeQEm6
         rToAIUUOlpKrTryLoOVj2W1RZDoW+PLOLroZluqBuJ+tDdiKCTe4DxMgD66DXqBYEuO5
         fzEA==
X-Gm-Message-State: AOAM531tKS8U4aoX2NQXon6LnWrhnsTftx/1EQBxhjr+8jHwSw/ZR+oU
        j+oYD1h3jSrqwW+0ZJf9NAhkNc/xiHr0fw==
X-Google-Smtp-Source: ABdhPJyzBeTNhoswiflN5FN/ubPn0cH35OViNzH4Fz4OZvOf6YQJFt77EyZDiz/uXNt6x/HfWwP0Ew==
X-Received: by 2002:a05:600c:4e4d:b0:38f:11ed:595 with SMTP id e13-20020a05600c4e4d00b0038f11ed0595mr326737wmq.64.1649880122257;
        Wed, 13 Apr 2022 13:02:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:02:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 02/27] blame: use "goto cleanup" for cleanup_scoreboard()
Date:   Wed, 13 Apr 2022 22:01:31 +0200
Message-Id: <patch-v6-02.27-c2dcdfab458-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
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
2.36.0.rc2.843.g193535c2aa7

