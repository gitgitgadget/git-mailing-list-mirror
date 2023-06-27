Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D10CEB64DC
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 19:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjF0TxU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 15:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjF0TxL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 15:53:11 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2A42117
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:53:11 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-26304c2e178so1402590a91.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687895590; x=1690487590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R7hzoPmQMHKHQiFGKhhcMXV7prE5a3DF/FvGwezczmQ=;
        b=5p2sHUZ2u5r1h6wLectQvMDnhFQSBns01eddNz0Gr66Jit5U24L5INgjv8Cf5rLGJw
         PcOuN9C4ZbrSCckL0Op08b+VktqmGYxmCP45P7vitWTnQitJqw6ir6Fezzy5pf+KYxAM
         Yh15pvn5hrltlZ6a10EbOLlpNCyUosgO5NWSNyT49X/rAmJ12kbckL4iimnPO+ecCu0V
         ybuiGQpySoShh+E4Z3Bu78ARaUdC2nhgsB8Yz8gz7u+kTIoZlvQZtkieXZxJW/dj2w8K
         Z4MQSUpojrQuZ/g04498PxPqcKjKr08SpaYbyLxv0O+s1PIjCi91nrZlLYtnnDePXAT4
         Nl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687895590; x=1690487590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7hzoPmQMHKHQiFGKhhcMXV7prE5a3DF/FvGwezczmQ=;
        b=lSfFkOCe1bSRUeJcRWO9dm0XYA3mLtKvQplZUeHhrl61mvVmgIUBh6lLJNPDzqXgfJ
         cy+j1ZZrcy7GkyVUnnI+VYZ390y8V5sTpBI0jI2w/wkNyuSxwbi03K6DX/bcOwbZloLj
         Q/HisCZIspVyb/sPIWnl2x9X6mrCicsXjXixzBddgMDY5XX3ucFLD8ORmobO6AYKZiPO
         PFRAYEgJX94M6k6pB4XFFXGU+21oV/igSpJD8xYTtrgVZrZCkISk1XzdSnUuzsLlgj4o
         5tvs07+nUw+20DUUxFrgOpp5+xcNoKuokxnNdtKFXahAT32j3u381/yQMDN0rswownu+
         f5iw==
X-Gm-Message-State: AC+VfDxgBcGk1OUJZMLKsJmUyHHQTeUkiKkvbyrjnWu8zQvBJ1ndoAsL
        VdwPb/oPUxYf0kWCzjbif0n8/hZp7CjMmKpVD3EUUupq1mw9/l07pMM3n/565R2H6QOuQdYYzxR
        vVGTx1aaKOGFmMc9ZcgKDHMvlnE1AaYO5rM/bDVj5qzgTLSrBXGTicQVmdASW4rw2oQ==
X-Google-Smtp-Source: ACHHUZ7R+nLChvpX5614BuS/TuWq4Cbs99gxlec4D0npWNFSKTiJDYg0oOEQ7yOZhWnhiek8xhzEzboK/pKW4TM=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90a:ce8b:b0:262:ff1c:bc2f with SMTP
 id g11-20020a17090ace8b00b00262ff1cbc2fmr853614pju.5.1687895590610; Tue, 27
 Jun 2023 12:53:10 -0700 (PDT)
Date:   Tue, 27 Jun 2023 19:52:46 +0000
In-Reply-To: <20230627195251.1973421-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627195251.1973421-4-calvinwan@google.com>
Subject: [RFC PATCH 3/8] object: move function to object.c
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        chooglen@google.com, johnathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While remove_or_warn() is a simple ternary operator to call two other
wrapper functions, it creates an unnecessary dependency to object.h in
wrapper.c. Therefore move the function to object.[ch] where the concept
of GITLINKs is first defined.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 object.c  | 5 +++++
 object.h  | 6 ++++++
 wrapper.c | 6 ------
 wrapper.h | 5 -----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/object.c b/object.c
index 60f954194f..cb29fcc304 100644
--- a/object.c
+++ b/object.c
@@ -617,3 +617,8 @@ void parsed_object_pool_clear(struct parsed_object_pool *o)
 	FREE_AND_NULL(o->object_state);
 	FREE_AND_NULL(o->shallow_stat);
 }
+
+int remove_or_warn(unsigned int mode, const char *file)
+{
+	return S_ISGITLINK(mode) ? rmdir_or_warn(file) : unlink_or_warn(file);
+}
diff --git a/object.h b/object.h
index 5871615fee..e908ef6515 100644
--- a/object.h
+++ b/object.h
@@ -284,4 +284,10 @@ void clear_object_flags(unsigned flags);
  */
 void repo_clear_commit_marks(struct repository *r, unsigned int flags);
 
+/*
+ * Calls the correct function out of {unlink,rmdir}_or_warn based on
+ * the supplied file mode.
+ */
+int remove_or_warn(unsigned int mode, const char *path);
+
 #endif /* OBJECT_H */
diff --git a/wrapper.c b/wrapper.c
index bd7f0a9752..62c04aeb17 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -5,7 +5,6 @@
 #include "abspath.h"
 #include "config.h"
 #include "gettext.h"
-#include "object.h"
 #include "strbuf.h"
 
 static intmax_t count_fsync_writeout_only;
@@ -642,11 +641,6 @@ int rmdir_or_warn(const char *file)
 	return warn_if_unremovable("rmdir", file, rmdir(file));
 }
 
-int remove_or_warn(unsigned int mode, const char *file)
-{
-	return S_ISGITLINK(mode) ? rmdir_or_warn(file) : unlink_or_warn(file);
-}
-
 static int access_error_is_ok(int err, unsigned flag)
 {
 	return (is_missing_file_error(err) ||
diff --git a/wrapper.h b/wrapper.h
index db1bc109ed..166740ae60 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -111,11 +111,6 @@ int unlink_or_msg(const char *file, struct strbuf *err);
  * not exist.
  */
 int rmdir_or_warn(const char *path);
-/*
- * Calls the correct function out of {unlink,rmdir}_or_warn based on
- * the supplied file mode.
- */
-int remove_or_warn(unsigned int mode, const char *path);
 
 /*
  * Call access(2), but warn for any error except "missing file"
-- 
2.41.0.162.gfafddb0af9-goog

