Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B784C43217
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiJNPlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiJNPkp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:40:45 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE3E15A305
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:38 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so5635752wmr.2
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IV9VsMnmeNLvXObYBNqpDkqy5Y1QcPO4zazqC6lXxXc=;
        b=XZ7xDPbNSkGvfhzde4YH7OOvpuSrkG7iGSN3E9qsacyMlmhKtRTlDKtbQdu+lsV3MB
         E2IZZzxSd4bUOUvRAOntjPQrtrGCgSm5zJNx3uNAhKJDdXVh7D1amK05l2q7de0nSBRE
         LiiRKllrjv52LpCuYUJ03PyDHeHtSiCXo9H/Aq2AfcQ7OiN9F0T03KI5zEy/5EDO/SbY
         EjZQRhFoAvHDP8+4q/DUQOZ2S0rc7IbTanhNvrqMgAcARew/ncI/rhXQ98IparZl2Nzm
         c61QYPvPD0g7tkh79Y3arNzP/PzcLNx3jg9a3oWlj0neEqymNnkOZrxdA/9fTpoECn8/
         v5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IV9VsMnmeNLvXObYBNqpDkqy5Y1QcPO4zazqC6lXxXc=;
        b=Wd1MBfhjiuSGwlBPmAg61LZLSMR09B04TFQs/y2JpS94YdF00lQBsalvFB9+A8Nknz
         yAi8xQLlNs2sz5VIIX65J1R2svUinYCcfQFdbdGpwapY25YtZZvvx+SHKij393llz1tz
         XNH2PeCLI4IixXKntSOvhTFJ3af5UH7Iv7EyCFaRznmzlvnUG7RneHpKaTiqZS8r9Ly6
         loferS8L0oIXBNVuvUs/xCAJHi72/2Yh5vUcHzMSdbjl/Ue2+LJaIlA5biBuWI0JoYre
         EVbn7PRO0xIXCNuoT8oVu06604+1lwZDvAD3ej2NUliQbUlH7nW5kojt05FIDHTewecJ
         kv7g==
X-Gm-Message-State: ACrzQf1/MEBuN8rUotZhg5VKLYqPNeLaMHjpKexbu9yRu2tEQoNTbXPU
        1QZabKWTZB/zQs2d5yCNIUGr9wq0sylFBg==
X-Google-Smtp-Source: AMsMyM41vMTOM+4rq9PNK2zfVIimw/t1qrqIaPEVNnGM6k4BOq/J3KmeLIcejE76otAAtPLjvlro/A==
X-Received: by 2002:a05:600c:5388:b0:3c5:4c1:a1f6 with SMTP id hg8-20020a05600c538800b003c504c1a1f6mr4127029wmb.11.1665762036899;
        Fri, 14 Oct 2022 08:40:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c4639ac6sm2385391wmz.34.2022.10.14.08.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:40:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/10] gc: use strvec_pushf(), avoid redundant strbuf_detach()
Date:   Fri, 14 Oct 2022 17:40:21 +0200
Message-Id: <patch-09.10-0f5524e40ad-20221014T153426Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
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
2.38.0.1092.g8c0298861b0

