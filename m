Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC39BC33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 11:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836BD207FF
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 11:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="I0I+EYxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgA2LM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:12:58 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:35597 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgA2LM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 06:12:56 -0500
Received: by mail-wr1-f53.google.com with SMTP id g17so19684986wro.2
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 03:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ix/atSX62WvJHCm4sbYuiWqaDsDs6m6kBgOX/MS69H4=;
        b=I0I+EYxOCtjhxJPrYw8o5JoHXU8xfKioS+8vz+VfP1udxOxn5GSKv216wIJGdZ7/Ei
         GGSLQGuPFa0tr1AEn0G+gF9AYREXdTJxNZ+D5OyPmQifb2uftD9T96MTT318h/S0zVE/
         WG3w18Oon95A37dXvZJUxCYYC1WCGvDCSpKMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ix/atSX62WvJHCm4sbYuiWqaDsDs6m6kBgOX/MS69H4=;
        b=Tcc4JLVih3sCU/OjNnnuERXg0JDmECYkUV4eWXbi2c5Dag3YPDuQtD0cM6SmPbN3CL
         WkZ6iJBZqw247agu0Ja5cmUYyEwlOG/cZ/h74XXNz+qIVSUk32UPUTVF+STepKOUkrKW
         yq4CI4fFInOSN/mdBiy8oexd4fqG50S1pY0eYMA/cwRvcBdOyMbld1JNwkVmtsnNUNnV
         j7KpDLLKbgoUj1Erwh0U+HopfqxhZFIOesjwCj9V9OxGoNJO9cMX8vwAbHN5cYiEgQS3
         19WvUol8PQ13t/W04kw/smsDVwHGX0uM/4LZODM7kuAyQ8VeMyGOd/oN73NPNHbYfWcl
         Q7VA==
X-Gm-Message-State: APjAAAVWWdRnBJQJ7j4iiQ84hCj7N4QVGwfkjaIaBSyYXSHv1hqw22VB
        gypz3Xg1Wb+ktY8dggCXx+WRYugBe9I=
X-Google-Smtp-Source: APXvYqxtECH1RpG6cto/Jay0AJjIEQ9QONc6ld+hG2agZk3EPqJJ/ZNP2Gq/lkOr6Wj+ncLPaFx+eg==
X-Received: by 2002:adf:ffc5:: with SMTP id x5mr35591109wrs.92.1580296374097;
        Wed, 29 Jan 2020 03:12:54 -0800 (PST)
Received: from ethel.corp.roku ([85.118.3.105])
        by smtp.gmail.com with ESMTPSA id z6sm2226241wrw.36.2020.01.29.03.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 03:12:53 -0800 (PST)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Yang Zhao <yang.zhao@skyboxlabs.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 4/6] git-p4: create helper function importRevisions()
Date:   Wed, 29 Jan 2020 11:12:44 +0000
Message-Id: <20200129111246.12196-5-luke@diamand.org>
X-Mailer: git-send-email 2.20.1.390.gb5101f9297
In-Reply-To: <20200129111246.12196-4-luke@diamand.org>
References: <20200129111246.12196-1-luke@diamand.org>
 <20200129111246.12196-2-luke@diamand.org>
 <20200129111246.12196-3-luke@diamand.org>
 <20200129111246.12196-4-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it easier to try/catch around this block of code to ensure
cleanup following p4 failures is handled properly.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 132 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 68 insertions(+), 64 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index d796074b87..f90b43fe5e 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3555,6 +3555,73 @@ def importHeadRevision(self, revision):
             print("IO error details: {}".format(err))
             print(self.gitError.read())
 
