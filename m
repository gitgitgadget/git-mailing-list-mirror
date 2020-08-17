Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18A8C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 15:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B19522C9F
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 15:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtK018fo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbgHQPkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387471AbgHQPkL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 11:40:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80539C061342
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 08:40:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 9so13600246wmj.5
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PkGI2LMW/ZUwdqVFcB7zHQ7z8COU+eDI3R4VNjzHwOg=;
        b=BtK018foeenRGANJGER59a2gP9nHEGPjbR4LNjXb6B1Aah1rmT2k9b+I8BRv1IvIo1
         kvRyJBPD0htCz8w4s/Mm80A3IGt+b+MpKDo9W2ghDMs8Qb47WiF0rdWMtzulJPAtb1by
         mWy3Fi9kDV359TdyEtst96iQY096qo6ZKo9fhZNdBv+LrppjYMtVMuChM9+wLTa+iMm+
         H2R/WDBo9ADj0zTDFEJ5eVIWfN7ElyTwWZq3DfgTjQjD6S0vDh2DuI0oSUu+8tN7uAP1
         zRn1wZsTXLoFfsd7azSxjpYwKxAxYX59JkDJvSsU98bNmM2F+Gg4gYMzE2fVh6m19OU7
         VUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PkGI2LMW/ZUwdqVFcB7zHQ7z8COU+eDI3R4VNjzHwOg=;
        b=F3ABQoyETl0BGK34M++2voKcfpmYkVvlq9cSCsBCW425gIPeqExcC1rWChEt6VTrOx
         DM7JnflUAJhJ1h2NOcMbQT6ueLInVU4SSByTCVq+L2s78Jzl1q/LCsjptZAcxYoN91me
         5fz/IXZhdw+D0e5orUyXtmE6CpmpEP98LQycKWIHnAXAEIIEpCEXpL8Aw17FW/WubtcK
         +tVTJ+cNNGK1qVk9xp0vOhaXzkg7CJOQI3R0z1unqOJHf5svJCxKou2QkS6t3uZKueei
         uTxH1olGOmKAM57Yw3PsZ0C0hJsnef70NfeY3KBIwH981R8qXEWr9HWw0x00WqMtPops
         jDSg==
X-Gm-Message-State: AOAM532P9oi1ljsix8db2fc7t/HoloYAzCT543iv4LW3xfXeB0PHIeJ+
        R1FmGb+SOTX0M08F7YCaWWBt0t0hYuo=
X-Google-Smtp-Source: ABdhPJzZJx0m3dfYwqzWB0KsrJzGbeur6Y5CHu37SZ8bdVOhIuueFGlSGnJDGSIPeMfkb2GO1MhM3g==
X-Received: by 2002:a1c:678b:: with SMTP id b133mr16239836wmc.117.1597678799074;
        Mon, 17 Aug 2020 08:39:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d23sm30887693wmd.27.2020.08.17.08.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 08:39:58 -0700 (PDT)
Message-Id: <10b333695e913983de0885400833f406e8383de2.1597678796.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.705.git.1597678796.gitgitgadget@gmail.com>
References: <pull.705.git.1597678796.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 15:39:53 +0000
Subject: [PATCH 1/4] Split off reading loose ref data in separate function
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

