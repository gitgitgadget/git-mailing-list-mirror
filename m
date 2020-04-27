Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79CAC4CECD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4442073C
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsAK9+5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgD0UUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726832AbgD0UUd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 16:20:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F272CC09B050
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:43 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so22096407wrr.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c5jxiwoT9rIsUs25Z1wdbQYxfOfdfVcJvvnS9hg6XKE=;
        b=AsAK9+5e2phHodi8ioplVjKcXUo+BdYKwyfhTi+GdZhs48M3GtLCOBhQM2LC2bDX8B
         jwEci2vxfF+zoehANU28SoSUcsleEwD6I/b9iDjDEQTEOjqvyn6jy3Nx3bJMaveNH6NO
         spxlhtmYC8lQ3PPl8+DoT/U2QiSrWTcgarXDLgz/OdwTFq1mellZM/7UFxICtONVp8uu
         YJZikTYnzJ8cbxyxe2ZV12xEBfkFKSASjetMPXzxYeHl5loo5sDa0THKpyvrJLrugZfl
         /wHAHDlmfmVLY60Vu1zWMmX8PKz++uWcAoAKX0a05tHudXqmvpTDoou8tVqmzgggkIdh
         LTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c5jxiwoT9rIsUs25Z1wdbQYxfOfdfVcJvvnS9hg6XKE=;
        b=HSm0DWrGYBfuHOc3iezR9a9ku5lD/89qHJVlC27z6BjgJMiMfF85rMQVLGHK6lTkqK
         BoBSDK7Dw6Gx1pNIM7EydKh4tJzPWEOMTgyCbSOHfwPGSgRNiUHD+Ie/7wo+BT8zNOgz
         kqXsnyFuULCdVgC+CIw4mDaIJdNIt3+WCZoys1UzGuuzQeD8qJCOgmAxRtimZxCy0/3w
         XERqB1MoCKx/g3l3ImIxeu4Jxd87t9lXZZW9eAJRdXiZgU9KSlIlcRD3cGAVofal4yJl
         /nAQshXozT/9hCFugG9cIrWVmx3Npck7/iR1E0D5On+uDJt6CQd+wbjqaQluVM+FIGuF
         Ajkw==
X-Gm-Message-State: AGi0PuZK7bt+V+oNtCjPXenfUN67wbeIa7LNHw8YxANC4cqTr6vGDqz3
        VEofmNnoJ30aWm1wPZRprWJSEWnP
X-Google-Smtp-Source: APiQypIhOaFsrpzFu2H9I7h4xXA7g1Z7tZi2ZnwqSffbj56iJrFXcPeuYVF3Zr7jRMKwkY2clTxbJA==
X-Received: by 2002:adf:c3ca:: with SMTP id d10mr30664497wrg.64.1588018422613;
        Mon, 27 Apr 2020 13:13:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n6sm302853wmc.28.2020.04.27.13.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:13:42 -0700 (PDT)
Message-Id: <bc89bcd9c8c9b33e517a21bbe7c441538e288ebc.1588018418.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
        <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Apr 2020 20:13:29 +0000
Subject: [PATCH v10 03/12] create .git/refs in files-backend.c
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

