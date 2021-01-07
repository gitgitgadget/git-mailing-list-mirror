Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EBDC433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29CB0233FC
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbhAGQdg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 11:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbhAGQdf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 11:33:35 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C47DC0612FB
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 08:32:20 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v14so5702391wml.1
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 08:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MFoyZvSH404fKlOXAhW3wSlHVKAaWMcAXJn9MXCrdIg=;
        b=Dwduus8GiyCI1JmWc+ElHKAlBkj4UjYVYd7aN6unQvN/tYA+8UEec7TtXJQcDdw/bP
         qzyPSO6aZLg2oPSl5QYXu3PHSXW7LQseuCafOfpOaOwuKO+XZAithK26A8d+9wGmowNr
         KjuzWF9Xb6LkVC96GI5/43l8wErpaCNUWH4xK+gdIWcaiRC5s221H+wVrdwjqw4+Hw8g
         PHuH7sQOijhq3FVv+RT50ZvwIK/9HRHBSp1/mYn86cMY57ONAhhrc6mPjrS5f/BSfkGS
         JSTOnGGqFecf7IA0d/qwv7PlXRS6Sc589/r+LJ99J1kcUx+OhDjqPFBqPCPLwppqJmPo
         nt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MFoyZvSH404fKlOXAhW3wSlHVKAaWMcAXJn9MXCrdIg=;
        b=XVzJCqaS7VaCtjcrlz0klxJXN4CgUqM2k8tSl97d49SllYS4DNQRQbXuf3t97FqryN
         0paVEbvNJ8Ps2vWx778q5vgckZlPaxp11rTlKwIe7Emb9qMp6z9S0vwtoCJvfTN5oBcL
         us/1MR1cWnZizwpCxEnvon4hOFApwtp+gCH4igghAvvc+Qavxjb7DmN3LUUSDD5J1fUY
         uR1jB+vD4hGE6PFVAFqBuPDdSZ88qf2bOZSR+WapM1cVnV/CgDNohQWwPgpKHsu/vT2Z
         WLNLRG2/VOjd80wrvTYfeYjc1jF/A7Ofa8XvrrnqwzF6yJ4Sx8wakuu1+2M3cYoxodsu
         djQQ==
X-Gm-Message-State: AOAM531TK6coyn3Deu1pa8xUFb0ZRI20+KwiZ0FGAeRLl/YeIlODit6v
        ngC2LVtm5CO4V59Tq1AljN228HiJaU0=
X-Google-Smtp-Source: ABdhPJxYZfHlbl++4iFn50OpsSq3jP578/RIQQNJM30BPLmw6Fjrj3Lt7YnKyEgJ6QxH9Jrnf9nVSQ==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr8811399wml.74.1610037139003;
        Thu, 07 Jan 2021 08:32:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w8sm8668139wrl.91.2021.01.07.08.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 08:32:18 -0800 (PST)
Message-Id: <2d7b18c2e0b351e98e687126fc067dc4fcd7a498.1610037132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
References: <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
        <pull.829.v3.git.1610037131.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Jan 2021 16:32:07 +0000
Subject: [PATCH v3 06/10] index-format: use 'cache tree' over 'cached tree'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The index has a "cache tree" extension. This corresponds to a
significant API implemented in cache-tree.[ch]. However, there are a few
places that refer to this erroneously as "cached tree". These are rare,
but notably the index-format.txt file itself makes this error.

The only other reference is in t7104-reset-hard.sh.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/index-format.txt | 6 +++---
 t/t7104-reset-hard.sh                    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index 69edf46c031..c71314731ec 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -26,7 +26,7 @@ Git index format
      Extensions are identified by signature. Optional extensions can
      be ignored if Git does not understand them.
 
-     Git currently supports cached tree and resolve undo extensions.
+     Git currently supports cache tree and resolve undo extensions.
 
      4-byte extension signature. If the first byte is 'A'..'Z' the
      extension is optional and can be ignored.
@@ -136,9 +136,9 @@ Git index format
 
 == Extensions
 
-=== Cached tree
+=== Cache tree
 
-  Cached tree extension contains pre-computed hashes for trees that can
+  Cache tree extension contains pre-computed hashes for trees that can
   be derived from the index. It helps speed up tree object generation
   from index for a new commit.
 
diff --git a/t/t7104-reset-hard.sh b/t/t7104-reset-hard.sh
index 16faa078137..7948ec392b3 100755
--- a/t/t7104-reset-hard.sh
+++ b/t/t7104-reset-hard.sh
@@ -33,7 +33,7 @@ test_expect_success 'reset --hard should restore unmerged ones' '
 
 '
 
-test_expect_success 'reset --hard did not corrupt index or cached-tree' '
+test_expect_success 'reset --hard did not corrupt index or cache-tree' '
 
 	T=$(git write-tree) &&
 	rm -f .git/index &&
-- 
gitgitgadget

