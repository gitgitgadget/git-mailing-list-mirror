Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80576C2D0C5
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA4D217BA
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsJZA5Oy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfLGRsG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:48:06 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:51304 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfLGRr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 12:47:56 -0500
Received: by mail-wm1-f42.google.com with SMTP id g206so11158851wme.1
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 09:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fqOeCHbhS1rw+kBmqBgQZVR8txMGwT35WxogXmqsgMQ=;
        b=nsJZA5Oy9ut5LR17zV4VjYfTR5Iu+yHt1h7bD2Up0A1Px65+hTxKTWqFKwchcxBaJi
         XYCNQJokSiqlVtgdIz9qIEpL4u4E3nCdv9IJ4Nw5a82VQm65OXiJVkKPaN2yHAS8lRGT
         xajgJptqevvHIz68wlj1tQcWB2ZfzAitcNyKDHPAt7HIIqNltzEopte6l51MG52Xxck8
         lnX66RCKO7oXNsD+Cnbbl9MgAAC7xohmpIvxA+jmP4zbLM9EVKxc1ca5aq1WXkTsHm6b
         TNlGJqrlrF0/qVQpoRn+kYlb/OshAMCikmokkAezsxo0zfT6Smnhd9cR8ObvgtX35rMH
         K5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fqOeCHbhS1rw+kBmqBgQZVR8txMGwT35WxogXmqsgMQ=;
        b=CpuE/LR4MQqlNSdo/xWWCyl/VFFiAlF8j1b3o1O4aHbxAEsGK1lCXRxDlrkwAB5rGM
         GMgNCb7Beulx/AM+H8f+LeVKdAG7s2tHHQG0Fytk5cEE4qwD2eP2ctHd891EJ9Gedk0r
         iIroSN0d6o9LjFnL7ScAtAwPnJXfZwgZlQ6siH44e6YbJTdDBG29VeumVBWNeCx6O1eE
         hACduYygwitlN8NLpAqBpB6op370Ax5AXDDOX/PJIuhyFYh33UhbrH8w0vtLK1sZ5fJR
         QfGG+Kf6kfNz0jSwlFPpexR4bpQ3utI7b+/68ZXeepyjYFeHXNEMsEnrIhtWWyiwymiu
         9zDw==
X-Gm-Message-State: APjAAAXwr8r7deoyndCi6Ot4uTORd4cKH+OXK7lx2qHhslXcknHuGbeO
        NM3/vzgCcrSr93ybwhD+DWUj5Min
X-Google-Smtp-Source: APXvYqzMMDCzoCi0C6y2Ki3D8jr6g1Sg9mLyDCIt3ZrtlKs27vlVAHcGtWvZNNNdCMbdP1rsPV8KEg==
X-Received: by 2002:a05:600c:2409:: with SMTP id 9mr15381327wmp.109.1575740873972;
        Sat, 07 Dec 2019 09:47:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3sm20697115wrn.33.2019.12.07.09.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 09:47:53 -0800 (PST)
Message-Id: <e97ac0af8a33bc55c32b96d76136aef106d7b337.1575740863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Dec 2019 17:47:40 +0000
Subject: [PATCH v5 12/15] git-p4: p4CmdList - support Unicode encoding
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

The p4CmdList is a commonly used function in the git-p4 code. It is used
to execute a command in P4 and return the results of the call in a list.

The problem is that p4CmdList takes bytes as the parameter data and
returns bytes in the return list.

Add a new optional parameter to the signature, encode_cmd_output, that
determines if the dictionary values returned in the function output are
treated as bytes or as strings.

Change the code to conditionally pass the output data through the
as_string() function when encode_cmd_output is true. Otherwise the
function should return the data as bytes.

Change the code so that regardless of the setting of encode_cmd_output,
the dictionary keys in the return value will always be encoded with
as_string().

as_string(bytes) is a method defined in this project that treats the
byte data as a string. The word "string" is used because the meaning
varies depending on the version of Python:

  - Python 2: The "bytes" are returned as "str", functionally a No-op.
  - Python 3: The "bytes" are returned as a Unicode string.

