Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21A0C3F68F
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D9A206DB
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 22:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvfYXyzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfLDW3v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:29:51 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:38616 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbfLDW3s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 17:29:48 -0500
Received: by mail-wr1-f45.google.com with SMTP id y17so1124158wrh.5
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 14:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=annvhjwxSXPrbFLi5I+ldURL5XncKDANKEh5DqKKyLo=;
        b=gvfYXyzWMD+6Ijr6Yt4945Ch802PaG+FNdNNQz3q78gmEuDJeWeerG6qpKJfvztVLX
         2bLac3kNuDkp0BOGIQqgbjj1AziZ6kn5q+Jzys6gIHkEGTv6TAcbdLx/gQmn7OG/AzIi
         cT2iVrhDcHuzRbV9C4MZMVv6NdVZBEJewhK8SvEduaWIPGgwUXSnVwqcsZS9HR7U/2Mk
         5ESsL6+G2R6s5kAPo/p05XIKi74rsx9tF9h7x3fmUWscsxOX/NbqRwckUNNCBtv2ftX3
         wGzK5Kj5Dc/bv+VpHil6iVljKusWHHJy+JBg7LxbtdtY+BF8V95MpYUWyR/alehCQqmc
         a06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=annvhjwxSXPrbFLi5I+ldURL5XncKDANKEh5DqKKyLo=;
        b=OjN4DHt0OEBJAORgy0mRJTQi4dFx8k4g/A0mxBhi0IEU7GnJ6zUHfoxKSBL2hioOKi
         00AJcnNcnvNbMD8MGFDNxt+wm1CpLPdpyHOuFGiXX7LsiOkvR2cVx9Z5Hjvu18Y+t9GL
         BwTLh7yAqoUuV7QPivDFBctKJ4VaURnHshAI98NDF1LQmWnb2ver4X59UbsW9D6un8ws
         6uT7RDmQNhzkkPNsjDGav8D8mDVjRizwPZbJZQ2IDlV21MD4X6gr4dqUNVlmI9jm/N8r
         cte0mWS0KRJpox2kH2hibqSZkuVNxpJT4QHeOtEiK5GWMEP5671fvk6PgDF/6Y5avC+B
         A3Mw==
X-Gm-Message-State: APjAAAUcqWD7OjGdqTp0Stkz2Fpk7lqHucuW7fYEUhnc6cWPFkG6rHO3
        /BtieLWHJ4ccHG6DAwpoJ6Wjl0UI
X-Google-Smtp-Source: APXvYqwI80Ww5ngxVf9sKwSPCE10j6aUtKDKfoQOY+b6EyjTBnSitr2xWZKUMjOxtTL7SihQXxdLZg==
X-Received: by 2002:adf:9427:: with SMTP id 36mr6627156wrq.166.1575498586052;
        Wed, 04 Dec 2019 14:29:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm9748666wrr.75.2019.12.04.14.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 14:29:45 -0800 (PST)
Message-Id: <e1a424a955071414a634a703a85f1969f968bb0f.1575498578.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
        <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Dec 2019 22:29:34 +0000
Subject: [PATCH v4 08/11] git-p4: p4CmdList  - support Unicode encoding
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

The p4CmdList is a commonly used function in the git-p4 code. It is used to execute a command in P4 and return the results of the call in a list.

Change this code to take a new optional parameter, encode_data that will optionally convert the data AS_STRING() that isto be returned by the function.

Change the code so that the key will always be encoded AS_STRING()

Data that is passed for standard input (stdin) should be AS_BYTES() to ensure unicode text that is supplied will be written out as bytes.

Additionally, change literal text prior to conversion to be literal bytes.

Signed-off-by: Ben Keene <seraphire@gmail.com>
(cherry picked from commit 88306ac269186cbd0f6dc6cfd366b50b28ee4886)
---
 git-p4.py | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0da640be93..f7c0ef0c53 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -711,7 +711,23 @@ def isModeExecChanged(src_mode, dst_mode):
     return isModeExec(src_mode) != isModeExec(dst_mode)
 
 def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
-        errors_as_exceptions=False):
+        errors_as_exceptions=False, encode_data=True):
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
+        If 'encode_data' is set to true (the default) the data that is returned 
+        by this function will be passed through the "as_string" function.
+    """
 
     if not isinstance(cmd, list):
         cmd = "-G " + cmd
@@ -734,7 +750,7 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
             stdin_file.write(stdin)
         else:
             for i in stdin:
-                stdin_file.write(i + '\n')
+                stdin_file.write(as_bytes(i) + b'\n')
         stdin_file.flush()
         stdin_file.seek(0)
 
@@ -748,12 +764,15 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
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
+                    out[as_string(key)] = (as_string(value) if encode_data else value)
+                result.append(out)
     except EOFError:
         pass
     exitCode = p4.wait()
-- 
gitgitgadget

