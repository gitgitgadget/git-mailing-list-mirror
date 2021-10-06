Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82635C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623BA61181
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 10:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbhJFKEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 06:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238044AbhJFKE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 06:04:29 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6604AC061764
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 03:02:31 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o20so7096201wro.3
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 03:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NcpHrFgWJ/ELH9PBJYnq/2Qtb68AxKqIsRJrlrd2dV4=;
        b=UqI20zdBQk8l7OWEM9jjvn1qjgEutdsfSk1Cky6H/na6933Yl15Gk9qFYI8WJKeoPu
         CmJpNrrfMgokPo/90/OcbIO9fypmPEI+y7fhffkbrCMsId1uPqdwlybRsma9FviJUR2I
         pzycc5L36ec4UOX2fbpwgNfvIviE+5zLiZWAsEyoMU42BhUecXBONAcss5P/jEXOZcJS
         MzsK1vAIgVMhbXcmrefCdFxVEWNrr6DATyYRa6AW2Raqfw3ISLpc9c+Nj0MROWJaU1Be
         Twdu4nCC4Q3nakAfFl1IprobsAb7217YzBjLpzGHW8Ml4IoHtem3U6HHVLGiORmuYjas
         e+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NcpHrFgWJ/ELH9PBJYnq/2Qtb68AxKqIsRJrlrd2dV4=;
        b=UxIdr6G8XfNpBpWPGtebLlMXsXi/3YuCrH6q/qbDu16F6vtC7tE1kr1qXD85GjBurI
         Y49GVDP8XabUCoDGUAHAkTXpZWEvyUIiJufTdheoFqnmBrTh7HHW4gN/saB27TuwBt9X
         5OnKgdyirzlNSGI7M/Of/WvpKVcg7ZLhPv3NNRNmD9SNe5sur4hb3H3fnEMriGGAgkCh
         S/pX3kLP4gxdU4UiM2lyrQZxJQQkI/79BoI/3P5RtOGWhCjc2CrQuN9dDG+gFfqXRs1v
         0HyfWiBO1DS+SziXKrQ02D6DdXyBiKfrcDmzagkRRUz8/QBY0j0j7y5tuYvmsOtAzkTz
         8O9w==
X-Gm-Message-State: AOAM531QtEFLdcUXxVUqG6w5gZR9MsoW1D9Y1Fe+sP9Sf/s8VMB8jCGs
        pExF10G5uGto+iN5ti52qjHZEFOFIibGkw==
X-Google-Smtp-Source: ABdhPJxDC2qh6wvfsWQjydijgbibuuKr1YK4BM3UgTfWff18sPVa7oI3oPf25DbLvjeRGshy9tlwxQ==
X-Received: by 2002:a1c:1b4a:: with SMTP id b71mr8817760wmb.33.1633514549560;
        Wed, 06 Oct 2021 03:02:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h18sm5515279wmq.23.2021.10.06.03.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 03:02:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/7] tests: fix a memory leak in test-prio-queue.c
Date:   Wed,  6 Oct 2021 12:02:19 +0200
Message-Id: <patch-1.7-8806f9cb5e8-20211006T095426Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1441.gbbcdb4c3c66
In-Reply-To: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in t/helper/test-prio-queue.c, the lack of freeing
the memory with clear_prio_queue() has been there ever since this code
was originally added in b4b594a3154 (prio-queue: priority queue of
pointers to structs, 2013-06-06).

By fixing this leak we can cleanly run t0009-prio-queue.sh under
SANITIZE=leak, so annotate it as such with
TEST_PASSES_SANITIZE_LEAK=true.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-prio-queue.c | 2 ++
 t/t0009-prio-queue.sh      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/t/helper/test-prio-queue.c b/t/helper/test-prio-queue.c
index f4028442e37..133b5e6f4ae 100644
--- a/t/helper/test-prio-queue.c
+++ b/t/helper/test-prio-queue.c
@@ -46,5 +46,7 @@ int cmd__prio_queue(int argc, const char **argv)
 		}
 	}
 
+	clear_prio_queue(&pq);
+
 	return 0;
 }
diff --git a/t/t0009-prio-queue.sh b/t/t0009-prio-queue.sh
index 3941ad25286..eea99107a48 100755
--- a/t/t0009-prio-queue.sh
+++ b/t/t0009-prio-queue.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='basic tests for priority queue implementation'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >expect <<'EOF'
-- 
2.33.0.1441.gbbcdb4c3c66

