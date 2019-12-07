Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A17C43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC53421835
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="bLNM1ocq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLGAdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:33:53 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:34518 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfLGAdt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 19:33:49 -0500
Received: by mail-pl1-f182.google.com with SMTP id h13so3419908plr.1
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 16:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9FBp/3+bkK9ifG9OGAMf1ZSZQg355B0N36vipH8avig=;
        b=bLNM1ocq3euJyzBj/HtLtpNdQrJIzLL+U95PEXpHX7xJyaFVA0V240qprJS/mVuYxz
         DcGzVjYv9zUBGeZiiZ80fiOdE6V3G4yq00MR/Y0Xhy1qmAuw8EvIYvJOcLfIQs4wI6hd
         fFNg//zcthNIv/+a2RlVPOgxVwl8JZF2RyOucc1kbAO/zCQnVIQyesKnrTTyrJCFpjTh
         ybqcmPU6ykyzIxgBLW9brBfds1bTgj6z2mRrDfjJAuXf5hyEsRw1DuYOEadj5n4UwNm0
         qTg9xo76OpBPHtbiV7Bqn9L4X8m+kXzc80+HQZGn6uTni/CZwaFx0JB6Z3TiJlVDNmz7
         6MJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9FBp/3+bkK9ifG9OGAMf1ZSZQg355B0N36vipH8avig=;
        b=j3/pr1a1kuIDsdjRdNPMCD/i0HOS4M/+0MXyYjw/rR9sVeW3/FWvJZbKz+xF3dKo9K
         g0eUzsYca8eOlEp1za+PgSUXKQAqCNn7itC87LatCG2nuyD0m5BxzjAVJAtKwULUDd2/
         206WSW0MRPPvicyv8Jz+vw5isBnzar0hQ8LddYv+byHDtOX2lnZPVwHPKN/X/45KLlaR
         K4sYag4qogekAG81HkOTn2lVrNz9uPCySd7ixJvaPd2F7o2dpeHeLkcb4Uz5QcX91IIk
         zcyNv1siwLPEarEOVLryCrOKFqAMko90CDeRZiGonkPIsh3BgwkkEBMAcNxGF8AWyVaO
         3WRA==
X-Gm-Message-State: APjAAAXiFppSpR4aoD1PVJ7txToXmkz+Q9/LC37rZ1Zu8FPmUzro7Zw7
        ssu0aYVpvey4gAyN9sbyGHMuzg9Ij1mCeA==
X-Google-Smtp-Source: APXvYqxB9moN0JJME9aXMYUvaZA9wzYCcMa1OGoGl/q0m4v620bnpIVW3IEpxZU/A+qIv8kbf3HDXg==
X-Received: by 2002:a17:90a:d985:: with SMTP id d5mr17287985pjv.73.1575678828527;
        Fri, 06 Dec 2019 16:33:48 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id b21sm18708949pfp.0.2019.12.06.16.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 16:33:47 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [PATCH 04/13] git-p4: decode response from p4 to str for python3
Date:   Fri,  6 Dec 2019 16:33:22 -0800
Message-Id: <20191207003333.3228-5-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The marshalled dict in the response given on STDOUT by p4 uses `str` for
keys and string values. When run using python3, these values are
deserialized as `bytes`, leading to a whole host of problems as the rest
of the code assumes `str` is used throughout.

This patch changes the deserialization behaviour such that, as much as
possible, text output from p4 is decoded to native unicode strings.
Exceptions are made for the field `data` as it is usually arbitrary
binary data. `depotFile[0-9]*`, `path`, and `clientFile` are also exempt
as they contain path information which may not be UTF-8 encoding
compatible, and must survive round-trip back to p4.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>

SQUASH: use unicode string internally throughout
---
 git-p4.py | 61 ++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index ebeef35a92..6720c7b24a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -157,6 +157,19 @@ def die(msg):
         sys.stderr.write(msg + "\n")
         sys.exit(1)
 
