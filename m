Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189A0C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F234D22527
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="N08wuF2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfLMXx0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:53:26 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:40656 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfLMXxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 18:53:25 -0500
Received: by mail-pl1-f172.google.com with SMTP id g6so1883010plp.7
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 15:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a4Lo37diy/qv5OQQYgH1+e/IZeMp2Ts13inSK6KPdzc=;
        b=N08wuF2C2m+jBHEqvXAdimPEDx768SatkZpMIT6JtqI2OvWOhgG9K/paE7o4mzK4m5
         IKRc+mJdKIdGExwP70FYN70igPkamZMlEvBuv9JoboJSDq4ey1dzZR9GhnsnhRBFUbjH
         h5q5VKfS6rUJXPUS3AeGK12Zygs0xjICVhhZmb/1XRs1bGoeAKgrRqE6UvvHGdCbke6g
         2K2pCc1nmnHQ4XUzD8PmUg9xxJ6UPjOKMBZuddmJt3QUOAx0Zl0ziAHSj+/9UKqmJheF
         cJh9NA0w+Cc8dMidyEBHCm5CaQVfZ8D3vOqSZHKdz/YG7lcLuhnE6g0grjcKX/YWbonb
         sQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a4Lo37diy/qv5OQQYgH1+e/IZeMp2Ts13inSK6KPdzc=;
        b=QdkiN8QcI0WeUcTnTXgF3MP1oGNKAVRdbewpHOx1D5Tm//XYY4L+Q/uzhfx9/zYdXy
         0gH7uV00T5YFqLQOAGc0c1ivVPjbEiF/nFMJq+ylF7o5KgyE4rcGOKi3Vhn2e91H3K8g
         QlPaevq1DfMmBumCOoSmMlYnWTKqYQHK/1lY8zUgvNvroetgxb5OGJ6l0BtUhz/pNjkC
         mTLb/Fjv9UYlJR1KBDevH3OjHKtH1R6tafeRgac3PevuUNXfCiEavu1/RdInZeAHxXG5
         uSIAklOyBeX5u4pzXVsBq8oGS37eOgMEnZOB6ui9/QvccxyiFCNnz3OaRYPuBNtXrGNH
         0iRQ==
X-Gm-Message-State: APjAAAX42UiGxklkUO+XbVuWXexIv96ZOZXB4R1PqFyH0MphhyBGGSHW
        ReZUwTjxVqEwVgk5NjHfG2X/puiXVWylzCLI
X-Google-Smtp-Source: APXvYqxpsOZ/IWnJ3WRj87ah1hqmwNN2Ei2AEX1jo1qrhFpOVt09Y7j1cfHpe1vJNg9BC1akAcVYvw==
X-Received: by 2002:a17:902:8688:: with SMTP id g8mr2351304plo.132.1576281204470;
        Fri, 13 Dec 2019 15:53:24 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id r2sm11926036pgv.16.2019.12.13.15.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 15:53:23 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>, luke@diamand.org,
        liu.denton@gmail.com, seraphire@gmail.com
Subject: [PATCH v2 05/14] git-p4: encode/decode communication with git for python3
Date:   Fri, 13 Dec 2019 15:52:39 -0800
Message-Id: <20191213235247.23660-7-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
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
Reviewed-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index ca891e3d5d..d62fb05989 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -183,10 +183,12 @@ def read_pipe_full(c):
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
@@ -194,6 +196,8 @@ def read_pipe(c, ignore_error=False):
             out = ""
         else:
             die('Command failed: %s\nError: %s' % (str(c), err))
+    if not raw:
+        out = decode_text_stream(out)
     return out
 
 def read_pipe_text(c):
@@ -220,7 +224,6 @@ def read_pipe_lines(c):
     val = [decode_text_stream(line) for line in pipe.readlines()]
     if pipe.close() or p.wait():
         die('Command failed: %s' % str(c))
-
     return val
 
 def p4_read_pipe_lines(c):
@@ -616,7 +619,8 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
             stdin_file.write(stdin)
         else:
             for i in stdin:
-                stdin_file.write(i + '\n')
+                stdin_file.write(encode_text_stream(i))
+                stdin_file.write(b'\n')
         stdin_file.flush()
         stdin_file.seek(0)
 
@@ -1245,7 +1249,7 @@ def generatePointer(self, contentFile):
             ['git', 'lfs', 'pointer', '--file=' + contentFile],
             stdout=subprocess.PIPE
         )
-        pointerFile = pointerProcess.stdout.read()
+        pointerFile = decode_text_stream(pointerProcess.stdout.read())
         if pointerProcess.wait():
             os.remove(contentFile)
             die('git-lfs pointer command failed. Did you install the extension?')
@@ -3538,6 +3542,15 @@ def openStreams(self):
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

