Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2A3EB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 19:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjF0TxL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 15:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjF0TxK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 15:53:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F55610F5
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:53:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c1039cbba72so528904276.0
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 12:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687895587; x=1690487587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hZuSZCZII7PvO9amGQkSEKppFNjLgyI2N/nPiwfLb6s=;
        b=5OPo0PJnT9OAl0S8vTyQaOUdMFnXRxI9Tz1DZE5H3elfUaz29riHmelB9DjRIaagnn
         fEhoZT9xXFZqmHfkgk2NGISGzgrptF1XIkSozjGnA8qf32gVRUr0PplGQdVzx0kNQKph
         hWe/2HszIkx6Ecp70HuKwGAjZU4LP7NN5c8m3TUZ+TNJ3BTgSTt/D8GUzBYOKJHZ42oK
         Twu774MC2pHtqhzhdM5qzJtX1BUw/DvJzke3iZb8VjdLv2zsMqeVcXswTZ9XQhLmQ9HB
         aPS1iKoIB/ZdNUM7j4yUnThEEvLtCUaBA/byzR0pc4KiBtSVzp+8mtdzfkssGKDhAjjM
         QfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687895587; x=1690487587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZuSZCZII7PvO9amGQkSEKppFNjLgyI2N/nPiwfLb6s=;
        b=K0CwhesbB0KXMKZRn8A1ZpwhKfY3mYJ+CYrI2a9T1nekxcIaszTbYpiTaQBa6g9sb+
         iN0AWoehwwpEJFd9EVR6Urq67gWUuHCnPiSAI0LUXHj0ePOaUZ0RMs2hIYoHNZlymWyD
         5GhjIOmvwbxYoGU57JrhpiqPBVb5TUKcAthd61bKH5DKzV1esuQHMMWinP5x9UlJSJ5C
         rOnr2vQ4xSWQNsngFM/amuBe6u59phU0NM/TP1Jj4n8rqxMsQUOzBzd/nXQARfFQwQaE
         sNqgmuTItOM+HQ/qW387UEPZdroWfUssJo9BMohl9X415OkRc4TGzpC/rUU3h6o8ILtF
         Rf9g==
X-Gm-Message-State: AC+VfDzppqN5iMrK4gWLBZjx/dH7KmvGCQ4/wq8IplLJ8fcUrwH1QexX
        pHH1sl7//La94pVzRu4Dpe83YqEL26ePlyaBwBZeKl3zc/zaJpzXUoJz+PXoiSadAyDOVGfq3fh
        QtYS+Ip8vK40Qg8UdwdLxFc/8IizXZyNDaaHkbr1/07m5l5dhO3gsOVaC+AV5J6appw==
X-Google-Smtp-Source: ACHHUZ7j1CFsJ6PGAOULwi388ZswykZJdvEhVJMqZ0L4HrvAoxJQlA6KHNca6ViyWy42JR10WoUnY/LZfIbfl5Y=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:ac92:0:b0:bc4:78ac:920f with SMTP id
 x18-20020a25ac92000000b00bc478ac920fmr14891939ybi.0.1687895587651; Tue, 27
 Jun 2023 12:53:07 -0700 (PDT)
Date:   Tue, 27 Jun 2023 19:52:44 +0000
In-Reply-To: <20230627195251.1973421-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627195251.1973421-2-calvinwan@google.com>
Subject: [RFC PATCH 1/8] trace2: log fsync stats in trace2 rather than wrapper
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        chooglen@google.com, johnathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As a library boundary, wrapper.c should not directly log trace2
statistics, but instead provide those statistics upon
request. Therefore, move the trace2 logging code to trace2.[ch.]. This
also allows wrapper.c to not be dependent on trace2.h and repository.h.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 trace2.c  | 13 +++++++++++++
 trace2.h  |  5 +++++
 wrapper.c | 17 ++++++-----------
 wrapper.h |  4 ++--
 4 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/trace2.c b/trace2.c
index 0efc4e7b95..f367a1ce31 100644
--- a/trace2.c
+++ b/trace2.c
@@ -915,3 +915,16 @@ const char *trace2_session_id(void)
 {
 	return tr2_sid_get();
 }
+
+static void log_trace_fsync_if(const char *key)
+{
+	intmax_t value = get_trace_git_fsync_stats(key);
+	if (value)
+		trace2_data_intmax("fsync", the_repository, key, value);
+}
+
+void trace_git_fsync_stats(void)
+{
+	log_trace_fsync_if("fsync/writeout-only");
+	log_trace_fsync_if("fsync/hardware-flush");
+}
diff --git a/trace2.h b/trace2.h
index 4ced30c0db..689e9a4027 100644
--- a/trace2.h
+++ b/trace2.h
@@ -581,4 +581,9 @@ void trace2_collect_process_info(enum trace2_process_info_reason reason);
 
 const char *trace2_session_id(void);
 
+/*
+ * Writes out trace statistics for fsync
+ */
+void trace_git_fsync_stats(void);
+
 #endif /* TRACE2_H */
diff --git a/wrapper.c b/wrapper.c
index 22be9812a7..bd7f0a9752 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -6,9 +6,7 @@
 #include "config.h"
 #include "gettext.h"
 #include "object.h"
-#include "repository.h"
 #include "strbuf.h"
-#include "trace2.h"
 
 static intmax_t count_fsync_writeout_only;
 static intmax_t count_fsync_hardware_flush;
@@ -600,16 +598,13 @@ int git_fsync(int fd, enum fsync_action action)
 	}
 }
 
-static void log_trace_fsync_if(const char *key, intmax_t value)
+intmax_t get_trace_git_fsync_stats(const char *key)
 {
-	if (value)
-		trace2_data_intmax("fsync", the_repository, key, value);
-}
-
-void trace_git_fsync_stats(void)
-{
-	log_trace_fsync_if("fsync/writeout-only", count_fsync_writeout_only);
-	log_trace_fsync_if("fsync/hardware-flush", count_fsync_hardware_flush);
+	if (!strcmp(key, "fsync/writeout-only"))
+		return count_fsync_writeout_only;
+	if (!strcmp(key, "fsync/hardware-flush"))
+		return count_fsync_hardware_flush;
+	return 0;
 }
 
 static int warn_if_unremovable(const char *op, const char *file, int rc)
diff --git a/wrapper.h b/wrapper.h
index c85b1328d1..db1bc109ed 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -88,9 +88,9 @@ enum fsync_action {
 int git_fsync(int fd, enum fsync_action action);
 
 /*
- * Writes out trace statistics for fsync using the trace2 API.
+ * Returns trace statistics for fsync using the trace2 API.
  */
-void trace_git_fsync_stats(void);
+intmax_t get_trace_git_fsync_stats(const char *key);
 
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
-- 
2.41.0.162.gfafddb0af9-goog