The p4CmdList function returns a list of dictionaries that contain
the result of p4 command. If the callback (cb) is defined, the
standard output of the p4 command is redirected.

Data that is passed to the standard input of the P4 process should be
as_bytes() to avoid conversion unicode encoding errors.

as_bytes(text) is a method defined in this project that treats the text
data as a string that should be converted to a byte array (bytes). The
behavior of this function depends on the version of python:

  - Python 2: The "text" is returned as "str", functionally a No-op.
  - Python 3: The "text" is treated as a UTF-8 encoded Unicode string
        and is decoded to bytes.

Additionally, change literal text prior to conversion to be literal
bytes for the code that is evaluating the standard output from the
p4 call.

Add encode_cmd_output to the p4Cmd since this is a helper function that
wraps the behavior of p4CmdList.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 03829f796d..e8f31339e4 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -716,7 +716,23 @@ def isModeExecChanged(src_mode, dst_mode):
     return isModeExec(src_mode) != isModeExec(dst_mode)
 
 def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
-        errors_as_exceptions=False):
+        errors_as_exceptions=False, encode_cmd_output=True):
+    """ Executes a P4 command:  'cmd' optionally passing 'stdin' to the command's
+        standard input via a temporary file with 'stdin_mode' mode.
+
+        Output from the command is optionally passed to the callback function 'cb'.
+        If 'cb' is None, the response from the command is parsed into a list
+        of resulting dictionaries. (For each block read from the process pipe.)
+
+        If 'skip_info' is true, information in a block read that has a code type of
+        'info' will be skipped.
+
+        If 'errors_as_exceptions' is set to true (the default is false) the error
+        code returned from the execution will generate an exception.
+
+        If 'encode_cmd_output' is set to true (the default) the data that is returned
+        by this function will be passed through the "as_string" function.
+    """
 
     if not isinstance(cmd, list):
         cmd = "-G " + cmd
@@ -739,7 +755,7 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
             stdin_file.write(stdin)
         else:
             for i in stdin:
-                stdin_file.write(i + '\n')
+                stdin_file.write(as_bytes(i) + b'\n')
         stdin_file.flush()
         stdin_file.seek(0)
 
@@ -753,12 +769,15 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
         while True:
             entry = marshal.load(p4.stdout)
             if skip_info:
-                if 'code' in entry and entry['code'] == 'info':
+                if b'code' in entry and entry[b'code'] == b'info':
                     continue
             if cb is not None:
                 cb(entry)
             else:
-                result.append(entry)
+                out = {}
+                for key, value in entry.items():
+                    out[as_string(key)] = (as_string(value) if encode_cmd_output else value)
+                result.append(out)
     except EOFError:
         pass
     exitCode = p4.wait()
@@ -785,8 +804,9 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
 
     return result
 
-def p4Cmd(cmd):
-    list = p4CmdList(cmd)
+def p4Cmd(cmd, encode_cmd_output=True):
+    """Executes a P4 command and returns the results in a dictionary"""
+    list = p4CmdList(cmd, encode_cmd_output=encode_cmd_output)
     result = {}
     for entry in list:
         result.update(entry)
@@ -1165,7 +1185,7 @@ def getClientSpec():
     """Look at the p4 client spec, create a View() object that contains
        all the mappings, and return it."""
 
-    specList = p4CmdList("client -o")
+    specList = p4CmdList("client -o", encode_cmd_output=False)
     if len(specList) != 1:
         die('Output from "client -o" is %d lines, expecting 1' %
             len(specList))
@@ -2609,7 +2629,7 @@ def update_client_spec_path_cache(self, files):
         if len(fileArgs) == 0:
             return  # All files in cache
 
-        where_result = p4CmdList(["-x", "-", "where"], stdin=fileArgs)
+        where_result = p4CmdList(["-x", "-", "where"], stdin=fileArgs, encode_cmd_output=False)
         for res in where_result:
             if "code" in res and res["code"] == "error":
                 # assume error is "... file(s) not in client view"
-- 
gitgitgadget

