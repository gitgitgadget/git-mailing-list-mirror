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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E73FC4708E
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 646D2611BD
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbhE1MNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbhE1MNa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:30 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF7BC06138B
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:53 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n5-20020a1c72050000b0290192e1f9a7e1so2273732wmc.2
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7r9ULGv9apYUhZVJDTU9OoHivQOcGw4trxulZmX+NM=;
        b=r0ThF77Wp+e/BxBJwZKaGpiHnVnzvMKYAOjaUIafVZSSCYu7y4NVJBUuyhG5EH/Wvl
         DRfTwHAJqrJcA8unSwFM1qFpdw/hfA/0y743kuKJj7WumE3c60GRm3fQ0//KO4/5fHK1
         p3Q1u9tidbgaRntdvF6S1nYzOyhYBwAsutQwvi/4K1QTZ4VXVWS7fq4sQni/GtfJTkUX
         42qp+TACGkOPwJm0cxYm9mPHGuSI+iNnF/XR/qW2bM6Scqmjja1C//sJj86Iq1BgXyL9
         U2qFc5OP79bXhzq4QS5KVZ20b3oyYWTpHxwYcfqj6vPS6OXOq7bVuhr9pOC9Gq3ZiwPh
         z4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7r9ULGv9apYUhZVJDTU9OoHivQOcGw4trxulZmX+NM=;
        b=QB8YoJFtxXjIBK9gmiGyQIaO4Vlaatkl+XaQfo334EjR+osdAciDWH+UKMQOmv6/Ov
         VQBPU1wsdW+QQiOn10ui4iCCN0LweVKynzkd2z0TdiODPrBixPL8vdctzhyE6Evs2Jw/
         8LOUKpZWJj1e+PF56YzApoY+HzbsMxtsAHU0W576XtRljbxMLRRf2BZuWSBWu9nPh3be
         gI7Lj5UVtVo/bVqKZ5ivsjuYAnax7raPe3smfVYB/2cIue6taxjBqfUcpT+Zsx0lAgfI
         KQWFotOJXZTe+PsfidkJ6VqSOwHskXn4CFbhuhi4dEXqO2BkjwWqwggDM8Uu1nqUBXHg
         zy1g==
X-Gm-Message-State: AOAM531XN+HGnsyNTXmVbKza+iLQzGmWSy6J1kgRDGQCXREQQRrrxQ5V
        AeCyl8RaVkombWqrElUI7EeWqtN4aqg4sQ==
X-Google-Smtp-Source: ABdhPJxAGWxH+mgigrkJLf8cwsz0+cYP7106fy7Uounwb6WpdPZ2cOix4Ip0JEHY1VOugsuFApuoBw==
X-Received: by 2002:a1c:a50e:: with SMTP id o14mr12196711wme.78.1622203912269;
        Fri, 28 May 2021 05:11:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:51 -0700 (PDT)
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
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/31] git-p4: use 'git hook' to run hooks
Date:   Fri, 28 May 2021 14:11:15 +0200
Message-Id: <patch-13.31-03129460fd2-20210528T110515Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.460.g26a014da44c
In-Reply-To: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com> <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
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
2.32.0.rc1.458.gd885d4f985c

