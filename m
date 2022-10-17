Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBCEC4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 17:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiJQRtr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 13:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiJQRtn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 13:49:43 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AC714D12
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:35 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y10so9155687wma.0
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Mo1VnrPzDKuOigK23quXQsUrqYTK7579fyvcbIHPNs=;
        b=bOS0k+BRX7qa5AeJLFaO/zv7kLAsachOQG0f1dyYnrDmBL3TpV3a1bdfi6llaDrgRU
         ufgfr+i9Eq8bWMdGWZOJmuy3FWNyN/O9jg55XTfqEx/Uo2vXtouITZT5rpoZKtO0MWjq
         gCZUaBn0hS7gI8IW38v9r5PVzfLLNTUzx+NovXxCUHhP44+eLxDUp5bD8GBsCf/qCvma
         PQ8K/U+z3CNZXMS+8Om9FgGNFqEYtL/im2dbQZZNQ4/iK+8+qRbaHIIldRTCFpz/IWug
         6Q8dtSmdLdmUHsuCiAL1m84iGr/4R5xQ5oFDCGjae69ta42JqCsGd/FAwjJU+TrdQYYL
         0Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Mo1VnrPzDKuOigK23quXQsUrqYTK7579fyvcbIHPNs=;
        b=1BZ+jVhmTIh11Wv3pU9YTdu0Nm0jQt5shO1yqb3DrIJf+HxXozbHitQuf4jknaMB3o
         DnUiRK/BbXpWjyJZb4vH2XmpoVQZwszxONgwIpXn6GJAPsuJn6GiRi01zgQRlfJM5aVq
         OCclSZ13lFaJbGLVMxRVhNMQ/yXEcGrhL+PPlWDq0gMacqObEUYW06BDLglDT5WwQn8v
         W79BqJoHGHLXAYMLQoSXnZDvcCy63U/x37wP8Ep/N+vDawPW4utA4ChjfQPDbFzjU5L6
         j/3bX8aMDFD851zDbqYioWsP0pvTJ2BNqX/OC8NU2MgMcnqvvbMRS78PlgG8oQRaHRKH
         vdQg==
X-Gm-Message-State: ACrzQf1NVb05ODBfc6WiU3qIeNlSZzya/kHULHMiV/VKscc+b5Ws9ACQ
        u29sTuDyn3No30zx0xdFRVlJqJZLYxxvVA==
X-Google-Smtp-Source: AMsMyM4B4sEQiJSFDBJVfJCkdXig0z/sv8MSfpPpOSJz0ut6GP4Fdcm2C77b4COLPZO6DNQNdZ8mSA==
X-Received: by 2002:a05:600c:4588:b0:3c6:f8b2:dd34 with SMTP id r8-20020a05600c458800b003c6f8b2dd34mr3551725wmo.178.1666028973126;
        Mon, 17 Oct 2022 10:49:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c4b9a00b003a5537bb2besm10676023wmp.25.2022.10.17.10.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 10:49:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/10] run-command API: remove RUN_COMMAND_STDOUT_TO_STDERR flag
Date:   Mon, 17 Oct 2022 19:49:17 +0200
Message-Id: <patch-v2-06.10-75eccc152ad-20221017T170316Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1093.gcda8671d6c6
In-Reply-To: <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The run_command_v_opt*() API is meant to handle various common cases
where we don't want the verbosity of calling the underlying
run_command(), but we're explicitly not trying to cover the full API
surface of run_command() itself.

So if we're not using some of these flags we probably won't need them
again, any future user who needs to set "stdout_to_stderr" can just
use run_command() itself, and the convenience API shouldn't be
cluttered by trying to handle all the needs of various one-offs.

So let's remove the RUN_COMMAND_STDOUT_TO_STDERR flag, it hasn't been
used since 860a2ebecd2 (receive-pack: send auto-gc output over
sideband 2, 2016-06-05) when its last user started using the
underlying API directly.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c |  1 -
 run-command.h | 12 +++++-------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/run-command.c b/run-command.c
index fa23fd0b803..f9a0b13f62f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1008,7 +1008,6 @@ static void run_command_set_opts(struct child_process *cmd, int opt)
 {
 	cmd->no_stdin = opt & RUN_COMMAND_NO_STDIN ? 1 : 0;
 	cmd->git_cmd = opt & RUN_GIT_CMD ? 1 : 0;
-	cmd->stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
 	cmd->silent_exec_failure = opt & RUN_SILENT_EXEC_FAILURE ? 1 : 0;
 	cmd->use_shell = opt & RUN_USING_SHELL ? 1 : 0;
 	cmd->clean_on_exit = opt & RUN_CLEAN_ON_EXIT ? 1 : 0;
diff --git a/run-command.h b/run-command.h
index cf250e36426..0af01bd9b67 100644
--- a/run-command.h
+++ b/run-command.h
@@ -226,12 +226,11 @@ int run_auto_maintenance(int quiet);
 
 #define RUN_COMMAND_NO_STDIN		(1<<0)
 #define RUN_GIT_CMD			(1<<1)
-#define RUN_COMMAND_STDOUT_TO_STDERR	(1<<2)
-#define RUN_SILENT_EXEC_FAILURE		(1<<3)
-#define RUN_USING_SHELL			(1<<4)
-#define RUN_CLEAN_ON_EXIT		(1<<5)
-#define RUN_WAIT_AFTER_CLEAN		(1<<6)
-#define RUN_CLOSE_OBJECT_STORE		(1<<7)
+#define RUN_SILENT_EXEC_FAILURE		(1<<2)
+#define RUN_USING_SHELL			(1<<3)
+#define RUN_CLEAN_ON_EXIT		(1<<4)
+#define RUN_WAIT_AFTER_CLEAN		(1<<5)
+#define RUN_CLOSE_OBJECT_STORE		(1<<6)
 
 /**
  * The run_command_v_opt*() API is a convenience wrapper for an
@@ -249,7 +248,6 @@ int run_auto_maintenance(int quiet);
  *
  *	- RUN_COMMAND_NO_STDIN: .no_stdin
  *	- RUN_GIT_CMD: .git_cmd
- *	- RUN_COMMAND_STDOUT_TO_STDERR: .stdout_to_stderr
  *	- RUN_SILENT_EXEC_FAILURE: .silent_exec_failure
  *	- RUN_USING_SHELL: .use_shell
  *	- RUN_CLEAN_ON_EXIT: .clean_on_exit
-- 
2.38.0.1091.gf9d18265e59

