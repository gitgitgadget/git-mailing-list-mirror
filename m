Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CF4C2D0B1
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE98E20661
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6ju5XOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfLDW3t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:29:49 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:39350 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDW3q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 17:29:46 -0500
Received: by mail-wr1-f50.google.com with SMTP id y11so1112166wrt.6
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 14:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R6auDpzwkB0Sojq7Ppg7Wt15Zp6cHNblRehr26rK1no=;
        b=P6ju5XOYIjCDNyBvTNLHZqfkbeuc/wOleSydi3mlknGStfQ2NJ+Z0vMJK07Wl1rbAH
         aUjuUQUK42yx9p0i/NAldOgpAn/Z1XTrlS38weI5+fe6v3jMtfGInbc5qmHaZHa/4yVe
         G1784wHTu43w3EuB52hO9vKqpt8ouL9Dcglvu1q9v73C3c3X76n8cZHmIW9/Aa3LS3tx
         kI8ppAI2xS0sVz+A00Mx0tJ+bktLJ9untO/JBTGok3bGcYPrKIaupioRKx1wy/Za4LrP
         rHHXuc3Gzb6hPe7XDzZpjdY7IoCrGWBUiqTTV9KggNmT/jzAABMNyXTPohp2MsI4iT2o
         LY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R6auDpzwkB0Sojq7Ppg7Wt15Zp6cHNblRehr26rK1no=;
        b=NrP4JJy0zQmZ7XqOBEpbU+sUR0yDECIVN2tnIvzGBh1RMRRA2f8aVB9ZUr0+WH/oRF
         5tz1rnir1sYwKZMzgqSH4YFm2EI2Q/kyDoKF7m+6JGoL+tmzgtgYGdYfPSPlGPwk4jEL
         ZKK9o2zqdR7DdimlsArAAWdx4Gvtt0bRKoY4xuJkrF0Iu1dC1FKNGDF5svSUxYYxGNBO
         dIq9QHrfqxJtghRal7uEMDgBzOTLHyy6Wb3XX6PU/Pmrm1nc0UMYgxPZYgJoT/w9GFAn
         TvknE0A4tlIQP4qQ00MZcR/UbR9vdAaDq3Q+oTrmAUQo6HJPRbTz99W8uX79PEjza4Gv
         ERwg==
X-Gm-Message-State: APjAAAUj7omRXh/FbGwdp3t2LwW4zapzYOfQ7DFOW6TWBLPbpz1sxHBf
        GH4yJjR4duPcuqWFXilQxeRZo/xR
X-Google-Smtp-Source: APXvYqxsbUceZ7KsmA1hGdKoxRFGox2eiXAQHHKsCIZC4rswqcGPeRNxRBjf9N/mQTqzSlu4x9YIYQ==
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr6939375wrs.276.1575498582836;
        Wed, 04 Dec 2019 14:29:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10sm8176239wmd.1.2019.12.04.14.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 14:29:42 -0800 (PST)
Message-Id: <3c41db3e9157e20aeed41d3eff373183c9834bff.1575498577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
        <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Dec 2019 22:29:30 +0000
Subject: [PATCH v4 04/11] git-p4: python3 syntax changes
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

Python 3+ handles strings differently than Python 2.7.  Since Python 2 is reaching it's end of life, a series of changes are being submitted to enable python 3.7+ support. The current code fails basic tests under python 3.7.

There are a number of translations suggested by modernize/futureize that should be taken to fix numerous non-string specific issues.

Change references to the X.next() iterator to the function next(X) which is compatible with both Python2 and Python3.

Change references to X.keys() to list(X.keys()) to return a list that can be iterated in both Python2 and Python3.

Add the literal text (object) to the end of class definitions to be consistent with Python3 class definition.

Change integer divison to use "//" instead of "/"  Under Both python2 and python3 // will return a floor()ed result which matches existing functionality.

Change the format string for displaying decimal values from %d to %4.1f% when displaying a progress.  This avoids displaying long repeating decimals in user displayed text.

Signed-off-by: Ben Keene <seraphire@gmail.com>
(cherry picked from commit bde6b83296aa9b3e7a584c5ce2b571c7287d8f9f)
---
 git-p4.py | 55 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 93dfd0920a..b283ef1029 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -26,6 +26,9 @@
 import zlib
 import ctypes
 import errno
+import os.path
+import codecs
+import io
 
 # support basestring in python3
 try:
