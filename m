Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E424EC433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC7C207D3
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax0r2OC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgHROXw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgHROXY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 10:23:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F83C061348
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:23:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d190so16393358wmd.4
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NoV3mdz7adJNLz7R5IzVkTZi/pFBlVIFLmIKQrOHX3s=;
        b=ax0r2OC+T5H4yBVETo8GBMPP6hjmQqzyEzCEXp9ohgxmeMpqhcckB9LH6Fd3R1wCJ/
         iuvdMMqgaOViIlXdmr9LOfRR7L8sQytMer0I+g/w2N1CedgxaBV6cRvbP0Hu0UfnOSVS
         XZnzeQuiH7iMk7oSjQ7N+bszr3xvLfnxiWKfgi4xyxH+TG4lHu1L90R9Ii/VCVL0Ethd
         Ewq2gXaPiwiFlNdjeMLP7HGtYLRee+YFYt3/QDMNSra61yi9mRVg0o1TSiMkSB1JGIb6
         dgEIpTSdNjAd9KT1B1a3jT/98dmCfy5mn3uXyBuVFUi+u71Jg3mdGByR3bhHdRjSbS2R
         rB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NoV3mdz7adJNLz7R5IzVkTZi/pFBlVIFLmIKQrOHX3s=;
        b=gJAD4//fV9i89LOgaSWdvsypMNjm0Roe0K5O9uOiV7S6quwfT74/InKRgPkUL8DxjQ
         LH5y+dIPKIvxs+WNO0wD3botGkX+VpimRldyQ9LGDnTqQPWfwB0fY10cOCvdTZ27R2HL
         +jBNvlOZASmeqaabV9vlMf5ZQ0ikJ5W/3wZ2PZweB3yM/VMkx5nCEzoycOOfGstPMsLF
         2+JrdnuD13r7V36dFBUNbhCS7hAMDKcWDU//mgWWCT9kZjn+MKhFP9LZopZFZjaRxz0V
         Y5xM2AAUBz0Ferpb+lrukFnp+/w9J2V7RlLXJLuT64uEV487TCpPJUQ4/SEc0FZ/A+aA
         dHbQ==
X-Gm-Message-State: AOAM533PfYWtsBwnGEu1dANVXAqt/3QJz3PBZLgAlZjvMUhYGnDh52UU
        AUGMXOHICSB1FiZcZHXCSlrLL4vgzZ0=
X-Google-Smtp-Source: ABdhPJzJqmbyuImoFogrQUbq3E5qcQxT2E1nkI5WVq05cHYldtpM1VT45DqYd3K+eX9yMOO9/hUu6A==
X-Received: by 2002:a1c:4844:: with SMTP id v65mr152890wma.149.1597760597132;
        Tue, 18 Aug 2020 07:23:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 31sm35415925wrj.94.2020.08.18.07.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:23:16 -0700 (PDT)
Message-Id: <6f86cfaa94cfeaf7a2af417991ca07e41b6b0c3d.1597760589.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
        <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 14:23:04 +0000
Subject: [PATCH v2 07/11] maintenance: take a lock on the objects directory
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

If the lock file already exists, then fail silently. This will become
very important later when we implement the 'fetch' task, as this is our
stop-gap from creating a recursive process loop between 'git fetch' and
'git maintenance run'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 0231d2f8c1..a47bf64623 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -830,6 +830,25 @@ static int maintenance_run(struct maintenance_opts *opts)
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
+			error(_("lock file '%s' exists, skipping maintenance"),
+			      lock_path);
+		free(lock_path);
+		return 0;
+	}
+	free(lock_path);
 
 	for (i = 0; !found_selected && i < TASK__COUNT; i++)
 		found_selected = tasks[i].selected;
@@ -850,6 +869,7 @@ static int maintenance_run(struct maintenance_opts *opts)
 		}
 	}
 
+	rollback_lock_file(&lk);
 	return result;
 }
 
-- 
gitgitgadget

