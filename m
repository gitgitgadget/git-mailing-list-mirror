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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A3FC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7195C22CF8
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbhAET0C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbhAET0B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:26:01 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E2EC061798
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:24:44 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id x20so966353lfe.12
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OTcZy0lfk9sqHtVCIHKXZztuPDmTjS6lr9VU7ngS/FE=;
        b=M7T0ZEt4Q0RgsdDUdczYvzkkRcvc/7V7ZphlpIUbNZ+9IDRjQgJHc8szXFkM4k9FOU
         vOkuY5MQ5RifJxj+q0OIiniGbRr3k53xWx8mypnuw8F8aiE/t2DaYFGM6LFKiUX5Y1eT
         ycoEQdiAyYV8xl1Tzodf6Exp+GIGsyg5ubK8gIN7s0OXQmFBXy/jQxbKKrksCAipmyUy
         k6qfn5fjARoHl5xezdgxHnRjptt+FzhsUHGTn27vADIqclPKpm6lD+PfnURH34lFe7Iy
         jxB/tBPIIEbBt2Rc37SrbATdUZltCp1OCEAGfiOoJ6PC3izr++xiH3SpB+bDWBRoraqi
         ZjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OTcZy0lfk9sqHtVCIHKXZztuPDmTjS6lr9VU7ngS/FE=;
        b=hvRPJMr9HxZpo9Nz3ah16rsm6BOYTy6swU7RyYxMZgbvWYiIx4qC7VNPl3GVt1hgim
         /WgFmsv/mb2h5f2kQWh/vyHIM9uX7UrajG+YPoCZbKWV1Brd3wDDGhkdnCmTbNFMy5i8
         LpEc+wX0TIoB+u8BO54F4vgMd/IjVEAWBRW3PpRF3wnDwj/1zIVcpuES03Ca2Nu7mi40
         Mdpe0FuYJUIyjK38d77YzR4FwbxKmjOZh3bnbheEga7hMI7vNSndIn9V0dhQtKQ9SLHe
         Q+3Nd5aF9hU5FnwSUYUAMm7/9y1gR5zf0na/UwQ5Nb7jB17wjJhBHzd3T0XYO9+H7bzQ
         5Mww==
X-Gm-Message-State: AOAM5311q7q/z1+UIyDIYQwMaiZ0Mp7N4ve3C3uAf5d0yPdYsp6ocpSb
        Rv6AcZVYUOyezc79OiQ8dqMZq8THSBA=
X-Google-Smtp-Source: ABdhPJxB3GmuyOx2j62etNtfV0NHYxHxAMEOSc3n3VxlOM+jkMxhmtrXni4sObSajf9FspY9g1f8OQ==
X-Received: by 2002:a19:991:: with SMTP id 139mr320837lfj.637.1609874683220;
        Tue, 05 Jan 2021 11:24:43 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id h1sm9116lfc.121.2021.01.05.11.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:24:42 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 3/5] midx: don't peek into `struct lock_file`
Date:   Tue,  5 Jan 2021 20:23:48 +0100
Message-Id: <6dfb457b2a3187546eb4b4d90679348f2051a57d.1609874026.git.martin.agren@gmail.com>
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
lock_file`. Use the lock file API instead.

The two functions we're calling here double-check that the tempfile is
indeed "active", which is arguably overkill considering how we took the
lock on the line immediately above. More importantly, this future-proofs
us against, e.g., other code appearing between these two lines or the
lock file and/or tempfile internals changing.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 midx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 79c282b070..9d41b9c271 100644
--- a/midx.c
+++ b/midx.c
@@ -918,7 +918,7 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 					(pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
 
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
-	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
+	f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
 	FREE_AND_NULL(midx_name);
 
 	if (packs.m)
-- 
2.30.0

