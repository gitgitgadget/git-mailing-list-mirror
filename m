Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD5EC35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 22:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A333206CC
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 22:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t5bZW5Zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBFW4C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:56:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40599 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgBFW4C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 17:56:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id t3so384005wru.7
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 14:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a5MugNypZYrYYS+PqgDeP05BEbdNQfn2h67TbnEP+6w=;
        b=t5bZW5ZvKRDHSwTK5+6hoBEtiH5Zx4M4XUrzzVlGj5Zm5wPOcPVHygnrX/X0a86mrz
         LYZzSbfGgJGFaYU3TIvGfYCfaDV5afk7Py4R6MkG+M0T2L7GHZrZqi5mtafguIrp4u9q
         8jVNdmJ1YLaMspjp1U+G/QlXywSgkuhBYBnwpMfmWHu37yTUGr7GMsWYALvmO8IMS948
         ktpKkgSgAM/n6VX/48eszbgYIp+icWuIEZTL2njAXfhFIPeZvXhqCaTDz+Z+SpUUpj1u
         Qrm3A8Epq03qMb/nzHyoMwhX+o7SOSsPde6ChU6Y7oIBjLT1Qizt9GuGXfFdePrdj8wN
         1DjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a5MugNypZYrYYS+PqgDeP05BEbdNQfn2h67TbnEP+6w=;
        b=ixsegugurRICFWWQ5GyA7iCONIl6p9hGMtsjmsajNJB81C43okd2PHnqsVfbl4vdqw
         JQnC2Nxq0ZJg9AvTrfOvOEd+P8eAiGLfXgn4bpeas1rveq6TdpRVuNCR6qTAEt8e+YNt
         xGh/lY6zXkWxH/vOs9cXSUInK3Gb7FZbcP6SPJY2VH+yPTh+7bvky/TqfzujbQhevyYG
         +Pfw7aY50vte6LYHMBxPopcPgJO+E52/DuHNZiPA+UI5NR0IYRjgZxD0gAkBRxc3k7E6
         pWcWhwDl0Ow6Vp1NRYgCH0wNpxPgwAt82yff9rwTeLK6T7fKHfU7xIn2D/C4+OT1KP92
         WE/A==
X-Gm-Message-State: APjAAAWXNp52DQWuQk5qeHBLPAC3YsVxb0crwLYiP4QgGR1i/khnEx8i
        duZCk23FkR9KkJ3ZX43qIxizCSnu
X-Google-Smtp-Source: APXvYqwKcdUxCHbyii659tB8Hne8PGmHZjZorVzJqTtWi+JtBC/eme/82yb8XybHSczZ/99CrkMLzg==
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr312703wrr.32.1581029759660;
        Thu, 06 Feb 2020 14:55:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a62sm1063394wmh.33.2020.02.06.14.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 14:55:59 -0800 (PST)
Message-Id: <4d6da9bc473580f56ecd1f1fa2df5c8e8bd5e936.1581029756.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
References: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
        <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Feb 2020 22:55:53 +0000
Subject: [PATCH v4 2/5] create .git/refs in files-backend.c
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
index 0ea66a28b6..1d362e99fb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3158,9 +3158,15 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
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

