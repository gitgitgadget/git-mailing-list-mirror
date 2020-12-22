Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D057C43332
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC08F22B43
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 00:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgLVAGC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 19:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgLVAF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 19:05:59 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF45C0611CA
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:58 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a206so15781586ybg.0
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 16:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=L4RilQ5LCEZEBzhRS+wHs2R686j6A/MWoLRo01wQIRA=;
        b=r92Uh608WETvd0mauBeRCjYj/PU0Crxo4Z58Ni86xml1aoTGwCXfo892iMnollHkIl
         q+vG9vU5Fb8F5dSrkJaS3Zjkr0AayEIzFUZ3Dbg1RRUP03AgfrCNADMkRAJCNe2AthHv
         ssbLtRqhqsB+iCmwMG6GGZxrPurt1h6lY6fZNULeVRC6zUGXKSziqXbhK9eEAOs72A3n
         dJRM3kd480ZT7vnqvasoE9d6c9+QbMwDKXZZrd9UbfQaySAsAGINQI3MaqonCT2NQYsF
         HjyQu/J8XvZqNs9bSJR4JD1PtFaaMXvdL47V+eTVTUvOeZm1p1hb/G+dYKxhfJsCbWDl
         2+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L4RilQ5LCEZEBzhRS+wHs2R686j6A/MWoLRo01wQIRA=;
        b=QdSWUr3da8e+qLtJhh+zFVRJ5eRofqKKiKO6BiK05tv1JA/GGgQhUbHcLe8sf3Wg8a
         hLwiR+CJ24B5KKQQg/49yS/R6TCWzJxMPtX7DiQxCHOLyP1PfKyMX5ECaQ+MVwK+z+Pu
         gt35q5qKsBfBiqukSw/fC38aFjO/pD6ZxIeA3kkAX5szxZGQEXRguPNjBmpx5RP5C8ZU
         J40qHrNTbRVRbUHbPPqz+slaS0Y8tFMcGPEZEugDxV5UqF1vLJwJsMRaP6HJmy6U02v2
         HYiclMnA6AnfjHeJn+oMpdF1f57bJkSXvwAEsmMhU23cXX8ZFRsqzwwZVcpCb61IroI3
         yfHg==
X-Gm-Message-State: AOAM533roJb+xyCFB6xI/fFWfcstnkmE8uaGyhygGhpe23lfWlBlJQlK
        h571NtL8xH8WFyTE07by/DBV9SarvoKP4Sb1Xcu43UFLjZ08q7zqNuxQRrDlwZg8CCTv9blxElQ
        vLUP3OlFrgGwY5KLh6f9XhlqsCp0LgpWifOtc3sDHfCjWpzHPc9NpB1amtB6G0G3l72nd+g21MA
        ==
X-Google-Smtp-Source: ABdhPJxLqB5QN7rfFnpecdDx+S5H9CZF0qfrNkpsb4zcC1dguaCNezxKJIkkstvEdXptVJ3sO4rIqFZ+YcTx7agVes8=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:b5c6:: with SMTP id
 d6mr24921983ybg.421.1608595497421; Mon, 21 Dec 2020 16:04:57 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:04:26 -0800
In-Reply-To: <20201222000435.1529768-1-emilyshaffer@google.com>
Message-Id: <20201222000435.1529768-9-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201222000435.1529768-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.29.2.490.gc7ae633391
Subject: [PATCH v3 08/17] git-p4: use 'git hook' to run hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of duplicating the behavior of run-command.h:run_hook_le() in
Python, we can directly call 'git hook run'. As a bonus, this means
git-p4 learns how to find hook specifications from the Git config as
well as from the hookdir.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Maybe there is a better way to do this - I had a hard time getting this to run
    locally, and Python is not my forte, so if anybody has a better approach I'd
    love to just take that patch instead :)
    
    Since v6, removed the developer debug print statements.... :X
    
    Maybe there is a better way to do this - I had a hard time getting this to run
    locally, and Python is not my forte, so if anybody has a better approach I'd
    love to just take that patch instead :)

 git-p4.py | 67 +++++--------------------------------------------------
 1 file changed, 6 insertions(+), 61 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 6ae5bbfe99..6e23e2ad1a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -208,70 +208,15 @@ def decode_path(path):
 
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
+    if not cmd:
         return True
 
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
+    """args are specified with -a <arg> -a <arg> -a <arg>"""
+    args = (['git', 'hook', 'run'] +
+	    ["-a" + arg for arg in param] +
+	    [cmd])
 
+    return subprocess.call(args) == 0
 
 def write_pipe(c, stdin):
     if verbose:
-- 
2.28.0.rc0.142.g3c755180ce-goog

