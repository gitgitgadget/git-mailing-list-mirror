Return-Path: <SRS0=lL1X=3Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4E2C3524B
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9222082E
	for <git@archiver.kernel.org>; Tue,  4 Feb 2020 20:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueZb94dI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBDU1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:27:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54005 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbgBDU1p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Feb 2020 15:27:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id s10so31330wmh.3
        for <git@vger.kernel.org>; Tue, 04 Feb 2020 12:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mmMWlmvLck5EZeGIY9Hkd3lsWGQM8WsRGULVqbfBW5g=;
        b=ueZb94dIdzd9jc4WLAMS57MmB1fOlyFWDKti0tEuRAXcKM2RDzV4aDaQozsx81OtFu
         hh54bZgaPmQr7J0Wq1nK6x6AvYbn6wO5rG/LSnYwFv/Pfqr8zMkZdsluVDV2COI77OVD
         COqSkVZvxMuTb2ol11CnhC8kIU2A0e++kMmAYD5Gtfm7oDgMNFtVBVrkfXLl4uwNAank
         N7zFqzYQGuOKwMjRinTXN1nJzwNlfMCnp6JEZP7Ow6CXQ8Oc5WKrxfHeFYqHdFC97Wax
         cRdqCt4lYPsOISWD5yCE1yPS5UsPoV2HFNKm6swGgAKnuEwAEJVHDGFyRSycsCANJ3hw
         iTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mmMWlmvLck5EZeGIY9Hkd3lsWGQM8WsRGULVqbfBW5g=;
        b=Stg6iFhRrQG70Dio1YTN7m20nPmEDtsmXZDoJPVuB0PghddqV83uzzXiznA5qquFSK
         tSmRU5S/eByb7Q8zslCOz5MAZKb10IuOAdnLP2Hw/Z7BGtX/8xDL5+Q5j9cF/jntai+S
         Y+VqWhSOk1E+3J4bRY+q2mkB0ZldiFPXjynayFRrx8lavlXqBIcwdY9fDaJx7HP0tnHF
         /+ug9JUmG3gdinOIZpaidSv5F2ydv0KhHSowHTAOAQOxkx3Uw++7wRs+0+iuZ1KFn03R
         +V2WFPPj+/X/y/lcwbvO6OBWxI57As5WvZjNKVrayDZV7+knBEc0vPQJhrm5Copx2MfB
         HSgQ==
X-Gm-Message-State: APjAAAUMfVvZeRoNUF5t9tBFkmIJEfNi/GWdST46E6LJzGpxGe9wUNVP
        TimOaPk7n9tunndMlaMYTy55f3ed
X-Google-Smtp-Source: APXvYqx/qYKMzqV0FtlwxFgJtgfwqeYanbzKzUgv89ElE8PYUcOIK62GrFQfT8yr5xscaC2AcaUuzA==
X-Received: by 2002:a1c:b4d7:: with SMTP id d206mr790546wmf.188.1580848063761;
        Tue, 04 Feb 2020 12:27:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm32340219wrt.90.2020.02.04.12.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 12:27:42 -0800 (PST)
Message-Id: <5b7060cb2fc25fc1c71b7c70864ebf758b59aa90.1580848060.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
References: <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
        <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Feb 2020 20:27:37 +0000
Subject: [PATCH v3 3/6] create .git/refs in files-backend.c
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
 refs/files-backend.c | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

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
index 0ea66a28b6..0c53b246e8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3158,6 +3158,11 @@ static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 		files_downcast(ref_store, REF_STORE_WRITE, "init_db");
 	struct strbuf sb = STRBUF_INIT;
 
+	files_ref_path(refs, &sb, "refs");
+	safe_create_dir(sb.buf, 1);
+        /* adjust permissions even if directory already exists. */
+	adjust_shared_perm(sb.buf);
+
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
-- 
gitgitgadget

