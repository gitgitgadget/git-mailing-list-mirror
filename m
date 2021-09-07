Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156C7C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECC161057
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 13:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344745AbhIGNiR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 09:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343628AbhIGNiE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 09:38:04 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC96CC06179A
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 06:36:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u26-20020a05600c441a00b002f66b2d8603so1850929wmn.4
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 06:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l0MAmZmOyqa1wApQi9lyUCvdt02PjhsqsP/HLs7DN4E=;
        b=awxBYRq/nXERqDbkEoTvRCR3p43D9S3Dfobr2M4hv1u/O92SwVMrNUCmmgiz2y8xWT
         0sV6ukXupTjzjI1VMQibpKPNCcgbEKXwq/WbezN78zEJYcmQnOK6NImrYsVLn3rywNSq
         iR2WbZZKxndCiI8nB5gZ5nNj+drpjbiicr7TjbNH7mtGittWQPNNzBGRrda2pTm4sCsD
         8e73zG6hkh6IjWQPKgsRvvB/Vz1U9ojGQkO7Ky6rhMmXqHOikIHnOoDqyl7A2Us4Wrbg
         TmbmwnXcWZdSZZs1OrlJi2t9lXlatzEAJS0CKPiQTaqc9QoAYIYwC04knbkQPxeyZ+1v
         jBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l0MAmZmOyqa1wApQi9lyUCvdt02PjhsqsP/HLs7DN4E=;
        b=qS2lWL/Na5R9K/tS9Z+oasXDAcF93Xlko8zD8GplLuU3MX0QesJd+7GvPfRM42Iouy
         4UA8jZfGquSEiNQLsszs4X1cuxrHiJV23FnLzl92cvsPq8fuK5tmjGgfiDKlWUDuQSpZ
         Fx+KBuJ5J1u6ZqodrBhHBqWLy2BnH0tKk0iOBqulgRjymUo0u6X4x41pTW3V4XBP0Y4V
         rtscu3Lu5Jo3oKQTpXV4EOP/rv/OTXeaolYF3vHugVXDj8fbbp2diTb1bSokK2GrVRrU
         aF7H94LOSBbX9y+4n3i6BScBrVKXcmVUz9USv2CH2sBgd13TgoJhZiGvlwDwcpCZZGb9
         zTig==
X-Gm-Message-State: AOAM532lknz3F1cZpSgxBNuUJg2RJ1XMnYu1bI+Ib/bkYc3FTPJIDb7C
        MfaCLbUjqGCC08D+3azgm/s7gpcpFfA=
X-Google-Smtp-Source: ABdhPJzdqIclqXUBmRQEK47DCvTV9w/bcOHQddIzsrl77Ze4giVuKdCKne3p2+OKwBDC/2ntfJsiAQ==
X-Received: by 2002:a1c:2bc6:: with SMTP id r189mr4046257wmr.183.1631021814386;
        Tue, 07 Sep 2021 06:36:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm11001994wrs.60.2021.09.07.06.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 06:36:54 -0700 (PDT)
Message-Id: <1124dbad594ed24d4b20d5afc213b57c6f253603.1631021808.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com>
References: <pull.1067.v2.git.git.1630947142.gitgitgadget@gmail.com>
        <pull.1067.v3.git.git.1631021808.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Sep 2021 13:36:48 +0000
Subject: [PATCH v3 7/7] refs: change log_ref_setup calling convention
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/files-backend.c | 48 ++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4aa4d2bbba1..114d01a9e3c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1535,30 +1535,26 @@ static int open_or_create_logfile(const char *path, void *cb)
 }
 
 /*
- * Create a reflog for a ref. If force_create = 0, only create the
- * reflog for certain refs (those for which should_autocreate_reflog
- * returns non-zero). Otherwise, create it regardless of the reference
- * name. If the logfile already existed or was created, return 0 and
- * set *logfd to the file descriptor opened for appending to the file.
- * If no logfile exists and we decided not to create one, return 0 and
- * set *logfd to -1. On failure, fill in *err, set *logfd to -1, and
- * return -1.
+ * Create a reflog for a ref. If force_create = 0, only create the reflog for
+ * certain refs (those for which should_autocreate_reflog returns non-zero).
+ * Otherwise, create it regardless of the reference name. On success, return the
+ * filedescriptor. If the log should not be written, return 0 On error, return
+ * -1 and fill in *err.
  */
-static int log_ref_setup(struct files_ref_store *refs,
-			 const char *refname, int force_create,
-			 int *logfd, struct strbuf *err)
+static int log_ref_setup(struct files_ref_store *refs, const char *refname,
+			 int force_create, struct strbuf *err)
 {
 	struct strbuf logfile_sb = STRBUF_INIT;
 	char *logfile;
 
-	*logfd = -1;
+	int logfd = -1;
 	if (!force_create && !should_autocreate_reflog(refname))
 		return 0;
 
 	files_reflog_path(refs, &logfile_sb, refname);
 	logfile = strbuf_detach(&logfile_sb, NULL);
 
-	if (raceproof_create_file(logfile, open_or_create_logfile, logfd)) {
+	if (raceproof_create_file(logfile, open_or_create_logfile, &logfd)) {
 		if (errno == ENOENT)
 			strbuf_addf(err,
 				    "unable to create directory for '%s': "
@@ -1572,11 +1568,11 @@ static int log_ref_setup(struct files_ref_store *refs,
 				    logfile, strerror(errno));
 	}
 
-	if (*logfd >= 0)
+	if (logfd > 0)
 		adjust_shared_perm(logfile);
 
 	free(logfile);
-	return (*logfd < 0) ? -1 : 0;
+	return logfd;
 }
 
 static int files_create_reflog(struct ref_store *ref_store, const char *refname,
@@ -1584,15 +1580,14 @@ static int files_create_reflog(struct ref_store *ref_store, const char *refname,
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE, "create_reflog");
-	int fd;
-
-	if (log_ref_setup(refs, refname, 1, &fd, err))
-		return -1;
+	int fd = log_ref_setup(refs, refname, 1, err);
 
-	if (fd >= 0)
+	if (fd > 0) {
 		close(fd);
+		return 0;
+	}
 
-	return 0;
+	return fd;
 }
 
 static int log_ref_write_fd(int fd, const struct object_id *old_oid,
@@ -1624,15 +1619,12 @@ static int files_log_ref_write(struct files_ref_store *refs,
 	if (log_all_ref_updates == LOG_REFS_UNSET)
 		log_all_ref_updates = is_bare_repository() ? LOG_REFS_NONE : LOG_REFS_NORMAL;
 
-	result = log_ref_setup(refs, refname,
-			       flags & REF_FORCE_CREATE_REFLOG,
-			       &logfd, err);
+	logfd = log_ref_setup(refs, refname, flags & REF_FORCE_CREATE_REFLOG,
+			      err);
 
-	if (result)
-		return result;
+	if (logfd <= 0)
+		return logfd;
 
-	if (logfd < 0)
-		return 0;
 	result = log_ref_write_fd(logfd, old_oid, new_oid,
 				  git_committer_info(0), msg);
 	if (result) {
-- 
gitgitgadget
