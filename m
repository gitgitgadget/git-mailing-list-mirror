Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C309C3F68F
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 11:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC17207FF
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 11:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="YTjExkYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgA2LM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:12:59 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37282 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgA2LM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 06:12:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so5990679wmf.2
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 03:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=90AbT0PbaLywCDJmgFe8ze6B1BJdAjeS/VGBXruk8KY=;
        b=YTjExkYm9GDFYIPPoqHWVlUBLX6aYGTViPl3+ms4OWv1MSIlU3ISBtrSZi6/vVaX2l
         3rMGm6kcSTBWPCkC0qLU+IKas3R4VhsgfHiid94oUjXYpk0PGoYznCLC+/HPx0J0HUqd
         k9dDop95vOKRwwA1L27RPyH0xT3g0MIW/xgts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=90AbT0PbaLywCDJmgFe8ze6B1BJdAjeS/VGBXruk8KY=;
        b=jcYg0BdvwdLFcy5/lCC7FV4BemZ3dPt2vBR22tB508DXUEoJX3TroOJqb0vG6mUhV0
         r2UYy8DgxlCxFtzIg5uB4WRMWIWkE6E80wZE9LGfGPLDjfBuzLPJGKDY6RZXdpeXHrUT
         pCTDaluylcRjonaSgcX8yAqCiowB3L1aR6LfxbL6oAz47/kFmwdV+YhcvgmuYoMYxq4a
         8wamcdh9RjMdolL01MlUG8iXtbX30UhWMXcP9quHg4+j37/ek85GZ2BcTbw5y/6TS9AM
         WUy/yCy1E/0DCd7NZDgC3tGt+ancaz7tiOZSaEo2AOdyGKAXAFB2LIHWdHYssplFhetU
         8s+g==
X-Gm-Message-State: APjAAAW8VsXtyR3WWalLOXQd4blkMhYq7m30/YEmfWyOnsRPzpX6Xi1n
        HoWjBcyluxFrRhNCAcC9GXkxhs+gbF0=
X-Google-Smtp-Source: APXvYqzZHM91uvR32NkNcaMuvdAHbxBls3L4prI/UmVdK5m00iEF+Pzfzh8Nz63VTIKxCBePbW64Yg==
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr10997132wml.55.1580296375030;
        Wed, 29 Jan 2020 03:12:55 -0800 (PST)
Received: from ethel.corp.roku ([85.118.3.105])
        by smtp.gmail.com with ESMTPSA id z6sm2226241wrw.36.2020.01.29.03.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 03:12:54 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Yang Zhao <yang.zhao@skyboxlabs.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 5/6] git-p4: cleanup better on error exit
Date:   Wed, 29 Jan 2020 11:12:45 +0000
Message-Id: <20200129111246.12196-6-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.390.gb5101f9297
In-Reply-To: <20200129111246.12196-5-luke@diamand.org>
References: <20200129111246.12196-1-luke@diamand.org>
 <20200129111246.12196-2-luke@diamand.org>
 <20200129111246.12196-3-luke@diamand.org>
 <20200129111246.12196-4-luke@diamand.org>
 <20200129111246.12196-5-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After an error, git-p4 calls die(). This just exits, and leaves child
processes still running.

Instead of calling die(), raise an exception and catch it where the
child process(es) (git-fastimport) are created.

This was analyzed in detail here:

    https://public-inbox.org/git/20190227094926.GE19739@szeder.dev/

This change does not address the particular issue of p4CmdList()
invoking a subchild and not waiting for it on error.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index f90b43fe5e..a69a24bf4c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -169,6 +169,9 @@ def calcDiskFree():
         return st.f_bavail * st.f_frsize
 
 def die(msg):
+    """ Terminate execution. Make sure that any running child processes have been wait()ed for before
+        calling this.
+    """
     if verbose:
         raise Exception(msg)
     else:
@@ -3574,7 +3577,7 @@ def importRevisions(self, args, branch_arg_given):
             # does not have any existing p4 branches
             if len(args) == 0:
                 if not self.p4BranchesInGit:
-                    die("No remote p4 branches.  Perhaps you never did \"git p4 clone\" in here.")
+                    raise P4CommandException("No remote p4 branches.  Perhaps you never did \"git p4 clone\" in here.")
 
                 # The default branch is master, unless --branch is used to
                 # specify something else.  Make sure it exists, or complain
@@ -3582,9 +3585,9 @@ def importRevisions(self, args, branch_arg_given):
                 if not self.detectBranches:
                     if not branch_exists(self.branch):
                         if branch_arg_given:
-                            die("Error: branch %s does not exist." % self.branch)
+                            raise P4CommandException("Error: branch %s does not exist." % self.branch)
                         else:
-                            die("Error: no branch %s; perhaps specify one with --branch." %
+                            raise P4CommandException("Error: no branch %s; perhaps specify one with --branch." %
                                 self.branch)
 
             if self.verbose:
@@ -3825,22 +3828,32 @@ def run(self, args):
 
         self.openStreams()
 
-        if revision:
-            self.importHeadRevision(revision)
-        else:
-            self.importRevisions(args, branch_arg_given)
+        err = None
 
-        if gitConfigBool("git-p4.importLabels"):
-            self.importLabels = True
+        try:
+            if revision:
+                self.importHeadRevision(revision)
+            else:
+                self.importRevisions(args, branch_arg_given)
 
-        if self.importLabels:
-            p4Labels = getP4Labels(self.depotPaths)
-            gitTags = getGitTags()
+            if gitConfigBool("git-p4.importLabels"):
+                self.importLabels = True
 
-            missingP4Labels = p4Labels - gitTags
-            self.importP4Labels(self.gitStream, missingP4Labels)
+            if self.importLabels:
+                p4Labels = getP4Labels(self.depotPaths)
+                gitTags = getGitTags()
 
-        self.closeStreams()
+                missingP4Labels = p4Labels - gitTags
+                self.importP4Labels(self.gitStream, missingP4Labels)
+
+        except P4CommandException as e:
+            err = e
+
+        finally:
+            self.closeStreams()
+
+        if err:
+            die(str(err))
 
         # Cleanup temporary branches created during import
         if self.tempBranches != []:
-- 
2.20.1.390.gb5101f9297

