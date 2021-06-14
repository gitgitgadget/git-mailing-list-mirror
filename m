Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3683BC4743C
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BCBF6144F
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhFNKi6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:38:58 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:53180 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbhFNKg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:36:57 -0400
Received: by mail-wm1-f48.google.com with SMTP id f17so11839890wmf.2
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CWoqdfr50plwmlkBtSy1F3aFaYVY5KaFBSGL1KzvXCQ=;
        b=p2yMFWynYA6tODZgp2UJQV5M1lIqhlCMb/Bk5SodqZ/1Dh2LnfBRHR4o2WHClXwxGj
         Pkv12JUDCai3TdxFrkCbYxIjEpZqatBOks3t6HrKng5TQnP4KTHRc8wr2a8nJvJChMgO
         m1bfo1TfN15OFjb/+Y9laq4p2ScYY5QrMsudwi7OEYr570qFD4ZesxjBfaKrpxIOKUZn
         MJY36LLDYe9Xj3Dh3uTC05EnFw5khB/7PnMaPA9rmiExMrvbeYdcPlIcWb4I23daz2/8
         byLzesbrjFwSPs7szFfV/7UBx88ZxgOoleIpYrVnUC5YNJcz/GNGOv+snfeZKBL31l26
         4Z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CWoqdfr50plwmlkBtSy1F3aFaYVY5KaFBSGL1KzvXCQ=;
        b=T2BvJKZP9ffWu5C1fgvZRk5Yt4XE2iksUqABGkgNE7bhBnrU+StP6PjT3SqMQcgWjB
         0arxOex6ONHhqhUiJbDE+UuStNyny1So8oKx0H44YGYsEvIcKXCLh6klIke/71eBW5ZH
         w3cHk7SEaXXNLZ6Th4og29MwZt4kqxLeRA0HWUnu6kpl9H7gJ7USfq9+YjzkYaMV7Mio
         yyzznHERFFqpJT0mM34ImdvWTw0m8ddF77rQra2YhxWjNN4pmpzffYSS1uYOqm5C8GAp
         TPd3nHKKH/ULQaXBsEKpLK6qSIWKoXh3AFzpota3b6s+Sk9KjnyapqqP2Fz6XvWC8df+
         QDmw==
X-Gm-Message-State: AOAM531l1hxqkqZMNHFikVkXoqQm0O/cgZSGUNnhmgoNsEeSMj9rZiJM
        BMPM0zQOt3SSaj5UhU6JPDwMlwo569qetw==
X-Google-Smtp-Source: ABdhPJy80kA6yOxtcEYlb5cGMSvdJm4cWnGHfwTNvnIeiU+WkJgYFACkkf7bsR+rsOLzmt9uFBYYhg==
X-Received: by 2002:a05:600c:5128:: with SMTP id o40mr31307616wms.43.1623666833945;
        Mon, 14 Jun 2021 03:33:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:33:53 -0700 (PDT)
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
Subject: [PATCH v2 11/30] git-p4: use 'git hook' to run hooks
Date:   Mon, 14 Jun 2021 12:33:00 +0200
Message-Id: <patch-11.30-aa970a81752-20210614T101920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com> <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
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

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 git-p4.py | 72 ++++++-------------------------------------------------
 1 file changed, 7 insertions(+), 65 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index d34a1946b75..e76d8df3139 100755
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
2.32.0.rc3.434.gd8aed1f08a7

