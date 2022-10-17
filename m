Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F60DC4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 17:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiJQRtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 13:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiJQRth (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 13:49:37 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5770F58A
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id t4so9112827wmj.5
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09jczzBKoiZ5VT0vFNyyBObMkIOVjeQ1lFzwJFExFSk=;
        b=c9N68i+t+Sc8+fJVpAhl1L2XbK8JtlCVl0bkv8RFyfGQo/OB3lwii/8MSUJfK/6/N9
         KlYvEuuZnnBQOt3LpI9UL63/eibl+SRPOBhHMqaqVNgMbt0d24YfTwZO/qv1HWbdCVU2
         Og9YLd19Wxz0ybzjCdT+qVRiNXsuagYyoeB3vnaYfCi2Iri+8GwtTQnHDDZXKDJFOFLN
         5qSaJX1qxr7Db2E+gFr94LgGSUx/oX9dvczduYZ7CVkmzIy6OKiO6/c28PncFSk4ml3G
         zce3FOsD3W3/CeCljmWNdZ2c7NdivMhFXm/W0vJXx+3opLtFabWxURdaibcKIcaV6mTP
         xFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09jczzBKoiZ5VT0vFNyyBObMkIOVjeQ1lFzwJFExFSk=;
        b=KLk6PryMffU3qSihPyXyt6HuLIOjHAezU5ZDr2GQ1TdDm6FmolTM2PQPQzhJvaNZZ7
         XTJVTSNAPp9RlLgQVcaFHeK9/JvOB+MUoNiTLPcLyDNOXCUuTWE8dcuzti5Ry1xB+cbT
         /7u4ub80XZc92W3hLcabHrU/onGvrJBfh1kMvUBhz0eEBmFqY/2574J6AsPAJRdeVnqb
         Ib0gJEFiBkDju6nEdSPFLi6Y4KGsIrWv5vzkLpRUB/gb7RpgKGYHiMh8+3FpLdACAmRm
         IYmQ0aH2eEuX+SUaj+ataKAsH44jKXYZygEhqJOt6GhOQTttqHrNHsXir7wC6fGnvMuS
         EPqQ==
X-Gm-Message-State: ACrzQf1zM+wDaMlMUp/V1YzNp5QRCjCsQt+jRrZTExkL0xa0a2KKpiYk
        LS/WssXkCcoK9TM738Ajt7ZWVCnzDKVNWw==
X-Google-Smtp-Source: AMsMyM77z9WBgHVQq6XDB5TbRKIFJJUdD3EkCFQggf2UqIrZFzBlfJ4fY7OnCyXsxJszM5D2davMqw==
X-Received: by 2002:a05:600c:4e8a:b0:3c6:da7c:8d71 with SMTP id f10-20020a05600c4e8a00b003c6da7c8d71mr16993100wmq.16.1666028970702;
        Mon, 17 Oct 2022 10:49:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c4b9a00b003a5537bb2besm10676023wmp.25.2022.10.17.10.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 10:49:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/10] run-command API docs: clarify & fleshen out run_command_v_opt*() docs
Date:   Mon, 17 Oct 2022 19:49:16 +0200
Message-Id: <patch-v2-05.10-4fca38bb4d6-20221017T170316Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1093.gcda8671d6c6
In-Reply-To: <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
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
2.38.0.1091.gf9d18265e59