+# We need different encoding/decoding strategies for text data being passed
+# around in pipes depending on python version
+if sys.version_info.major >= 3:
+    def decode_text_stream(s):
+        return s.decode() if isinstance(s, bytes) else s
+    def encode_text_stream(s):
+        return s.encode() if isinstance(s, str) else s
+else:
+    def decode_text_stream(s):
+        return s
+    def encode_text_stream(s):
+        return s.encode('utf_8') if isinstance(s, unicode) else s
+
 def write_pipe(c, stdin):
     if verbose:
         sys.stderr.write('Writing pipe: %s\n' % str(c))
@@ -186,7 +199,7 @@ def read_pipe_full(c):
     expand = isinstance(c,basestring)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=expand)
     (out, err) = p.communicate()
-    return (p.returncode, out, err)
+    return (p.returncode, out, decode_text_stream(err))
 
 def read_pipe(c, ignore_error=False):
     """ Read output from  command. Returns the output text on
@@ -209,11 +222,11 @@ def read_pipe_text(c):
     if retcode != 0:
         return None
     else:
-        return out.rstrip()
+        return decode_text_stream(out).rstrip()
 
-def p4_read_pipe(c, ignore_error=False):
+def p4_read_pipe(c, ignore_error=False, raw=False):
     real_cmd = p4_build_cmd(c)
-    return read_pipe(real_cmd, ignore_error)
+    return read_pipe(real_cmd, ignore_error, raw=raw)
 
 def read_pipe_lines(c):
     if verbose:
@@ -222,7 +235,7 @@ def read_pipe_lines(c):
     expand = isinstance(c, basestring)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
     pipe = p.stdout
-    val = pipe.readlines()
+    val = [decode_text_stream(line) for line in pipe.readlines()]
     if pipe.close() or p.wait():
         die('Command failed: %s' % str(c))
 
@@ -253,6 +266,7 @@ def p4_has_move_command():
     cmd = p4_build_cmd(["move", "-k", "@from", "@to"])
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     (out, err) = p.communicate()
+    err = decode_text_stream(err)
     # return code will be 1 in either case
     if err.find("Invalid option") >= 0:
         return False
@@ -633,6 +647,20 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
     try:
         while True:
             entry = marshal.load(p4.stdout)
+            if bytes is not str:
+                # Decode unmarshalled dict to use str keys and values, except for:
+                #   - `data` which may contain arbitrary binary data
+                #   - `depotFile[0-9]*`, `path`, or `clientFile` which may contain non-UTF8 encoded text
+                decoded_entry = {}
+                for key, value in entry.items():
+                    key = key.decode()
+                    if isinstance(value, bytes) and not (key in ('data', 'path', 'clientFile') or key.startswith('depotFile')):
+                        value = value.decode()
+                    decoded_entry[key] = value
+                # Parse out data if it's an error response
+                if decoded_entry.get('code') == 'error' and 'data' in decoded_entry:
+                    decoded_entry['data'] = decoded_entry['data'].decode()
+                entry = decoded_entry
             if skip_info:
                 if 'code' in entry and entry['code'] == 'info':
                     continue
@@ -850,6 +878,7 @@ def branch_exists(branch):
     cmd = [ "git", "rev-parse", "--symbolic", "--verify", branch ]
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     out, _ = p.communicate()
+    out = decode_text_stream(out)
     if p.returncode:
         return False
     # expect exactly one line of output: the branch name
@@ -1993,7 +2022,7 @@ def applyCommit(self, id):
         tmpFile = os.fdopen(handle, "w+b")
         if self.isWindows:
             submitTemplate = submitTemplate.replace("\n", "\r\n")
-        tmpFile.write(submitTemplate)
+        tmpFile.write(encode_text_stream(submitTemplate))
         tmpFile.close()
 
         if self.prepare_p4_only:
@@ -2040,11 +2069,11 @@ def applyCommit(self, id):
             if self.edit_template(fileName):
                 # read the edited message and submit
                 tmpFile = open(fileName, "rb")
-                message = tmpFile.read()
+                message = decode_text_stream(tmpFile.read())
                 tmpFile.close()
                 if self.isWindows:
                     message = message.replace("\r\n", "\n")
-                submitTemplate = message[:message.index(separatorLine)]
+                submitTemplate = encode_text_stream(message[:message.index(separatorLine)])
 
                 if update_shelve:
                     p4_write_pipe(['shelve', '-r', '-i'], submitTemplate)
@@ -2145,7 +2174,7 @@ def exportGitTags(self, gitTags):
                 print("Not creating p4 label %s for tag due to option" \
                       " --prepare-p4-only" % name)
             else:
-                p4_write_pipe(["label", "-i"], labelTemplate)
+                p4_write_pipe(["label", "-i"], encode_text_stream(labelTemplate))
 
                 # Use the label
                 p4_system(["tag", "-l", name] +
@@ -2469,7 +2498,7 @@ def append(self, view_line):
 
     def convert_client_path(self, clientFile):
         # chop off //client/ part to make it relative
-        if not clientFile.startswith(self.client_prefix):
+        if not decode_path(clientFile).startswith(self.client_prefix):
             die("No prefix '%s' on clientFile '%s'" %
                 (self.client_prefix, clientFile))
         return clientFile[len(self.client_prefix):]
@@ -2729,7 +2758,7 @@ def splitFilesIntoBranches(self, commit):
         return branches
 
     def writeToGitStream(self, gitMode, relPath, contents):
-        self.gitStream.write('M %s inline %s\n' % (gitMode, relPath))
+        self.gitStream.write(encode_text_stream(u'M {} inline {}\n'.format(gitMode, relPath)))
         self.gitStream.write('data %d\n' % sum(len(d) for d in contents))
         for d in contents:
             self.gitStream.write(d)
@@ -2770,7 +2799,7 @@ def streamOneP4File(self, file, contents):
             git_mode = "120000"
             # p4 print on a symlink sometimes contains "target\n";
             # if it does, remove the newline
-            data = ''.join(contents)
+            data = ''.join(decode_text_stream(c) for c in contents)
             if not data:
                 # Some version of p4 allowed creating a symlink that pointed
                 # to nothing.  This causes p4 errors when checking out such
@@ -2824,7 +2853,7 @@ def streamOneP4File(self, file, contents):
         pattern = p4_keywords_regexp_for_type(type_base, type_mods)
         if pattern:
             regexp = re.compile(pattern, re.VERBOSE)
-            text = ''.join(contents)
+            text = ''.join(decode_text_stream(c) for c in contents)
             text = regexp.sub(r'$\1$', text)
             contents = [ text ]
 
@@ -2839,7 +2868,7 @@ def streamOneP4Deletion(self, file):
         if verbose:
             sys.stdout.write("delete %s\n" % relPath)
             sys.stdout.flush()
-        self.gitStream.write("D %s\n" % relPath)
+        self.gitStream.write(encode_text_stream(u'D {}\n'.format(relPath)))
 
         if self.largeFileSystem and self.largeFileSystem.isLargeFile(relPath):
             self.largeFileSystem.removeLargeFile(relPath)
@@ -2939,9 +2968,9 @@ def streamP4FilesCbSelf(entry):
                 if 'shelved_cl' in f:
                     # Handle shelved CLs using the "p4 print file@=N" syntax to print
                     # the contents
-                    fileArg = '%s@=%d' % (f['path'], f['shelved_cl'])
+                    fileArg = f['path'] + encode_text_stream('@={}'.format(f['shelved_cl']))
                 else:
-                    fileArg = '%s#%s' % (f['path'], f['rev'])
+                    fileArg = f['path'] + encode_text_stream('#{}'.format(f['rev']))
 
                 fileArgs.append(fileArg)
 
-- 
2.21.0.windows.1

