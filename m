Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49527EEB560
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 17:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245217AbjIHRpD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 13:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjIHRo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 13:44:59 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99701FC9
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 10:44:53 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-68bf02547dbso3287674b3a.1
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 10:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694195093; x=1694799893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s8GT+aljLTzsbDePyseZ/joAWLog4DPSAq/SXT+uXTY=;
        b=kLMJktt4DDYeSLEja0yPqoQRkDuwKAcGnt6ivz00fjJG7WHwU7R0gf7pZSzoK7gk5u
         wJhR4zWbndLIqZYU/0u1dViRhvX4ocwk7cAuV4As9TqMrrCv0kPa+7D+KkPIBTnBzZvu
         /fqA4lW+rsGksqeJ2poiMQGMgO3D2P011eO5Vs35bYhBt4EVnamEOxFvVlAOHEl0DB1B
         vRiZljZ1HepZuccSlFsOHokTCraiwvWzCf7BV0fGeCAJjls8TQ3FyZQQvjwwe1TOZw/S
         D8TkAKUa+PcNIzPwYgGe5zVZmVmppGj1m+7lf2AM4ZC9DcEZEr6cl6Z8b8K9hXdKsQSV
         +enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694195093; x=1694799893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8GT+aljLTzsbDePyseZ/joAWLog4DPSAq/SXT+uXTY=;
        b=T5WRDwneyenDfEwv3ObDnEuE+qL0ZCdns9hnafezcWVf9PjxRsPK+sBV8ESg5IISgO
         hRQwykMQ4mhpR0uG0lWzl03lPlOu7ujC/cKZ6i0AUyDTJsNlG4yftCUbkCldNFg4MoFM
         oLH7dnVfR9Eyt2ZwKqnRqk63i4JR/8VFxLIU4fKNp18ViPv4N9KKezgrL5WeiMRewZY0
         d/pjCCgSOt7Brysm2aVJ/ZaIXCjLMSLbrdqVFbECkBqsDEj/4pleZ9v8QTLki1PPTzlm
         ZQU/h1ujqIJEkKpuIekdKCKAxu9Hsrqcuva3xG1BYD64qkqY/ETkJHiStm2CESWoWBIP
         FJHg==
X-Gm-Message-State: AOJu0YwQw1qJ3Pg5LQupbYV2Z65YhzMHFNPZKkiDD7X3fk6nBA4Kw72o
        Uk7TUJztIo33EDEoFc52r/v7ecTj9RcnBQOUTyb72hic3vSkKdgNmW6E9xiW80tt8IcWsjCOGdC
        BNo4GcfHd1tf4hkbAIIpGdgmk8ZjAu+Ug6GX3oc2IKk9pH4haHNZ/wCrJm/bSI2wuAg==
X-Google-Smtp-Source: AGHT+IGd9+ZyGFYyOavygFsb0i2bb3SqQpC3Lj4mO1n0aKiq3Lav7CXOejzDyHzx+PWhUnmYsxutYb4ND0hRPJw=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:2d19:b0:68e:3c6d:da7a with SMTP
 id fa25-20020a056a002d1900b0068e3c6dda7amr1284408pfb.4.1694195093336; Fri, 08
 Sep 2023 10:44:53 -0700 (PDT)
Date:   Fri,  8 Sep 2023 17:44:39 +0000
In-Reply-To: <20230908174134.1026823-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230908174134.1026823-1-calvinwan@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908174443.1027716-2-calvinwan@google.com>
Subject: [PATCH v3 2/6] wrapper: remove dependency to Git-specific internal file
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order for wrapper.c to be built independently as part of a smaller
library, it cannot have dependencies to other Git specific
internals. remove_or_warn() creates an unnecessary dependency to
object.h in wrapper.c. Therefore move the function to entry.[ch] which
performs changes on the worktree based on the Git-specific file modes in
the index.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 entry.c   | 5 +++++
 entry.h   | 6 ++++++
 wrapper.c | 6 ------
 wrapper.h | 5 -----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/entry.c b/entry.c
index 43767f9043..076e97eb89 100644
--- a/entry.c
+++ b/entry.c
@@ -581,3 +581,8 @@ void unlink_entry(const struct cache_entry *ce, const char *super_prefix)
 		return;
 	schedule_dir_for_removal(ce->name, ce_namelen(ce));
 }
+
+int remove_or_warn(unsigned int mode, const char *file)
+{
+	return S_ISGITLINK(mode) ? rmdir_or_warn(file) : unlink_or_warn(file);
+}
diff --git a/entry.h b/entry.h
index 7329f918a9..ca3ed35bc0 100644
--- a/entry.h
+++ b/entry.h
@@ -62,4 +62,10 @@ int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st)
 void update_ce_after_write(const struct checkout *state, struct cache_entry *ce,
 			   struct stat *st);
 
+/*
+ * Calls the correct function out of {unlink,rmdir}_or_warn based on
+ * the supplied file mode.
+ */
+int remove_or_warn(unsigned int mode, const char *path);
+
 #endif /* ENTRY_H */
diff --git a/wrapper.c b/wrapper.c
index 48065c4f53..453a20ed99 100644
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
@@ -632,11 +631,6 @@ int rmdir_or_warn(const char *file)
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
index 79c7321bb3..1b2b047ea0 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -106,11 +106,6 @@ int unlink_or_msg(const char *file, struct strbuf *err);
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
2.42.0.283.g2d96d420d3-goog

