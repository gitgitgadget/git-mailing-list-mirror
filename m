Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1C4C2D0C1
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6959D205ED
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="BL5iRZBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfLGAdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:33:52 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:38756 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfLGAdw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 19:33:52 -0500
Received: by mail-pf1-f171.google.com with SMTP id x185so4193503pfc.5
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 16:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=os1Xb9YKCSCV0c1kabaYrhzFU9ohu6RZ63Fz/Wm/YU4=;
        b=BL5iRZBWVJ2bSUA2F5JhsrUKmQ7h+SX5AsJFk3785gS/oZCuQzS5PWvtKXtMb29EfT
         Q+O7F6BgxymeB2ydjJ+wrGWB83ks8UWFohjh+gXsedEfitKYpAKQsMMwMxyOfBgHM0JU
         idGGmWvxLeiFrZLxbUj6WjEiJDWMoiFc58a2ASF1O4PiVqes38RuaWVwwg86n3WmEdpY
         2tB7pS1D7+KZg6K9dPeJMXSgeV0RwTI1tDFQhzb/cqWyBshULX5XbBKYl+wQg3Td4Ix0
         X1petCkNjCFAVwD031RhsLacfwUUV+aB8T68U62YQ9XxcOtYGuL2A57wL/jv80U1RhBM
         3fTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=os1Xb9YKCSCV0c1kabaYrhzFU9ohu6RZ63Fz/Wm/YU4=;
        b=dEtP48EIR5oKIk/B6zfiGzmVSoDMA1XMY0nKJQVSXOhft45Dy8Ep5GBKDcKKOyT5Iu
         VlBlpO2Wd1Su/8VERMVvOL368FBIM/mGN3KYUeL0iI232ATe1eJvGFOC41LR/mnNdM6Z
         0Qe3WDJAcnugXSStIaw/IUh7GcKKfO3uV7nCpRM7CbywBD8L6Vt93MIGBo7ErW2KZtUU
         IDheG+5EgAgK3K9ZYWsLW3Y/y2yyWXYJpZokAK7U9GvdEm2+X5v4cNNpheI7V11qzntS
         ZMANf4qbiq1mTVFCBFz70FmTZTwiqAVEFRHLsv5TbKbK6K7n6fuKitHOd1uLJULpZPiP
         qmyw==
X-Gm-Message-State: APjAAAXRcc+dbflDtAEjlt4QHGy+/cfUyf6yWOfyJthxII2doc9hJtha
        MGuSTVLD6SpRa203QoYMj3rVteVHaJfCIQ==
X-Google-Smtp-Source: APXvYqygSrIopu4L/SFem1sJsSt5S342MUyo7asmP4p7fqJxKKrdCr2YHSbXEORbb4gnGk3zz227aA==
X-Received: by 2002:a63:6507:: with SMTP id z7mr6740262pgb.322.1575678830587;
        Fri, 06 Dec 2019 16:33:50 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id b21sm18708949pfp.0.2019.12.06.16.33.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 16:33:49 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [PATCH 06/13] git-p4: convert path to unicode before processing them
Date:   Fri,  6 Dec 2019 16:33:24 -0800
Message-Id: <20191207003333.3228-7-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

P4 allows essentially arbitrary encoding for path data while we would
perfer to be dealing only with unicode strings.  Since path data need to
survive round-trip back to p4, this patch implements the general policy
that we store path data as-is, but decode them to unicode before doing
any non-trivial processing.

A new `decode_path()` method is provided that generally does the correct
conversion, taking into account `git-p4.pathEncoding` configuration.

For python2.7, path strings will be left as-is if it only contains ASCII
characters.

For python3, decoding is always done so that we have str objects.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
---
 git-p4.py | 67 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index fefa716b17..088924fbe1 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -170,6 +170,21 @@ def decode_text_stream(s):
     def encode_text_stream(s):
         return s.encode('utf_8') if isinstance(s, unicode) else s
 
