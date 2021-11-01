Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDE4C433FE
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4424760EE9
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 18:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbhKATCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbhKATAl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:00:41 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46484C06122C
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 11:56:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id a20-20020a1c7f14000000b003231d13ee3cso126675wmd.3
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OrcMSbNZOdGM8XjKFkufhxbElu+IgzWMf07xkaqMzsQ=;
        b=A/tYSacEJxnaK22Zh33kgso8rMX5KP5poT/8xZ4Sik0c6OJyw7+QlAensU6X7h1yza
         5ObHzw5LWo2O2fwUbu+rTp/9YiW+d5h3Qok4nn2F8fwWdIU3zx6oRH0m1EGpGmVoNc1V
         7qDcZXzEgyuZVV1Kdl6Xxq+tRzJ2wYXhu7NY9qt1qsmh+WKxdKgaECo7HvaMv52e33fZ
         e4CSCahpBM+eJbofya5Em9zGrayTixvK/SypPG8cuFI/mJ49pwQGVTDvkFz9nsk38zwh
         IXSoOKdYgYdyKStlUdxgnPDcBPfFX4uJgsCzvYURJfCvDUqdrYWLEJ4jVclAzaaQ0rFT
         4pXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OrcMSbNZOdGM8XjKFkufhxbElu+IgzWMf07xkaqMzsQ=;
        b=twF/nkI3u/c5cAyVdVAl6AOCjC+YIEcoFgYTy74hPHwfUZYH1liefXRpWFuqu+iCqX
         VTKeErd8J/lK8NyknPhCOwV8OqeoSJhnzFCjxVKHPGYt6LRkPhZn6z3PenwwwYVe6WZP
         Bsl8ls3IMnYs95bnF5lXE/IJsfgKPJGwuXUgWhIi0vODVHFs7qIUDXBat5IkMD7Ztg8x
         o3bPM/+hOHFYJq9GqY/wtk7mGhmebeWq/OWE217R+6wY3duKFAd1PLq8WEGbkEG0BxSh
         Fkx9O+8QpDXxKK+GedSY3K2S5gthObAFGS96jWUnxvw2BsRysF+QKGCsN6RcKxBb6vgq
         3Jww==
X-Gm-Message-State: AOAM530DJ/Os3YuZP21NCpM1vvHK1YvReNDeXYRr8M4iN2Zjyxv9g90T
        /FGfthRIIQ+wcMfu6acKvfP2T9KZKRNvivj2
X-Google-Smtp-Source: ABdhPJw5NZGa7QFfpUpb9MXCvOpp4i6KjZ0RxiXD+JYbjDBllfafPnQrJWEzNTu/LR5y23k70B7cbQ==
X-Received: by 2002:a05:600c:511c:: with SMTP id o28mr892993wms.96.1635792995300;
        Mon, 01 Nov 2021 11:56:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14sm314185wmq.4.2021.11.01.11.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 11:56:34 -0700 (PDT)
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
Subject: [PATCH v4 13/17] git-p4: use 'git hook' to run hooks
Date:   Mon,  1 Nov 2021 19:56:18 +0100
Message-Id: <patch-v4-13.17-98e0e3330fb-20211101T184938Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
References: <cover-v3-00.13-00000000000-20211019T231647Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com>
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
2.33.1.1570.g069344fdd45

