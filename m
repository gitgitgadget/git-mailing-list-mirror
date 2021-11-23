Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FC6C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbhKWLtx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236444AbhKWLtm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:49:42 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C47C061756
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:33 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p18so18442064wmq.5
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yVBi56GeAHhOM1VrDA1m5eG4tJCdLbej0iVCFsjgchM=;
        b=DyxYW8LNz04159VZaGlELH1ngdRpXN6xI16CmjmPA5FyatrQJjvGE7Xj+3GVNZL2gc
         KXZSVLEoom3w0l5//W0iZH0zampp22G4jf39MQ9GwzOku8oEQ+0gDaLvq2biAYgSwFhv
         pZkj/4lB3QsxRtKeQXA/FOC9scXnnEzC6YCdjLH9CI7Ql+FBGDJME2RxUXxc1CZkCsca
         9inht5GExex2/HGDXBbjjamAfNuxNG5j+Jiodrw4W/BK6M3Jj4FBPGA7EkoJ28TBo2v2
         azNkFt9ab+FD1k386Xhx6LoHa1YZCVgL+++vx2LYTHl3GhzFtTM4P5lchL425o3duKfm
         T4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yVBi56GeAHhOM1VrDA1m5eG4tJCdLbej0iVCFsjgchM=;
        b=a/O03gzqTgQni8adKJha3nFBPy1ajplJQC1fc4gFyVXLmTI2iJBnb7OILHo+FDRA03
         mBXLeqhcuSKVG5JPRSRvgBhcwqV73rhKV1zW35qbfabp5qZImchbtONqIg6L3aiqVOmY
         zLzuJXY3f89kuyrkVARvOdIO5hrClRcMeeDiO09FEL6PMiKkZp8BUJvTOyAF/3V2KD5t
         gzwEyWpp0NJj3gA6p7o7URxi6SHmhDZhjcBsmMIdp5OND0z8MGdQTxx/e1/FmXCcNLbk
         MSyH4+Abk2+oXsTCfQ2sWE9GFJkiGSx32eWF84xgr7wzq0GQMLT3/kk0OH4w84A8oObp
         oEXg==
X-Gm-Message-State: AOAM533SdvKyW4VkZdFZmDeyUyBx18Aju4nxbZSuvOasLTAdVYEiAsUz
        N973lqgos8gWb11RRkGffOIlo+cPNqH0YA==
X-Google-Smtp-Source: ABdhPJxinTlUb4XkkR1yT7HAC8OeMaWn7xHar1jN8Mq46ExF6YF3ZIWs0cydmLpjP1sG48rxnQOwWg==
X-Received: by 2002:a1c:9842:: with SMTP id a63mr2285755wme.102.1637667992270;
        Tue, 23 Nov 2021 03:46:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm1723145wmq.27.2021.11.23.03.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:46:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 13/17] git-p4: use 'git hook' to run hooks
Date:   Tue, 23 Nov 2021 12:46:12 +0100
Message-Id: <patch-v5-13.17-e858f332a62-20211123T114206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
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
2.34.0.831.gd33babec0d1

