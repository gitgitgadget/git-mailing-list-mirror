Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62391C00454
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF33206EE
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="a5HdgvMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfLMXxZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:53:25 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39274 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMXxY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 18:53:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id z3so358909plk.6
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 15:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tvfWooet+YCIrq4gMPJWJqSVZ9mojouy3CgJCq/Kix0=;
        b=a5HdgvMxqBNVWb4T1VvSrjUeD/ifDxd/9rsyywNsiM1CfL3qenrjjY3y7juLnDMeSC
         m3dl6WqvXk06WaJJM0CPCUVb350bx+WlkCskFA6y/vo+R+6FEo1FrEYPlEiggTIZtmTP
         cxr+nrnoBW/peiAY8j1Gf0KYDwMMZQHOut7YiVnLVKKP7OuVAeTBG4bnYa40aIhWObwv
         t03u1MmzGkFVlMaAvvGn+I+QYQitQGq/vo8hXjpq0EPBlLt+LRnxSUZkHld+2JZsO43k
         ygu9SmFdPmYR3+mPBBCrMM5w/g1BIs/DNcphnMPC7yATFZbxi2tAWnJzjakJVRZTfSgM
         qwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tvfWooet+YCIrq4gMPJWJqSVZ9mojouy3CgJCq/Kix0=;
        b=c3pvQBffetTvArdS/gCiInE2WSPU/W3RGNw+WL/cNjkWT551DPoSQpa0SnG5qPFj4t
         4cEokrdJwnbPrg524syRUh9g/p3ibgP/l9IA2q1/NEd6n1QafJsrEQZ6DNlHxwyHFtZN
         NQHYtFpNT85UNU5RXFE5msiImX5tui3RvmQPLDLDKvRRT8YCbHpUEY01QKySEQp0Ffx7
         Q7CMo/1MRScx2ZtB1rIIUthS5Pi1l2Nm3s9Q1Cw1TovkHzKTwda2Yx3cUb1AzIXWAJrT
         sNR7Qji+59t3XDPswR0iwsqiJDuiEJLD5plp5iSflYXiXfpEOe1sO8HDBeCTSX4MmXkb
         waIQ==
X-Gm-Message-State: APjAAAXWzuPdBw3h8t9zF9euIm3a6BfNIYSJPzhG/Mr7PD9feAQzO1DJ
        4rJhQYQop7MbGXCv0F9wZN7QQFWWkUI99J0q
X-Google-Smtp-Source: APXvYqx/nGuWolvvc7AwEzymTm29X/3Tb8g1RTTSQXqm1yxZdDTIkfvqZMvRZpBWYM8r8erMC5Ondg==
X-Received: by 2002:a17:902:7c88:: with SMTP id y8mr2322667pll.104.1576281203346;
        Fri, 13 Dec 2019 15:53:23 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id r2sm11926036pgv.16.2019.12.13.15.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 15:53:22 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>, luke@diamand.org,
        liu.denton@gmail.com, seraphire@gmail.com
Subject: [PATCH v2 04/14] git-p4: encode/decode communication with p4 for python3
Date:   Fri, 13 Dec 2019 15:52:38 -0800
Message-Id: <20191213235247.23660-6-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
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
as they contain path strings not encoded with UTF-8, and must survive
survive round-trip back to p4.

Conversely, text data being piped to p4 must always be encoded when
running under python3.

encode_text_stream() and decode_text_stream() were added to make these
transformations more convenient.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
---
 git-p4.py | 59 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 153aff16f3..ca891e3d5d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -135,6 +135,21 @@ def die(msg):
         sys.stderr.write(msg + "\n")
         sys.exit(1)
 
+# We need different encoding/decoding strategies for text data being passed
+# around in pipes depending on python version
+if bytes is not str:
+    # For python3, always encode and decode as appropriate
+    def decode_text_stream(s):
+        return s.decode() if isinstance(s, bytes) else s
+    def encode_text_stream(s):
+        return s.encode() if isinstance(s, str) else s
+else:
+    # For python2.7, pass read strings as-is, but also allow writing unicode
+    def decode_text_stream(s):
+        return s
+    def encode_text_stream(s):
+        return s.encode('utf_8') if isinstance(s, unicode) else s
+
 def write_pipe(c, stdin):
     if verbose:
         sys.stderr.write('Writing pipe: %s\n' % str(c))
