Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51347C433F5
	for <git@archiver.kernel.org>; Tue, 31 May 2022 16:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346242AbiEaQ7J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 May 2022 12:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240921AbiEaQ7H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 May 2022 12:59:07 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A1368F95
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:59:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n185so363700wmn.4
        for <git@vger.kernel.org>; Tue, 31 May 2022 09:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tUEtMkmbptir9Rs4qS4pHzBnuRdyc0yZ8hyiZ6GBLKU=;
        b=aKPZMrgk6GxDN1sWfKx+v0YwFDdhUAq1vEdJioIpbOXq+k/QDEhavAsjCHEtIMV0eh
         88xWr1ScBS3iY3A6SIZGMg/ypHiYgDiGMqxfJDRkslXtTgxQRJMb5NuKrk+DJrvXzAJK
         G+v53N3I73J0lfsORrd/avuv4wedy/B6ZV+2WWDN6MkpFicVakysUVHcn68vrYRIYdo1
         BWblDwvxouoJsF1TlEmxI4nrCDfEaNPgYptwr/Flaoxu+v6NwTrWzPCAlhy7eNZoRyzq
         F5v/P2KAF7ZDzJGnaRfr0XGGctphuTyuTWped3SMLeSQrNPnW4tQYFYPTjA8AWQAViQo
         5mFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tUEtMkmbptir9Rs4qS4pHzBnuRdyc0yZ8hyiZ6GBLKU=;
        b=7Tk0wbG4lAkgPgiATfZthVi1SCi3tNqtWcooE8YSLfSBoJyQ5uza7DSsB4FSM45CSL
         2KDtaFpd5N2eEDhzQfm82b7Ws/VPJQzX1SSPakC63ofxIBYbyiQbyEyDuGr5Qk51azkk
         gnSLJlgHRKqI1UfNzMJiDBgvsUjpZK/fWe6YJlTgFj15Z0vssaiSyymHkzdVxFHPiMl9
         ZWYe4px2KO+fRUgUzuimb/7A8NEDhCjr6JDgCzjPPDmFr2aQ7wCn6H0TVDfP14NwrUzI
         Bd+Jtpp0v+2HaBGRigS8kwLWvxQf+7wr5DHo0Kbuybrm1wdjXd3TR7ZAb7s2XUwWcRHe
         rnKA==
X-Gm-Message-State: AOAM530iyapZXbKOLPd3U2vEoI4KN1DHcRJWeM/XUE/B2sj366pShK5t
        COiyelgfEKPVc3bEs+JHw54pMb5dtGo=
X-Google-Smtp-Source: ABdhPJymic4/pdldsv0AKeVRGWAqL5XRl6zK8pg9Hk4u7yo01LwoPbKE7xGLz6SjVjsMYYfti0gUFQ==
X-Received: by 2002:a05:600c:20e:b0:397:697f:172b with SMTP id 14-20020a05600c020e00b00397697f172bmr24673686wmi.84.1654016344290;
        Tue, 31 May 2022 09:59:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d47c3000000b0020d0cdbf7eesm12829820wrc.111.2022.05.31.09.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 09:59:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] common-main.o: move non-trace2 exit() behavior out of trace2.c
Date:   Tue, 31 May 2022 18:58:43 +0200
Message-Id: <patch-v2-1.6-d446e4679d4-20220531T164806Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1100.g16130010d07
In-Reply-To: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20220521T170939Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the exit() wrapper added in ee4512ed481 (trace2: create new
combined trace facility, 2019-02-22) so that we'll split up the trace2
logging concerns from wanting to wrap the "exit()" function itself for
other purposes.

This makes more sense structurally, as we won't seem to conflate
non-trace2 behavior with the trace2 code. I'd previously added an
explanation for this in 368b5843158 (common-main.c: call exit(), don't
return, 2021-12-07), that comment is being adjusted here.

Now the only thing we'll do if we're not using trace2 is to truncate
the "code" argument to the lowest 8 bits.

We only need to do that truncation on non-POSIX systems, but in
ee4512ed481 that "if defined(__MINGW32__)" code added in
47e3de0e796 (MinGW: truncate exit()'s argument to lowest 8 bits,
2009-07-05) was made to run everywhere. It might be good for clarify
to narrow that down by an "ifdef" again, but I'm not certain that in
the interim we haven't had some other non-POSIX systems rely the
behavior. On a POSIX system taking the lowest 8 bits is implicit, see
exit(3)[1] and wait(2)[2]. Let's leave a comment about that instead.

