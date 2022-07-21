Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D30DC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 09:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiGUJGO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 05:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiGUJGK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 05:06:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB2652E79
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 02:06:07 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b133so1189746pfb.6
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 02:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2INkS0aNYDFhpobbJlmoECKz7Cb9QU+Cpz3YQTVy+WA=;
        b=qpb8cVIIpHkFg58hap5g3YO014uC22MWw3f9XdZDzud+f2D01L8gxaAgtJ1h4b+0wM
         Kt+CsgclJZxPZNq6+8tNkuX0RZQaDQck8jhIbROsUKFKI/LXHNNMPBpCG73WbvcXPoYN
         uqwWLSjjvqtRK/qdt2jU1dC/QXA9D0c6JT+fPLfepUTUX49xrtERfNrlU1UR8YHO3kHq
         MKlbnxyT9OSr/dfajtWxf03GVZMMnMI8OlzJ0iuN0yNlmJ+5LdGVb96OEbI7SLMBgew8
         I8G5aUQD96erQ7itD+uygDKxTPpXygMvKvoiEhpsNlqiZGOx5mEn47+M99ajUC0eWEyv
         8XDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2INkS0aNYDFhpobbJlmoECKz7Cb9QU+Cpz3YQTVy+WA=;
        b=wTqK6R1K6mPACJ7As36uncHV7XXYdRCupHkCPWDT4uTnAXyHB/fqvSR78mTGPLWVgk
         r/9FJkIIu9xN8EKW2nzcWW7Blui5o+CRcPLuKyqEiU43gRW1MOkld/Du0Va8EWwdu5tm
         wnCpqhyu39WAdCZjsvI+f48ayGCFAyWLKuPN1dgGr9+ReoN2106dJAkIYx0quEacF3lN
         uao+kv9QylYzsnbQDuE7etQU2yFvIng53uLecKMKBWq/+ZJMcfzpY9am416+VpJnCI/L
         OeMi+kvhBuVtrJcnJnZQ7jnb6ncgENxcoewyLZkinYg+zjgaXjsRWwSqA4Q7RYraPdeU
         aoMA==
X-Gm-Message-State: AJIora+KAvNKzONnO0U73QELKwIIEy+HxEKqN1ry+FVR6DW49qxsEXJ8
        15bYcHMmoNt0e2iv1tjdzfI=
X-Google-Smtp-Source: AGRyM1vbWNh8cT0ofcp39otgYv4SaS8JVUU0CMgE15VxGu8GXtfOy+mk0BIj/NWH9iVEtGbY8ikmlQ==
X-Received: by 2002:a63:756:0:b0:41a:8d6b:792a with SMTP id 83-20020a630756000000b0041a8d6b792amr222951pgh.432.1658394367405;
        Thu, 21 Jul 2022 02:06:07 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090322ca00b0016c9e5f291bsm1127291plg.111.2022.07.21.02.06.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jul 2022 02:06:06 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@tenglongtldeMacBook-Pro.local>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v8 4/6] pack-bitmap.c: do not ignore error when opening a bitmap file
Date:   Thu, 21 Jul 2022 17:05:46 +0800
Message-Id: <d11ea092d511f3be4601f65ec54d492474fe821c.1658393856.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.679.gc613175da2
In-Reply-To: <cover.1658393855.git.dyroneteng@gmail.com>
References: <cover.1658393855.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Calls to git_open() to open the pack bitmap file and
multi-pack bitmap file do not report any error when they
fail.  These files are optional and it is not an error if
open failed due to ENOENT, but we shouldn't be ignoring
other kinds of errors.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 7d8cc063fc..f8f9937c9e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -317,10 +317,13 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	char *bitmap_name = midx_bitmap_filename(midx);
 	int fd = git_open(bitmap_name);
 
-	free(bitmap_name);
-
-	if (fd < 0)
+	if (fd < 0) {
+		if (errno != ENOENT)
+			warning_errno("cannot open '%s'", bitmap_name);
+		free(bitmap_name);
 		return -1;
+	}
+	free(bitmap_name);
 
 	if (fstat(fd, &st)) {
 		close(fd);
@@ -376,10 +379,14 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 
 	bitmap_name = pack_bitmap_filename(packfile);
 	fd = git_open(bitmap_name);
-	free(bitmap_name);
 
-	if (fd < 0)
+	if (fd < 0) {
+		if (errno != ENOENT)
+			warning_errno("cannot open '%s'", bitmap_name);
+		free(bitmap_name);
 		return -1;
+	}
+	free(bitmap_name);
 
 	if (fstat(fd, &st)) {
 		close(fd);
-- 
2.35.0.rc0.679.gc613175da2

