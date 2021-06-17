Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520BEC48BE5
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E0F861245
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhFQKZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhFQKZa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:25:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB23C0617AE
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b11so3269787edy.4
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DL6XCi/03qNcT3N6dN9SuwpfB6ZZ2iEg6jAUskaW268=;
        b=abJX1WGMpJHqPtxgt2y7GimiqjqeIcCW2TVelfQcfMr6EIFeiZnxkoWkEEnpE0/8xd
         MpU8paTVZbhJas8G6To/0hG2mCxNYfDMOvRQQvyNdSW4ERV/zJ45/WZC/L6u0f7hSiWa
         r1qbynCWcygRzIxaXPI+ZxIVIfhCwxbTg3y9UYaQc9wBnD9hcfTe80SVstEK//RJiu8k
         IY4fRNwt0jWHxtxEN/6lRdH4VevJyYt5wqvOq0jN3vAIIwVXAlK81//SnPEa6ebDcp8Z
         wmE0NvLyXWrLdmanAqtiD32Ha1oLmRhN1JWOLOav9FDaDZOMVxbg/KBxmSUuB7V+nDfG
         NGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DL6XCi/03qNcT3N6dN9SuwpfB6ZZ2iEg6jAUskaW268=;
        b=dPKmq55UwecNTfxIPuJbKMb9Efe5lv19DejJ0VguZUDYqQIKAVxZyUVKys+3Zm5IFl
         +f6rt0W7hb0caNnj4di/cKjVVZJYU3NlHtAVlo4mXYrfnDfjel8EkOyPm3QudLWHfLcE
         NxL4z5hUfn70Cpz9N6PVYMqKOfH1S0eyJAMGXvxqPFY3ZMXoagO6lxGomlUs1RKUI9Ih
         JXCEVwh2HaS5q7od+XWcE7KtUzMBQCIHx0OqWKP8Z2CkbgkiibAcy+DqzA/TP2fKInyu
         wj0V1dxnb0gmRgbJS45pBokyNKMw1Psk2G/UGhau0lD0NWUjYepkvZ9IhOnzvf4P4zWg
         BK6w==
X-Gm-Message-State: AOAM533LytHffaENy6Yvx1C9cbh0exk++q0WEFTlAm6xF+1QwVpZnfnt
        2lNtjLjAgwjFz34cVfd6GpuTmq2/KPBc8w==
X-Google-Smtp-Source: ABdhPJz1Ov28LCUqao69C7X3yhLGQTyXmGWLx2ef6AwlFbnDCDVwaMnjd0h5spDwhnNRMGimMNk0ow==
X-Received: by 2002:a05:6402:759:: with SMTP id p25mr5579048edy.146.1623925396339;
        Thu, 17 Jun 2021 03:23:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jo13sm3447293ejb.91.2021.06.17.03.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:23:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/27] git-p4: use 'git hook' to run hooks
Date:   Thu, 17 Jun 2021 12:22:43 +0200
Message-Id: <patch-09.27-246a82b55b-20210617T101217Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.576.g59759b6ca7d
In-Reply-To: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
References: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com> <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Instead of duplicating the behavior of run-command.h:run_hook_le() in
Python, we can directly call 'git hook run'. We emulate the existence
check with the --ignore-missing flag.

As this is the last hook execution in git.git to not go through "git
hook run" or the hook.[ch] library we can now be absolutely sure that
our assertion in hook.c that only hooks known by the generated (from
githooks(5)) hook-list.h are permitted.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-p4.py | 72 ++++++-------------------------------------------------
 1 file changed, 7 insertions(+), 65 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index d34a1946b7..e76d8df313 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -207,71 +207,13 @@ def decode_path(path):
         return path
 
 def run_git_hook(cmd, param=[]):
-    """Execute a hook if the hook exists."""
-    if verbose:
-        sys.stderr.write("Looking for hook: %s\n" % cmd)
-        sys.stderr.flush()
-
-    hooks_path = gitConfig("core.hooksPath")
-    if len(hooks_path) <= 0:
-        hooks_path = os.path.join(os.environ["GIT_DIR"], "hooks")
-
-    if not isinstance(param, list):
-        param=[param]
-
-    # resolve hook file name, OS depdenent
-    hook_file = os.path.join(hooks_path, cmd)
-    if platform.system() == 'Windows':
-        if not os.path.isfile(hook_file):
-            # look for the file with an extension
-            files = glob.glob(hook_file + ".*")
-            if not files:
-                return True
-            files.sort()
-            hook_file = files.pop()
-            while hook_file.upper().endswith(".SAMPLE"):
-                # The file is a sample hook. We don't want it
-                if len(files) > 0:
-                    hook_file = files.pop()
-                else:
-                    return True
-
-    if not os.path.isfile(hook_file) or not os.access(hook_file, os.X_OK):
-        return True
-
-    return run_hook_command(hook_file, param) == 0
-
-def run_hook_command(cmd, param):
-    """Executes a git hook command
-       cmd = the command line file to be executed. This can be
-       a file that is run by OS association.
-
-       param = a list of parameters to pass to the cmd command
-
-       On windows, the extension is checked to see if it should
-       be run with the Git for Windows Bash shell.  If there
-       is no file extension, the file is deemed a bash shell
-       and will be handed off to sh.exe. Otherwise, Windows
-       will be called with the shell to handle the file assocation.
-
-       For non Windows operating systems, the file is called
-       as an executable.
-    """
-    cli = [cmd] + param
-    use_shell = False
-    if platform.system() == 'Windows':
-        (root,ext) = os.path.splitext(cmd)
-        if ext == "":
-            exe_path = os.environ.get("EXEPATH")
-            if exe_path is None:
-                exe_path = ""
-            else:
-                exe_path = os.path.join(exe_path, "bin")
-            cli = [os.path.join(exe_path, "SH.EXE")] + cli
-        else:
-            use_shell = True
-    return subprocess.call(cli, shell=use_shell)
-
+    """args are specified with -a <arg> -a <arg> -a <arg>"""
+    args = ['git', 'hook', 'run', '--ignore-missing', cmd]
+    if param:
+        args.append("--")
+        for p in param:
+            args.append(p)
+    return subprocess.call(args) == 0
 
 def write_pipe(c, stdin):
     if verbose:
-- 
2.32.0.576.g59759b6ca7d

