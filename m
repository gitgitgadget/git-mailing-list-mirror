Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2905BC54FD0
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 21:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E6B20782
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 21:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZV3F6wEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgDTVPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725774AbgDTVPA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 17:15:00 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87906C061A0F
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 14:15:00 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id f12so8561173edn.12
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 14:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c5jxiwoT9rIsUs25Z1wdbQYxfOfdfVcJvvnS9hg6XKE=;
        b=ZV3F6wEMKgswOvDLAY7W+YJ1KVeB0hfbUjMkU+E/S4ibq4wW1+7gDfmGD2dxB2+NwV
         DpEl42FqL8R+xw4LFvR46axnHegbDhVLWCJBON/BBDttUzgsCQmYKEU5Y6vvoz6QQlzl
         Y+8xf797IEZJm2+wi2GUWhz9Sfh11fjQSzDY/1Ady5Cp0Rlmjl1ufcJFe9AAHKyLbqgA
         BGKHYRuXQ3BWdcfbeu/bbemCOPQX6mVYrjYDPXHQRQ2gmfzDFhfEN3w3krLQNLRhRxYE
         CSO6VBaKiiWIPnAWQ7JReMovXk6A+H92JuZIqA8nxN9i9E33Oi1AfHA+du7d2WJ3VD0E
         rH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c5jxiwoT9rIsUs25Z1wdbQYxfOfdfVcJvvnS9hg6XKE=;
        b=FPSNnI8yK8gjZw9Zj/76qN3sWQndb/7CiJWttncgSMyR1bEJmiAnoMxonKu9Qvn0Yb
         JysPpm6r1F/0EWEFzuovZV1zP4bQyw5AN1xUUkFX8AvUKEMyokYWpx2qHuzXfYKIeTvR
         lu72q/Ni9F9H08MYTpNLwpTxTAvc2fY8qWJeRwDCK2TpO9PNMqEaUPqbD0LplGEbmdrE
         yF+jqhEZx+dK4i5ax3G7RYhsqpdvGrwYTVXUuXge9wXJFW3gzjtgniKpuQN0uiNk3cZa
         A1gPlgbko2hvskIk7u7fFoi2dfvHRXCU/sr1b6ul7qXUpdBmWqLY2fOrfIXdZCBkl0IS
         cLag==
X-Gm-Message-State: AGi0PuZeGr/WkDv8CWhPLFzZx+FYTjr9qdQcyBgcV5bH7a+QW9OQx4yx
        rFgS5kw9BQR1B/gKF7u60yN8vtzn
X-Google-Smtp-Source: APiQypI1+nBzVvhDSe0sJYFSSE6ytUbc4ocYT9/xy3zeaZ3npnjqt0VF+biKMKTdbx4kVXiUz/al1w==
X-Received: by 2002:a05:6402:22ba:: with SMTP id cx26mr12765837edb.198.1587417299198;
        Mon, 20 Apr 2020 14:14:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id gg24sm45278ejb.66.2020.04.20.14.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:14:58 -0700 (PDT)
Message-Id: <91f1efe24ec2b983437b9e20cab61ce31c3917cb.1587417295.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
References: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
        <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Apr 2020 21:14:48 +0000
Subject: [PATCH v9 03/10] create .git/refs in files-backend.c
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

