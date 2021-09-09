Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD24EC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 09:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93A61611BF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 09:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhIIJsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 05:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbhIIJsW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 05:48:22 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73F8C061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 02:47:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u19-20020a7bc053000000b002f8d045b2caso917895wmc.1
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hBpn/46jdaM8KeSDi2/L4N0QpfzUDd1UJlMYW8lw10c=;
        b=D8EJ+gPEZ26lqvwCpd7epW69G1AE62DqTR5l1zJEeoYt8FHW6hI8qtqOUen/bB75Nl
         ArQRqecU8pSsahXed5247FUBze5JxsRsC2s7LVJMAvJci2lOD+jq1MOPePMQjK0HUWGA
         XhiN2b1QedLYU37sMAtQwd3YWXohQ6opjoytcamUhZoVsyRouULCup9zGsbYZ+/Uckn0
         IRovBgMTsM5j6hNf6qHHmlQPanFm9plHIjNuvBUf4KP45o3XUNF409R77AtJay/YgukN
         jwPpE7eWUcnX0Vd2u8eFBmOExYwvcfbWijTsJOF4aUMn3/hFDqAidKD+ef0y+ZXOK/9W
         0eOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hBpn/46jdaM8KeSDi2/L4N0QpfzUDd1UJlMYW8lw10c=;
        b=vgwiIagk4RmpvI7S1hGxJbE7f7H0IEwV1iHxitC446EXoaN2T6NfKYi2pEAiIKxlP/
         Mpjndkl39FWJGwsHEYQihrb5MWOekq1aL5deSFAaMV8SYH0UHH1gnXshbPsKm7mKFH8+
         BNvpkdroqmZ4Icw5qQuUDjwbfT5OXy6RYH8sBLY+/MdLr8h5AdCot0ORLMmDmE31Sdbm
         +38TpWPchoU9ygP53pQo0zC02JjpcG/qsgYwLTD9DHgfODqjaKOZNhay/nlLs+Cr4J7S
         G3bnCtlzyUFjhCxkLagRAKxTJpSO8/3Gj1rdgxeolVvsGQ+i2QNKTD2KSI4RbThMSqQz
         uk3w==
X-Gm-Message-State: AOAM531SWIzweimhA2ZiXcHK/qFTQa+oMYt7FVtbX3SI7plDYtvmzFgd
        ht4K3u5zGQF/woaog9k5L6AsXv4dwR8=
X-Google-Smtp-Source: ABdhPJy4u2S3agW9vbMMAkDlkVC3iezHnL+riGXjjzzCYwXy6EAyAd7OhSDrFkpXUKuhNkZ7oLXTBg==
X-Received: by 2002:a7b:c197:: with SMTP id y23mr2023340wmi.135.1631180831764;
        Thu, 09 Sep 2021 02:47:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm1032721wmj.29.2021.09.09.02.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 02:47:11 -0700 (PDT)
Message-Id: <df76ee7b77f0a81db32e28eb4c8a253a19e68028.1631180828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1035.git.1631180828.gitgitgadget@gmail.com>
References: <pull.1035.git.1631180828.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Sep 2021 09:47:06 +0000
Subject: [PATCH 2/4] run-command: offer to close the object store before
 running
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Especially on Windows, where files cannot be deleted if _any_ process
holds an open file handle to them, it is important to close the object
store (releasing all handles to all `.pack` files) before running a
command that might spawn a garbage collection.

This scenario is so common that we frequently see the pattern of closing
the object store before running auto maintenance or another Git command.

Let's make this much more convenient by teaching the `run_command()`
machinery a new flag to release the object store before spawning the
process.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 run-command.c | 5 +++++
 run-command.h | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/run-command.c b/run-command.c
index f72e72cce73..e2dc6243774 100644
--- a/run-command.c
+++ b/run-command.c
@@ -8,6 +8,7 @@
 #include "string-list.h"
 #include "quote.h"
 #include "config.h"
+#include "packfile.h"
 
 void child_process_init(struct child_process *child)
 {
@@ -740,6 +741,9 @@ fail_pipe:
 
 	fflush(NULL);
 
+	if (cmd->close_object_store)
+		close_object_store(the_repository->objects);
+
 #ifndef GIT_WINDOWS_NATIVE
 {
 	int notify_pipe[2];
@@ -1044,6 +1048,7 @@ int run_command_v_opt_cd_env_tr2(const char **argv, int opt, const char *dir,
 	cmd.use_shell = opt & RUN_USING_SHELL ? 1 : 0;
 	cmd.clean_on_exit = opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
 	cmd.wait_after_clean = opt & RUN_WAIT_AFTER_CLEAN ? 1 : 0;
+	cmd.close_object_store = opt & RUN_CLOSE_OBJECT_STORE ? 1 : 0;
 	cmd.dir = dir;
 	cmd.env = env;
 	cmd.trace2_child_class = tr2_class;
diff --git a/run-command.h b/run-command.h
index 3893193f32f..ad207daced7 100644
--- a/run-command.h
+++ b/run-command.h
@@ -134,6 +134,14 @@ struct child_process {
 	 */
 	unsigned use_shell:1;
 
+	/**
+	 * Release any open file handles to the object store before running
+	 * the command; This is necessary e.g. when the spawned process may
+	 * want to repack because that would delete `.pack` files (and on
+	 * Windows, you cannot delete files that are still in use).
+	 */
+	unsigned close_object_store:1;
+
 	unsigned stdout_to_stderr:1;
 	unsigned clean_on_exit:1;
 	unsigned wait_after_clean:1;
@@ -240,6 +248,7 @@ int run_auto_maintenance(int quiet);
 #define RUN_USING_SHELL			(1<<4)
 #define RUN_CLEAN_ON_EXIT		(1<<5)
 #define RUN_WAIT_AFTER_CLEAN		(1<<6)
+#define RUN_CLOSE_OBJECT_STORE		(1<<7)
 
 /**
  * Convenience functions that encapsulate a sequence of
-- 
gitgitgadget

