Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC28C388F7
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 031C020782
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 20:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="eFIL1wvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbgKDUd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKDUdy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 15:33:54 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B48BC0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 12:33:54 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id l2so20685360qkf.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 12:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TG+HUabaJz0q+hpO92ZhNvJW7axRZAVyBNT9ft6nAJI=;
        b=eFIL1wvyd+/stJjEDBUdB6T2WCguaIdtw1KFHWiKikEoQkxHSapOI8gqt9JDgEVS1q
         Mk2gYP8QT4qv/KkG+aKIzkPOo8oyFhhkpXin4w7xrhujcG0LSjVYTnerLWlI6iCd/OSY
         VFoOsjP7OCW4ZPoG4jbtCWPBQBKQI+CiW0KRd9yd3sxhcgmXn3j0aZK74dmtP3yhAoxf
         1HS0zdWLekVNnfQgqjUNOLSqWQtnmM7tmXjIUzWLcmGxnw1waI+QQisZoKuGJJoP6kgY
         3ikBfwYFQvf66YUG9CUuwRKblKVfVwe/BXsudtPtoiltA+ObjwNUPgR1aEPhlJERocw+
         41dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TG+HUabaJz0q+hpO92ZhNvJW7axRZAVyBNT9ft6nAJI=;
        b=J7qrdxtnF0EfLc78r/G/kAtNKv9Sw2vElXBDD3ZBIFe/jsxqtPWAdaPvxlL/jVCwec
         2gV9jhIG+mffaveaVL42ZwUxlPb0CdcTkLFD3c5y5zXccA/KJNnxq/nrESNc2mjaznuX
         4jBaIhpK57itqKquYbwG4BfDicvZW/QCiiDJwg42cbEjnXOVhD8F+bwGTzeNkwBJUKkM
         zAOjuLeYCOC6UDsnJ0SzxuSrQG5ugOIojkt8KxQBfbGv6Bj7brHVhazHzjVo0liTB33N
         amE4RrGLsQTYKt0vR+0fainn0xO5wOx8gzyY4XiDXx+IyUift1R6g36mMGCVGm/ZqQqc
         ib8Q==
X-Gm-Message-State: AOAM531zjPj2aHU7ThouZPOHgiande/gb2oREy83QPkUpeBoR7svh598
        BbY1Rk2ncBbLrck4TOlZ8xns7QqDKSbEVg==
X-Google-Smtp-Source: ABdhPJzO7A3PrgcI3xxFbtHAOPk0YLk8zAWeGe72+YX/RDd+0pEJq6COdJWMr3DTbuJBLDH84Wfqyw==
X-Received: by 2002:a37:a54d:: with SMTP id o74mr6566961qke.296.1604522033164;
        Wed, 04 Nov 2020 12:33:53 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id m15sm1100971qtc.90.2020.11.04.12.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:33:52 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, git@jeffhostetler.com, chriscool@tuxfamily.org,
        peff@peff.net, newren@gmail.com, jrnieder@gmail.com,
        martin.agren@gmail.com
Subject: [PATCH v4 06/19] entry: make fstat_output() and read_blob_entry() public
Date:   Wed,  4 Nov 2020 17:33:05 -0300
Message-Id: <46ed6274d7bff1747a73f3a032fa907af2082782.1604521275.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604521275.git.matheus.bernardino@usp.br>
References: <cover.1604521275.git.matheus.bernardino@usp.br>
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
 entry.h | 3 +++
 2 files changed, 7 insertions(+), 4 deletions(-)

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
index acbbb90220..60df93ca78 100644
--- a/entry.h
+++ b/entry.h
@@ -39,4 +39,7 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
  */
 void unlink_entry(const struct cache_entry *ce);
 
+void *read_blob_entry(const struct cache_entry *ce, unsigned long *size);
+int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st);
+
 #endif /* ENTRY_H */
-- 
2.28.0

