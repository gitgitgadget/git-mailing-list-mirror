Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7886C33CB7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7362082E
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 21:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNTyRTgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgAaV6V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:58:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38978 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgAaV6U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 16:58:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so10386683wrt.6
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 13:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KmGtXPMlV8ymsmHIwAhdCuBuRoA9p/FklThI8KHVs9A=;
        b=RNTyRTgg/HUxYtjpbK7w0AwmOfTB/LpOgRmqqJnYN0V0DBIXdfbqY68o3ZSUqMRVLk
         w0mNiwoRi1HnGAMP76GF/mVZHj+q8FLpLqgXxt4tS1y8YY+AOcZA2i51iJm0KQaepNAN
         +JveUDAyUbM5gbiEf4ezEN5c9txe6iiA/sOuwqlXDDoYsR+HLCHBHeEYUS5+pmRSoBw6
         RtjRkJ2Iqogg1R+hn7yOfREEwortjOuV0SgGb4Y2wPByz0VIPu4SSZ2PouniOeQU+xZZ
         99PW/sxH1hbfy4icKwgzNp7aDaEg2K1WDzcaEmI14CNUR8IK8K61AxjDeugb6Fm3prRA
         kKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KmGtXPMlV8ymsmHIwAhdCuBuRoA9p/FklThI8KHVs9A=;
        b=JuYRkX8QVWSkLa770rNOHDgk06DFI36ADKlqfSbGrX4sgpN1jbGpZHX7fCrPe/m2HN
         UZmh+5gup+Itmi3aJUiomCEwCH/YOWIY7vblEISqdRhVx/P1JQH1X6W8FpYNR11kma1V
         AZoBZ21Xfv9NJQroCrVOYmFDmGOtvewkB/tMZz5sMImlp9CkAzgGLI4nAKp/pai5JH0g
         cU1WORUNFgZjMCHCsymJ3wGeGDYRAIuISKJAYtPvHazn6WRbEOy1PchIx4cBKuWvnVSi
         rU+ae90cp+3v43M23zTvr51fAb/iQe2vUDuOdWkInWNwIWwcTPHYO66+pBLQjlaAVA8J
         wnxQ==
X-Gm-Message-State: APjAAAVEnGpwYSVNv7kbY1RwOOOgpeL3H1dPtms4pvi5yCRmMvA96ynz
        UmFnfbXan/GT8EIQ1Ww5ax6/O1rK
X-Google-Smtp-Source: APXvYqwl9T2o9BfysldcPRXA2lqqNGkQpXJVMQwgZu6UtHh9TD5pVKa5RZRl0WCUmYb6yrDnOdp9XA==
X-Received: by 2002:adf:f64b:: with SMTP id x11mr405473wrp.355.1580507898061;
        Fri, 31 Jan 2020 13:58:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x21sm11930849wmi.30.2020.01.31.13.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 13:58:17 -0800 (PST)
Message-Id: <f1f9fdc542353196612f8dd6b996d4fbd1f76c73.1580507895.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
References: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
        <pull.698.v2.git.git.1580507895.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 21:58:13 +0000
Subject: [PATCH v2 2/4] git-p4: create new method gitRunHook
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

This commit is in preparation of introducing new p4 submit hooks.

The current code in the python script git-p4.py makes the assumption
that the git hooks can be executed by subprocess.call() method. However,
when git is run on Windows, this may not work as expected.

The subprocess.call() does not execute SH.EXE implictly under Windows,
so the scripts may fail. In other words, the hooks do not execute under
windows because the shell interpreter is not automatically loaded.

Add a new function, gitRunHook, that takes 2 parameters:
* the filename of an optionally registered git hook
* an optional list of parameters

The gitRunHook function will honor the existing behavior seen in the
current code for executing the p4-pre-submit hook:

* Hooks are looked for in core.hooksPath directory.
* If core.hooksPath is not set, then the current .git/hooks directory
  is checked.
* If the hook does not exist, the function returns True.
* If the hook file is not accessible, the function returns True.
* If the hook returns a zero exit code when executed, the function
  return True.
* If the hook returns a non-zero exit code, the function returns False.

Add new conditional behavior for Windows:
* Check for an evironment variable 'EXEPATH' which should be set by
  git when git-p4.py is envoked.
* If EXEPATH is None - treat it as an empty string.
* If EXEPATH is set, look for sh.exe in the bin/ directory located
  in EXEPATH.
* If EXEPATH is not set, attempt to resolve against "bin/sh.exe"
* Add a new test for Windows that checks to see of sh.exe can be
  located. If not, return True.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 7d8a5ee788..4e481b3b55 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4125,6 +4125,35 @@ def printUsage(commands):
     "unshelve" : P4Unshelve,
 }
 
+def gitRunHook(cmd, param=[]):
+    """Execute a hook if the hook exists."""
+    if verbose:
+        sys.stderr.write("Looking for hook: %s\n" % cmd)
+        sys.stderr.flush()
+
+    hooks_path = gitConfig("core.hooksPath")
+    if len(hooks_path) <= 0:
+        hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
+
+    hook_file = os.path.join(hooks_path, cmd)
+    if isinstance(param,basestring):
+        param=[param]
+
+    if platform.system() == 'Windows':
+        exepath = os.environ.get("EXEPATH")
+        if exepath is None:
+            exepath = ""
+        shexe = os.path.join(exepath, "bin", "sh.exe")
+        if os.path.isfile(shexe) \
+            and os.path.isfile(hook_file) \
+            and os.access(hook_file, os.X_OK) \
+            and subprocess.call([shexe, hook_file] + param) != 0:
+            return False
+
+    else:
+        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file] + param) != 0:
+            return False
+    return True
 
 def main():
     if len(sys.argv[1:]) == 0:
-- 
gitgitgadget

