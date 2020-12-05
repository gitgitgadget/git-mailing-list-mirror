Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C41C1B087
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E856229C4
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgLEBvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731209AbgLEBvT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:51:19 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA19C08E85E
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:50:05 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id kk4so4344888pjb.7
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=DkPnR/H7PAZzH4bbaf0ld6sKav/CB6vmj5JV5jjTvg8=;
        b=jLJtx6Z+9jJf2xcUxd+SalRuktljdNuqIlXBoul/uAseI6IKlWREZiukHtokx8Bb48
         zzhKBsEXcBlp8/myjo9n5HcX8lyIrNCKtB1VL1Oo9qy3G3/wZEav1gfL+l804Icpo2bn
         hnebg6mk4+CfFCDnd6+SVy4ptRubv1VQqzGQKG1X8QoHmxHcw9gV/ChgQ0vcvLVo+Xq7
         A0FM7LVbocY0170Ir7h7zgWGkE5wmW6QuzRdsK9QeNyJCk0X0trjuAXS2Jx45GOtokkA
         JBappjLRQvH3HCvAwHCQCJ1b6rHXda0moqci2DXNc1OCVUbunwCy2XGMJxMyPyEFsOv4
         8LpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DkPnR/H7PAZzH4bbaf0ld6sKav/CB6vmj5JV5jjTvg8=;
        b=XRiZFBStO1omNtsfVhrVWIAJ1x2ulRjG4ZmJ1+Ok4QWNTxdhq9r5EY2oiuI99lG+Bb
         yw+q64sI+yjm4MwoVJ3neLmmFrL0nrYQyg6vt/NfThs1Au0Zla3n+8iLPeDtRKuTa8xW
         whibLoeW7wyi7CB6bkQpP4pfKGtoCcF8Ez6Lx490VUJCgwqccoozyzYAGouwUereQFak
         NbsXy3aHeW1FctWdMVGHqvcJdqTpNFvqKkiZ9Oo+3D7I6iRlng9oCdCLXisMb7NIIGq4
         JejIGlTA5ll8/B3wGxoJNN0Zz9BqcTJHc6grDSxc/HZxMpr02Ido80bdP/j0vPVrZf5+
         Md2g==
X-Gm-Message-State: AOAM532GMo3xqXjCdnkhkzqBoFsLy0bua9aK4MVrEVLn3d1veWSWECkw
        VwMcJagUnUK8XsISJVlgzLRS0J6Ets/VqZWpClIAGrOVsXeY8suC+Cb28o2wyGMSUO8gA+Y0lgv
        ySWbL/g6/34wvuYiotizNUAvlDKeZkQeK7olW9ZQ2T8pFSFfBeVxcs+h+OMiSDQY+bh56GRX0WQ
        ==
X-Google-Smtp-Source: ABdhPJwpFR1lOvkjzA89sE5WsgbjiyiIZBmzb+EieH3N9BE/hLzwB8uvv7nf8b7Vd+QIjiqiUgwSAuhnc9RWpOrYFKg=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6a00:14cd:b029:18b:fac7:d88 with
 SMTP id w13-20020a056a0014cdb029018bfac70d88mr6432640pfu.6.1607133005254;
 Fri, 04 Dec 2020 17:50:05 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:49:36 -0800
In-Reply-To: <20201205014945.1502660-1-emilyshaffer@google.com>
Message-Id: <20201205014945.1502660-9-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014945.1502660-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 08/17] git-p4: use 'git hook' to run hooks
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

 git-p4.py | 70 +++++++------------------------------------------------
 1 file changed, 9 insertions(+), 61 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 6ae5bbfe99..73161a56d9 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -208,70 +208,18 @@ def decode_path(path):
 
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
+    print('ESS: entering run_git_hook')
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
+    print ('ESS: args:')
+    print (args)
 
+    return subprocess.call(args) == 0
 
 def write_pipe(c, stdin):
     if verbose:
-- 
2.28.0.rc0.142.g3c755180ce-goog

