Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C36C43603
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 18:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58BF920700
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 18:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hktEOSSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfLHSGT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 13:06:19 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33994 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfLHSGT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Dec 2019 13:06:19 -0500
Received: by mail-lf1-f65.google.com with SMTP id l18so8942273lfc.1
        for <git@vger.kernel.org>; Sun, 08 Dec 2019 10:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X5Vepp81X2nwHQX9TWhpw5ZglAPMRnEv7rDnL3HBB28=;
        b=hktEOSSRY5fevq8ofwhBPYgrSFPtGGtqVO8JShfVYrRLbFb2vblnqQbLeA9vZ4gmgO
         e31F20SjBwHuvojzpbvsNZXj2A6x79rgJL9PiX5KIxQiX155eihmz2TVIj3zq+fbYqqK
         Aia4yWrMK80gG5vbZU17U7UhYhE0a6F//4gfu8ZZUx3iCTPUTzcXoBMhRFFJ3ioor7Ye
         gnTQHK38ulV6+/79HhXS/VvsMLNKrs35wTlVzGfVEmjvAbycpUu1A397djSfNEV5KPPN
         jBfSzTj1Ju0hK2L+YseoP5VfKN07Nc0TYAzeUy2MtIAMevqHoKUv122K41ixi2kzibZx
         rfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X5Vepp81X2nwHQX9TWhpw5ZglAPMRnEv7rDnL3HBB28=;
        b=tt4pMbAqothq+NW+qaCMsy9ARasTuzPB+GMCZ/6c42m/HRdU66fb1im+tGZgqsVzq8
         3e4mNOnq8xDzYp7WAVzkqAUZFhieniZdP3k45F11Uifewecef2Ze5yKsliTKjJg51WNG
         Xmnwmzc86Ziqm5R9ew4ZQJamauB0JTPzrp0vOVzUFXBuMjSknkRrs8UU/bcglu1FJDdN
         2Ls41xaPjRyl6a1+9E9Vd2zbQ86FsQQokYm8gSs2F/tRDGq1aSDvHMa36DS2Iw9SU/j1
         vnyjTgPyUIfeBcSvjUiQwbGPhHEXXyScSRS+cM3SdM20AWXgtM6k3xdsaOXckqKCDEA8
         8yTg==
X-Gm-Message-State: APjAAAV3t/z+TOMjpjoDQCoQsYkpvxbJNJWDk+JddSNIrmrRBQF7xmSA
        Cb3nt1BVbISH7ZkQjDioymXGDETZ82H6/w==
X-Google-Smtp-Source: APXvYqxUU32KLT0jAAMa0W+01r2Bo1TB3nViDQNNVIaPNYMbujqhZUD5bDav/B/krQ6szI4yKTQWAQ==
X-Received: by 2002:ac2:44d9:: with SMTP id d25mr6672371lfm.15.1575828376640;
        Sun, 08 Dec 2019 10:06:16 -0800 (PST)
Received: from crux.lan ([2a02:2149:8784:6e00:5968:5337:69b5:bbae])
        by smtp.gmail.com with ESMTPSA id n13sm9229719lji.91.2019.12.08.10.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 10:06:16 -0800 (PST)
From:   otalpster@gmail.com
To:     git@vger.kernel.org
Cc:     mhagger@alum.mit.edu, matheus.bernardino@usp.br,
        Plato <otalpster@gmail.com>
Subject: [PATCH] entry.c: use dir-iterator to avoid explicit dir traversal
Date:   Sun,  8 Dec 2019 20:04:39 +0200
Message-Id: <20191208180439.19018-1-otalpster@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Plato <otalpster@gmail.com>

Replace usage of opendir/readdir/closedir API to traverse directories
recursively, at remove_subtree() function, by the dir-iterator API. This
simplifies the code and avoids recursive calls to remove_subtree().

Signed-off-by: Plato <otalpster@gmail.com>
---
Hello,

This is my first patch.
I hope I cc'd the correct people and didn't mess up.

The changes pass the test suite t/ and Travis CI.
Please point out any mistakes.

Thanks for your time! :)

 entry.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/entry.c b/entry.c
index 53380bb614..e7f4881d3b 100644
--- a/entry.c
+++ b/entry.c
@@ -2,6 +2,8 @@
 #include "blob.h"
 #include "object-store.h"
 #include "dir.h"
+#include "iterator.h"
+#include "dir-iterator.h"
 #include "streaming.h"
 #include "submodule.h"
 #include "progress.h"
@@ -50,29 +52,25 @@ static void create_directories(const char *path, int path_len,
 
 static void remove_subtree(struct strbuf *path)
 {
-	DIR *dir = opendir(path->buf);
-	struct dirent *de;
-	int origlen = path->len;
+	int ok;
+	unsigned int flags = DIR_ITERATOR_PEDANTIC;
+	struct dir_iterator *iter = dir_iterator_begin(path->buf, flags);
 
-	if (!dir)
+	if (!iter)
 		die_errno("cannot opendir '%s'", path->buf);
-	while ((de = readdir(dir)) != NULL) {
-		struct stat st;
 
-		if (is_dot_or_dotdot(de->d_name))
+	while ((ok = dir_iterator_advance(iter)) == ITER_OK) {
+		if (is_dot_or_dotdot(iter->path.buf))
 			continue;
 
-		strbuf_addch(path, '/');
-		strbuf_addstr(path, de->d_name);
-		if (lstat(path->buf, &st))
-			die_errno("cannot lstat '%s'", path->buf);
-		if (S_ISDIR(st.st_mode))
-			remove_subtree(path);
-		else if (unlink(path->buf))
-			die_errno("cannot unlink '%s'", path->buf);
-		strbuf_setlen(path, origlen);
+		if (unlink(iter->path.buf)) {
+			die_errno("cannot unlink '%s'", iter->path.buf);
+		}
 	}
-	closedir(dir);
+
+	if (ok != ITER_DONE)
+		die(_("failed to iterate over '%s'"), path->buf);
+
 	if (rmdir(path->buf))
 		die_errno("cannot rmdir '%s'", path->buf);
 }
-- 
2.24.0

