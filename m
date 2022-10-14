Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E16C43219
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 15:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiJNPkr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbiJNPkf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 11:40:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278D5EA37B
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:33 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bu30so8158715wrb.8
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 08:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvNgDTNWspXdQYWjfMNnNU7pq+rmI/6FtHUPNOtVF3w=;
        b=QqbWogzgzcztXDsHg5M9JAnBX41RSQnDS7d60RohvUNQt8ww/n8W76Ya6hcGMZWcn7
         ReQn+BjEfyFKpIEkBCGHvxkDO2JGyKZ+09K9+ktqBnN93RUfVKdZiLEa8mJ6m7KsSerZ
         PcDx4+NcXLiStKd88zQOL0K06vBT7rTAi1AfFmzBnOwk1ni6UxD0aWHOpXInJmn/pUix
         SlFkrxTOpfogODEeDpewV9fTsNoj3Y4kbdWPGLY4i8uh0srfWKMPPncNuLUE8KM0NapH
         n+3QOsReEE/c4Fqwl7cgZHXl0W/CRhRZBnUA2Sa0S5MqKfgVZoMe+M29Ttius98+4/UQ
         wPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvNgDTNWspXdQYWjfMNnNU7pq+rmI/6FtHUPNOtVF3w=;
        b=IejCs9YE5IZCMQckgWh68/SblgHGCg0U7U037YYkb9RzYDg5ve/y3weTZXY/kGj4r+
         o77z92biwHqKjmQQ8VupgehRF80HLRGPErzpkio/CfFipM6Il3mCXO7GNjsx/Ie3O1cx
         mUEqyMIzc6eLbtR4PFfGD8SfXeLqVo3UrEVrTVRQb0ncA+YKqzxwqBrvsTOOMXSb3jWA
         +trn4gAEzMZLhc4uxJ9jr3hD+NIjUjS5DWHFtvOvTjk15P4XKfzwr8SCMcuWIn6rW6A+
         JvHFV9N1cLzkTa3FRzxF0l71DNh2zE+iBuKrL+jGGIxdGysTRcqC1fhsJ/eC3ctaFv9Y
         jMMg==
X-Gm-Message-State: ACrzQf2EHTHfLAu4HuUHqBux4VmxIiIt5yXStfbxMgk/07kamvmx0Skn
        tKh+J9GiL/ODnMWrJ6B3C4WY0UXR4JibFQ==
X-Google-Smtp-Source: AMsMyM5cjhy1yLLDKkYgNlWqRlOULyIClvmOxVtaNqBX/wllN7jinJL80VUNbER+1bUDZDBdZQWjYQ==
X-Received: by 2002:a5d:4f8b:0:b0:22e:40fc:bd1b with SMTP id d11-20020a5d4f8b000000b0022e40fcbd1bmr3767892wru.717.1665762032097;
        Fri, 14 Oct 2022 08:40:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 123-20020a1c1981000000b003c6c4639ac6sm2385391wmz.34.2022.10.14.08.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:40:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/10] run-command API docs: clarify & fleshen out run_command_v_opt*() docs
Date:   Fri, 14 Oct 2022 17:40:17 +0200
Message-Id: <patch-05.10-b6a3c4c66f8-20221014T153426Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1092.g8c0298861b0
In-Reply-To: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a discussion of the flags that were missing to the
run_command_v_opt*() docs, and in doing so format them such that we
can easily add or remove flags from a table in the future, rather than
having them tied up in prose.

Let's also clarify why the user might want to use this API over
run_command() itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.h | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/run-command.h b/run-command.h
index 6320d70f062..cf250e36426 100644
--- a/run-command.h
+++ b/run-command.h
@@ -234,13 +234,28 @@ int run_auto_maintenance(int quiet);
 #define RUN_CLOSE_OBJECT_STORE		(1<<7)
 
 /**
- * Convenience functions that encapsulate a sequence of
- * start_command() followed by finish_command(). The argument argv
- * specifies the program and its arguments. The argument opt is zero
- * or more of the flags `RUN_COMMAND_NO_STDIN`, `RUN_GIT_CMD`,
- * `RUN_COMMAND_STDOUT_TO_STDERR`, or `RUN_SILENT_EXEC_FAILURE`
- * that correspond to the members .no_stdin, .git_cmd,
- * .stdout_to_stderr, .silent_exec_failure of `struct child_process`.
+ * The run_command_v_opt*() API is a convenience wrapper for an
+ * underlying run_command().
+ *
+ * It's intended to be used when the user already has an "argv" they'd
+ * like to use. As opposed to the "struct child_process"'s "args"
+ * member, which will be strvec_clear()'d by calling run_command(),
+ * the caller owns the "argv", which is not altered by invoking these
+ * functions.
+ *
+ * The "opt" flags that will cause various underlying run_command()
+ * members to be set. The flags and the corresponding struct members
+ * are:
+ *
+ *	- RUN_COMMAND_NO_STDIN: .no_stdin
+ *	- RUN_GIT_CMD: .git_cmd
+ *	- RUN_COMMAND_STDOUT_TO_STDERR: .stdout_to_stderr
+ *	- RUN_SILENT_EXEC_FAILURE: .silent_exec_failure
+ *	- RUN_USING_SHELL: .use_shell
+ *	- RUN_CLEAN_ON_EXIT: .clean_on_exit
+ *	- RUN_WAIT_AFTER_CLEAN: .wait_after_clean
+ *	- RUN_CLOSE_OBJECT_STORE: .close_object_store
+ *
  * The argument dir corresponds the member .dir. The argument env
  * corresponds to the member .env.
  */
-- 
2.38.0.1092.g8c0298861b0

