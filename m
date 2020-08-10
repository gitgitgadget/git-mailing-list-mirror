Return-Path: <SRS0=S9iH=BU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F7DC433DF
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BDF6206DA
	for <git@archiver.kernel.org>; Mon, 10 Aug 2020 21:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="rpZBogLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgHJVey (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHJVey (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Aug 2020 17:34:54 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB719C061756
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:34:52 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n129so4194733qkd.6
        for <git@vger.kernel.org>; Mon, 10 Aug 2020 14:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/1NqtSVRsdQ/XrZ7wCWXEDYg8R3VKgCtklFQLw7ZAiA=;
        b=rpZBogLscM6/R/oZZ3sTOpV1nLTqcsvZ7V2nwQIYcVLeIIAUraoyFCC+vYm87RjPUZ
         /0ub4zx3TUVG8rxVhIFU82d2VmM22YmvukGk9P1v08RIMzl0i6RrJj6cBMA0CeLiwxM3
         5oL8d18L8Im2NLMM73+Wfy6PPXbbxFPxb9wblz0s3UrokUH6HXbo9Bw4vPaljVZLb69S
         khsKgZpQi5Ye4kAb4rEyaCc3QsY7s5bIOhmcZRNLrf6eY3LfkHNn7wfpiu52DEmZ4Ex0
         nMZGwc7DS0g+PrscHsq8mGLE0s+23fpP6mfOz8Dol6ouBuhnn1hQkY+zhD9Tw3oU174e
         5zsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/1NqtSVRsdQ/XrZ7wCWXEDYg8R3VKgCtklFQLw7ZAiA=;
        b=H6s6h0wxOkP7S9JlxrvLRsNgapjbayyg9cocUK/OgcrsRuQXaGjpdB9lHTu1uZFUhF
         imiflHTJTYxSPn8evgCWs/GVCw7W+l09HZrVq8lIB71+YOYxayCgbCDC5rJfppvJxzox
         c0oSbtHUW7EqJfkrMXGHNyGOS+oTmLuIhe8CNDSqBTFtPB2s3a9ysXRQFPx4Y3D1iGqm
         mzgi5K7idlscvBsnLHj7FCfMgVQOnw3UIe+A2SlJyV5lzdla2/9D2y/AXta2OkzKxKIk
         JfffcXNqp88oaQsevS4rpEbsyXfmGwOUU+HKxdwALr6aQbX4p0z7/bCLtdexdOttyOnr
         CEhA==
X-Gm-Message-State: AOAM5315ukPWAK9OAV8tOQ5W/sLGcqcUrJZBUWCoCxdUqJA39YMZvwHe
        17VpCEsMXIn2HW5t/yp8Vc2DNZgaHQg=
X-Google-Smtp-Source: ABdhPJzjmy3Grf0wylBvRcUIyvtlRMTha8ABKXroW4DY8S6hMuvlHfvqfSW1ZUECJ4rxiRfF4zTZ7A==
X-Received: by 2002:a05:620a:11b7:: with SMTP id c23mr21575992qkk.70.1597095291712;
        Mon, 10 Aug 2020 14:34:51 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:87c:466:1120:3c2c:21e4:5931])
        by smtp.gmail.com with ESMTPSA id z197sm15370674qkb.66.2020.08.10.14.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:34:50 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jeff King <peff@peff.net>, Denton Liu <liu.denton@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [RFC PATCH 06/21] entry: make fstat_output() and read_blob_entry() public
Date:   Mon, 10 Aug 2020 18:33:14 -0300
Message-Id: <4f86b585b7cd1ae60ba5f90a74f0cca9af59929c.1597093021.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
References: <cover.1597093021.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
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
index f46c06e831..cc27564473 100644
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
2.27.0

