Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDD1C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbiCINSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiCINSp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:18:45 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D831066D4
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:17:46 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so3386993wmj.0
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cMd8CbAEW9TqiO4Kd0qqoXifFaip1chte21eewnminQ=;
        b=Pdz612+Cx6PEndKNGrJr9ARIJ30vb5aHw7seuihjDdnJoEesMQ3Jw956hyU6yendAq
         2By/MWFGE3c30lIg4LgWXRjbyi4RAZ/q0ygsEqPLBuCKchoIaOGEcJttI0s7697sldRh
         7a1m6v4BCn9j79hcLvFjHfZzsC7YzaHicUF79kbN16WGMNzGZwXHQrqfXontOdYO3nAm
         DRxf8QkAm2mQRMz+rJEMxYJPn7mX2KiuLf5pvDurOfzxzxJT4PWnNxI9BqMj7sZsqvN4
         9N1HhwKoVf8enKpPPBgP2OZn8L6dsVdVGpxh7BcGZmbSdpx50IsqJCE8yajDsxCbr88n
         HMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cMd8CbAEW9TqiO4Kd0qqoXifFaip1chte21eewnminQ=;
        b=vFQCn06k2DXtBz/I2I5faOaKQcTPfuCDCNL99SiVTPqfiJ17eyk2MxPBa+NXWsBQPy
         FUVdv6T2fp4qi8LvB21D0UlfXJaKdbD4Lu1KcvzKKNmaOrPE7CjENUZTb7ypffcZWqw+
         uZH7HLNI37U4+Nq5NNBllU2hz3X+gEIa/mWNiUQhz/s0+58/REF169yFNUMG4+rL4LbW
         Q6WNNEDYAcoqz4pA4NYRxA71XxDdGDF46F4dZ5qcjgqAPif0qJag2NVQJR7RiiwttvVW
         oXGrvzzKWz55mDnS06kF3sIOR6WYJ17OGOMDEi+8Ulxl4s8pWSsxhr4YhbJ5LFVgPZce
         sFFg==
X-Gm-Message-State: AOAM533rs48a0cnM7UUXQsmPmVCASP8IXHJQ95NB0iQ6lZLRHZxtXJq/
        uJQdyiwg6gM5ahM5YJIbstzB2d2bIcI=
X-Google-Smtp-Source: ABdhPJz2fG5TNMmA+CINo3QBW+IJTIBjrhGWvA6Drtkrx+Y/3SeI/0nlx9dF4DjFwpa2zjlkotxBFg==
X-Received: by 2002:a05:600c:218c:b0:389:a415:b84f with SMTP id e12-20020a05600c218c00b00389a415b84fmr7563069wme.11.1646831864331;
        Wed, 09 Mar 2022 05:17:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/24] t/helper/test-fast-rebase.c: don't leak "struct strbuf"
Date:   Wed,  9 Mar 2022 14:16:31 +0100
Message-Id: <patch-01.24-017c67c7540-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us since f9500261e0a (fast-rebase:
write conflict state to working tree, index, and HEAD, 2021-05-20)
changed this code to move these strbuf_release() into an if/else
block.

We'll also add to "reflog_msg" in the "else" arm of the "if" block
being modified here, and we'll append to "branch_msg" in both
cases. But after f9500261e0a only the "if" block would free these two
"struct strbuf".

This change is needed so that a subsequent addition of a "goto
cleanup" pattern when adding release_revisions() doesn't solve this
unrelated bug while it's at it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-fast-rebase.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index fc2d4609043..993b90eaedd 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -201,8 +201,6 @@ int cmd__fast_rebase(int argc, const char **argv)
 		}
 		if (create_symref("HEAD", branch_name.buf, reflog_msg.buf) < 0)
 			die(_("unable to update HEAD"));
-		strbuf_release(&reflog_msg);
-		strbuf_release(&branch_name);
 
 		prime_cache_tree(the_repository, the_repository->index,
 				 result.tree);
@@ -221,5 +219,8 @@ int cmd__fast_rebase(int argc, const char **argv)
 	if (write_locked_index(&the_index, &lock,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("unable to write %s"), get_index_file());
+
+	strbuf_release(&reflog_msg);
+	strbuf_release(&branch_name);
 	return (result.clean == 0);
 }
-- 
2.35.1.1295.g6b025d3e231

