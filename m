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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AB2C432BE
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDE26103C
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 19:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240176AbhHCTj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 15:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240204AbhHCTjk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 15:39:40 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53672C0617A3
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 12:39:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n12-20020a05600c3b8cb029025a67bbd40aso2477493wms.0
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 12:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wmNu7doJyXF6QA5Q08QNCB4BkAkAVAWjoaO4hJ5rNdE=;
        b=ZAlRPEMqxKTZGiT+JAq8gUlaTV6CpphZoJszRWAjPuC2MQQg/b9OI8+H3ufDXPAoLS
         sRdYkxt9+XIcxy4cWitRPJ30MpDAkvDzKEeNkAVgu59VvM6INAvIBKdjusN40ZFMEQ1B
         mhgjLZLz3xetjw/sVSX22DmAGm0lmJhio8Adp8Wed1tNbtIVU1R8GDurcdOoyBt9Gddh
         rrraQp6sScav3j1aJQp+RikwdveV8+RgJUFeufUvJrS03XSpCY0DfMT3d8bW7R31OOWG
         6nn6jkXdjyx61xTpwqAZyxd8tCzYpiW8GOaTnFA1dp8ykTe0fiO+lI/Huc+DKfIzY7EJ
         ns2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wmNu7doJyXF6QA5Q08QNCB4BkAkAVAWjoaO4hJ5rNdE=;
        b=jM3Hz0vwzubL71G8ZTrcHuZdv6cTwKhk43M23y0S6Xj0ajkUFg4tu9UUVVLoie4YWh
         t5k314p4ahdOWV099WUg1QD4JK6h29uHIXg15sCdhT9qFqwRBNs2STPHZQjofG9rI9NV
         sXlyw47LIm37e+sSvnpAJ2kj8TIXIjkszG/MSxuGwY6w5jkScyoR6X2OMBoI8Ao0B3us
         4i+O+V/M5nNPW1mQABpw6KAeg0GhP2T4SagYNpZGfOo4FiUx5fdA0cQKI9CqFTecXxNI
         ovzJD/MAtYyb6f4CjVoAzBgNLW1VNtG/dlMeXNKl65yR2kc091nAbsModBCpwdBP2IuU
         P0Aw==
X-Gm-Message-State: AOAM532mlKGMbXgAzghRZsiAMK/yQSJuhN+qHdyvhC2DKnDKi/xLkfY3
        8PYggcseopOzF2r9k71OlOaONLR3QQ8I5g==
X-Google-Smtp-Source: ABdhPJyD/C0jLdmMZvcqBGJtvB4YQNU5Em1GfzpgBrZYar06/pDhp2/mcQlrp9veHFoCwjhnQlHVKw==
X-Received: by 2002:a1c:1d81:: with SMTP id d123mr23535728wmd.72.1628019566578;
        Tue, 03 Aug 2021 12:39:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8sm15333562wrx.46.2021.08.03.12.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:39:26 -0700 (PDT)
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
Subject: [PATCH v4 16/36] git-p4: use 'git hook' to run hooks
Date:   Tue,  3 Aug 2021 21:38:42 +0200
Message-Id: <patch-v4-16.36-14a37a43db2-20210803T191505Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.593.g54be4d223c3
In-Reply-To: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
References: <cover-00.27-0000000000-20210617T101216Z-avarab@gmail.com> <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
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
2.33.0.rc0.595.ge31e012651d

