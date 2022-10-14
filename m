Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C068C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiJNPk6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiJNPko (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:40:44 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FD3F6151
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a3so8251333wrt.0
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czw+C2bEo+JIYG+MFFoenGzOzqMwi0isCQRejd0sv7w=;
        b=cChel47kxeW/kEm7c1q9OBfMtrfK8p/9XjWYeyDfiolmtuk0oyXeDIoif+9Lmj5yvJ
         DUbN7fuPGAxLjwBfT7GNTWesIsA5Ty3T7S3hI0CjcbJ6SG3Z1Sb/mZa1WnFvrNs0Y4K2
         FwImq4LDnhzUfGCyzoKN5Wrw3TsbuYwJDmnpX85EtZ5qMzvtCCWaYMQb7ckmX2nR3MUU
         j7O2go45o2d/MfmVdsu+2Y7HwHcKK3cJYpyNc00U4OqKSsGSSL/LIrMZgXS0mV9OWVS2
         LlDpLr4UtYG8jKF9bmwqbNjz/CS3EJZYKzn5KAXJ69GLIjl8D7mNks9t4IuY036EZgKW
         wlTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czw+C2bEo+JIYG+MFFoenGzOzqMwi0isCQRejd0sv7w=;
        b=lourtNo6jdU+aXbIzfNWg/Gzk21dv1P9AJo+VGVSVdcD5KDJuwe1hvcj2REONCK7kJ
         qFUM6wD6Q+TXs/esjMfDUtbuv36EwaCq/K7W8WutNzdGz78IrdF16RDF8WZk4uo5Wozl
         a6JzfuUxBzccARIMo1cxJmJtMctJGp0W/SY4tb2ONhED3Hd/l8b5Hdh0MqcrNDkzw/wq
         TlnYEYQnw9WXtxB6vdb/gt4eBR+qHe2zBVyaSpUukwAO4xnjI2XLjRuamV37cVwTer3v
         jQVnUIJRf5UsJVySGRiduwAcyi7dAaP5ulXMtmmRDW7UhlYM3xG0dhZN7/7hUQlFv7ti
         JY9Q==
X-Gm-Message-State: ACrzQf3kemp2JWpWsfdISkMeXULvCnutu32FTL/fvvhi4Mrz8HkrHGu1
        43lClFBsMu5IudBCpXQERKbmSQBf0WM5xA==
X-Google-Smtp-Source: AMsMyM6w45giNSzQ1AdkVCnpYuKywGcftA8qaXOIWt+C+YON1LMmepP3Ur56h6wHqJLK4ihuzfU7oQ==
X-Received: by 2002:a5d:648c:0:b0:22e:63be:be09 with SMTP id o12-20020a5d648c000000b0022e63bebe09mr3788195wri.159.1665762033370;
        Fri, 14 Oct 2022 08:40:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c4639ac6sm2385391wmz.34.2022.10.14.08.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:40:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/10] run-command API: remove RUN_COMMAND_STDOUT_TO_STDERR flag
Date:   Fri, 14 Oct 2022 17:40:18 +0200
Message-Id: <patch-06.10-9d0286fbf64-20221014T153426Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
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
index 0be5626f7f2..fe1b4a0b650 100644
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
2.38.0.1092.g8c0298861b0

