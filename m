Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E429FC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B83E7208E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGDRJ0Bq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgGaP1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgGaP1X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D068BC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a14so28387594wra.5
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZSCrgk5+sMFrmaVpehfL7VYDj4kraqL145ODGpjev7w=;
        b=KGDRJ0BqrddWCJiItel+71tp+0KiZYnu2a1tLP+dCz2kHRd6FrL2D+A8HW4nFrRIh/
         yVaTDoOZXoXnhdjlG1ntVeW+KZrdUzBSIcOBjaTKYv/7zKT28UE1Bsqta5CzK7YuV92b
         jQ9V61ngBVKboT2fQWrPSYVqXz1D+2jR0bxtN1HWSGWybL4vNdgIsrCDigfT18n9bWgC
         kePpDOSNkVXmtkc9VSw23Rhh/K8x2LuTErj4vKYRVQrig9osz0fVqZMyc1dDfrHORcVZ
         ffZaRb9APs6dC3alHzhlbZKG9HoLXrL6V1gTEHdggrLmgvMXTLxcE5rM6j/Th8V+pLz0
         QyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZSCrgk5+sMFrmaVpehfL7VYDj4kraqL145ODGpjev7w=;
        b=Nd2/OoPN/0tepxW5FEM34BNw9n/kCL67tO9kbbAmUfesN49Xygs1kb6U31QspXLIhm
         MCqLCt3DEAk1uj87hgP4cXMXQfu701xzzFgx9ST4lCCvR+1CmW5VoacdTFFIs39UPo1a
         PYJbnt3yfILxnGcQmtzfFm7nSN81p2f0/2z0D9OjvEM8x5jwwat34fbBSfTUdSwF/a1G
         DjAeeCC3ckl0vCwx25A+UcVC9y/Y9xqXUUqR43tnmTUvc6sCwCAkrv8c6efUZuG7m4Dp
         PKnWbpyAP6JD3L4WWV8ns3WH2Ew7wc/VHbtverO0uwd8COiHOhcR+5FqfQtIGCL+6j3N
         Df1Q==
X-Gm-Message-State: AOAM530DMuWKzoUbXsEX4swGquvg395VmLCXbf9qCNWQunPs2eFAA+Qg
        ccYHzrJcHYsdfskFkd6s32+5+sin
X-Google-Smtp-Source: ABdhPJwYevJohmra88NhOB0slgTfWQyHVHGXQAbFkmhQJ7BrUytOmQ2hP9sIdcRbABzIT4+fRXeD+Q==
X-Received: by 2002:adf:cd8f:: with SMTP id q15mr4412334wrj.347.1596209241234;
        Fri, 31 Jul 2020 08:27:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 130sm14639767wme.26.2020.07.31.08.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:20 -0700 (PDT)
Message-Id: <05ced516832e55eb61c135ea26e95e4c83362ad2.1596209237.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:26:57 +0000
Subject: [PATCH v20 01/21] refs: add \t to reflog in the files backend
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

commit 523fa69c3 (Jul 10, 2020) "reflog: cleanse messages in the
refs.c layer" centralized reflog normalizaton.  However, the
normalizaton added a leading "\t" to the message. This is an artifact
of the reflog storage format in the files backend, so it should be
added there.

Routines that parse back the reflog (such as grab_nth_branch_switch)
expect the "\t" to not be in the message, so without this fix, git
with reftable cannot process the "@{-1}" syntax.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs.c               | 1 -
 refs/files-backend.c | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 89814c7be4..2dd851fe81 100644
--- a/refs.c
+++ b/refs.c
@@ -907,7 +907,6 @@ static void copy_reflog_msg(struct strbuf *sb, const char *msg)
 	char c;
 	int wasspace = 1;
 
-	strbuf_addch(sb, '\t');
 	while ((c = *msg++)) {
 		if (wasspace && isspace(c))
 			continue;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index e0aba23eb2..985631f33e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1628,8 +1628,10 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
 	int ret = 0;
 
 	strbuf_addf(&sb, "%s %s %s", oid_to_hex(old_oid), oid_to_hex(new_oid), committer);
-	if (msg && *msg)
+	if (msg && *msg) {
+		strbuf_addch(&sb, '\t');
 		strbuf_addstr(&sb, msg);
+	}
 	strbuf_addch(&sb, '\n');
 	if (write_in_full(fd, sb.buf, sb.len) < 0)
 		ret = -1;
-- 
gitgitgadget

