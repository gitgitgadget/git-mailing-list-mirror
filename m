Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95511C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C664206EE
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="s4nG4MyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLMXxX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:53:23 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42342 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMXxW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 18:53:22 -0500
Received: by mail-pl1-f196.google.com with SMTP id x13so1882027plr.9
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 15:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ecnvCqyfkZcd7TihBAMzcdaLrOm3d+1fccnRmDnk5Lk=;
        b=s4nG4MyKtIBQCSP/U+yeLk+kYJ8wj5hSlWJfOjhlv3Wt0P6tQeLzIJB2LkQZ8pWAtL
         tG0sN4dejCZqUQfnBOcaGdFdDgrJmKwDNxxvEcfhxfQ0ags8cgaCXCaNqbgshAS3pjpK
         KE08KOb4k0ThgHvmI8NdroGDRrSz/FYA2Z8Zxs0FfTHg0OF8i6eWyR0CIV7GETk6lg0q
         poLcbfdAj3thtd/ueuZFRbN53OWMXoW2ySBORUl/LVa1T1u3Y+4xwSDmy71mBVcNerGg
         UEz73XiEuZPCReKIC5KXBqB5C9RR8Cs4Sf++igXE28fBaZwW78HLAHHg8Z7X9MpfAD04
         RpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ecnvCqyfkZcd7TihBAMzcdaLrOm3d+1fccnRmDnk5Lk=;
        b=LW4sQaM5uVTIJ8rW6CaQXwqhk3GQje8CuEybICp+nEV6sfIOYLQwYvoa6wSgF5zVAl
         H9SO/ynhLmg+fEjnD8274NrZqGc8TWHyjBJNEbFDzoyp7bRFik6iRlFdigwKfRJARZUu
         cWswDN2ryKDNlJE++CNhSwtZ+ZPmZjby5ftejyp5nWocDcEyeMD6RADyFY/2WRX+630G
         TFVtfdx+Y3WfawotYtrdt4SoqBctEo4cVB7mSjbxvy3JOOfTyuH0xZKSnS8fu5yLTNDV
         IQu+DADOvp1AeBCcCvWAkJ2iZNap3gvDn1jHUCLwtIs0bhLQWGF6m9IdiIXZPsiTM22+
         4Izw==
X-Gm-Message-State: APjAAAVQLAxGn7UsJFmeTLk0oY2aPqQMMX/PCKM9rAiEK2YXW51ceSOg
        VnNrs5cQ17DSbfrsn1P2Yvbzxz03RRkhmmbw
X-Google-Smtp-Source: APXvYqyxY8J/vklTD+1PT94znKD6EsrRrXTPvsCLIAcMxJTMB9T4IrRVpslNla+lZqEev3aG64Cyuw==
X-Received: by 2002:a17:90a:1b6b:: with SMTP id q98mr2509216pjq.106.1576281201183;
        Fri, 13 Dec 2019 15:53:21 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id r2sm11926036pgv.16.2019.12.13.15.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 15:53:20 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, luke@diamand.org,
        liu.denton@gmail.com, Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [PATCH v2 02/14] git-p4: change the expansion test from basestring to list
Date:   Fri, 13 Dec 2019 15:52:36 -0800
Message-Id: <20191213235247.23660-4-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

Python 3 handles strings differently than Python 2.7. Since Python 2
is reaching it's end of life, a series of changes are being submitted to
enable python 3.5 and following support. The current code fails basic
tests under python 3.5.

Some codepaths can represent a command line the program
internally prepares to execute either as a single string
(i.e. each token properly quoted, concatenated with $IFS) or
as a list of argv[] elements, and there are 9 places where
we say "if X is isinstance(_, basestring), then do this
thing to handle X as a command line in a single string; if
not, X is a command line in a list form".

This does not work well with Python 3, as there is no
basestring (everything is Unicode now), and even with Python
2, it was not an ideal way to tell the two cases apart,
because an internally formed command line could have been in
a single Unicode string.

Flip the check to say "if X is not a list, then handle X as
a command line in a single string; otherwise treat it as a
command line in a list form".

This will get rid of references to 'basestring', to migrate
the code ready for Python 3.

Thanks-to: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ben Keene <seraphire@gmail.com>
Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
---
 git-p4.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 37777bb9fd..2f177fb43b 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -89,7 +89,7 @@ def p4_build_cmd(cmd):
         # Provide a way to not pass this option by setting git-p4.retries to 0
         real_cmd += ["-r", str(retries)]
 
-    if isinstance(cmd,basestring):
+    if not isinstance(cmd, list):
         real_cmd = ' '.join(real_cmd) + ' ' + cmd
     else:
         real_cmd += cmd
@@ -155,7 +155,7 @@ def write_pipe(c, stdin):
     if verbose:
         sys.stderr.write('Writing pipe: %s\n' % str(c))
 
-    expand = isinstance(c,basestring)
+    expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdin=subprocess.PIPE, shell=expand)
     pipe = p.stdin
     val = pipe.write(stdin)
@@ -177,7 +177,7 @@ def read_pipe_full(c):
     if verbose:
         sys.stderr.write('Reading pipe: %s\n' % str(c))
 
-    expand = isinstance(c,basestring)
+    expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=expand)
     (out, err) = p.communicate()
     return (p.returncode, out, err)
@@ -213,7 +213,7 @@ def read_pipe_lines(c):
     if verbose:
         sys.stderr.write('Reading pipe: %s\n' % str(c))
 
-    expand = isinstance(c, basestring)
+    expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
     pipe = p.stdout
     val = pipe.readlines()
@@ -256,7 +256,7 @@ def p4_has_move_command():
     return True
 
 def system(cmd, ignore_error=False):
-    expand = isinstance(cmd,basestring)
+    expand = not isinstance(cmd, list)
     if verbose:
         sys.stderr.write("executing %s\n" % str(cmd))
     retcode = subprocess.call(cmd, shell=expand)
@@ -268,7 +268,7 @@ def system(cmd, ignore_error=False):
 def p4_system(cmd):
     """Specifically invoke p4 as the system command. """
     real_cmd = p4_build_cmd(cmd)
-    expand = isinstance(real_cmd, basestring)
+    expand = not isinstance(real_cmd, list)
     retcode = subprocess.call(real_cmd, shell=expand)
     if retcode:
         raise CalledProcessError(retcode, real_cmd)
@@ -506,7 +506,7 @@ def getP4OpenedType(file):
 # Return the set of all p4 labels
 def getP4Labels(depotPaths):
     labels = set()
-    if isinstance(depotPaths,basestring):
+    if not isinstance(depotPaths, list):
         depotPaths = [depotPaths]
 
     for l in p4CmdList(["labels"] + ["%s..." % p for p in depotPaths]):
@@ -593,7 +593,7 @@ def isModeExecChanged(src_mode, dst_mode):
 def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
         errors_as_exceptions=False):
 
-    if isinstance(cmd,basestring):
+    if not isinstance(cmd, list):
         cmd = "-G " + cmd
         expand = True
     else:
@@ -610,7 +610,7 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
     stdin_file = None
     if stdin is not None:
         stdin_file = tempfile.TemporaryFile(prefix='p4-stdin', mode=stdin_mode)
-        if isinstance(stdin,basestring):
+        if not isinstance(stdin, list):
             stdin_file.write(stdin)
         else:
             for i in stdin:
-- 
2.21.0.windows.1