+
+    def importRevisions(self, args, branch_arg_given):
+        changes = []
+
+        if len(self.changesFile) > 0:
+            output = open(self.changesFile).readlines()
+            changeSet = set()
+            for line in output:
+                changeSet.add(int(line))
+
+            for change in changeSet:
+                changes.append(change)
+
+            changes.sort()
+        else:
+            # catch "git p4 sync" with no new branches, in a repo that
+            # does not have any existing p4 branches
+            if len(args) == 0:
+                if not self.p4BranchesInGit:
+                    die("No remote p4 branches.  Perhaps you never did \"git p4 clone\" in here.")
+
+                # The default branch is master, unless --branch is used to
+                # specify something else.  Make sure it exists, or complain
+                # nicely about how to use --branch.
+                if not self.detectBranches:
+                    if not branch_exists(self.branch):
+                        if branch_arg_given:
+                            die("Error: branch %s does not exist." % self.branch)
+                        else:
+                            die("Error: no branch %s; perhaps specify one with --branch." %
+                                self.branch)
+
+            if self.verbose:
+                print("Getting p4 changes for %s...%s" % (', '.join(self.depotPaths),
+                                                          self.changeRange))
+            changes = p4ChangesForPaths(self.depotPaths, self.changeRange, self.changes_block_size)
+
+            if len(self.maxChanges) > 0:
+                changes = changes[:min(int(self.maxChanges), len(changes))]
+
+        if len(changes) == 0:
+            if not self.silent:
+                print("No changes to import!")
+        else:
+            if not self.silent and not self.detectBranches:
+                print("Import destination: %s" % self.branch)
+
+            self.updatedBranches = set()
+
+            if not self.detectBranches:
+                if args:
+                    # start a new branch
+                    self.initialParent = ""
+                else:
+                    # build on a previous revision
+                    self.initialParent = parseRevision(self.branch)
+
+            self.importChanges(changes)
+
+            if not self.silent:
+                print("")
+                if len(self.updatedBranches) > 0:
+                    sys.stdout.write("Updated branches: ")
+                    for b in self.updatedBranches:
+                        sys.stdout.write("%s " % b)
+                    sys.stdout.write("\n")
+
     def openStreams(self):
         self.importProcess = subprocess.Popen(["git", "fast-import"],
                                               stdin=subprocess.PIPE,
@@ -3761,70 +3828,7 @@ def run(self, args):
         if revision:
             self.importHeadRevision(revision)
         else:
-            changes = []
-
-            if len(self.changesFile) > 0:
-                output = open(self.changesFile).readlines()
-                changeSet = set()
-                for line in output:
-                    changeSet.add(int(line))
-
-                for change in changeSet:
-                    changes.append(change)
-
-                changes.sort()
-            else:
-                # catch "git p4 sync" with no new branches, in a repo that
-                # does not have any existing p4 branches
-                if len(args) == 0:
-                    if not self.p4BranchesInGit:
-                        die("No remote p4 branches.  Perhaps you never did \"git p4 clone\" in here.")
-
-                    # The default branch is master, unless --branch is used to
-                    # specify something else.  Make sure it exists, or complain
-                    # nicely about how to use --branch.
-                    if not self.detectBranches:
-                        if not branch_exists(self.branch):
-                            if branch_arg_given:
-                                die("Error: branch %s does not exist." % self.branch)
-                            else:
-                                die("Error: no branch %s; perhaps specify one with --branch." %
-                                    self.branch)
-
-                if self.verbose:
-                    print("Getting p4 changes for %s...%s" % (', '.join(self.depotPaths),
-                                                              self.changeRange))
-                changes = p4ChangesForPaths(self.depotPaths, self.changeRange, self.changes_block_size)
-
-                if len(self.maxChanges) > 0:
-                    changes = changes[:min(int(self.maxChanges), len(changes))]
-
-            if len(changes) == 0:
-                if not self.silent:
-                    print("No changes to import!")
-            else:
-                if not self.silent and not self.detectBranches:
-                    print("Import destination: %s" % self.branch)
-
-                self.updatedBranches = set()
-
-                if not self.detectBranches:
-                    if args:
-                        # start a new branch
-                        self.initialParent = ""
-                    else:
-                        # build on a previous revision
-                        self.initialParent = parseRevision(self.branch)
-
-                self.importChanges(changes)
-
-                if not self.silent:
-                    print("")
-                    if len(self.updatedBranches) > 0:
-                        sys.stdout.write("Updated branches: ")
-                        for b in self.updatedBranches:
-                            sys.stdout.write("%s " % b)
-                        sys.stdout.write("\n")
+            self.importRevisions(args, branch_arg_given)
 
         if gitConfigBool("git-p4.importLabels"):
             self.importLabels = True
-- 
2.20.1.390.gb5101f9297

