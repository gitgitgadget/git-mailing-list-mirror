Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC47C4332F
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242193AbhLVEAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238970AbhLVD77 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 22:59:59 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB08C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:58 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso494827wmc.3
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 19:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QYzwCnq2igDg55TYenVdAFCneRzYTszgqPq9NLVZsAw=;
        b=I4zoYGRPFS1BaTJBJLz8zvQwaLurte5egN/iCF9IOqgA8G0Ag8PZe50740GJ4Q6PKN
         UqjZJP+6yEzK7f426bLns6dX93wJiyN1yVoqWI2IG8vJ0MhNZHm2EI9fS9c08tHndH7R
         DyvYZd4v3SuvkJ/s9ae3Rq36pXJ7hnC14/BhoEZNtzDDcJfjL9D9KBi8xw60B0FN9GI1
         2ahqjKlR2+198+u8vOE/iZOtjXPOw3z1vEf82YkJgDojH4AGllBs4YRPqn/CYGCwzz+/
         jr2nu/dG7G9RMJSEOXdDnI3P7aHdwhtvCePdVEQuzlv/jnlxBR0dyKBbFOZVva7tKjFB
         YrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QYzwCnq2igDg55TYenVdAFCneRzYTszgqPq9NLVZsAw=;
        b=chF6bXmoF3AxcNgLAg7uwMAtEgrCUCa336ZTmciI0TM1ghdzLDZPuGzyCi9Tk2H5ei
         ux09IEAnD0Vjkm0WUj7sh0zTbRcSKVs52tBgetFmg1cgdx5EqlXKccznw52Qtc6BNgdN
         +JGrWA+CKzAwUowE+12bUCsGX5RZqE7yXp01frwM/Pes+6D1DXBYFhNEDzgoXssgLD+W
         7nCyLBH0WTygE2dvQ/7NUrbatBHOuPCdaOTUGHxaxpPUqh7C/5nRpT3FY3go61IbV/4X
         rYKTkaqsc+8EIyMkL5IjQ7Oy3qMCo0SnL74g3jgZghQcEhahoYlzhl9jSZXropdTe3Qj
         1V2w==
X-Gm-Message-State: AOAM531iRF4ew+5LOFU7fmCCtGqeHqNSlUm18soCzKuIkWUWsrJBVVNL
        pFqb+aZFsYxcTZAaA9smF2RfDW+c2MJhQw==
X-Google-Smtp-Source: ABdhPJxFGIrLeLbospIe1tlEgll/QdlOHML/H4Ybt7iaLUkp/oxuhdJ75Awu2Sa5NKIqr7a3TbYUUw==
X-Received: by 2002:a1c:20c2:: with SMTP id g185mr914028wmg.115.1640145597100;
        Tue, 21 Dec 2021 19:59:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s8sm867300wra.9.2021.12.21.19.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:59:56 -0800 (PST)
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
Subject: [PATCH v6 13/17] git-p4: use 'git hook' to run hooks
Date:   Wed, 22 Dec 2021 04:59:39 +0100
Message-Id: <patch-v6-13.17-a184afd1ffd-20211222T035755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20211222T035755Z-avarab@gmail.com>
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
2.34.1.1146.gb52885e7c44