@@ -631,7 +634,7 @@ def parseDiffTreeEntry(entry):
 
     If the pattern is not matched, None is returned."""
 
-    match = diffTreePattern().next().match(entry)
+    match = next(diffTreePattern()).match(entry)
     if match:
         return {
             'src_mode': match.group(1),
@@ -935,7 +938,7 @@ def findUpstreamBranchPoint(head = "HEAD"):
     branches = p4BranchesInGit()
     # map from depot-path to branch name
     branchByDepotPath = {}
-    for branch in branches.keys():
+    for branch in list(branches.keys()):
         tip = branches[branch]
         log = extractLogMessageFromGitCommit(tip)
         settings = extractSettingsGitLog(log)
@@ -1129,7 +1132,7 @@ def getClientSpec():
     client_name = entry["Client"]
 
     # just the keys that start with "View"
-    view_keys = [ k for k in entry.keys() if k.startswith("View") ]
+    view_keys = [ k for k in list(entry.keys()) if k.startswith("View") ]
 
     # hold this new View
     view = View(client_name)
@@ -1371,7 +1374,7 @@ def processContent(self, git_mode, relPath, contents):
         else:
             return LargeFileSystem.processContent(self, git_mode, relPath, contents)
 
-class Command:
+class Command(object):
     delete_actions = ( "delete", "move/delete", "purge" )
     add_actions = ( "add", "branch", "move/add" )
 
@@ -1386,7 +1389,7 @@ def ensure_value(self, attr, value):
             setattr(self, attr, value)
         return getattr(self, attr)
 
-class P4UserMap:
+class P4UserMap(object):
     def __init__(self):
         self.userMapFromPerforceServer = False
         self.myP4UserId = None
@@ -1437,7 +1440,7 @@ def getUserMapFromPerforceServer(self):
                 self.emails[email] = user
 
         s = ''
-        for (key, val) in self.users.items():
+        for (key, val) in list(self.users.items()):
             s += "%s\t%s\n" % (key.expandtabs(1), val.expandtabs(1))
 
         open(self.getUserCacheFilename(), "wb").write(s)
@@ -1788,7 +1791,7 @@ def prepareSubmitTemplate(self, changelist=None):
                 break
         if not change_entry:
             die('Failed to decode output of p4 change -o')
-        for key, value in change_entry.iteritems():
+        for key, value in list(change_entry.items()):
             if key.startswith('File'):
                 if 'depot-paths' in settings:
                     if not [p for p in settings['depot-paths']
@@ -2032,7 +2035,7 @@ def applyCommit(self, id):
             p4_delete(f)
 
         # Set/clear executable bits
-        for f in filesToChangeExecBit.keys():
+        for f in list(filesToChangeExecBit.keys()):
             mode = filesToChangeExecBit[f]
             setP4ExecBit(f, mode)
 
@@ -2285,7 +2288,7 @@ def run(self, args):
             self.clientSpecDirs = getClientSpec()
 
         # Check for the existence of P4 branches
-        branchesDetected = (len(p4BranchesInGit().keys()) > 1)
+        branchesDetected = (len(list(p4BranchesInGit().keys())) > 1)
 
         if self.useClientSpec and not branchesDetected:
             # all files are relative to the client spec
@@ -2676,7 +2679,7 @@ def __init__(self):
         self.knownBranches = {}
         self.initialParents = {}
 
-        self.tz = "%+03d%02d" % (- time.timezone / 3600, ((- time.timezone % 3600) / 60))
+        self.tz = "%+03d%02d" % (- time.timezone // 3600, ((- time.timezone % 3600) // 60))
         self.labels = {}
 
     # Force a checkpoint in fast-import and wait for it to finish
@@ -2793,7 +2796,7 @@ def splitFilesIntoBranches(self, commit):
             else:
                 relPath = self.stripRepoPath(path, self.depotPaths)
 
-            for branch in self.knownBranches.keys():
+            for branch in list(self.knownBranches.keys()):
                 # add a trailing slash so that a commit into qt/4.2foo
                 # doesn't end up in qt/4.2, e.g.
                 if p4PathStartsWith(relPath, branch + "/"):
@@ -2834,7 +2837,7 @@ def streamOneP4File(self, file, contents):
                 size = int(self.stream_file['fileSize'])
             else:
                 size = 0 # deleted files don't get a fileSize apparently
-            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size/1024/1024))
+            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size//1024//1024))
             sys.stdout.flush()
 
         (type_base, type_mods) = split_p4_type(file["type"])
@@ -2934,7 +2937,7 @@ def streamP4FilesCb(self, marshalled):
             required_bytes = int((4 * int(self.stream_file["fileSize"])) - calcDiskFree())
             if required_bytes > 0:
                 err = 'Not enough space left on %s! Free at least %i MB.' % (
-                    os.getcwd(), required_bytes/1024/1024
+                    os.getcwd(), required_bytes//1024//1024
                 )
 
         if err:
@@ -2963,7 +2966,7 @@ def streamP4FilesCb(self, marshalled):
 
         # pick up the new file information... for the
         # 'data' field we need to append to our array
-        for k in marshalled.keys():
+        for k in list(marshalled.keys()):
             if k == 'data':
                 if 'streamContentSize' not in self.stream_file:
                     self.stream_file['streamContentSize'] = 0
@@ -2978,8 +2981,8 @@ def streamP4FilesCb(self, marshalled):
             'depotFile' in self.stream_file):
             size = int(self.stream_file["fileSize"])
             if size > 0:
-                progress = 100*self.stream_file['streamContentSize']/size
-                sys.stdout.write('\r%s %d%% (%i MB)' % (self.stream_file['depotFile'], progress, int(size/1024/1024)))
+                progress = 100.0*self.stream_file['streamContentSize']/size
+                sys.stdout.write('\r%s %4.1f%% (%i MB)' % (self.stream_file['depotFile'], progress, int(size//1024//1024)))
                 sys.stdout.flush()
 
         self.stream_have_file_info = True
@@ -3060,7 +3063,7 @@ def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
 
         gitStream.write("tagger %s\n" % tagger)
 
-        print("labelDetails=",labelDetails)
+        print(("labelDetails=",labelDetails))
         if 'Description' in labelDetails:
             description = labelDetails['Description']
         else:
@@ -3199,7 +3202,7 @@ def getLabels(self):
             self.labels[newestChange] = [output, revisions]
 
         if self.verbose:
-            print("Label changes: %s" % self.labels.keys())
+            print("Label changes: %s" % list(self.labels.keys()))
 
     # Import p4 labels as git tags. A direct mapping does not
     # exist, so assume that if all the files are at the same revision
@@ -3342,7 +3345,7 @@ def getBranchMapping(self):
 
     def getBranchMappingFromGitBranches(self):
         branches = p4BranchesInGit(self.importIntoRemotes)
-        for branch in branches.keys():
+        for branch in list(branches.keys()):
             if branch == "master":
                 branch = "main"
             else:
@@ -3454,14 +3457,14 @@ def importChanges(self, changes, origin_revision=0):
             self.updateOptionDict(description)
 
             if not self.silent:
-                sys.stdout.write("\rImporting revision %s (%s%%)" % (change, cnt * 100 / len(changes)))
+                sys.stdout.write("\rImporting revision %s (%4.1f%%)" % (change, cnt * 100 / len(changes)))
                 sys.stdout.flush()
             cnt = cnt + 1
 
             try:
                 if self.detectBranches:
                     branches = self.splitFilesIntoBranches(description)
-                    for branch in branches.keys():
+                    for branch in list(branches.keys()):
                         ## HACK  --hwn
                         branchPrefix = self.depotPaths[0] + branch + "/"
                         self.branchPrefixes = [ branchPrefix ]
@@ -3650,13 +3653,13 @@ def run(self, args):
                 if short in branches:
                     self.p4BranchesInGit = [ short ]
             else:
-                self.p4BranchesInGit = branches.keys()
+                self.p4BranchesInGit = list(branches.keys())
 
             if len(self.p4BranchesInGit) > 1:
                 if not self.silent:
                     print("Importing from/into multiple branches")
                 self.detectBranches = True
-                for branch in branches.keys():
+                for branch in list(branches.keys()):
                     self.initialParents[self.refPrefix + branch] = \
                         branches[branch]
 
@@ -4040,7 +4043,7 @@ def findLastP4Revision(self, starting_point):
             to find the P4 commit we are based on, and the depot-paths.
         """
 
-        for parent in (range(65535)):
+        for parent in (list(range(65535))):
             log = extractLogMessageFromGitCommit("{0}^{1}".format(starting_point, parent))
             settings = extractSettingsGitLog(log)
             if 'change' in settings:
@@ -4179,7 +4182,7 @@ def printUsage(commands):
 
 def main():
     if len(sys.argv[1:]) == 0:
-        printUsage(commands.keys())
+        printUsage(list(commands.keys()))
         sys.exit(2)
 
     cmdName = sys.argv[1]
@@ -4189,7 +4192,7 @@ def main():
     except KeyError:
         print("unknown command %s" % cmdName)
         print("")
-        printUsage(commands.keys())
+        printUsage(list(commands.keys()))
         sys.exit(2)
 
     options = cmd.options
-- 
gitgitgadget

