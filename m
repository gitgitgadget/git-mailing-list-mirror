Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF95C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1D82245C
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUvnsH9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387504AbgGaP1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387489AbgGaP1j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3276EC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a14so28388372wra.5
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+WuypdgIR9jq6om9lvliEs+R4/dv/kz5HqLKufWt9ZY=;
        b=IUvnsH9+lLdXmI1EM0GXIXxxX2bImYZjBfLZrK8QVOTbXWT9JrWO7fup8RiuR8d0tS
         c7yxcxKdlfOiKzY0XmgxtPWJX2fZ+dNyqF1fp/Wn27mOd8+C5s1t5HPDwWUxL9Ox9EFb
         wVJqnctQTxoZf2nWjaWKGmgSGX8zTpn8WZAymvdsiF7mRpJdP4+TSFlB8N9NQs6WOJOc
         +Noh33yPomPzPHtJPR1p8MupBHyXn4uxNtttCXmffgHrrNPtKjndZl+lJwQXz+jD+/6R
         UpS5miLYRgI3nRlLjzvwOMhX2twcLqXFwcYh4HGJt7PlBiDtwacJUnARWBd9kqCSFYMP
         Cz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+WuypdgIR9jq6om9lvliEs+R4/dv/kz5HqLKufWt9ZY=;
        b=sM27EZ5ebdsQkfiCVh6z8t+54i0NoAughRkacwRQOcvhZsbPjHT7IEkugsD7ziyTRf
         hvSfZkSSddrGFNTb/xE/rC5pnBjcQwyLVET//Y9RRHNnqMqyH1LF25XJX/G4LouQN4R1
         SRacHrMHV6T2UY3vmCco3ZjmJsPMRIJfHcyd45EhiIibEA8nUbQ7U3EFlZTxwB0MFELV
         YecH+Q2DmS/7ipcgsN3W+7MUvjq2KPIh9u0J0jWFTk0znAC1C5S+W6Ql2t6mrUx4AWiq
         GX3sbMN1hZG9liBRNOh774PUIrlYnnB5lo5l/4JorPKnH4FqqS/0uRXfsvMV+qr/Gawj
         2dCQ==
X-Gm-Message-State: AOAM530f1KvNqw4aVGlLBrzeWUPIyxZF7U2DbNDgTt+LoG1Hxmpf1uDT
        XNwdrGFy6odY4a1yCDLrD15Eeide
X-Google-Smtp-Source: ABdhPJyoHv9fgcsBs0TxC3NywrBkue2/KRhMdSMA+CauaAhnXCPLzj9sOOL79QVqkLaxH0GTBzs1WA==
X-Received: by 2002:adf:d1b2:: with SMTP id w18mr3797248wrc.235.1596209257840;
        Fri, 31 Jul 2020 08:27:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v67sm14648405wma.46.2020.07.31.08.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:37 -0700 (PDT)
Message-Id: <a6449d4346cfb715ce8309010334bd60543cc1d3.1596209238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:27:11 +0000
Subject: [PATCH v20 15/21] Read FETCH_HEAD as loose ref
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

FETCH_HEAD is a loose ref (either symref or OID), followed by further
metadata. It can therefore not be read through a ref backend
normally. Special case this in reftable-backend.c.

This functionality is shared between all backends, but the ref backend
interface doesn't have a method to retrieve the repository directory,
hence this functionality must be pushed down to the backend
implementation.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/reftable-backend.c | 31 +++++++++++++++++++++++++++++++
 t/t0031-reftable.sh     |  9 ++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 93f3d337b6..8d30f3ea61 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1304,6 +1304,33 @@ git_reftable_reflog_expire(struct ref_store *ref_store, const char *refname,
 	return err;
 }
 
+static int read_fetch_head(struct git_reftable_ref_store *refs,
+			   const char *refname, struct object_id *oid,
+			   struct strbuf *referent, unsigned int *type)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf path_sb = STRBUF_INIT;
+	int ret = -1;
+	int fd;
+	strbuf_addf(&path_sb, "%s/%s", refs->repo_dir, refname);
+	fd = open(path_sb.buf, O_RDONLY);
+	if (fd < 0) {
+		goto out;
+	}
+	strbuf_reset(&sb);
+	if (strbuf_read(&sb, fd, 256) < 0) {
+		ret = -1;
+	}
+	strbuf_rtrim(&sb);
+
+	ret = parse_loose_ref_contents(sb.buf, oid, referent, type);
+out:
+	close(fd);
+	strbuf_release(&sb);
+	strbuf_release(&path_sb);
+	return ret;
+}
+
 static int git_reftable_read_raw_ref(struct ref_store *ref_store,
 				     const char *refname, struct object_id *oid,
 				     struct strbuf *referent,
@@ -1319,6 +1346,10 @@ static int git_reftable_read_raw_ref(struct ref_store *ref_store,
 		return refs->err;
 	}
 
+	if (!strcmp(refname, "FETCH_HEAD")) {
+		return read_fetch_head(refs, refname, oid, referent, type);
+	}
+
 	/* This is usually not needed, but Git doesn't signal to ref backend if
 	   a subprocess updated the ref DB.  So we always check.
 	*/
diff --git a/t/t0031-reftable.sh b/t/t0031-reftable.sh
index a6634bc882..9f90c10030 100755
--- a/t/t0031-reftable.sh
+++ b/t/t0031-reftable.sh
@@ -169,5 +169,12 @@ test_expect_success 'worktrees 2' '
 	git worktree add --detach existing_empty master
 '
 
-test_done
+test_expect_success 'FETCH_HEAD' '
+        initialize &&
+	test_commit one &&
+	(git init sub && cd sub && test_commit two) &&
+	git fetch sub &&
+	git checkout FETCH_HEAD
+'
 
+test_done
-- 
gitgitgadget

