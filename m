Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F783C5DF9D
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3831A20747
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 02:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="PLxqdMNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403926AbgJ2CQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 22:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbgJ2CPn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 22:15:43 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55193C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:43 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id s14so850138qkg.11
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 19:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pnjvx5nwJkdEA5uoqvN7tjpCjIhkVeUGZe2ysSBLLsA=;
        b=PLxqdMNPyLHNqcYV0AqQB4FL5N87WswBQoXvR4g8SxwiORgkXyoueFncovGPPpuLFq
         y1XqLF5utoT6ZxLM5yHzZ7LZzyo7I/RI+5OmXXiTu8FIbXGZHs8b9whoKE0gdnZ/9gfD
         y3y6mMLjXbJyqRZkH7FRvmnTQH3Pm9Seho1/lR6EG9w4D29CKFHINEUyydgcAgm8ZH/L
         O/WElwawdfAWuNTKs0TSW95Xov9Hh8sDVVIiW87mjPld3CE0uG8bILDzXPcftQcR7lc+
         oKUccemZe7vJLSo0+/6TNr5HkLDQaYnGNIaopMtFgT694C/rtS/F2sc6GC51JJfkR3YZ
         3WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pnjvx5nwJkdEA5uoqvN7tjpCjIhkVeUGZe2ysSBLLsA=;
        b=RLZFAvjh8/mPluDt0HzHVZyABHbSjbyUHbcZpzAbT+AQJ4VE8mqywKVLYjMbyju+lY
         oTPnViIKkCif+LiXQJmO4vgk3VBM1251xxQxQP9+CSlzWb77wDd3nU0sBd9HzPvcrf2e
         ZhYvruCpNrE267c/IH3f0ce64XmrdanV6F/qlfugTWGoys/Vb66WbPMIAtUC9GLdwwOp
         vn3SRb8N6+DGlPmt5/4YsKCfJh7gXZpIVfup5F6aL/NG/HTdRoUpSrjj79wLsPvndgvf
         q2FXgZOc4+Mh9dqQXDwoUMEqZP2vsjsw7+sWbh79rIOpjHohJIRlr8TfSCulx4jB6O1l
         gUCQ==
X-Gm-Message-State: AOAM531TXyB4CKKMxV6tM6zaO5TA+LRzjWFkZVCieIfvGf2pjm7i07L5
        ajxo+Yh6hqhSzlHe2P/454CGdJqwBRmwjg==
X-Google-Smtp-Source: ABdhPJznlAqRABL1uKCHCurLImOcukpfZrBw/FWLG2QPcyx8Dc/MxjIJVw26pLtZVoqFLPh7qd5nMw==
X-Received: by 2002:a05:620a:2054:: with SMTP id d20mr1667905qka.175.1603937742186;
        Wed, 28 Oct 2020 19:15:42 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id n201sm608371qka.32.2020.10.28.19.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 19:15:41 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v3 06/19] entry: make fstat_output() and read_blob_entry() public
Date:   Wed, 28 Oct 2020 23:14:43 -0300
Message-Id: <bfa52df9e2a51c62cf75ac18603f1bbf4f7c3081.1603937110.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603937110.git.matheus.bernardino@usp.br>
References: <cover.1603937110.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two functions will be used by the parallel checkout code, so let's
make them public. Note: fstat_output() is renamed to
fstat_checkout_output(), now that it has become public, seeking to avoid
future name collisions.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 entry.c | 8 ++++----
 entry.h | 2 ++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/entry.c b/entry.c
index b0b8099699..b36071a610 100644
--- a/entry.c
+++ b/entry.c
@@ -84,7 +84,7 @@ static int create_file(const char *path, unsigned int mode)
 	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
 }
 
-static void *read_blob_entry(const struct cache_entry *ce, unsigned long *size)
+void *read_blob_entry(const struct cache_entry *ce, unsigned long *size)
 {
 	enum object_type type;
 	void *blob_data = read_object_file(&ce->oid, &type, size);
@@ -109,7 +109,7 @@ static int open_output_fd(char *path, const struct cache_entry *ce, int to_tempf
 	}
 }
 
-static int fstat_output(int fd, const struct checkout *state, struct stat *st)
+int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st)
 {
 	/* use fstat() only when path == ce->name */
 	if (fstat_is_reliable() &&
@@ -132,7 +132,7 @@ static int streaming_write_entry(const struct cache_entry *ce, char *path,
 		return -1;
 
 	result |= stream_blob_to_fd(fd, &ce->oid, filter, 1);
-	*fstat_done = fstat_output(fd, state, statbuf);
+	*fstat_done = fstat_checkout_output(fd, state, statbuf);
 	result |= close(fd);
 
 	if (result)
@@ -346,7 +346,7 @@ static int write_entry(struct cache_entry *ce,
 
 		wrote = write_in_full(fd, new_blob, size);
 		if (!to_tempfile)
-			fstat_done = fstat_output(fd, state, &st);
+			fstat_done = fstat_checkout_output(fd, state, &st);
 		close(fd);
 		free(new_blob);
 		if (wrote < 0)
diff --git a/entry.h b/entry.h
index 2d69185448..f860e60846 100644
--- a/entry.h
+++ b/entry.h
@@ -37,5 +37,7 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
  * removal, such that empty directories get removed.
  */
 void unlink_entry(const struct cache_entry *ce);
+void *read_blob_entry(const struct cache_entry *ce, unsigned long *size);
+int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st);
 
 #endif /* ENTRY_H */
-- 
2.28.0

