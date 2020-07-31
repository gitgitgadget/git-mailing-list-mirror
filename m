Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEF9C433E3
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 385BE208E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUUY3x6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732627AbgGaP1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbgGaP1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541F6C061756
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so28313852wrj.13
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VAgTHFnMW7bk7rrR+YEm302UdQ0/BXviUIbtuoGzlYk=;
        b=SUUY3x6fhwj/e2ST5EI8VBHNjCw1SxSPkTTlOIa3Wdo26jvvzhhZrjqsvm03NztvSj
         M9wqL7pQCEPgAgLwwWcjlEMfDMNseAQrdpPld90gM4lOonSYPYxU6HUzVHI2m3ArHnM9
         She2Mji6mLL3BIvQHEuFgaG6JZVVav6jFjSJD2yFshG7Pt4Pzu8TLH5fEovnOyETGahb
         Bbsrvd+F1xBRU98gI7d9gsf1D1tvm0a/1ldtUKHYpxPU6V1sZMEPoNAbh0Q1JXpEY9JY
         jlvEYFDZ9fgRub2M2t0xBWysU2qjEbsSfFdmt6KcYSH9V0xfW5ETwzrPmO2fxkmN0c2U
         3CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VAgTHFnMW7bk7rrR+YEm302UdQ0/BXviUIbtuoGzlYk=;
        b=R/++2OLKdQiy6vIwtesID9+haKQpfSP0aFac4mpcp6kKBUXIdDxrx1uQaQDOy6FL4Z
         OyOjRM2gbwgcpBGZDYMDESyrWhvyMRMvLe6/NRoZoOKS31du6/HCUIX/fs7KB3gsajMK
         0pzCiKCZlPCJaCrPeS8O9rbS2sYEzs3y3Un3Rvy9KpUe7TBcSgJQnsXddZUO3gMjqe47
         UaFofSEvsCFiaQAAc9D9QZhjhsuScSLGG6FfP09uGTs1Q4+pjRokTd/HxVieKMEoigXi
         oFJ2RCBy47C2H4ULcbXU373XNdsOpGEeyUUu0V+p5WOhI+klHyqyoFGmuZ2NcHxuVWjx
         AcMQ==
X-Gm-Message-State: AOAM530UBDpudIuZUNknlyruLw3AwBH31/GfVYgPCJtLP8PVFMuSQxCl
        mBUSnC1IHmg+3h5HFs4MQCsdYSak
X-Google-Smtp-Source: ABdhPJzjnpM8DQs6hVlcv9BtriyaN+lbU4Si34xI7V1O9r/q1m5Qj365S6trsGTkuCc300bVzUBKWQ==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr3923030wrn.65.1596209241944;
        Fri, 31 Jul 2020 08:27:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 129sm13624334wmd.48.2020.07.31.08.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:21 -0700 (PDT)
Message-Id: <d0f0680c0e10b3248fcb4aa45d6c0ed84680f9e7.1596209238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:26:58 +0000
Subject: [PATCH v20 02/21] Split off reading loose ref data in separate
 function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This prepares for handling FETCH_HEAD (which is not a regular ref)
separately in the reftable backend.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/files-backend.c | 34 +++++++++++++++++++---------------
 refs/refs-internal.h |  6 ++++++
 2 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 985631f33e..3a3573986f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -360,7 +360,6 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	struct strbuf sb_path = STRBUF_INIT;
 	const char *path;
 	const char *buf;
-	const char *p;
 	struct stat st;
 	int fd;
 	int ret = -1;
@@ -465,6 +464,21 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	close(fd);
 	strbuf_rtrim(&sb_contents);
 	buf = sb_contents.buf;
+
+	ret = parse_loose_ref_contents(buf, oid, referent, type);
+
+out:
+	save_errno = errno;
+	strbuf_release(&sb_path);
+	strbuf_release(&sb_contents);
+	errno = save_errno;
+	return ret;
+}
+
+int parse_loose_ref_contents(const char *buf, struct object_id *oid,
+			     struct strbuf *referent, unsigned int *type)
+{
+	const char *p;
 	if (skip_prefix(buf, "ref:", &buf)) {
 		while (isspace(*buf))
 			buf++;
@@ -472,29 +486,19 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 		strbuf_reset(referent);
 		strbuf_addstr(referent, buf);
 		*type |= REF_ISSYMREF;
-		ret = 0;
-		goto out;
+		return 0;
 	}
 
 	/*
-	 * Please note that FETCH_HEAD has additional
-	 * data after the sha.
+	 * FETCH_HEAD has additional data after the sha.
 	 */
 	if (parse_oid_hex(buf, oid, &p) ||
 	    (*p != '\0' && !isspace(*p))) {
 		*type |= REF_ISBROKEN;
 		errno = EINVAL;
-		goto out;
+		return -1;
 	}
-
-	ret = 0;
-
-out:
-	save_errno = errno;
-	strbuf_release(&sb_path);
-	strbuf_release(&sb_contents);
-	errno = save_errno;
-	return ret;
+	return 0;
 }
 
 static void unlock_ref(struct ref_lock *lock)
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 357359a0be..24d79fb5c1 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -674,6 +674,12 @@ struct ref_store {
 	const struct ref_storage_be *be;
 };
 
+/*
+ * Parse contents of a loose ref file.
+ */
+int parse_loose_ref_contents(const char *buf, struct object_id *oid,
+			     struct strbuf *referent, unsigned int *type);
+
 /*
  * Fill in the generic part of refs and add it to our collection of
  * reference stores.
-- 
gitgitgadget

