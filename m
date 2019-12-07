Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86419C2D0C1
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB53205ED
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="W3Wu8vzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfLGAdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:33:53 -0500
Received: from mail-pf1-f182.google.com ([209.85.210.182]:41041 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfLGAdu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 19:33:50 -0500
Received: by mail-pf1-f182.google.com with SMTP id s18so4184621pfd.8
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 16:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KhQ1YTQyFSHt1kjeeSmimqG1rGO2PgRR7vaP9hAVFGI=;
        b=W3Wu8vzjsQwodwx/+K+/a9q43hN+HRJElZJbR1rO6bGs4WXB0/fDewBlOoyxhqdNsb
         gKHJkMPTXolLZUrw8JpcQYiMD1BTxj/yZ3fBLqMgZlp1aFBUx2eUB1FZlTIXs3Tfhcuj
         5iA8HPIS2UckKSi2Rx7Yjep52FKXIbKQ0t3nsOYeurgAIXuphgNADJc7t+7QMwpNMvMJ
         RWNxMMA3cWugjozAs0UXcnv+KKpWJYEnOrcS/EVmQJkaxL51niPxdaHmVdgicV6C5Tzy
         H3GiASNjTyxa7lK4N5xbtRDLC0qX2JNU8+WtEDQ2QSafT6aMewQEAHn9CwjXJ+fpz/9O
         weLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KhQ1YTQyFSHt1kjeeSmimqG1rGO2PgRR7vaP9hAVFGI=;
        b=YXQI/LCkpS32ptSLulhdx6W3huWeqqlPtoAiQeFpPD7jgtLivhMk0eXk+R0sYIXkiR
         lMq94hnyQCj+YbAu3rv6eJxfVN2ImSS71Mk/oCnRbgU16XMrv5XlEI5xi4BQI2yBeOAc
         vEOcey+jTYxt8GD5MVjw6NRuh8vdqfisoqOsTd2Xmw8rc9/QikQafXXrGbCwWeStwPxn
         VQpNoUn2QYLzxWa4SlZyvHiI4mHTYCuokei4gSULpiQi4IS+oG12mNbU0whjrZ2RahIC
         VzRgEzhfMxUOqXV/CG961+W89EwGpL1E7syk6sozGOj3N3hpOsf+ODmw4lKl1Vjj9a6W
         uAoA==
X-Gm-Message-State: APjAAAXvuEaNdmPTIj26BkOEj8sgd+Fjvnd/dVcu7BvaQCrDjGZk68EQ
        iA/8YX2FP5Km9jN6Msw59q404rGZhMEd5w==
X-Google-Smtp-Source: APXvYqw+yhYbg+6qXkZsYwL3hBMGrlXTN9WnxWtcMavMZg4pz3Z4zVzl2CKRPtNtTEH9RwHdfF0+7A==
X-Received: by 2002:a63:b64a:: with SMTP id v10mr6694048pgt.145.1575678829481;
        Fri, 06 Dec 2019 16:33:49 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id b21sm18708949pfp.0.2019.12.06.16.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 16:33:48 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [PATCH 05/13] git-p4: properly encode/decode communication with git for python 3
Date:   Fri,  6 Dec 2019 16:33:23 -0800
Message-Id: <20191207003333.3228-6-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Under python3, calls to write() on the stream to `git fast-import` must
be encoded.  This patch wraps the IO object such that this encoding is
done transparently.

Conversely, any text data read from subprocesses must also be decoded
before running through the rest of the pipeline.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
---
 git-p4.py | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 6720c7b24a..fefa716b17 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -201,10 +201,12 @@ def read_pipe_full(c):
     (out, err) = p.communicate()
     return (p.returncode, out, decode_text_stream(err))
 
-def read_pipe(c, ignore_error=False):
+def read_pipe(c, ignore_error=False, raw=False):
     """ Read output from  command. Returns the output text on
         success. On failure, terminates execution, unless
         ignore_error is True, when it returns an empty string.
+
+        If raw is True, do not attempt to decode output text.
     """
     (retcode, out, err) = read_pipe_full(c)
     if retcode != 0:
@@ -212,6 +214,8 @@ def read_pipe(c, ignore_error=False):
             out = ""
         else:
             die('Command failed: %s\nError: %s' % (str(c), err))
+    if not raw:
+        out = decode_text_stream(out)
     return out
 
 def read_pipe_text(c):
@@ -238,7 +242,6 @@ def read_pipe_lines(c):
     val = [decode_text_stream(line) for line in pipe.readlines()]
     if pipe.close() or p.wait():
         die('Command failed: %s' % str(c))
-
     return val
 
 def p4_read_pipe_lines(c):
@@ -634,7 +637,8 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
             stdin_file.write(stdin)
         else:
             for i in stdin:
-                stdin_file.write(i + '\n')
+                stdin_file.write(encode_text_stream(i))
+                stdin_file.write(b'\n')
         stdin_file.flush()
         stdin_file.seek(0)
 
@@ -3556,6 +3560,15 @@ def openStreams(self):
         self.gitStream = self.importProcess.stdin
         self.gitError = self.importProcess.stderr
 
+        if bytes is not str:
+            # Wrap gitStream.write() so that it can be called using `str` arguments
+            def make_encoded_write(write):
+                def encoded_write(s):
+                    return write(s.encode() if isinstance(s, str) else s)
+                return encoded_write
+
+            self.gitStream.write = make_encoded_write(self.gitStream.write)
+
     def closeStreams(self):
         self.gitStream.close()
         if self.importProcess.wait() != 0:
-- 
2.21.0.windows.1

