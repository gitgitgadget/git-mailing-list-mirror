Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E3EC433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A413C2071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLWfivSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgHYSeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgHYSd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:33:57 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874C8C061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:33:56 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x9so3103236wmi.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ve9lqwr3rt4c0jBLwiGFjmwc1D6qMi9ssw1Sq551o4Q=;
        b=cLWfivSXUejnsqhyN+321LDgKqfR5hfWNvRQJaDhyZqKBXXRh3aOFZZSes+XE6JdZi
         jCBfQCJphUdg4aUfhXw6OZR+9SWknj3j9awR++2uj7ey8eKNqX5IKixyxxewO30VTKhQ
         EKxTlPKmc23fg4LcrIbn6dJzG2ngFHEY0tI7+NfG4sGQUpfamAPlWINbgA4K1mrG686h
         IsqlwUORzZ9QDroHx4Jq813Yw+NeB4DFFwAE8VWvRM+lvrm93HlhdzD+Oii6jJ3DZErW
         XnTyfRiKsezPWcK/yhrC1lEe6bBrkRJm2zjXprHOwZZ5qiwYcXWOt6J2MOrbZvjfNF9Y
         dHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ve9lqwr3rt4c0jBLwiGFjmwc1D6qMi9ssw1Sq551o4Q=;
        b=AL7tEZB0deAa1Qolktod8yiTrcVw5jBNRKvaCGYmYQWYJMcyQ9FPAVRfbFTTG9xkJ2
         aZInkCLEWtoDjOUw8k3tKMhzgDJBmyfU5VuBs4JJ1ySYeehnqi2R2n8/o7wp1dwfcoNh
         7Hxa6v+EC3D422XDoMs0adTcY6a/BalDj8qyQvc6Ryzgz4L+IbAFSXZNIX3aTr/IspyS
         PU1FpP6jAMGAOSq+Vvh1qiCuuylzPR4grUK1HR9AdiU/7M0VQ+GwtOyijHkz0GLZfoKS
         URkxqa01Y01tbfNLKlt51Q7EdVHq/6yM+4Ne+WxrMl4tuJmxlhyypuMGD5EKIGVTVK/V
         cBnA==
X-Gm-Message-State: AOAM5334L9mfkg+CJMIinyjCgtT8wvUwqeKTzLtEpvHgudR0gTAQwpvq
        dbYElaT8CM6oVLJgB9NNbnINNhgom8s=
X-Google-Smtp-Source: ABdhPJyoERXotOUb4PH6m9otYv6v3S8+s/JS1SYIGHj/nTjSWZ7aUcEm3D3oadGCn9r8cVL1nXOXbQ==
X-Received: by 2002:a1c:2045:: with SMTP id g66mr3091791wmg.184.1598380434964;
        Tue, 25 Aug 2020 11:33:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 36sm12417324wrs.25.2020.08.25.11.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:33:54 -0700 (PDT)
Message-Id: <3d513acdd8885d90393cbfa847c38e802ffddac9.1598380427.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
References: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
        <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:33:42 +0000
Subject: [PATCH v3 07/11] maintenance: take a lock on the objects directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
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

If the lock file already exists, then fail with a warning. If '--auto'
is specified, then instead no warning is shown and no tasks are attempted.
This will become very important later when we implement the 'prefetch'
task, as this is our stop-gap from creating a recursive process loop
between 'git fetch' and 'git maintenance run --auto'.

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

