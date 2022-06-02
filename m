Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E58C43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 12:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbiFBMZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 08:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbiFBMZo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 08:25:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E5913274F
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 05:25:43 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q7so6260606wrg.5
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 05:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Xb9Rcsd9pK9CK+PbUe3Q1mgSDjc8KrZVyHGiblOA2A=;
        b=GJWe71ealkt2HESaL5dWSbtOxdXR5+EkJ/wCTVfXKR2R15aFrxlrfn9KJkPBzN5LmP
         u3sC9p3+89M3uVRF4YMB2ZD30s6HbrhKJ3XzYOMGg1fmz3/QjFsOOkTARMb/XlJCT1q0
         Ar17Mu/Bs0HGc2EPb0vF8beVWk7bIMYgVaoSaBDHcsyBpfbArm5sDtVdZ3nFH2m4b50u
         COzt+03wLb7FGG5blln7xFWrXd/n8KIecUW9qxcnYJuPHwFi5uAwEpaMyIisrlbBGbDv
         a8KXSkIbEDeiVAq4eeLdicdrdDjWFIqdvmGjsmC5o8pqspgsFivuws5RjACa17qpwMMx
         y50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Xb9Rcsd9pK9CK+PbUe3Q1mgSDjc8KrZVyHGiblOA2A=;
        b=XpRKKQiivpeTQUeSrjMa9YfaxtPG8daUnTTeYsZ5lt+SJTF5Pfdhkoco799ZzAmxoe
         UHD1BuIa3y3vvi3Q71hg9AAOffOj465hCcE3GQBsTtzfgOtwompkEUJRdKMQBEaAtXJM
         JvzXuFSKWV0aKFl9PA2fpovbA0/h4M2CEdGFtC9v3LGIknpTOXKGT+gt7PuBbvskXf+T
         LuE5wIUFCSTQarZPq0PN0PXgoCzil8rqmRgJ6I5gk1+5jefhIP3SRdnXILfOySVhbutO
         FT7PDIeEQYEFLafC8rejNe0y281SyZKq23QhfWj4hMiE6MrOBlnmCTpNDaOo5crJ2i+b
         sKpg==
X-Gm-Message-State: AOAM53033fWIS3ohScibYlSQ8tUC0opYUqsscekkFRCIPUGoTGiRZQzR
        6JJ3IXfDzT3BrTghJCG21JcT12+lZchIeA==
X-Google-Smtp-Source: ABdhPJzLbmaunZkAwkq14vZTl3iR4mJbbOfYITxyjOPCo6lg/jSSuo8yxsct0jOi/aUn7W+P7vp/Nw==
X-Received: by 2002:a5d:588d:0:b0:20e:e4f0:e3 with SMTP id n13-20020a5d588d000000b0020ee4f000e3mr3505942wrf.87.1654172741128;
        Thu, 02 Jun 2022 05:25:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b0020e615bab7bsm4305100wrt.7.2022.06.02.05.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 05:25:40 -0700 (PDT)
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
Subject: [PATCH v3 1/6] common-main.o: move non-trace2 exit() behavior out of trace2.c
Date:   Thu,  2 Jun 2022 14:25:32 +0200
Message-Id: <patch-v3-1.6-9c4f8d840e9-20220602T122106Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.gb3ecdfb3e6a
In-Reply-To: <cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com>
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
 common-main.c     | 20 ++++++++++++++++----
 git-compat-util.h |  4 ++--
 trace2.c          |  8 ++------
 trace2.h          |  8 +-------
 4 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/common-main.c b/common-main.c
index 29fb7452f8a..b6124dd2c2c 100644
--- a/common-main.c
+++ b/common-main.c
@@ -55,10 +55,22 @@ int main(int argc, const char **argv)
 
 	result = cmd_main(argc, argv);
 
+	/* Not exit(3), but a wrapper calling our common_exit() */
+	exit(result);
+}
+
+/* We wrap exit() to call common_exit() in git-compat-util.h */
+int common_exit(const char *file, int line, int code)
+{
 	/*
-	 * We define exit() to call trace2_cmd_exit_fl() in
-	 * git-compat-util.h. Whether we reach this or exit()
-	 * elsewhere we'll always run our trace2 exit handler.
+	 * For non-POSIX systems: Take the lowest 8 bits of the "code"
+	 * to e.g. turn -1 into 255. On a POSIX system this is
+	 * redundant, see exit(3) and wait(2), but as it doesn't harm
+	 * anything there we don't need to guard this with an "ifdef".
 	 */
-	exit(result);
+	code &= 0xff;
+
+	trace2_cmd_exit_fl(file, line, code);
+
+	return code;
 }
diff --git a/git-compat-util.h b/git-compat-util.h
index 96293b6c43a..1227ff80ca7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1451,8 +1451,8 @@ int cmd_main(int, const char **);
  * Intercept all calls to exit() and route them to trace2 to
  * optionally emit a message before calling the real exit().
  */
-int trace2_cmd_exit_fl(const char *file, int line, int code);
-#define exit(code) exit(trace2_cmd_exit_fl(__FILE__, __LINE__, (code)))
+int common_exit(const char *file, int line, int code);
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
2.36.1.1103.gb3ecdfb3e6a

