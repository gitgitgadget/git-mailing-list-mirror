Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9B2C433FE
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAAF261040
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 13:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbhJMN0E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 09:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhJMN0D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 09:26:03 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DCEC061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:24:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v17so8313508wrv.9
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 06:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/sgCZEVhm4PDL3iLjTUg6Fkzl4YfWpLM3LmcqSVEADQ=;
        b=oq9cTLS1jSiHgkIqqo/ngvJwDsO0q6nWRxLV0H8VW7Z6hHO4WEMwaFNILN+v1/vETM
         Oq6z+ORtPVDQuW43e1R7cjs2gxCsSRxGuz/rvVhXNfQz3KnriTRZ/YiZRuYuafugt/Wt
         aIi7+wy7alhhzOOSAEpwdOaieDHSkWLEBFKguNI1u0k4y6YZS8oUk+XyYS9L5C2/MtPv
         z3KaStPASI5UhWsvkhuIcX17r3HBEKbOd4spTV+uKTpQL2rEmFYz11+uvNNPJwad24yR
         g9E7PWWYtNRdiLGDn4+2PQk3uIdvX9KTmyzsXd07mWAW/+yYouF/UhnLixZx+hCnhI2i
         bXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/sgCZEVhm4PDL3iLjTUg6Fkzl4YfWpLM3LmcqSVEADQ=;
        b=bJdfbbY1uASbGIrf1Uh1chpSPUJL+pDaRYe8yNkqU7cyBvzGAFhM1oHiHyaqvv92IQ
         WOZzzDw3YNXH2kG4jwn/QtMQlZou3CtmDqaYao98FzrIqBscBkATQ5OyPQl3QfAbwyNV
         ak/NU9VE4F4hOEr1GU7AgYW4C+3wD3kuUu2qpDwF2MH6VA2ILd5ru4t+ury/mA13ba9y
         Oz5UY4Wgpns+bKjzDkX1PsrvkgeIDxG0QYnRL/0MQ7pBKFm/w76iLxHt79Gw6TbhQSAh
         FglLq8IZVA7mLyt5erts1XwsqP9n+GDaIOhNSmLZ67kWrKHsquQaYFs8PqiEfmaDYVvz
         b6CA==
X-Gm-Message-State: AOAM53321YVMzYYE1CTd5F8igoMp7w8sByNMfEsFd0TUrulkerFWfe45
        IqzsGrCwAypSDvBuFqdu/iXA6sCea0L9mA==
X-Google-Smtp-Source: ABdhPJyLUb9aAelVMBazm+rvVCnFZtsnks/9X6p/8oM4mNz4c9bnmFdeYgPWrZ4lenDC4d8wacKJxQ==
X-Received: by 2002:adf:a411:: with SMTP id d17mr40363986wra.393.1634131438222;
        Wed, 13 Oct 2021 06:23:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k10sm13044205wrh.64.2021.10.13.06.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 06:23:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/3] unpack-trees: don't leak memory in verify_clean_subdirectory()
Date:   Wed, 13 Oct 2021 15:23:53 +0200
Message-Id: <patch-v3-1.3-0ab1e74f50d-20211013T132223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1569.gd2dc77f7abf
In-Reply-To: <cover-v3-0.3-00000000000-20211013T132223Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20211007T094019Z-avarab@gmail.com> <cover-v3-0.3-00000000000-20211013T132223Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix two different but related memory leaks in
verify_clean_subdirectory(). We leaked both the "pathbuf" if
read_directory() returned non-zero, and we never cleaned up our own
"struct dir_struct" either.

 * "pathbuf": When the read_directory() call followed by the
   free(pathbuf) was added in c81935348be (Fix switching to a branch
   with D/F when current branch has file D., 2007-03-15) we didn't
   bother to free() before we called die().

   But when this code was later libified in 203a2fe1170 (Allow callers
   of unpack_trees() to handle failure, 2008-02-07) we started to leak
   as we returned data to the caller. This fixes that memory leak,
   which can be observed under SANITIZE=leak with e.g. the
   "t1001-read-tree-m-2way.sh" test.

 * "struct dir_struct": We've leaked the dir_struct ever since this
   code was added back in c81935348be.

   When that commit was written there wasn't an equivalent of
   dir_clear(). Since it was added in 270be816049 (dir.c: provide
   clear_directory() for reclaiming dir_struct memory, 2013-01-06)
   we've omitted freeing the memory allocated here.

   This memory leak could also be observed under SANITIZE=leak and the
   "t1001-read-tree-m-2way.sh" test.

This makes all the test in "t1001-read-tree-m-2way.sh" pass under
"GIT_TEST_PASSING_SANITIZE_LEAK=true", we'd previously die in tests
25, 26 & 28.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1001-read-tree-m-2way.sh | 2 ++
 unpack-trees.c              | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index 1057a96b249..d1115528cb9 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -20,6 +20,8 @@ In the test, these paths are used:
 	rezrov  - in H, deleted in M
 	yomin   - not in H or M
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/unpack-trees.c b/unpack-trees.c
index a7e1712d236..89ca95ce90b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2156,9 +2156,10 @@ static int verify_clean_subdirectory(const struct cache_entry *ce,
 	if (o->dir)
 		d.exclude_per_dir = o->dir->exclude_per_dir;
 	i = read_directory(&d, o->src_index, pathbuf, namelen+1, NULL);
+	dir_clear(&d);
+	free(pathbuf);
 	if (i)
 		return add_rejected_path(o, ERROR_NOT_UPTODATE_DIR, ce->name);
-	free(pathbuf);
 	return cnt;
 }
 
-- 
2.33.0.1569.gd2dc77f7abf

