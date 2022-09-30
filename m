Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109A5C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 14:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiI3OKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 10:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiI3OKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 10:10:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1033485A8C
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 07:10:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bk15so7033792wrb.13
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 07:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=D4yfEYicJUjAtxcJlo9i01ADZOW5DGBuB6FKtnPcBIY=;
        b=coAREnZ8Zme1Yk+ywD+9c8INz8U6AVaQGplc3AKnq8VNeAr8URKdG7kLvEYSMFt5cN
         3aQ99wTTXvK7zMZ/uAnc4s5vAhayKQXkypMaQyGUu7SjSd7NxBjbADZQCi+p6XeTIIdK
         I+G1gYt73J6RXQzxYazh87x+b+7HW3gtEYUkU6IG1aO5/I5gEQkIDhNdwcZZxPX7AkCD
         nziBMNKEk1osUCOOgjTgf5ylzzKIPA45CJuRDcEY0NSIZPIQQqc2y7lPO5cNRRnbtAb4
         wlb49YPTlvUNxFmFLLu4ZjR+yWYX48nTGM2qLXKno6mbkcAytFO1qxiRapsma1qiC1Iy
         WgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=D4yfEYicJUjAtxcJlo9i01ADZOW5DGBuB6FKtnPcBIY=;
        b=YQ9Dfma7CzZ/5W9QY5ykDRyr8Obm0nnNV1EuO6BXLrn0wyvvPfScCFvdHV9BDqnzKl
         0GrPmhB7HZ5/3aB+V/GM4wxxmVW2OhHfExLyn+ZTxa9cB0hwC6cLc4Li9G1mhJ4qaQxM
         PVPT20asLDNQaKUzc0XOQdcMnvqLI92gwTp52UkS76CKQzSTHsXKwqdsT4lzgQpy92Mr
         cWH8zAzsuoLWwMymthgpyYhE1fiM2Nk9jz94RppPc7GYanlj2DjWrZaa+YO4SE/k5nM8
         SFbaJi+uXFsUA9uxN8+FKB21jRwhr/1N7lOajw9Kbsp4P+T1+o6TtLKqNQdZzqU5t/vp
         d5mQ==
X-Gm-Message-State: ACrzQf2R9RIQjbbclqgbSgRpdQp30knDAdE508QGHKuEyJ5zOb+lFf/8
        AbrEh6iKzfG39skvVmFSOu+p63WlZ6k=
X-Google-Smtp-Source: AMsMyM7c9+YJ8cmI3CjtaeY4A2pFls5I27i2xFpUGi4m28+VgU9R7Wf8PxAJyxfIrOuK4bDTxSXRxA==
X-Received: by 2002:a5d:6c63:0:b0:22a:4247:1e7c with SMTP id r3-20020a5d6c63000000b0022a42471e7cmr6034063wrz.625.1664547018931;
        Fri, 30 Sep 2022 07:10:18 -0700 (PDT)
Received: from localhost (94-21-37-194.pool.digikabel.hu. [94.21.37.194])
        by smtp.gmail.com with ESMTPSA id q14-20020adfea0e000000b00228c792aaaasm1987764wrm.100.2022.09.30.07.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 07:10:18 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/6] rebase -i: emphasize that 'update-ref' expects a fully-qualified ref
Date:   Fri, 30 Sep 2022 16:09:45 +0200
Message-Id: <20220930140948.80367-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.542.g9b62912f7f
In-Reply-To: <20220930140948.80367-1-szeder.dev@gmail.com>
References: <20220930140948.80367-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The argument of the 'update-ref' instruction is treated as a fully
qualified ref, and there is no DWIMery to interpret 'update-ref
feature' to create/update the branch named "feature", i.e. the ref
"refs/heads/feature".  Update the help text appended to the todo list
to make this clearer.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 rebase-interactive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 7407c59319..7c6288f997 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -57,9 +57,9 @@ void append_todo_help(int command_count,
 "        create a merge commit using the original merge commit's\n"
 "        message (or the oneline, if no original merge commit was\n"
 "        specified); use -c <commit> to reword the commit message\n"
-"u, update-ref <ref> = track a placeholder for the <ref> to be updated\n"
-"                      to this position in the new commits. The <ref> is\n"
-"                      updated at the end of the rebase\n"
+"u, update-ref <ref> = track a placeholder for the fully-qualified <ref> to\n"
+"                      be updated to this position in the new commits. The\n"
+"                      <ref> is updated at the end of the rebase\n"
 "\n"
 "These lines can be re-ordered; they are executed from top to bottom.\n");
 	unsigned edit_todo = !(shortrevisions && shortonto);
-- 
2.38.0.rc2.542.g9b62912f7f

