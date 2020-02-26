Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6380C4BA0B
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 08:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A750E206E6
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 08:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEXVgM76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgBZItx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:49:53 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34464 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbgBZItx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 03:49:53 -0500
Received: by mail-ed1-f65.google.com with SMTP id dm3so1970513edb.1
        for <git@vger.kernel.org>; Wed, 26 Feb 2020 00:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zvV6ikoarnwTEEvMB5pK+kHoMHc6Mf8HUaG+5pG6Nus=;
        b=pEXVgM76X2anb6n8m+2x6HwODnPqH+C3WiWnzA2BJwhPq4kPgZzuXmDx+Nmbjw4PxP
         tjJZAA3lQRooPtBHAxcqr6gn3e24rcxKiZh6essVG5YFC7WAXiHOWATdTOTtOGBn2NDq
         +52neKh8pzyGBdYswQuKfvFoLPJEy2NLXJ5aqS0n0a9el8ENM2zDv0xo02urtUs/z4Uw
         y/wjAGYL5PD7H6zwZ+IF8cWIcQY+CY6R+Vqi07wcxgahziFJCJBRYQkAKNblgb4Zgryz
         lXtp+jsjiWQHU4aMQ4ILgpLbx2/b2/R4eXr62uh0h3J0lVwf970UMpH9aKichCVd2D+P
         0aHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zvV6ikoarnwTEEvMB5pK+kHoMHc6Mf8HUaG+5pG6Nus=;
        b=gVKa0d3CudVcSU5770REvS7uLSqg0A1j//wMYW1ESuGkzDRGsCAVHD9VqlJSGkX3HX
         dV+bzOG059crSDmGbz9u4ToVNlupQUaw9E/PmlNkoiRcXWjYlIOzt8Of+TmmEHH1n6Fv
         E0iwg6N0qB3FDonnhEHxm5A5QLfQlvZYGoLImrva2ylj7L9WTaU5nTGD7jCiADSzox6B
         kkK2Jsi86e8iOPjh2gdNt4tQhni6Oy3zXvRgzD7qRQc52TMXvefQd3I0GijpLOkj3o77
         T1Q4+l/jeF40FkC1YOE0oruHajHDsHKpI4Qwr69Yo4MH0rUv5JqQ7vgZ7so4qVpbU3Sl
         eL2Q==
X-Gm-Message-State: APjAAAXZRjKz9MQPqpjabhtfbbmobFvboH0b9cihv/JYKn3nNZfLoB2c
        JzvVmrg0wd/jTNhuDUJVj5RR9P5m
X-Google-Smtp-Source: APXvYqxNb3j9i2a6DRPvB/+rnNQdCzYbZl6oTtxN5KK2QzRvsrqZby3zl0nII35eBLCXFf4E9i2hyQ==
X-Received: by 2002:a17:907:2623:: with SMTP id aq3mr3334342ejc.153.1582706990071;
        Wed, 26 Feb 2020 00:49:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i31sm57607edi.42.2020.02.26.00.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 00:49:49 -0800 (PST)
Message-Id: <b68488a095eadd45dca6b1a0a697ef0567099460.1582706986.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
References: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
        <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Feb 2020 08:49:42 +0000
Subject: [PATCH v7 2/6] create .git/refs in files-backend.c
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

This prepares for supporting the reftable format, which will want
create its own file system layout in .git

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/init-db.c    | 2 --
 refs/files-backend.c | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 944ec77fe10..45bdea05890 100644
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
index 561c33ac8a9..ab7899a9c77 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3157,9 +3157,15 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 		files_downcast(ref_store, REF_STORE_WRITE, "init_db");
 	struct strbuf sb = STRBUF_INIT;
 
+	files_ref_path(refs, &sb, "refs");
+	safe_create_dir(sb.buf, 1);
+	/* adjust permissions even if directory already exists. */
+	adjust_shared_perm(sb.buf);
+
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
+	strbuf_reset(&sb);
 	files_ref_path(refs, &sb, "refs/heads");
 	safe_create_dir(sb.buf, 1);
 
-- 
gitgitgadget

