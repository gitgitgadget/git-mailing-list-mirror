Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CA9C2D0CD
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A233207FF
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 12:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlh6QTMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfLQMBx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:01:53 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34101 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfLQMBw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 07:01:52 -0500
Received: by mail-pj1-f67.google.com with SMTP id j11so4497977pjs.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 04:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CAkrqt19tr4PU/c0NR+jni1gYZ5EFpMiOfpujG+skJw=;
        b=qlh6QTMMyfntv/5BQX8dxbz70nKhEWQRRQnH+EOZyuKdTdeRMh9a8oejq7JaQbroeo
         LJmN7nmewLxsv5dZvBVVrKRjnWyUzQz1gV91Y9AZjoeKHVfagieQ6YDYey4DETSa9072
         8FgMXnV5LeEAtHjdmTtmCcobvU9Ck0OGcqTrykwLBOF1fssUCaSV3wKKycNNhPR6JkQd
         GV5FCcEJhbuc2jUFCFpKokUyXhRkUOmCgScEXlWqJJFjoMihXobf9RPSkF3W481wgvGm
         PpWcLs+pPG1vn7x2ybo5PQ8OjSao6JO6X7KAT9xTz5t5PLhHWWoXmLP3RkQUraLl9U9W
         GW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CAkrqt19tr4PU/c0NR+jni1gYZ5EFpMiOfpujG+skJw=;
        b=Yr7Lj+Y789vDyoREnxrQL7zzBqHBJxJAC/BVK53k1dV8VIH8p+omII+eOmi1KI4LAS
         yJsYDQvCtQ2F7mV0dtqCHxGE853WsQNZY3oW1/jPVAXNSDS8f52kwH/e28SAjWA01iwo
         GtRYlL04AwhZsVfRQNJ+WIyKNU4CVVq7yJShZH4OzMweZ+cC4qh5wYYuuYG0PdorHlS5
         5omd9C5MsifuLAr+KvtXbpThhcYb2vd6rvBkL4pO2TfhshnSpmTNc0fHwlqb0fZXcWqH
         9n/aRaybYUJX6WaZmyBPO+lKauTtvo7UDSUxMnDWD6F6orKMTRqIyIsZ8C9vbOrVyv9A
         86IQ==
X-Gm-Message-State: APjAAAVakKdmkT2aumhOd/Jio65P9R8Q2wwGIlyjwdtKnwYxeVfL+a+b
        gDjCwX8Zl9lCbqKlYZmmbTjdY0Gq
X-Google-Smtp-Source: APXvYqxHuTPLfRZrOwGeP7VJXTakcVi2OyutU6MmTtA55xVAWaDNdPe/DTE0wGi6z+5iw3RO61Ki8A==
X-Received: by 2002:a17:902:be02:: with SMTP id r2mr21274154pls.76.1576584111222;
        Tue, 17 Dec 2019 04:01:51 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id a15sm27531723pfh.169.2019.12.17.04.01.50
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:01:50 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 11/15] t1307: reorder `nongit test_must_fail`
Date:   Tue, 17 Dec 2019 04:01:36 -0800
Message-Id: <2dd91c5568835f8263d18db62c787deb1eeb1650.1576583819.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.0.627.geba02921db
In-Reply-To: <cover.1576583819.git.liu.denton@gmail.com>
References: <cover.1576583819.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the future, we plan on only allowing `test_must_fail` to work on a
restricted subset of commands, including `git`. Reorder the commands so
that `nongit` comes before `test_must_fail`. This way, `test_must_fail`
operates on a git command.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t1307-config-blob.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
index 37dc689d8c..002e6d3388 100755
--- a/t/t1307-config-blob.sh
+++ b/t/t1307-config-blob.sh
@@ -74,7 +74,7 @@ test_expect_success 'can parse blob ending with CR' '
 '
 
 test_expect_success 'config --blob outside of a repository is an error' '
-	test_must_fail nongit git config --blob=foo --list
+	nongit test_must_fail git config --blob=foo --list
 '
 
 test_done
-- 
2.24.0.627.geba02921db