@@ -151,6 +166,8 @@ def write_pipe(c, stdin):
 
 def p4_write_pipe(c, stdin):
     real_cmd = p4_build_cmd(c)
+    if bytes is not str and isinstance(stdin, str):
+        stdin = encode_text_stream(stdin)
     return write_pipe(real_cmd, stdin)
 
 def read_pipe_full(c):
@@ -164,7 +181,7 @@ def read_pipe_full(c):
     expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=expand)
     (out, err) = p.communicate()
-    return (p.returncode, out, err)
+    return (p.returncode, out, decode_text_stream(err))
 
 def read_pipe(c, ignore_error=False):
     """ Read output from  command. Returns the output text on
@@ -187,11 +204,11 @@ def read_pipe_text(c):
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
@@ -200,7 +217,7 @@ def read_pipe_lines(c):
     expand = not isinstance(c, list)
     p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
     pipe = p.stdout
-    val = pipe.readlines()
+    val = [decode_text_stream(line) for line in pipe.readlines()]
     if pipe.close() or p.wait():
         die('Command failed: %s' % str(c))
 
@@ -231,6 +248,7 @@ def p4_has_move_command():
     cmd = p4_build_cmd(["move", "-k", "@from", "@to"])
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     (out, err) = p.communicate()
+    err = decode_text_stream(err)
     # return code will be 1 in either case
     if err.find("Invalid option") >= 0:
         return False
@@ -611,6 +629,20 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
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
@@ -828,6 +860,7 @@ def branch_exists(branch):
     cmd = [ "git", "rev-parse", "--symbolic", "--verify", branch ]
     p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
     out, _ = p.communicate()
+    out = decode_text_stream(out)
     if p.returncode:
         return False
     # expect exactly one line of output: the branch name
@@ -1971,7 +2004,7 @@ def applyCommit(self, id):
         tmpFile = os.fdopen(handle, "w+b")
         if self.isWindows:
             submitTemplate = submitTemplate.replace("\n", "\r\n")
-        tmpFile.write(submitTemplate)
+        tmpFile.write(encode_text_stream(submitTemplate))
         tmpFile.close()
 
         if self.prepare_p4_only:
@@ -2018,7 +2051,7 @@ def applyCommit(self, id):
             if self.edit_template(fileName):
                 # read the edited message and submit
                 tmpFile = open(fileName, "rb")
-                message = tmpFile.read()
+                message = decode_text_stream(tmpFile.read())
                 tmpFile.close()
                 if self.isWindows:
                     message = message.replace("\r\n", "\n")
@@ -2707,7 +2740,7 @@ def splitFilesIntoBranches(self, commit):
         return branches
 
     def writeToGitStream(self, gitMode, relPath, contents):
-        self.gitStream.write('M %s inline %s\n' % (gitMode, relPath))
+        self.gitStream.write(encode_text_stream(u'M {} inline {}\n'.format(gitMode, relPath)))
         self.gitStream.write('data %d\n' % sum(len(d) for d in contents))
         for d in contents:
             self.gitStream.write(d)
@@ -2748,7 +2781,7 @@ def streamOneP4File(self, file, contents):
             git_mode = "120000"
             # p4 print on a symlink sometimes contains "target\n";
             # if it does, remove the newline
-            data = ''.join(contents)
+            data = ''.join(decode_text_stream(c) for c in contents)
             if not data:
                 # Some version of p4 allowed creating a symlink that pointed
                 # to nothing.  This causes p4 errors when checking out such
@@ -2802,7 +2835,7 @@ def streamOneP4File(self, file, contents):
         pattern = p4_keywords_regexp_for_type(type_base, type_mods)
         if pattern:
             regexp = re.compile(pattern, re.VERBOSE)
-            text = ''.join(contents)
+            text = ''.join(decode_text_stream(c) for c in contents)
             text = regexp.sub(r'$\1$', text)
             contents = [ text ]
 
@@ -2817,7 +2850,7 @@ def streamOneP4Deletion(self, file):
         if verbose:
             sys.stdout.write("delete %s\n" % relPath)
             sys.stdout.flush()
-        self.gitStream.write("D %s\n" % relPath)
+        self.gitStream.write(encode_text_stream(u'D {}\n'.format(relPath)))
 
         if self.largeFileSystem and self.largeFileSystem.isLargeFile(relPath):
             self.largeFileSystem.removeLargeFile(relPath)
@@ -2917,9 +2950,9 @@ def streamP4FilesCbSelf(entry):
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