1. https://man7.org/linux/man-pages/man3/exit.3.html
2. https://man7.org/linux/man-pages/man2/wait.2.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 common-main.c     | 19 +++++++++++++++++--
 git-compat-util.h | 12 ++++++++++--
 trace2.c          |  8 ++------
 trace2.h          |  8 +-------
 4 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/common-main.c b/common-main.c
index 29fb7452f8a..bb0100f6024 100644
--- a/common-main.c
+++ b/common-main.c
@@ -56,9 +56,24 @@ int main(int argc, const char **argv)
 	result = cmd_main(argc, argv);
 
 	/*
-	 * We define exit() to call trace2_cmd_exit_fl() in
-	 * git-compat-util.h. Whether we reach this or exit()
+	 * We define exit() to call common_exit(), which will in turn
+	 * call trace2_cmd_exit_fl(). Whether we reach this or exit()
 	 * elsewhere we'll always run our trace2 exit handler.
 	 */
 	exit(result);
 }
+
+int common_exit(const char *file, int line, int code)
+{
+	/*
+	 * For non-POSIX systems: Take the lowest 8 bits of the "code"
+	 * to e.g. turn -1 into 255. On a POSIX system this is
+	 * redundant, see exit(3) and wait(2), but as it doesn't harm
+	 * anything there we don't need to guard this with an "ifdef".
+	 */
+	code &= 0xff;
+
+	trace2_cmd_exit_fl(file, line, code);
+
+	return code;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index 96293b6c43a..a446a363de2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1447,12 +1447,20 @@ static inline int is_missing_file_error(int errno_)
 
 int cmd_main(int, const char **);
 
+/**
+ * The exit() function is defined as common_exit() in
+ * git-compat-util.h.
+ *
+ * Intercepting the exit() allows us to hook in at-exit behavior, such
+ * emitting trace2 logging before calling the real exit().
+ */
+int common_exit(const char *file, int line, int code);
+
 /*
  * Intercept all calls to exit() and route them to trace2 to
  * optionally emit a message before calling the real exit().
  */
-int trace2_cmd_exit_fl(const char *file, int line, int code);
-#define exit(code) exit(trace2_cmd_exit_fl(__FILE__, __LINE__, (code)))
+#define exit(code) exit(common_exit(__FILE__, __LINE__, (code)))
 
 /*
  * You can mark a stack variable with UNLEAK(var) to avoid it being
diff --git a/trace2.c b/trace2.c
index e01cf77f1a8..0c0a11e07d5 100644
--- a/trace2.c
+++ b/trace2.c
@@ -202,17 +202,15 @@ void trace2_cmd_start_fl(const char *file, int line, const char **argv)
 					    argv);
 }
 
-int trace2_cmd_exit_fl(const char *file, int line, int code)
+void trace2_cmd_exit_fl(const char *file, int line, int code)
 {
 	struct tr2_tgt *tgt_j;
 	int j;
 	uint64_t us_now;
 	uint64_t us_elapsed_absolute;
 
-	code &= 0xff;
-
 	if (!trace2_enabled)
-		return code;
+		return;
 
 	trace_git_fsync_stats();
 	trace2_collect_process_info(TRACE2_PROCESS_INFO_EXIT);
@@ -226,8 +224,6 @@ int trace2_cmd_exit_fl(const char *file, int line, int code)
 		if (tgt_j->pfn_exit_fl)
 			tgt_j->pfn_exit_fl(file, line, us_elapsed_absolute,
 					   code);
-
-	return code;
 }
 
 void trace2_cmd_error_va_fl(const char *file, int line, const char *fmt,
diff --git a/trace2.h b/trace2.h
index 1b109f57d0a..88d906ea830 100644
--- a/trace2.h
+++ b/trace2.h
@@ -101,14 +101,8 @@ void trace2_cmd_start_fl(const char *file, int line, const char **argv);
 
 /*
  * Emit an 'exit' event.
- *
- * Write the exit-code that will be passed to exit() or returned
- * from main().
- *
- * Use this prior to actually calling exit().
- * See "#define exit()" in git-compat-util.h
  */
-int trace2_cmd_exit_fl(const char *file, int line, int code);
+void trace2_cmd_exit_fl(const char *file, int line, int code);
 
 #define trace2_cmd_exit(code) (trace2_cmd_exit_fl(__FILE__, __LINE__, (code)))
 
-- 
2.36.1.1100.g16130010d07

