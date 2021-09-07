Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D57C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7AB61101
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 12:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343624AbhIGMBc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 08:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245624AbhIGMB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 08:01:27 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA960C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 05:00:16 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id i24so7975535pfo.12
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 05:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5adauTvnVvh5L89F33zikem2gwiUE10oaZXShzCuTNA=;
        b=abdicbJyY4cTxuUoJ2xQD/LMQu+Hn6/c5Gk6yxfSjY3GEgnY20LUr5j1X2QKbLQel0
         +JYWWZv6NF+z++HWlJDgZhl9MGg4Pc2quDJBrKiSSXjwKUmo+5gEwHSTW2Cp7iMU9ex1
         sM2lUG8OZ2qpYBNeACb0KXPHzb6E3HzXC6jyMHcAqjWQ0n4D713Xjpo1qHoTNW0qHzVL
         nC4kG99o11Mg5TE9WC5nM6C1jwXtb/ErcwuUopGTCsHPgl1zpE2y8ipYZKkMfxH9yCmr
         6Toz5CW7U4g+B917C3FTRmKWbWJ83ym97GOE9c4hQZU45RtoTrlXWQVMFtKO0TBRwo35
         BydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5adauTvnVvh5L89F33zikem2gwiUE10oaZXShzCuTNA=;
        b=kb3CsjDckwWAjC0V5AjZ3Iv3QkmlONpr/28OF1No+3VtJM8xvjbNHlIPjfvOSY2eVS
         Fzvy95Bb3sVDUQNHZ+UT+aasQnVDpZ8XTGUFelRPmeYi+R/KSOur2W+9hrNeshM+3sR0
         a6Gb2TieDy73sx3b0Z7U4h3VRAX/XsM7L14HltdR9tC/xvABsDahkYmg9td9L7kAZFEq
         cAM0JI1WJRt1TmH3a+lO9Y220wH4noFEU/FTYkUYjGL13ATaD/uPk792/aCGRGJYu0C7
         dekqhCZEdLiO1ARxa+rkDxDev10M76mE4VY0qhwqSe8ULFC1pR5Xsgmdf/2ELmVbbyd5
         eeHg==
X-Gm-Message-State: AOAM530bbU0ltaXD/KusVCsBBKJJtF8StuldcwJNXRenOoqbhPEeRKSY
        yBT1pGPCGOAkY96cwWfnuyUsgNQzPSE=
X-Google-Smtp-Source: ABdhPJzwnAgem2Qimqt57eyfMHkW5UbJlhVDzekDyoPD1dfAhEqN+Cma6AXLDus+NJ5wIPPz+Lx5WQ==
X-Received: by 2002:a63:ef57:: with SMTP id c23mr16315124pgk.60.1631016016326;
        Tue, 07 Sep 2021 05:00:16 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.210])
        by smtp.gmail.com with ESMTPSA id a142sm11248150pfd.172.2021.09.07.05.00.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Sep 2021 05:00:16 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, emilyshaffer@google.com,
        gitster@pobox.com, jrnieder@gmail.com, kaartic.sivaraam@gmail.com,
        pc44800@gmail.com, periperidip@gmail.com, avarab@gmail.com,
        Atharva Raykar <raykar.ath@gmail.com>
Subject: [PATCH 07/13] submodule: remove fetch_in_submodule shell function
Date:   Tue,  7 Sep 2021 17:29:26 +0530
Message-Id: <20210907115932.36068-8-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210907115932.36068-1-raykar.ath@gmail.com>
References: <20210907115932.36068-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function has no more use in 'git-submodule.sh' after
bd82d7d467 (submodule: move core cmd_update() logic to C, 2021-07-20),
where we moved all of its uses to C, which has its own version for the
same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 git-submodule.sh | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 4e21d9715c..5197de4551 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -369,20 +369,6 @@ cmd_deinit()
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit ${GIT_QUIET:+--quiet} ${force:+--force} ${deinit_all:+--all} -- "$@"
 }
 
-# usage: fetch_in_submodule <module_path> [<depth>] [<sha1>]
-# Because arguments are positional, use an empty string to omit <depth>
-# but include <sha1>.
-fetch_in_submodule () (
-	sanitize_submodule_env &&
-	cd "$1" &&
-	if test $# -eq 3
-	then
-		echo "$3" | git fetch ${GIT_QUIET:+--quiet} --stdin ${2:+"$2"}
-	else
-		git fetch ${GIT_QUIET:+--quiet} ${2:+"$2"}
-	fi
-)
-
 #
 # Update each submodule path to correct revision, using clone and checkout as needed
 #
-- 
2.32.0

