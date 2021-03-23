Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75975C433E3
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F22619A9
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 14:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbhCWOVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 10:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhCWOUg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 10:20:36 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714AFC061765
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:35 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id d10so10525178qve.7
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 07:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o3ECagYgvOeZ3IfgS2wYqyttLxn1HpoK5ooW9+lNVTM=;
        b=btZqkr03lVOh4Ib9NEPS+DR5huPkSVbIWoMTX4KRuWAd/UE6ldrwr/y+q93H7x7PHA
         LDSCuBSbUC3BgRLHpE+gE0NaAzyLiRZ88U9d5vu1gFXF27KHHyXCDn6UI3yWGMaWPbg2
         l+ZWh1B5JrqIhyc5OBDNfW9crMs2q7S3RysQxJllVfZLYDOC6xsrCjrv963Cdxz00d9/
         rFqaNLhl4KXN5zo47EnByccklxWlE5z11oF+RTnla6E7TTnHRu7rL9ascFKTZX1+EWtR
         Pz5EqaZai1LIeZE4dFPEFC1an43eNslUsVrOm+9OfIVdDGrnXqoZGp+AfJP/3UetQ2YH
         hNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o3ECagYgvOeZ3IfgS2wYqyttLxn1HpoK5ooW9+lNVTM=;
        b=Rd6QYtaJTaD+O8lMZaJaetTd1qjfJMR+BP9QILoOU22T/njkVdu2hkxCFSVQIS1WSG
         7XIqfaADWmuH9DIR8l5NFxcae6lgJ3tSO/cS9mcOuroKk61ULG4GszvhmhLoiYVI6vyz
         RyulRNp8P/Q0sQyO8093aCTljOE2ODtekU3lqWDgmSa3jt/We6htXN7+SHCLAcs8zEPF
         V5xhZV0i+mCahx9VGXZ3McwP1ASodr3U2ExLKVkZxSaMaPLa6hjTxdYorNYSETqAB/87
         kYmsMLwUsaNEhInWv98hIbibb7D7Fym7hogZJMGXedFLU1UMTr57F97UT5X/n28kGdRl
         stwQ==
X-Gm-Message-State: AOAM532P8cTNSPafgDOJQ7YpfGah/2CKq/ni9N4bGIZvmRjrEF0mBpTG
        R1d7j6vhQHn/1HA7sfMvDkRt4Q==
X-Google-Smtp-Source: ABdhPJywQmXMA8HZ0JQ+mMpWdcQl7ePAAdLVpR5W/Moo9QERfNC2ghE73fbiFViRNBuA2hN8jR8ujQ==
X-Received: by 2002:a0c:fa0d:: with SMTP id q13mr4936419qvn.15.1616509234655;
        Tue, 23 Mar 2021 07:20:34 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id j12sm11011690qtn.36.2021.03.23.07.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 07:20:34 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org
Subject: [PATCH v6 6/9] entry: make fstat_output() and read_blob_entry() public
Date:   Tue, 23 Mar 2021 11:19:33 -0300
Message-Id: <af8b1691cc7f634a9a9c0a65ab15dc22dc3b1007.1616508954.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1616508954.git.matheus.bernardino@usp.br>
References: <cover.1616508954.git.matheus.bernardino@usp.br>
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
index c3e511bfb3..1e2d9f7baa 100644
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
2.30.1

