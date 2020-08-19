Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E72C433E3
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 14:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F96E2080C
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 14:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHMCkEF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgHSO2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbgHSO2H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 10:28:07 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D533C061343
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 07:28:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r4so21707959wrx.9
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 07:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PkGI2LMW/ZUwdqVFcB7zHQ7z8COU+eDI3R4VNjzHwOg=;
        b=lHMCkEF7tWNPvJb4guSKuJOYswlLvkuXHsNCNWbfpcdWIH+1mr2y7e7CSpMde12SXC
         bdj1Dhhe4D31h/4ErcQgOSQpHoD8F1MDrqvFBxDU6PxT6MwGzvHWTKKGAM9ndxhfUqeS
         PRmRNYhNOW2m0azQ1yElCrO5fQO4Fgb4Mt63TG0NBdM2HPprZhM/nVgAB0gTU9Le8wES
         hl783F2GmfrpHNhmJnzjIADQSEtHaLH+cHH5aeihQMIZ7kT2X5VYCnYGE8XIYbfpGQzj
         g6l+iGCqGOtL/km64Fv+ko3ZnYAfmy42fTJLHCYB77E+R7ryIpNioN5vTHzhKQYteZr4
         oN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PkGI2LMW/ZUwdqVFcB7zHQ7z8COU+eDI3R4VNjzHwOg=;
        b=II5Re31zfu2by/YSb6xiJzCGepyfAffa9nsJqITNTfZxVvKn7YqfPq5AUwOac6nKMr
         0LG7xg0ZtazYOBwFMJJeKoMd7kCYNDCop+HHpZKn2FNDh7ybqexAqVptNMrDelWHEHO7
         XQZkbyFW/0katazV8yrfVx585jbe5rxoqAWTnRVFpjvSaZr8smyZzm2ZrOXRqCzSj/NT
         t7x66ayThBu9FTg2EJbf/JciS1SbkV80tBXMsmXFgxjmue63oqnjUxtMbqOx0PaXckhq
         iAofIXXDNAfN+YBbxGEb/yFVanAFL092Dm9m8XFC3SUxlboEM+pHl3y6ut7Z7Kkzo4LB
         FJxg==
X-Gm-Message-State: AOAM530g5w1JrF5Qv0qRb4YO3iYe8eoFxdH/scIfByoFyxvBHuX9vdeb
        fndewoOkH2lMtIKgXNd6sgdFpVOKEvU=
X-Google-Smtp-Source: ABdhPJycxZEBsfuJyMV1Z5j6fqAJ8E4dJ6JcSFTMrd1ZQ1ywrGsMjnmjY6lzjl9AjyPRvr8dzRDziw==
X-Received: by 2002:adf:ec45:: with SMTP id w5mr25515573wrn.415.1597847281311;
        Wed, 19 Aug 2020 07:28:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11sm5599012wmc.33.2020.08.19.07.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 07:28:00 -0700 (PDT)
Message-Id: <557727064d5e060e164984887652aa956b9d111c.1597847278.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.705.v2.git.1597847278.gitgitgadget@gmail.com>
References: <pull.705.git.1597678796.gitgitgadget@gmail.com>
        <pull.705.v2.git.1597847278.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 19 Aug 2020 14:27:55 +0000
Subject: [PATCH v2 1/4] refs: split off reading loose ref data in separate
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
separately from the ref backend.

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

