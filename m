Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FACC433FE
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C26E6101D
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbhJLNdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236890AbhJLNdK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:33:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A47C061753
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:08 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y12so68337190eda.4
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WhloPMShTRx9Cpe0BYA8PAVBrJ36V9soI0h3m8gb3wU=;
        b=QwfTamP9SN3RsFdskrfQHzsGP2M6FPljDffSZYVyETWF+ot0ZuEQimKFHPbdJlx9cw
         TMr6VLvH7DWgRVKHe8iC6DXirMTYmvAz31PrgfaoLAG4BgmiYOQJr1DQCWmKM3zw6lcj
         003nCnGwxsoifI47BVDk/vUGM0ENvkyj1ZdDIQTncmzYqcamT0E4g9123QATubRdBgzK
         itka3As+wxqWjA2ml5eh3j/he5UPWw9um7OnUcWNUehRl13wHymXgVnmEVah3QJG1Mie
         mteyS6ZLds+nYqRfMVXBDAK357lkZmo+ITShU2gR2JYehXZRJ6pDvaYa74Kv0q3hTX+Q
         gFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WhloPMShTRx9Cpe0BYA8PAVBrJ36V9soI0h3m8gb3wU=;
        b=cRXuMoLY1htx7Lkvhug6P24olZdsSwUKcMRXXzpSz1qNwRVTHW7OGc/HbWhYD1uPC2
         bsB2/QMHxeIDNws7MY3a8sDRXFCW5hwi80mZz186sQyr0ve7zHctqUVkzV3H7st+SRvD
         IRed50zIJiYBWGkLjBCDl0Wj15Gtmo42Fa/oTIg+amXQkPaqb/F8y85IBomjjSqAKAOU
         EWO8Ac1s2WosqepVoQDdzW0pl1xmYNxUKSdEEp8qVRZPz/Tvnmp1phabbIOsgj9rd6Yg
         MhviaijEICHWm9LM0R6NJLcyyEsow4kQOcYvNL3YH8gh2/V9US+dEJit6hMB/dZi7fSt
         rzPg==
X-Gm-Message-State: AOAM532Sxm6ckFOj5QAjd+pGL+i1fF4oeRi+HxqIHufw0B+jv1dJOI05
        mjTyzCg/CfjyKto1SFQseeHEafAb/uJLGA==
X-Google-Smtp-Source: ABdhPJzHLOxmZdySF/cXrmrFReEZXwdDSrLsh3tq5PbJo3P1DhHR8m1QmLlply0bGSl1AMD/adMAhw==
X-Received: by 2002:a17:906:7716:: with SMTP id q22mr34367090ejm.457.1634045466518;
        Tue, 12 Oct 2021 06:31:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bi23sm2016405ejb.122.2021.10.12.06.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:31:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/13] git-p4: use 'git hook' to run hooks
Date:   Tue, 12 Oct 2021 15:30:34 +0200
Message-Id: <patch-09.13-69cc447a1e1-20211012T131934Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1567.g7b23ce7ed9e
In-Reply-To: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
References: <cover-00.13-00000000000-20211012T131934Z-avarab@gmail.com>
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
2.33.0.1567.g7b23ce7ed9e

