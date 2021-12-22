Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA743C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344973AbhLVS4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344956AbhLVS4n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:56:43 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E452C061746
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:42 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so2025221wmc.2
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HOTpe9FNENotMYcACPCrU+33ZDetlyOQNtsGAWihsVI=;
        b=VHh+PrdOWOitvscP3p3PMgSnQKG/MIAsePygCMSQ9pOvEV0oWYFfXrE/PhH24IHQqS
         RcnPPa8UyzmA0BxfiMpWBbTpaVoxVYCxy3uvyF5i8+CMZz8nVjxvdtk9Dc4iQptdxvX3
         FwJD8M4Jq5JY3V3rNuTK88b7Hc5IB3L2vA2zRQ88Z7r8S5gb/aYARVHV/vWf9P8AoN/V
         hBTR4pdLD9mOwZfYLKPm/r/h8d74eYm6MgrSDo1FpwXvuPA2GshPOPeV03pEcWwod7Dy
         CqnmudwAOYlr6NzjsnueRSjxUv2IfiOeRw4og8Dz7l6GkBQYD2zfQNFoHHw1gxGrwG7P
         ADTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HOTpe9FNENotMYcACPCrU+33ZDetlyOQNtsGAWihsVI=;
        b=hsj2GKZayY/R1+IfYYsi/IouFyVr9c0eFoTosEsNmudylMibgrv056/oFH/Cv/Fjct
         Bma/GMnXIOARno/1QuD73W1DPsvgRXpedL5NsVEL299wxHwSKrL6O7FQtlMF32/MMBIV
         JmlURehqg8RD7gQvpX+3AiPeOMpX/VvPV1EvSh2MSJnBoAqsPAt3Jtd1/kIGi6dNujeq
         hVjUTgC5gjhi+RQHy93FPIrakHzCDLSyimqQNbROJs70bT6EjR3/v6Di89+jALlvDTgd
         l1yaOZ9RDCWV3lLdCr5U4dtaggygkFVEx0MOIqOdNKi+SnMRSzmz5YHSFtPg+T/CC90f
         TxpA==
X-Gm-Message-State: AOAM533nznZmT4KGvBD9Xwq+JbWxe8R4PWJvkmvWyB9TVoANwBEVxTA2
        Hl8pBUvktVbhGNLxRMP4Pxvbe5BjRv0=
X-Google-Smtp-Source: ABdhPJxoeSVJbUPyn7WiwQkE2DQUuPJs1Sk8E7ux84aeEItDzSoz44KmyvIs+TIgdZPEejm/uCJQUQ==
X-Received: by 2002:a1c:e909:: with SMTP id q9mr1768854wmc.184.1640199401132;
        Wed, 22 Dec 2021 10:56:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u20sm4476388wml.45.2021.12.22.10.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:56:40 -0800 (PST)
Message-Id: <700a4e247e7e1deb19358960bbb75ebbde88ddbd.1640199396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 18:56:26 +0000
Subject: [PATCH v5 06/16] reftable: fix resource warning
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This would trigger in the unlikely event that we are compacting, and the next
available file handle is 0.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index df5021ebf08..10dfd370e8e 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -877,7 +877,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 	struct strbuf new_table_path = STRBUF_INIT;
 	int err = 0;
 	int have_lock = 0;
-	int lock_file_fd = 0;
+	int lock_file_fd = -1;
 	int compact_count = last - first + 1;
 	char **listp = NULL;
 	char **delete_on_success =
@@ -911,7 +911,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 	}
 	/* Don't want to write to the lock for now.  */
 	close(lock_file_fd);
-	lock_file_fd = 0;
+	lock_file_fd = -1;
 
 	have_lock = 1;
 	err = stack_uptodate(st);
@@ -932,7 +932,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 
 		sublock_file_fd = open(subtab_lock.buf,
 				       O_EXCL | O_CREAT | O_WRONLY, 0644);
-		if (sublock_file_fd > 0) {
+		if (sublock_file_fd >= 0) {
 			close(sublock_file_fd);
 		} else if (sublock_file_fd < 0) {
 			if (errno == EEXIST) {
@@ -1013,7 +1013,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 		goto done;
 	}
 	err = close(lock_file_fd);
-	lock_file_fd = 0;
+	lock_file_fd = -1;
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		unlink(new_table_path.buf);
@@ -1050,9 +1050,9 @@ done:
 		listp++;
 	}
 	free_names(subtable_locks);
-	if (lock_file_fd > 0) {
+	if (lock_file_fd >= 0) {
 		close(lock_file_fd);
-		lock_file_fd = 0;
+		lock_file_fd = -1;
 	}
 	if (have_lock) {
 		unlink(lock_file_name.buf);
-- 
gitgitgadget

