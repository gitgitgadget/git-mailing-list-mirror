Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34967C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E9BD6108E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 13:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345177AbhIBNNW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 09:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345126AbhIBNND (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 09:13:03 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320C7C061796
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 06:12:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z4so2847229wrr.6
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 06:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sAUDjTwIMDtKGi+zJ2dRl4kFDwzwtB7YeDDf17yCEdI=;
        b=XZxy/7/8QcQf5W9SG4xnRz5mmzw6K/m1mxL+MCljfp5mI0J+AoTBRkGjK7VrHhGTNc
         VKJS8GZXBlUHFeBB9C9tYRJExE3MSgM4ZuJenvQkw0OBJfv3rEqyRyWs8F7m4/oSj8L3
         VB5dvVsNKESEI9cVVESjTKtL7x0LpXaR0zAtixybXSe14Sxu84WlNJcF1xEsH9TodQk8
         KpIsfocK1+JYUlflQnAZlNuY3dn1KbB6wfyj672m8dDS1c/gJNPTzBl3DzrPeI1HJIsI
         WAkZXkvbGxkz63hKV5ejdtYIjWVRbiGJpjTPkqxUxY2F23WcBMvGFBOm+hR7Alp8emaD
         nZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sAUDjTwIMDtKGi+zJ2dRl4kFDwzwtB7YeDDf17yCEdI=;
        b=IyB4NfNkgs75GnjLPNW2l8HFwlvLxRixtwAHM1aEKjCXrYCU78N5wFHDEyGl8HTVIL
         yq7zYflOFDt7Z4mITGTp4ElzxE2ZaOOrFa7RYDz743e2ZlBF74hOF5xlh1buwHd1rbH8
         bVEGvCc8vwIgLUOjH6BBv1jS3IZn52f/xU0Y9q9ocTtm/IGc8bgMREc7nPtS+H8Debkl
         Q6EVd2Ps8qGledcM0fPtSKQtXCCuaiSavE0QdK3TbKdWaw6fh79s2hCZXs+NStSMLBdg
         ULoWvW/XTGLrnXriRSC6GxEOVN++74gbKp9pAVCmTgoq2uTANW9P19S6o0QbN0/vojBu
         F5wQ==
X-Gm-Message-State: AOAM533JKidRyRqXUS3hTPN7qWK5mzg7BFluyx3ZBn2QMVPxWHa5HjmG
        bg6OjUSTZljp+aC6d01vFGg1MTOkt+Edsw==
X-Google-Smtp-Source: ABdhPJzs8vgJPpUImKtXIIl1y48JoEXwZeMtsjDWfrsI0/PvBWFLhkEAx7Dm3lDi4EuSKpbLh5ntng==
X-Received: by 2002:adf:fd8c:: with SMTP id d12mr3641720wrr.21.1630588319532;
        Thu, 02 Sep 2021 06:11:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm1479635wmq.36.2021.09.02.06.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 06:11:58 -0700 (PDT)
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
Subject: [PATCH v5 16/36] git-p4: use 'git hook' to run hooks
Date:   Thu,  2 Sep 2021 15:11:16 +0200
Message-Id: <patch-v5-16.36-99f3dcd1945-20210902T125110Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.816.g1ba32acadee
In-Reply-To: <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com> <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
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
index 2b4500226aa..1f24cbf0bca 100755
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
2.33.0.816.g1ba32acadee

