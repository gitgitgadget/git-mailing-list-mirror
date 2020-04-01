Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE79FC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F952080C
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dt6qAA4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbgDAL3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:29:06 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46407 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732244AbgDAL3G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 07:29:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id cf14so29162606edb.13
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 04:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c5jxiwoT9rIsUs25Z1wdbQYxfOfdfVcJvvnS9hg6XKE=;
        b=Dt6qAA4V+g9btME2jpL0HhKYp9Wuhz9+drxaRxP19ou8B1/bUgJL7IDWFi2Rb4hRB0
         SKxB5dGCEM9wLpriUvbIHqxBstXt1i47aVc/6qQRWXXiwiEkGt+HN6huPS8LQ85Ve+eS
         a8S/YyGxEWZk1pFpZR1ceP11rFWkwAM0XbcVi0Pt9Axb5eJilkyE3ZIn2RuF6083lD+I
         CBE7gVsZkMi8UnDrbQY/mLGRb8YEXi3zN/gblWFVIgV3G9gLkGEviNeCH2gtGAHIfmVB
         6SByAzv+u+l/e8UeEPnvHuUZIzi9gDWpSfmM5bNSzUgKk6pfGthIcb3h1lW/AJZabXI1
         2o2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c5jxiwoT9rIsUs25Z1wdbQYxfOfdfVcJvvnS9hg6XKE=;
        b=pzgfPnfPS1IpgEaGrK/aQnzgPl8tJinDQS0ntvNZhTJHO/jaN6hZRxTV3ekF9wGi55
         MISEfli1K3vfe7sji8fdk4eq2XNwNjtc3OVG6046I/IS6lmRX2pg9yzBwx/cNyp8y6os
         PXsZ6F8PjnTrMrXuPET5H+rwXfH2miGn9nYk+A6ymHVy4OvAWcTZEMUPzV4cfz3C0Wyd
         PhCSMB1c7+F8wPmWyUujgFRHHP4f7jQ0QJx09047jib9rMDqQ/ELgOy6uBTl9KxSH6Ug
         GMsXoywNq/wRWUSBdSVqYqxY8f66wZE6pQrO+Le7L5a84vtMt2vfVuH8mIuOycK7f5to
         4YIw==
X-Gm-Message-State: ANhLgQ2XF3vAOWD7WsEYmm3rHkzEujc9uwhjJGWCcBcyVW03hQ5I4HTG
        daUQ7pbDbObzYj6ZIZSKABjpjPhW
X-Google-Smtp-Source: ADFU+vvl2pyLXQ9y2fFPTUEY4BLyRpOovGY1i60zrh70TDAkT6VqB+WatmGemrJFJjpAmFX/WknEEg==
X-Received: by 2002:a17:906:d8cd:: with SMTP id re13mr7901790ejb.62.1585740542406;
        Wed, 01 Apr 2020 04:29:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i26sm384200edx.23.2020.04.01.04.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 04:29:01 -0700 (PDT)
Message-Id: <8d34e2c5c8b4ff7d09fad7686201fb5b7d325ba8.1585740538.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
References: <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
        <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 11:28:51 +0000
Subject: [PATCH v8 2/9] create .git/refs in files-backend.c
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
index 0b7222e7188..3b50b1aa0e5 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -251,8 +251,6 @@ static int create_default_files(const char *template_path,
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

