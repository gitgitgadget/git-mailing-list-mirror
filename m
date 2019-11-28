Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BC0C432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 01:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0883208E4
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 01:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="Zjbz8/CB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfK1B3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:29:08 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:45042 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbfK1B3I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 20:29:08 -0500
Received: by mail-pl1-f173.google.com with SMTP id az9so10798343plb.11
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 17:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wZnaiYekNG2qVXBlJ0+Ui2ty5/7tzQtiW/cndr7jrgM=;
        b=Zjbz8/CBeMxMAMfJReryXtLS6d/g3BeAf5tznSP9iyitDCUFXZ041wd924e0sq76Y4
         rc9ZXqQyKbhTWvCVFI7YpCj4vO/+Z0ISyQZs4LqOkbhKuL517VjgifT/R9mpEk/QnTSi
         oyyWCm9XdHN4Z3//Ms+GTvccVkbC/K/kCL8D88teORrbmIcbcxoYzvm3uE0lRTzqJuCC
         mtTSz2vbx/EdX0ha/+8zJMNNhoH/MdBByr4JEg7F+bWXiSuV4fShkl8gHnNn0BIo7GTp
         DFzCqLqaAl5JAqYKlo0m5asc+yzOEqNMfeBewcacmqcSsZBh6GwB47RVxoDW5EbWf/uV
         oxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wZnaiYekNG2qVXBlJ0+Ui2ty5/7tzQtiW/cndr7jrgM=;
        b=CrSw5R9TUdi+xWhnZusJRR9O7LsTC+QOvtQMqyU31oebygK8be3b0AAXR2GoGSkoZO
         +twNy4NgFU5H3iyAVrt01rsO+3ws4t2OiKD5JSISC21myLSr1bqzrze2sAdemFvi7h7v
         c0xmzOmTiaKB/c3vh2HEgqGR2e39CISGQdqwIZM3vCDz1sFcr5VWhw+Azow1ESNk6/D2
         h1CEA6zaCftwLh6XOSFPWH7mpwd5KQPB3DCeosi+/XsVG/YNCohnErzdUxKph4O5VgAS
         SpULZ0kEGu0qblGNZlJZ+dqRr6vKIyWg2Q4AG9e92jvKMzPX97F49mvUJ2egWNH4a6yk
         yhYA==
X-Gm-Message-State: APjAAAXzWW1R+BtEqqL2tAvGeK2bUoCIVlbjHUNBJUW14LLoWKOgeQ7d
        8CrtfK0lDdwE/DnGRc14ljzlEN6yjkmEmg==
X-Google-Smtp-Source: APXvYqwWT3d7n2NklHZiMg02DsrjY91OO/tS1HN2dcBaZWWwwuO3LXX+ocNYWrl5uarEyrZbswvJyA==
X-Received: by 2002:a17:90a:ead5:: with SMTP id ev21mr9703965pjb.76.1574904547311;
        Wed, 27 Nov 2019 17:29:07 -0800 (PST)
Received: from SBL-PC-YZHAO.skyboxlabs.local ([184.67.13.114])
        by smtp.gmail.com with ESMTPSA id w15sm17507215pfn.13.2019.11.27.17.29.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 17:29:06 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [RFC PATCH 2/4] git-p4: properly encode/decode communication with git for python 3
Date:   Wed, 27 Nov 2019 17:28:05 -0800
Message-Id: <20191128012807.3103-3-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20191128012807.3103-1-yang.zhao@skyboxlabs.com>
References: <20191128012807.3103-1-yang.zhao@skyboxlabs.com>
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
 git-p4.py | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index ead9d816e1..d79cbf7005 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -237,6 +237,9 @@ def read_pipe_lines(c):
     if pipe.close() or p.wait():
         die('Command failed: %s' % str(c))
 
+    if use_encoded_streams:
+        val = [line.decode() for line in val]
+
     return val
 
 def p4_read_pipe_lines(c):
@@ -631,7 +634,7 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
             stdin_file.write(stdin)
         else:
             for i in stdin:
-                stdin_file.write(i + '\n')
+                stdin_file.write((i + '\n').encode())
         stdin_file.flush()
         stdin_file.seek(0)
 
@@ -3547,6 +3550,15 @@ def openStreams(self):
         self.gitStream = self.importProcess.stdin
         self.gitError = self.importProcess.stderr
 
+        if use_encoded_streams:
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
2.24.0.windows.2

