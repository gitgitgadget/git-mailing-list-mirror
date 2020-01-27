Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B908FC33CB7
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 14:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA1821739
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 14:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nx3Y3aDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgA0OWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:22:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38469 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgA0OWa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 09:22:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so11526492wrh.5
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 06:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rqLNVKHHq/bE/3ZWd1Y+DNOVqrq+R1A15fI8ANwYqeQ=;
        b=nx3Y3aDBsAQEGkWw7psj0gbEYxAQbOTRclxnmoIRAuPX+1zIc8FQ6ezUElJ6olqRXQ
         U+uu8nU8+Ctf/QdbcbzXXJmdFHlLLsbRhT1UrviGLtiSqr+w6oJQlyPTTIEVVDJ70m6r
         OMKwrET5kZD0ECymEfTi8XSKsz5gttCfRnHqHloTkOsPYkc17yHGRu0xJLbRxtOQRLYG
         DMY1Mt+n75/JeJRDPd7edo6I6gyP5XPDSNrW8JZHKYqSgBn9dN+lAfqs3HUT/lF8AMdw
         M2XMDLmJGPM4R/X4/163fD8WUO4OSDTCSx+52fj7uZBjLmFuoIpMr7uWjfLRnsyaL2p+
         BZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rqLNVKHHq/bE/3ZWd1Y+DNOVqrq+R1A15fI8ANwYqeQ=;
        b=VZhJZFwtHM2SG+fWAcLYw0zVwOyamAmRZZluVtrNjwc4j8FUMHwSllpXzg8wNZQoIE
         eUy0P4rYAnlMLv8qZlVCGYfaL/ZKVCB8J9o7gLHedCBX/ixlpkO7CtXOj9Hdu0u4j91f
         C6qqLHEaRVQPl6dif4tOzFE/lzyctFhEFKeCxFSROtRGQMrWHmeam5SGHbC9xuJwZv2h
         MJVwTKUt6enL1FLG4xFVAQdbK4tyd1f7T7L2I0Z9t/3nMFJXjXXdq2OZPoPbeWeDGOLS
         07zVXaUEc0HoRhZsLubYQrUBCqb/UBCIdpTfr/qLzbp8pE3Gt8jkkVTJBFPqA/Vv5M4I
         C8dw==
X-Gm-Message-State: APjAAAXPTpbbqUab39TcTPb/cUUyTzGcOl6gF7Iy7Z/8Ze1O64ih4Rjz
        R0qrwKyeT/S4uq9Dql4jPkWabMA9
X-Google-Smtp-Source: APXvYqxzgbwe+B35VKLd+TF7GJkU/FOii+1RKcO7FWAwPpFHfvx+LndPlJIIwACvu5KHg42HGqC3HA==
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr21277317wrs.287.1580134948323;
        Mon, 27 Jan 2020 06:22:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u188sm19327503wme.10.2020.01.27.06.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 06:22:27 -0800 (PST)
Message-Id: <d7d642dcf6f3c661c51302d02c69e781e201cc6e.1580134944.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
        <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jan 2020 14:22:21 +0000
Subject: [PATCH v2 2/5] create .git/refs in files-backend.c
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

This prepares for supporting the reftable format, which creates a file
in that place.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Change-Id: I2fc47c89f5ec605734007ceff90321c02474aa92
---
 builtin/init-db.c    | 2 --
 refs/files-backend.c | 4 ++++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 944ec77fe1..45bdea0589 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -226,8 +226,6 @@ static int create_default_files(const char *template_path,
 	 * We need to create a "refs" dir in any case so that older
 	 * versions of git can tell that this is a repository.
 	 */
-	safe_create_dir(git_path("refs"), 1);
-	adjust_shared_perm(git_path("refs"));
 
 	if (refs_init_db(&err))
 		die("failed to set up refs db: %s", err.buf);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0ea66a28b6..f49b6f2ab6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3158,6 +3158,10 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 		files_downcast(ref_store, REF_STORE_WRITE, "init_db");
 	struct strbuf sb = STRBUF_INIT;
 
+	files_ref_path(refs, &sb, "refs");
+	safe_create_dir(sb.buf, 1);
+ 	// XXX adjust_shared_perm ?
+
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
-- 
gitgitgadget

