Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9419C001E0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 16:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbjHJQhm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbjHJQh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 12:37:27 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF868359C
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:37:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583a89cccf6so14877237b3.1
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691685434; x=1692290234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kVc93oMajibcMyHFtL7WCAKEoCpgyDySoMcdNNdScTg=;
        b=wAM5xWwQw2c/Mkc9UEWTmj9fcWiFREam/HL6rwFbT11AMbAYKKGmG5NKeRs4yaVHSr
         8IUfDdeyfq+OrtTH+TmlCNnMSelPi3g4a9r05yBtxxyKpDCwNzzCJQWNcT8UvNScsjkM
         OPYkOdZuWCA7Z+QNO2PHq5Lp9DV5WGTVuVPa06D1aru2oUkXpDuGtMOhcIoco+fUEmzk
         dtamE+mrwSjsph5BqUmkpPisK8ldXe7gcnIT3Svyf8SuMj9PiZh0ixi/vG+IAzo65N8X
         ZX+yxIGbSqB/bClrKA84ntIHhneBSSU3RySM/dfItd4aSrhABmhYLY5aGKJ3H20d5xSg
         2DnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685434; x=1692290234;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVc93oMajibcMyHFtL7WCAKEoCpgyDySoMcdNNdScTg=;
        b=HdV58bbVv3bX6zRN7jyef/GWVzbgtQf8mB9FeQw4pV8eufVnrdNz3hc9LLKAMWpiw8
         0Vw3Lu7toPsbFKiqKPL5GmN3RzB/tdqidB3XQilySIRznT+h+ZVQHGRM7BC3uXFB03Xe
         Q67fdYfspws5owzgkJNEsZzxUmc6fIUJ2zxQOHFFvAnwftGjLln/P5msZG7c4N6xl1Du
         WPb9Ha2SV9swuZ9qcViPtf+a9VHmUjrmgA0ktkcxW8X0Kd5wNtV0LGRU+mgUBH50tYKF
         sy59VUMARtUsbvOs8QlljYDbH8n5AqpUAi6AnHKwNkb89+sZV8BUJiD6Wbc2ChCo9tOu
         G0qw==
X-Gm-Message-State: AOJu0YyKPNWHo1P66oTGqn5YS66t0wmmqjiqvZHp/63ANddbnLOFwS2l
        afxsWyGLzzGZKEozpv7H5zDnwHQJStq/Ms70lzQkB8hCmyxX2ZM3VEIvGrU2jJ1CNE14DQW11DF
        2U/s3CQ6q8jYgQWlfM4A2E/DZNiIdC7L4exEfBG0FsmwV+ydJnUqjImja/KCIYSfG6g==
X-Google-Smtp-Source: AGHT+IF5pDJRN1we7a2RoiMM5MP1l399heEnPta2DbVgxTC0S8wLHL19tb5R17fWEN8TlmQ3KPKOHiANn2FNqGI=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a5b:c12:0:b0:d62:7f3f:621d with SMTP id
 f18-20020a5b0c12000000b00d627f3f621dmr49368ybq.11.1691685433791; Thu, 10 Aug
 2023 09:37:13 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:36:49 +0000
In-Reply-To: <20230810163346.274132-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230810163346.274132-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230810163654.275023-2-calvinwan@google.com>
Subject: [RFC PATCH v2 2/7] object: move function to object.c
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        chooglen@google.com, jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
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
index 22be9812a7..118d3033de 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -5,7 +5,6 @@
 #include "abspath.h"
 #include "config.h"
 #include "gettext.h"
-#include "object.h"
 #include "repository.h"
 #include "strbuf.h"
 #include "trace2.h"
@@ -647,11 +646,6 @@ int rmdir_or_warn(const char *file)
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
index c85b1328d1..272795f863 100644
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
2.41.0.640.ga95def55d0-goog

