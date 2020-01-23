Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1960DC33CB6
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61EC21D7D
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjPiJ91S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgAWTlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:41:24 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52274 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbgAWTlX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 14:41:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id p9so3813457wmc.2
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 11:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rqLNVKHHq/bE/3ZWd1Y+DNOVqrq+R1A15fI8ANwYqeQ=;
        b=NjPiJ91S41mnbjIGct7KrN5XBZdXdOONdf4lxS+Vht1R8yJR+ljQoKrA4EncxmvqPf
         pFY9Kywko5YuoW1EBde2NqqaG2cTfFVfl2FS4b9Peu8p7Laac2HqdUaBRyd2sl4CLJQj
         CFrF3Weh0xnSgqV1wp0HkiIFqEWBpK6t1Bmfujhnb0WMQvg8dw9IQmYNMudE4J7baKx2
         rErstmci9OodpJ3q8b1+7w3geGyFdi4tW/kLqJIbEdpOQvLDyn8gIIfbaAhWhAWgTmxY
         NwpSXVJKyIKwXJWRkPfTrXhpvJqNPD2zrg30fpCYuYjCOcgrJ2YtUWj+HoRMrqckfJ/9
         sYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rqLNVKHHq/bE/3ZWd1Y+DNOVqrq+R1A15fI8ANwYqeQ=;
        b=mDz4fmG58+vL1lq+b4vu+faBcetjltibLWKOH0MGr1mJRdATydo6t7CwxmBRdXP9Ms
         GSFQkbBS81hT7m/jFcBWtLYit64aD8GOZ6nV4gRv1EaOU7aQEghWgTnkWiO5MvlDMPtJ
         Pc1FBcrV298glqfJezCiGth+FlRgdelyx97ky4JoqFAHa1hqQsX9XV5fWr5YL5DG7KlE
         SMW4zAF8JxYuXPriHi2JN6BKyYcaq417QkqHTpX6dhCclzTkQ+PdaxUJXlcJGA00vZSu
         5fJpiIae8+dfVxU13vaQ45vfpZgUXkVHBrkD3zvXY+gvXq7w3yVZ+BK8+wHKpN1shWyD
         uLNQ==
X-Gm-Message-State: APjAAAV29xbqlBQEicxUnSMYnSEMi92jGYEkfAv6mLduf+D3of3Wdo9c
        tVyPhEoOAdtyZrMDF+bZjDFtptO5
X-Google-Smtp-Source: APXvYqxH1+eY8lBo8A5m/XGF69dY0Dhsyd27vuYl08rkxcervP7JUx+zRLIqk5QqM8RKhNYsGu0WoA==
X-Received: by 2002:a7b:cbcc:: with SMTP id n12mr5659249wmi.186.1579808482277;
        Thu, 23 Jan 2020 11:41:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6sm4601350wru.44.2020.01.23.11.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 11:41:21 -0800 (PST)
Message-Id: <bc643d0b0cd2e82523c3c1956445f8d6f01c13af.1579808479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.git.1579808479.gitgitgadget@gmail.com>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jan 2020 19:41:16 +0000
Subject: [PATCH 2/5] create .git/refs in files-backend.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@xs4all.nl>,
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

