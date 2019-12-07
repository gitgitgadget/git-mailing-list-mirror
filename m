Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2141AC2BBE2
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD72217BA
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUdPhxE9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfLGRrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:47:51 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:46758 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfLGRrv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 12:47:51 -0500
Received: by mail-wr1-f46.google.com with SMTP id z7so11228348wrl.13
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 09:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0dqqa6jkHEt5zsxaZPmqLAX5RIVwpEdWH2EzXL8V48Q=;
        b=cUdPhxE9owG7EVmSlR5RMNqBqBmR1+1xBNC0ACbBJcfdK4mx6dSYF34uBxrqfTlxEX
         iuClDiiXXl/OqE/FP3oQwNhHq1J/pAsNMx+iyaHC4GNhyZZFuSh2v1NI3xswpeUoO5RV
         gF2HWauKBBGkbm0NL6SFzhooT913jHmRK121aGy10cGbNZ14VT5PWLqNNRjwu0T0mAsG
         vKwU6+FCLS9r/Zmuff3K3T9xVZvGtdXFxrgnzfYJ5ivn2TFXfvmXOD7VWVpkj5+NuP9v
         Q+GVxaIzeFz5NoHja/0TlcWFhKxm+SQIXyoehPxOGdZjkPWAhEqJ6gN8tR4VxUURxQji
         zSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0dqqa6jkHEt5zsxaZPmqLAX5RIVwpEdWH2EzXL8V48Q=;
        b=caeNWwOW2CLeDTB+CtUTpJLID/xMZobcRHlo4Em5TpfrEkhpVMWXXM4O7JeXyJ2G69
         Z3YL61lVOFgTOmrOURalYykJACncaeHzdnlnkwKqN4RcjCvwZsJDW00oop47q0VenOcV
         lGyG1Xi/JsAwnhj3RP3MzX0ld4r3nCkS5va1Pt080FYFpVK2QAHq+2dtw9l/PWAicaEQ
         DxGFH9i9MIYraruKjycINNPteI7Jv4zCNN9J8cyl+SzfvYv724sKLvb7F+BfHQnOHHpr
         rBTRjrl6KMsEIiWn6XrsK8mML8qoK79c0iH6q2C276fdRDMQqKY98iCUV0JQuqnfh0sg
         R4og==
X-Gm-Message-State: APjAAAX2nuXbvmBKSw1/au+4e82i/uoz7SU3hUTFsDKKVgWLfrTeZxPn
        6tdRwMzDwEFOUAngvpP+Nh+kVnLt
X-Google-Smtp-Source: APXvYqxzzu8kj9XglDJSAtFpYndb15GzalIYD6NZ4wJ3BuLerrKPXGdTbw7nFkW7GfclTGHWiD8/8g==
X-Received: by 2002:adf:d184:: with SMTP id v4mr20716388wrc.76.1575740868227;
        Sat, 07 Dec 2019 09:47:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s15sm17759449wrp.4.2019.12.07.09.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 09:47:47 -0800 (PST)
Message-Id: <7170aface2270e8c46439c5c1e01d2b18cdf6fd0.1575740863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Dec 2019 17:47:32 +0000
Subject: [PATCH v5 04/15] git-p4: change the expansion test from basestring to
 list
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

Python 3 handles strings differently than Python 2.7.  Since Python 2
is reaching it's end of life, a series of changes are being submitted to
enable python 3.5 and following support. The current code fails basic
tests under python 3.5.

The original code used 'basestring' in a test to determine if a list or
literal string was passed into 9 different functions.  This is used to
determine if the shell should be invoked when calling subprocess
methods.

Change references to 'basestring' in the isinstance tests to use 'list'
instead. This prepares the code to remove all references to basestring.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 65e926758c..3153186df0 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -108,7 +108,7 @@ def p4_build_cmd(cmd):
         # Provide a way to not pass this option by setting git-p4.retries to 0
         real_cmd += ["-r", str(retries)]
 
-    if isinstance(cmd,basestring):
+    if not isinstance(cmd, list):
         real_cmd = ' '.join(real_cmd) + ' ' + cmd
     else:
         real_cmd += cmd
@@ -174,7 +174,7 @@ def write_pipe(c, stdin):
     if verbose:
         sys.stderr.write('Writing pipe: %s\n' % str(c))
 
-    expand = isinstance(c,basestring)
+    expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdin=subprocess.PIPE, shell=expand)
     pipe = p.stdin
     val = pipe.write(stdin)
@@ -196,7 +196,7 @@ def read_pipe_full(c):
     if verbose:
         sys.stderr.write('Reading pipe: %s\n' % str(c))
 
-    expand = isinstance(c,basestring)
+    expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=expand)
     (out, err) = p.communicate()
     return (p.returncode, out, err)
@@ -232,7 +232,7 @@ def read_pipe_lines(c):
     if verbose:
         sys.stderr.write('Reading pipe: %s\n' % str(c))
 
-    expand = isinstance(c, basestring)
+    expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
     pipe = p.stdout
     val = pipe.readlines()
@@ -275,7 +275,7 @@ def p4_has_move_command():
     return True
 
 def system(cmd, ignore_error=False):
-    expand = isinstance(cmd,basestring)
+    expand = not isinstance(cmd, list)
     if verbose:
         sys.stderr.write("executing %s\n" % str(cmd))
     retcode = subprocess.call(cmd, shell=expand)
@@ -287,7 +287,7 @@ def system(cmd, ignore_error=False):
 def p4_system(cmd):
     """Specifically invoke p4 as the system command. """
     real_cmd = p4_build_cmd(cmd)
-    expand = isinstance(real_cmd, basestring)
+    expand = not isinstance(real_cmd, list)
     retcode = subprocess.call(real_cmd, shell=expand)
     if retcode:
         raise CalledProcessError(retcode, real_cmd)
@@ -525,7 +525,7 @@ def getP4OpenedType(file):
 # Return the set of all p4 labels
 def getP4Labels(depotPaths):
     labels = set()
-    if isinstance(depotPaths,basestring):
+    if not isinstance(depotPaths, list):
         depotPaths = [depotPaths]
 
     for l in p4CmdList(["labels"] + ["%s..." % p for p in depotPaths]):
@@ -612,7 +612,7 @@ def isModeExecChanged(src_mode, dst_mode):
 def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
         errors_as_exceptions=False):
 
-    if isinstance(cmd,basestring):
+    if not isinstance(cmd, list):
         cmd = "-G " + cmd
         expand = True
     else:
@@ -629,7 +629,7 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
     stdin_file = None
     if stdin is not None:
         stdin_file = tempfile.TemporaryFile(prefix='p4-stdin', mode=stdin_mode)
-        if isinstance(stdin,basestring):
+        if not isinstance(stdin, list):
             stdin_file.write(stdin)
         else:
             for i in stdin:
-- 
gitgitgadget