+def decode_path(path):
+    """Decode a given string (bytes or otherwise) using configured path encoding options
+    """
+    encoding = gitConfig('git-p4.pathEncoding') or 'utf_8'
+    if bytes is not str:
+        return path.decode(encoding, errors='replace') if isinstance(path, bytes) else path
+    else:
+        try:
+            path.decode('ascii')
+        except:
+            path = path.decode(encoding, errors='replace')
+            if verbose:
+                print('Path with non-ASCII characters detected. Used {} to decode: {}'.format(encoding, path))
+        return path
+
 def write_pipe(c, stdin):
     if verbose:
         sys.stderr.write('Writing pipe: %s\n' % str(c))
@@ -715,7 +730,8 @@ def p4Where(depotPath):
         if "depotFile" in entry:
             # Search for the base client side depot path, as long as it starts with the branch's P4 path.
             # The base path always ends with "/...".
-            if entry["depotFile"].find(depotPath) == 0 and entry["depotFile"][-4:] == "/...":
+            entry_path = decode_path(entry['depotFile'])
+            if entry_path.find(depotPath) == 0 and entry_path[-4:] == "/...":
                 output = entry
                 break
         elif "data" in entry:
@@ -730,11 +746,11 @@ def p4Where(depotPath):
         return ""
     clientPath = ""
     if "path" in output:
-        clientPath = output.get("path")
+        clientPath = decode_path(output['path'])
     elif "data" in output:
         data = output.get("data")
-        lastSpace = data.rfind(" ")
-        clientPath = data[lastSpace + 1:]
+        lastSpace = data.rfind(b" ")
+        clientPath = decode_path(data[lastSpace + 1:])
 
     if clientPath.endswith("..."):
         clientPath = clientPath[:-3]
@@ -2511,7 +2527,7 @@ def update_client_spec_path_cache(self, files):
         """ Caching file paths by "p4 where" batch query """
 
         # List depot file paths exclude that already cached
-        fileArgs = [f['path'] for f in files if f['path'] not in self.client_spec_path_cache]
+        fileArgs = [f['path'] for f in files if decode_path(f['path']) not in self.client_spec_path_cache]
 
         if len(fileArgs) == 0:
             return  # All files in cache
@@ -2526,16 +2542,18 @@ def update_client_spec_path_cache(self, files):
             if "unmap" in res:
                 # it will list all of them, but only one not unmap-ped
                 continue
+            depot_path = decode_path(res['depotFile'])
             if gitConfigBool("core.ignorecase"):
-                res['depotFile'] = res['depotFile'].lower()
-            self.client_spec_path_cache[res['depotFile']] = self.convert_client_path(res["clientFile"])
+                depot_path = depot_path.lower()
+            self.client_spec_path_cache[depot_path] = self.convert_client_path(res["clientFile"])
 
         # not found files or unmap files set to ""
         for depotFile in fileArgs:
+            depotFile = decode_path(depotFile)
             if gitConfigBool("core.ignorecase"):
                 depotFile = depotFile.lower()
             if depotFile not in self.client_spec_path_cache:
