Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C23C1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 02:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeB0CdX (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 21:33:23 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45710 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbeB0CdT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 21:33:19 -0500
Received: by mail-qt0-f196.google.com with SMTP id v90so21402680qte.12
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 18:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A9Cty2Y40oLOh/Wh8CdpRp7Qs1WjUSFti8+pHM7peGE=;
        b=uWdBg2DDpEJUJTk2PTWsY0xWeml4IILJQBJr3Qh/y2ThY/5XqKe87PRuIBzVT3Oyt8
         tWh0JOf2lYVCWnSr2WfLrFBUtl2yKea67xOdeDPX2dJtmPhwNDj+bH6d/1ouIMAHSXHS
         O/5YosPKmrm6+OvR9p1WmKDyuIgRmVCM9KO+rdmOcJ3tprlAXnwpHklzFUP2XpD8HHlw
         PfIKdg62jLhKUdHdkU1ygyicrDlfn/EY+7ffKtutksopYwLkOLmY53hvMVqQ9pqIKd4W
         /S90SZkpHnGcK4OlyFr3eLcAA15bpW7zsau4EElOvxdicR0GnRninYuIVeYx9sBZX4OH
         5orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A9Cty2Y40oLOh/Wh8CdpRp7Qs1WjUSFti8+pHM7peGE=;
        b=h9p8Fh92rg+ysLV80wG7PYCCfvWAc6cuYmrfLSQhq4hQY8UW0vPwb0dCUhgfrwTuhu
         M1mgV8FVyKCGiDTAELH/Wv1L8QiQ1agqj7FLe618nM5v9Ykv2PpdYBom+XMJbIByzTvs
         xeQixUSYH/EE6iUzA4FcRnKpjpYik9axO4avAF2nN/A2ReVfHLoqO2QBo+K6kaZzeJO8
         jQIkqbuZrH4a1kDDr3efjY0zf5ZTYlvmePnwffVUJvSjPMV12vOQEyEjUIm7yTEbay/B
         3RAWn6xcrdH1pqufUeN6lgdhyrQShH5BDE4aVak2MRKV+HpVCmqB5bZu4nRUf2TMsxQg
         u9sQ==
X-Gm-Message-State: APf1xPAfVTflYVBj3vq4UrbQ3jTdRr2c61VWS8HN9Zxpz2CoYdN8JigI
        jmcNrUNlY1NpWuEfbZP2H4/v0zvFRKg=
X-Google-Smtp-Source: AG47ELtBN2vTmmGGv1KRGQoFgC++EkP4UC28nTZuckzGGEclBOEA8RzJHdwTptHGMR8iWrQ/sWuhxA==
X-Received: by 10.237.47.165 with SMTP id m34mr21936068qtd.51.1519698798279;
        Mon, 26 Feb 2018 18:33:18 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id 94sm5566530qtb.2.2018.02.26.18.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Feb 2018 18:33:17 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        jonathantanmy@google.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 04/13] csum-file: add CSUM_KEEP_OPEN flag
Date:   Mon, 26 Feb 2018 21:32:58 -0500
Message-Id: <1519698787-190494-5-git-send-email-dstolee@microsoft.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch is new to the series due to the interactions with the lockfile API
and the hashfile API. I need to ensure the hashfile writes the hash value at
the end of the file, but keep the file descriptor open so the lock is valid.

I welcome any susggestions to this patch or to the way I use it in the commit
that follows.

-- >8 --

If we want to use a hashfile on the temporary file for a lockfile, then
we need hashclose() to fully write the trailing hash but also keep the
file descriptor open.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 csum-file.c | 10 +++++++---
 csum-file.h |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 5eda7fb..302e6ae 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -66,9 +66,13 @@ int hashclose(struct hashfile *f, unsigned char *result, unsigned int flags)
 		flush(f, f->buffer, the_hash_algo->rawsz);
 		if (flags & CSUM_FSYNC)
 			fsync_or_die(f->fd, f->name);
-		if (close(f->fd))
-			die_errno("%s: sha1 file error on close", f->name);
-		fd = 0;
+		if (flags & CSUM_KEEP_OPEN)
+			fd = f->fd;
+		else {
+			if (close(f->fd))
+				die_errno("%s: sha1 file error on close", f->name);
+			fd = 0;
+		}
 	} else
 		fd = f->fd;
 	if (0 <= f->check_fd) {
diff --git a/csum-file.h b/csum-file.h
index 992e5c0..b7c0e48 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -29,6 +29,7 @@ extern int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
 /* hashclose flags */
 #define CSUM_CLOSE	1
 #define CSUM_FSYNC	2
+#define CSUM_KEEP_OPEN	4
 
 extern struct hashfile *hashfd(int fd, const char *name);
 extern struct hashfile *hashfd_check(const char *name);
-- 
2.7.4

