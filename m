Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A77DC433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 15:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376515AbiATPM0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 10:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376509AbiATPMY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 10:12:24 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014B8C061748
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:22 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v123so12783115wme.2
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 07:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4f+I3S+5kXlrq2dgprxTUst4Q5HxOS1EHDxdA1BG70w=;
        b=i6kfUc6nxgzHKqB4LDRUfuZVULCh/jE8z1l8Vkn5LcvbxTyrSNhAK8MNRWDFwz7Lgw
         xfLumpUKAv2LEM/4FG55oGdePsjT9aLoK2rSVmXggzU43plm1lwTp28EbIFOjX0dJsfj
         hPcfOqIl3rfg5LZEYpk+jd9UiRxjs+tpIr2SbawjfkCuO7DYu4RMm/fOXmSb0No0t9XO
         wZAAibpaE/m3ItfB+kUcryFZMnfIi6NPFszqFoRbfWe13VTOAh7pKd98WR5Isdyf43hd
         405/OnDOoyzxxDNAys5H2oaxv9OoviIjlql2zJ4hYSifN/4w8n6YQSbPhPepdEcWi2vk
         c5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4f+I3S+5kXlrq2dgprxTUst4Q5HxOS1EHDxdA1BG70w=;
        b=YAvQtDQ8RjNOdHnsEqW89YbpPW2zkpCp5jrQIVlzqBkCK+YYmNqp5qISVVX5vGIScV
         bGvwx7Bd5lNSuElvN1HNO5RYGIZCofbI6EPSONIbSxpshCqpYBA6P2kTUXZH0g8mmqBq
         qolojiLts+Vfvglw5sOwfbe2q+YCqLHHfMHyCr/dhm6ruQ1qI7xKhI/hGN3MCSTnNsJg
         eSol8+BCN2SUEFcpaKEhlL+NmgfxgqE2V3dWvO8sLFOkNLzmCmWJRfYUZ5SNIrjAgOdt
         F7NiW7BQyr48AM+4RWvvkREQs4Z52acQETb8u+f0+Y8PShLCSH2ENLpEeMT1V2Frna3a
         XEdQ==
X-Gm-Message-State: AOAM531wxZjWk0HhzAuYcIFsvKFr5yN23ijzKFdMBH8cIC+Z4wzLZnWE
        T5gO2NigCtPONhvxCSBppiinDiwgvK4=
X-Google-Smtp-Source: ABdhPJwRkFgVRBf12KEhAqVpR9q7KglFx2VZsKWiE068+E21qXrvY83tfpILYexQZIJYVchBCBF6xQ==
X-Received: by 2002:adf:e196:: with SMTP id az22mr33910301wrb.637.1642691540503;
        Thu, 20 Jan 2022 07:12:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7sm6375140wma.39.2022.01.20.07.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 07:12:20 -0800 (PST)
Message-Id: <630f67bdb519251815f878fba73b07dd0ae75320.1642691534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
References: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Jan 2022 15:12:05 +0000
Subject: [PATCH v6 06/15] reftable: fix resource warning
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This would trigger in the unlikely event that we are compacting, and
the next available file handle is 0.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 56bf5f2d84a..ddbdf1b9c8b 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -889,7 +889,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 	struct strbuf new_table_path = STRBUF_INIT;
 	int err = 0;
 	int have_lock = 0;
-	int lock_file_fd = 0;
+	int lock_file_fd = -1;
 	int compact_count = last - first + 1;
 	char **listp = NULL;
 	char **delete_on_success =
@@ -923,7 +923,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 	}
 	/* Don't want to write to the lock for now.  */
 	close(lock_file_fd);
-	lock_file_fd = 0;
+	lock_file_fd = -1;
 
 	have_lock = 1;
 	err = stack_uptodate(st);
@@ -1031,7 +1031,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 		goto done;
 	}
 	err = close(lock_file_fd);
-	lock_file_fd = 0;
+	lock_file_fd = -1;
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		unlink(new_table_path.buf);
@@ -1068,9 +1068,9 @@ done:
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