-                self.client_spec_path_cache[depotFile] = ""
+                self.client_spec_path_cache[depotFile] = b''
 
     def map_in_client(self, depot_path):
         """Return the relative location in the client where this
@@ -2653,7 +2671,7 @@ def isPathWanted(self, path):
             elif path.lower() == p.lower():
                 return False
         for p in self.depotPaths:
-            if p4PathStartsWith(path, p):
+            if p4PathStartsWith(path, decode_path(p)):
                 return True
         return False
 
@@ -2662,7 +2680,7 @@ def extractFilesFromCommit(self, commit, shelved=False, shelved_cl = 0):
         fnum = 0
         while "depotFile%s" % fnum in commit:
             path =  commit["depotFile%s" % fnum]
-            found = self.isPathWanted(path)
+            found = self.isPathWanted(decode_path(path))
             if not found:
                 fnum = fnum + 1
                 continue
@@ -2696,7 +2714,7 @@ def stripRepoPath(self, path, prefixes):
         if self.useClientSpec:
             # branch detection moves files up a level (the branch name)
             # from what client spec interpretation gives
-            path = self.clientSpecDirs.map_in_client(path)
+            path = decode_path(self.clientSpecDirs.map_in_client(path))
             if self.detectBranches:
                 for b in self.knownBranches:
                     if p4PathStartsWith(path, b + "/"):
@@ -2730,14 +2748,15 @@ def splitFilesIntoBranches(self, commit):
         branches = {}
         fnum = 0
         while "depotFile%s" % fnum in commit:
-            path =  commit["depotFile%s" % fnum]
+            raw_path = commit["depotFile%s" % fnum]
+            path = decode_path(raw_path)
             found = self.isPathWanted(path)
             if not found:
                 fnum = fnum + 1
                 continue
 
             file = {}
-            file["path"] = path
+            file["path"] = raw_path
             file["rev"] = commit["rev%s" % fnum]
             file["action"] = commit["action%s" % fnum]
             file["type"] = commit["type%s" % fnum]
@@ -2746,7 +2765,7 @@ def splitFilesIntoBranches(self, commit):
             # start with the full relative path where this file would
             # go in a p4 client
             if self.useClientSpec:
-                relPath = self.clientSpecDirs.map_in_client(path)
+                relPath = decode_path(self.clientSpecDirs.map_in_client(path))
             else:
                 relPath = self.stripRepoPath(path, self.depotPaths)
 
@@ -2784,14 +2803,15 @@ def encodeWithUTF8(self, path):
     # - helper for streamP4Files
 
     def streamOneP4File(self, file, contents):
-        relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
-        relPath = self.encodeWithUTF8(relPath)
+        file_path = file['depotFile']
+        relPath = self.stripRepoPath(decode_path(file_path), self.branchPrefixes)
+
         if verbose:
             if 'fileSize' in self.stream_file:
                 size = int(self.stream_file['fileSize'])
             else:
                 size = 0 # deleted files don't get a fileSize apparently
-            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size/1024/1024))
+            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file_path, relPath, size/1024/1024))
             sys.stdout.flush()
 
         (type_base, type_mods) = split_p4_type(file["type"])
@@ -2809,7 +2829,7 @@ def streamOneP4File(self, file, contents):
                 # to nothing.  This causes p4 errors when checking out such
                 # a change, and errors here too.  Work around it by ignoring
                 # the bad symlink; hopefully a future change fixes it.
-                print("\nIgnoring empty symlink in %s" % file['depotFile'])
+                print("\nIgnoring empty symlink in %s" % file_path)
                 return
             elif data[-1] == '\n':
                 contents = [data[:-1]]
@@ -2828,7 +2848,7 @@ def streamOneP4File(self, file, contents):
             # just the native "NT" type.
             #
             try:
-                text = p4_read_pipe(['print', '-q', '-o', '-', '%s@%s' % (file['depotFile'], file['change'])])
+                text = p4_read_pipe(['print', '-q', '-o', '-', '%s@%s' % (decode_path(file['depotFile']), file['change'])], raw=True)
             except Exception as e:
                 if 'Translation of file content failed' in str(e):
                     type_base = 'binary'
@@ -2836,7 +2856,7 @@ def streamOneP4File(self, file, contents):
                     raise e
             else:
                 if p4_version_string().find('/NT') >= 0:
-                    text = text.replace('\r\n', '\n')
+                    text = text.replace(b'\r\n', b'\n')
                 contents = [ text ]
 
         if type_base == "apple":
@@ -2867,8 +2887,7 @@ def streamOneP4File(self, file, contents):
         self.writeToGitStream(git_mode, relPath, contents)
 
     def streamOneP4Deletion(self, file):
-        relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
-        relPath = self.encodeWithUTF8(relPath)
+        relPath = self.stripRepoPath(decode_path(file['path']), self.branchPrefixes)
         if verbose:
             sys.stdout.write("delete %s\n" % relPath)
             sys.stdout.flush()
@@ -3055,8 +3074,8 @@ def commit(self, details, files, branch, parent = "", allow_empty=False):
         if self.clientSpecDirs:
             self.clientSpecDirs.update_client_spec_path_cache(files)
 
-        files = [f for f in files
-            if self.inClientSpec(f['path']) and self.hasBranchPrefix(f['path'])]
+        files = [f for (f, path) in ((f, decode_path(f['path'])) for f in files)
+            if self.inClientSpec(path) and self.hasBranchPrefix(path)]
 
         if gitConfigBool('git-p4.keepEmptyCommits'):
             allow_empty = True
-- 
2.21.0.windows.1

