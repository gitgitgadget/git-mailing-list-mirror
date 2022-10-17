Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31C4C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 17:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiJQRuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 13:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiJQRtr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 13:49:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9327617887
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:38 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bu30so19586138wrb.8
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfABQ+K2gnW/3jQ18MR3JhVnEMMSZVxIPOYFnQSNeQc=;
        b=iO0ldZeCgwZG9bgIMER+zXtFqe79CaL9DVZwpad+wlYKtsPref5ostCq9rCYdEupiz
         grfTEVvzoiW+JtjVh1czrmP1mqxCFq4BkPw5wYwxqIZ0bd5iNefAJJq754F060oIRAlg
         tbLvd94XI546rmMvnLOn14aDieoSdVNElq7Lk+BZGq7zFpLNE4MxIByFQfv+XQ+oftIo
         5BUb8K2RWtk13m2sNEpfG8GP56RSJGEAc6VKIdkY2f899kn2aCBpMbS2OhuHBia1CvVU
         gyKHaOyuZqulnnQzyRQ1egGjyT0V2cRINvuNZ/VAL05uvWO7wDcvGxMtWiWSMUmZsUDU
         kZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfABQ+K2gnW/3jQ18MR3JhVnEMMSZVxIPOYFnQSNeQc=;
        b=BcuFUnLPFC4Y2VukfPQSBTO/V6w6CdGlrm6HfMdcXAfCGOIPar2l14ArOej3eXHRaT
         iA91F4jByEbhJe+b1lzxiCy2KtNmLKxsYArcE6tRvvI+Vm996+ZD4k4aCXye/+mogYdy
         BojAGaC0naeZ548p+jkX71i4Suf0PZof9dOLJwceFmSOdB6XIMfkXpzdRdMiQLBTw85j
         EYmr8a6qS+nWHckoD3+j6dWUjQwXxZ2UJqBg9F7WPPGL/8PW8M4DFAaU7j1TxxEL1Nor
         9W9ZDZj+nCpv5ZJRp4/aS649HKNZahgUUssQypaxP7W7Zo8MdD/DRAJJZkgCE0+6JAmQ
         vdKw==
X-Gm-Message-State: ACrzQf16f5hGtdHGiFm9B/dFi7aUjLF87m1zLVhl5a5RjQJezxm0VCuP
        l7jcehSFUONcBSJNzm4DaE+rXh6gfU3h1A==
X-Google-Smtp-Source: AMsMyM5S4nd5KGDCQX46GsJNY7Bz41W4kmEfto7GwddSC8JqejjwodbbJvofM/BCqrDezsC45OU4NQ==
X-Received: by 2002:adf:dfc1:0:b0:22f:edf7:b11b with SMTP id q1-20020adfdfc1000000b0022fedf7b11bmr6894751wrn.583.1666028976518;
        Mon, 17 Oct 2022 10:49:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c4b9a00b003a5537bb2besm10676023wmp.25.2022.10.17.10.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 10:49:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/10] gc: use strvec_pushf(), avoid redundant strbuf_detach()
Date:   Mon, 17 Oct 2022 19:49:20 +0200
Message-Id: <patch-v2-09.10-99c5688797a-20221017T170316Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1093.gcda8671d6c6
In-Reply-To: <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust code added in 3797a0a7b7a (maintenance: use Windows scheduled
tasks, 2021-01-05) to use strvec_pushf() directly. Rather than having
a function that returns a strbuf_detach() we need to free and have the
"strvec_pushl()" do its own "xstrdup()" we can format this in-place.

By changing this we only have the "strvec_clear()" between the
"run_command_v_opt()" and the "return result" in
"schtasks_remove_task()". In the subsequent commit we'll start using a
helper which'll allow us to skip the "strvec_clear()".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 075b4637660..519e64e86ee 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1894,12 +1894,7 @@ static int is_schtasks_available(void)
 #endif
 }
 
-static char *schtasks_task_name(const char *frequency)
-{
-	struct strbuf label = STRBUF_INIT;
-	strbuf_addf(&label, "Git Maintenance (%s)", frequency);
-	return strbuf_detach(&label, NULL);
-}
+#define SCHTASKS_NAME_FMT "Git Maintenance (%s)"
 
 static int schtasks_remove_task(enum schedule_priority schedule)
 {
@@ -1907,16 +1902,15 @@ static int schtasks_remove_task(enum schedule_priority schedule)
 	int result;
 	struct strvec args = STRVEC_INIT;
 	const char *frequency = get_frequency(schedule);
-	char *name = schtasks_task_name(frequency);
 
 	get_schedule_cmd(&cmd, NULL);
 	strvec_split(&args, cmd);
-	strvec_pushl(&args, "/delete", "/tn", name, "/f", NULL);
+	strvec_pushl(&args, "/delete", "/tn", NULL);
+	strvec_pushf(&args, SCHTASKS_NAME_FMT, frequency);
+	strvec_pushl(&args, "/f", NULL);
 
 	result = run_command_v_opt(args.v, 0);
-
 	strvec_clear(&args);
-	free(name);
 	return result;
 }
 
@@ -1935,7 +1929,6 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 	const char *xml;
 	struct tempfile *tfile;
 	const char *frequency = get_frequency(schedule);
-	char *name = schtasks_task_name(frequency);
 	struct strbuf tfilename = STRBUF_INIT;
 
 	get_schedule_cmd(&cmd, NULL);
@@ -2028,8 +2021,10 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 	      "</Task>\n";
 	fprintf(tfile->fp, xml, exec_path, exec_path, frequency);
 	strvec_split(&child.args, cmd);
-	strvec_pushl(&child.args, "/create", "/tn", name, "/f", "/xml",
-				  get_tempfile_path(tfile), NULL);
+	strvec_pushl(&child.args, "/create", "/tn", NULL);
+	strvec_pushf(&child.args, SCHTASKS_NAME_FMT, frequency);
+	strvec_pushl(&child.args, "/f", "/xml",
+		     get_tempfile_path(tfile), NULL);
 	close_tempfile_gently(tfile);
 
 	child.no_stdout = 1;
@@ -2040,7 +2035,6 @@ static int schtasks_schedule_task(const char *exec_path, enum schedule_priority
 	result = finish_command(&child);
 
 	delete_tempfile(&tfile);
-	free(name);
 	return result;
 }
 
-- 
2.38.0.1091.gf9d18265e59

