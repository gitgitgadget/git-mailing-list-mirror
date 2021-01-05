Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6F2C433E0
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A9C022D5B
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbhAET0D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbhAET0B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:26:01 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF3EC06179A
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:24:46 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id h205so1073602lfd.5
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XzxljG3u3B2G+pGLsNysBl8bhKcbOyXfAVTZFr7A7Jk=;
        b=rLRvnhQ5nKgBSRiX7M4uq3gaM/MaRwz2OwQqjLnr3ThZthlQO+Vv/dpjmE5NpWIkte
         sSQbanFpuB91jKn2gskocFa7mqsxR2nhU5pdZihYWfQ292KFQZFxNdPEEJzen7X0QUxH
         XBrHhWXxyAZR1FDVjInyAm7XgVXa68Kg0St2rHpA+gMp8nNUxdeUddXGo4/oGV3KQ7mr
         8wvCM2F5BxrL53N2bDbW7LwATEK2NhiRSYqU9QYkS8UK0DyQG/Bb8TbDaqY3HvBgQ6tq
         HC0xL4l/CgYPK9aoGPXnzxcv96gYUhOdYxg9GQqnn0Yh5uKyh3Yp4hjzMOpwzYr70zFL
         kd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XzxljG3u3B2G+pGLsNysBl8bhKcbOyXfAVTZFr7A7Jk=;
        b=uoEGnGbMcA8J6Jj/QqIzAUwNXpG5U6XPVrH02jnpGPYVV9dW2wDh5WPKkHzzQPUFj8
         ldXRDoxBhDvILjFIZEsfhwfLTNu2GDz19sOWNPecud07sOavdA7lv90vVmDu76awKDbi
         epVmP/HZ7NEy2kN4NWexNwNX+D1dTwgehif3ZmKe/khoL2TQCzTYCEf7jiBrce6/rhsA
         adhG6HX1AX7qKIQji4EIGP13yHGvcjBu+cKnXB0Yz9csM9vOd5J0fWp5Mh4GGwPeFz3G
         N2C2Dqg+QsL2qfeTu/OfDim9n9n2cLULvjOtEf9il241VOZhAUWJ0Hf7n9E/wJ5GUZeV
         qGbw==
X-Gm-Message-State: AOAM532aN/xctwS2HbRnScSWCSr0TXUgPtXKamvNoVd5zMZmHPyazX4v
        yM26aVvoq6uK5ACePPfFwy+3gDQL8/w=
X-Google-Smtp-Source: ABdhPJw5bhyzAOfwQCDiUYN03VZjvkWN56sodZTnFlENHQvynP3ULgwxfjxkGD0xekXxToIadPJIIA==
X-Received: by 2002:a2e:9d87:: with SMTP id c7mr466512ljj.43.1609874684962;
        Tue, 05 Jan 2021 11:24:44 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id h1sm9116lfc.121.2021.01.05.11.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:24:44 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 4/5] refs/files-backend: don't peek into `struct lock_file`
Date:   Tue,  5 Jan 2021 20:23:49 +0100
Message-Id: <a3510f3969d26d26ade136b27a7b9dd1d9cc2976.1609874026.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609874026.git.martin.agren@gmail.com>
References: <cover.1609874026.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to the previous commits, avoid peeking into the `struct
lock_file`. Use the lock file API instead. Note how we obtain the path
to the lock file if `fdopen_lock_file()` failed and that this is not a
problem: as documented in lockfile.h, failure to "fdopen" does not roll
back the lock file and we're free to, e.g., query it for its path.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 refs/files-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 04e85e7002..4fdc68810b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1824,12 +1824,12 @@ static int create_symref_locked(struct files_ref_store *refs,
 
 	if (!fdopen_lock_file(&lock->lk, "w"))
 		return error("unable to fdopen %s: %s",
-			     lock->lk.tempfile->filename.buf, strerror(errno));
+			     get_lock_file_path(&lock->lk), strerror(errno));
 
 	update_symref_reflog(refs, lock, refname, target, logmsg);
 
 	/* no error check; commit_ref will check ferror */
-	fprintf(lock->lk.tempfile->fp, "ref: %s\n", target);
+	fprintf(get_lock_file_fp(&lock->lk), "ref: %s\n", target);
 	if (commit_ref(lock) < 0)
 		return error("unable to write symref for %s: %s", refname,
 			     strerror(errno));
-- 
2.30.0

