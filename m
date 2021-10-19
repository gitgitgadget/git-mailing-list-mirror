Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FCAC433EF
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1ABA6115A
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 23:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhJSXYC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhJSXXy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 19:23:54 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722E5C061770
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:41 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a140-20020a1c7f92000000b0030d8315b593so6261751wmd.5
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 16:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LqX0dfhkbf4sC3tBtbgojackqNo/u8PwJmf5Rs/f08w=;
        b=aYKy2LumxWPmfmeP7mUwffa8kbGT+WF6qYKfSNB74JUmZr7GFLG+uv7awAphwHr9nf
         mNJNgV2uld6SJPbrQ3yRm6sjT96+gfiM2iZOYZWMJ0peFGuINRsIEUg8Ca0I/JZrVoQM
         vbJRdqqG4YM4vSw98Uw9wp7YAgKdCIfogN4QJ4UiKrtZh+WdB446jsH1w4bsv012HLPz
         EbJbAnJs994mnZ2U7wC7p8ZLin3Jz20uneuKBSbi0ykfrqYfhhMGeDkNJmMLH6h6Pvz9
         QJbP08VXTHstHnrAQ6fkeYoNFewtiHRFQLKFiMtkhkOaWASLn+++v9jKZtRasGstbghc
         jWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LqX0dfhkbf4sC3tBtbgojackqNo/u8PwJmf5Rs/f08w=;
        b=vAmi/ze05pNOsuExsw2zJuuDXQHYYGqxePJ/rDahPGj4DxhHFjyxUEEX+Fynl4qnRI
         Qkirv35jvKvGmCcago9PZRB4R43hU3EqCbl0281xspBsd+50U3EIP7MvQvJYToHYuEgn
         w7kz/G2H6A1lY437XNwMTkRmBwWu4aWdiZqdFm6IxTgV5wE9x6bEbU/YBKrsjzLqbh4Z
         xk7MCnHmH1z1pGOELV+5l0XmJVFztHCAM2sKACiIJYdWof+PkLI56bXDqrDjslwgpUeB
         O0iY/wWs+KXNH5vcsYWYvuxQpMLpLaZ+xHikPYpwWLPVvaUqtwWlKlSEJ2uFAuc4Uk9W
         +2KA==
X-Gm-Message-State: AOAM5320jujlqlXKWcj2W+F0xYJI/jPwepmBKkwMlhGeJZbng6pnpj6B
        LYdEY49sKfOA1zoi0PEwIL1amAyiwcSSww==
X-Google-Smtp-Source: ABdhPJwRuPda7eVLlAu5rEg+iI86AQ2DwhKRCWGLdwl+kEF2lo7vHdTQh+qK2sWUjvTImqlSKczNkg==
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr9580533wma.75.1634685699686;
        Tue, 19 Oct 2021 16:21:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g25sm304644wrc.88.2021.10.19.16.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:21:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 09/13] git-p4: use 'git hook' to run hooks
Date:   Wed, 20 Oct 2021 01:20:47 +0200
Message-Id: <patch-v3-09.13-95782109270-20211019T231647Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com> <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com>
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

We're dropping the "verbose" handling added in 9f59ca4d6af (git-p4:
create new function run_git_hook, 2020-02-11), those who want
diagnostic output about how hooks are run are now able to get that via
e.g. the trace2 facility and GIT_TRACE=1.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-p4.py | 70 +++++--------------------------------------------------
 1 file changed, 6 insertions(+), 64 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2b4500226aa..3b54168eb4a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -208,70 +208,12 @@ def decode_path(path):
 
 def run_git_hook(cmd, param=[]):
     """Execute a hook if the hook exists."""
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
+    args = ['git', 'hook', 'run', '--ignore-missing', cmd]
+    if param:
+        args.append("--")
+        for p in param:
+            args.append(p)
+    return subprocess.call(args) == 0
 
 def write_pipe(c, stdin):
     if verbose:
-- 
2.33.1.1338.g20da966911a

