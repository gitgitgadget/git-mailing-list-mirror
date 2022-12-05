Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B453DC4708D
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 19:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiLETAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 14:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiLETA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 14:00:29 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0A5B84E
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 11:00:27 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id n21so745227ejb.9
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 11:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SOe2Bq8Kq6b1KFnlnj0EmvIM01Cqh4p1zVmeegAbLdc=;
        b=acvwlAlWQpxa+LOuIGSEJMn2bHMcywPqRl1owQULh7T8MFnczONxJ2Exu2ouqFBPDa
         N74MG5SghN1ZITAJhC4YeORsFDQ7RpBCcolMotspFg+DtqiK0LfDck4E6WRYqbE+zmi7
         SVH8vJgxgePqLyCLvd5eTYbKi1j+2ng295zN0Nbn0qeLE71u4Xe/pxT5L5IjYVlgP8Yf
         j14cLOsBWxQdovsQhidUCncG0Hh2dnF5ZSHuz91pobQXspAn0HQ88QGqGZnHCWXUptHR
         ASzEXIXIdPL7C10mdD5Nl9+MQU/JW71YJ6ZCKNCnUMsn/EPoPxDHAMjBFWexewh59Pqp
         EZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SOe2Bq8Kq6b1KFnlnj0EmvIM01Cqh4p1zVmeegAbLdc=;
        b=AZLYV90VBYlzQy5rV3YaqYjJo9frTAQQvsCyPVAnKUXCSVn6Yp1EDj0/ydEOzg+ndO
         IYcqx+dPoS3v6S/XaFs7eA43wUn9vW5ORHbcSkj1L3ADotmbDf7GKZZtZ8lQJR5wc+Yu
         oFh+iNHOr+B0sKLTOJasfzY+b17wtf8c48WEhloHdyIqQS1ipnLkA9E1TfyImTvMNQ0D
         i+T1FOZ7imqXnzw2bJVgTzckiAQNyAE5Abu3vNzfaJr26SjI2HJseSrGdMXTWCqjBY/b
         F4EwytTgtEDGwgbD6I+lbW7OqU6bhuiKempuXLHiTzL2ArW7f09I0PlxefXBsm0fQUfs
         Ok0A==
X-Gm-Message-State: ANoB5pl6y6q1nkayx8GF4sawckVxfQSYWzUCR+tEdCW6LNTFK3mvszo/
        6/vopl6OfHKM6S6Rng07AqpGWPHiEm8=
X-Google-Smtp-Source: AA0mqf4GEFgG04pxdRB38uGSzeTMF4EXeqxPUQkhpL4eZnCYP2IxaTiLQKeFuV1A6AQYDSQ4zAVQqQ==
X-Received: by 2002:a17:906:6ac1:b0:7c0:9a3:87ff with SMTP id q1-20020a1709066ac100b007c009a387ffmr30687308ejs.505.1670266826141;
        Mon, 05 Dec 2022 11:00:26 -0800 (PST)
Received: from debianHome.localdomain (dynamic-077-008-023-161.77.8.pool.telefonica.de. [77.8.23.161])
        by smtp.gmail.com with ESMTPSA id s26-20020aa7cb1a000000b0045b3853c4b7sm113255edt.51.2022.12.05.11.00.25
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:00:25 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     git@vger.kernel.org
Subject: [PATCH] setup: avoid unconditional open with write flags
Date:   Mon,  5 Dec 2022 20:00:19 +0100
Message-Id: <20221205190019.52829-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 57f5d52a942 ("common-main: call sanitize_stdfds()") added the
sanitization for standard file descriptors (stdin, stdout, stderr) to
all binaries.  The lead to all binaries unconditionally opening
/dev/null with the flag O_RDWR (read and write).  Most of the time the
standard file descriptors should be set up properly and the sanitization
ends up doing nothing.

There are many non modifying git operations, like `git status` or `git
stash list`, which might be called by a parent to gather information
about the repository.  That parent might run under a seccomp filter to
avoid accidental modification or unwanted command execution on memory
corruptions.  As part of that seccomp filter open(2) and openat(2) might
be only allowed in read-only mode (O_RDONLY), thus preventing git's
sanitation and stopping the application.

Check before opening /dev/null to populate a possible non-present
standard file descriptor if actually any is missing.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
Alternatively one could add a command line argument
(`--no-stdfd-sanitization`).
---
 setup.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index cefd5f6..2af7170 100644
--- a/setup.c
+++ b/setup.c
@@ -1669,7 +1669,14 @@ const char *resolve_gitdir_gently(const char *suspect, int *return_error_code)
 /* if any standard file descriptor is missing open it to /dev/null */
 void sanitize_stdfds(void)
 {
-	int fd = xopen("/dev/null", O_RDWR);
+	int fd;
+
+	if (fcntl(0, F_GETFD) != -1 &&
+	    fcntl(1, F_GETFD) != -1 &&
+	    fcntl(2, F_GETFD) != -1)
+		return;
+
+	fd = xopen("/dev/null", O_RDWR);
 	while (fd < 2)
 		fd = xdup(fd);
 	if (fd > 2)
-- 
2.38.1

