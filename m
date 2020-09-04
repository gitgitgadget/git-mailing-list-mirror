Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6D7C43461
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 13:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C68492074D
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 13:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS1yQg56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbgIDNKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbgIDNJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 09:09:25 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA44C06124F
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 06:09:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a9so6056235wmm.2
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=M2VGT+0ymSl4SLlTLpbNJM/6HbTEkqPEnqmtuttPwRc=;
        b=IS1yQg56ZMy+523g9DFLchLkJptyoU8oP6t0HEZuaDHdP6HRj2MKjG9EBGK8PTuv9i
         ShPQaxCfeh3XhNZ0ig8sYp2k6qYHcUdZW4qf8p+gqGBtRLMQdu02P61epZTplUpy7M2K
         LWj/o/uNAB0uXTOrrwBTx87mcODIK/ryyOiZyIp70dfehZp3GSlEDf5A2uO4XuoQ9Po4
         9Is0KwSCGP/KD4F3DZyanOUxdeLUH6M3Sr7CSiY/1gB0W1uyKt+pcEKJgMwKqKx3xqyl
         8fItZuVWE+1Wjymt6s/DOkHCA+jaJSpVA6Ac76Ynmea1P2Mvel97oLyD59wi2cr1fYRP
         A8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=M2VGT+0ymSl4SLlTLpbNJM/6HbTEkqPEnqmtuttPwRc=;
        b=MHtjBiyyb9RBJwf8LqLdObfSxK5Y8a2Z+/ncpvmpMIXlA5jpZVkGb7dNvixn5j30O3
         evKAQHkSxtB9LIPhwAdGeyMxgRUtnRZ1SeLGKVEPezmKt2kXfMiJ7E9ec+R3e1yPHE18
         7zVVXp62sAPbDAPiZcJYMdmtxfkUahKg50vk89QNRgdU6XUKPzVlV7A/NRoxc4nylJor
         iOVDIydUWpNTln+5gl6grQvJ1JcvwqQtwZvWZUuN5/++5DrSVJSUTyz12rCkB9Ed0ug8
         kS9NKo7srYGEaiMPMX3Voo4Z6iQ90k2rja/optgxyCuTSp902bXs80gwVV2rXREm8ixY
         NL+Q==
X-Gm-Message-State: AOAM531uMgB14D4FGMMQ3y9gp4nZpfONGcQRh5gQmpseKInM6nZc5isl
        06v49wvzBcaqL4f5NTjqc5L3+0sWMdU=
X-Google-Smtp-Source: ABdhPJyts7/OkHfCrZuAPM7Ko+guxQs0XkbdxVsmgsFDNfel9oRUCaOu907ny8LycCbublAZRlYfwQ==
X-Received: by 2002:a05:600c:22d1:: with SMTP id 17mr3525939wmg.58.1599224963044;
        Fri, 04 Sep 2020 06:09:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c14sm11052437wrv.12.2020.09.04.06.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 06:09:22 -0700 (PDT)
Message-Id: <c57998a1c8844fc39cc95877a85790566e8f3331.1599224956.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
References: <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
        <pull.695.v4.git.1599224956.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Sep 2020 13:09:11 +0000
Subject: [PATCH v4 07/11] maintenance: take a lock on the objects directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Performing maintenance on a Git repository involves writing data to the
.git directory, which is not safe to do with multiple writers attempting
the same operation. Ensure that only one 'git maintenance' process is
running at a time by holding a file-based lock. Simply the presence of
the .git/maintenance.lock file will prevent future maintenance. This
lock is never committed, since it does not represent meaningful data.
Instead, it is only a placeholder.

If the lock file already exists, then no maintenance tasks are
attempted. This will become very important later when we implement the
'prefetch' task, as this is our stop-gap from creating a recursive process
loop between 'git fetch' and 'git maintenance run --auto'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index e94f263c77..1cebb7282d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -798,6 +798,25 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 {
 	int i, found_selected = 0;
 	int result = 0;
+	struct lock_file lk;
+	struct repository *r = the_repository;
+	char *lock_path = xstrfmt("%s/maintenance", r->objects->odb->path);
+
+	if (hold_lock_file_for_update(&lk, lock_path, LOCK_NO_DEREF) < 0) {
+		/*
+		 * Another maintenance command is running.
+		 *
+		 * If --auto was provided, then it is likely due to a
+		 * recursive process stack. Do not report an error in
+		 * that case.
+		 */
+		if (!opts->auto_flag && !opts->quiet)
+			warning(_("lock file '%s' exists, skipping maintenance"),
+				lock_path);
+		free(lock_path);
+		return 0;
+	}
+	free(lock_path);
 
 	for (i = 0; !found_selected && i < TASK__COUNT; i++)
 		found_selected = tasks[i].selected_order >= 0;
@@ -818,6 +837,7 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 		}
 	}
 
+	rollback_lock_file(&lk);
 	return result;
 }
 
-- 
gitgitgadget

