Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C6BC432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 01:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4876A20880
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 01:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="K8/J4g39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfK1B3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:29:12 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:34346 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfK1B3K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 20:29:10 -0500
Received: by mail-pj1-f42.google.com with SMTP id bo14so11075579pjb.1
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 17:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oReAEeoBT0m7v3nh92Oi4PY4yB4CzTlkxXMzEGITb9c=;
        b=K8/J4g39b00ACnTZqPXXSs/bUQSrfzI5uw1C29+Y5UR15izAxtWGOTQ3Tx/cA/rJNm
         9MpgUeOLb1MUKFEEv+szo0Zm3upyexb4CAkXdK5S0DVUd+D+tc1YDNRD21G5ejSNr3D2
         eGfNP24DztAsJgZYqmCkF+0ZQ/xTmrfoltS+OcJgSydqUMrcn2W/EhwnxQQPizdgcNdr
         h2cPp6w6zWC5TqGBBzcxdx2w7h+Eqn9yZLCLjITIPHe2ztaU4AirNO2/VbzHpyI13G9L
         h5w+u7aGz2oRkuVOawTamE8k6O2xWwLctidQI6LYgNJdv716DrJHt/klO7XONjpWoGDo
         9fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oReAEeoBT0m7v3nh92Oi4PY4yB4CzTlkxXMzEGITb9c=;
        b=ffhpepKu2Six6/UTuWZ63fzpWeDCpcZXbpLP1x+UVWwyJxJw/YNJ6xNC2DqrYup7lF
         qE+E47YS0PNcUdGBzWXFJIg61aZaMePbJoEN1zmZnxCJ39wkjZB4Dqu5C/Ws24iAaiT1
         2ladGB1hLyuvR3wKkc7NIDFn9TN4V0TDaXC0i3eYEIZKUgy39mk2b2KasEW+6agTObg1
         bkUJdTmNHZtVQNO4V3ryM+A/90+HveYnem5MnuX99HKKno0iBFOjn65+NteR7zxM4so2
         CZbxDZFGq5f1NHap4+7MRWYkYIi+s6/cFAq4Hi7XHp+zjyVxitpXmuxghSjolXTBGqgz
         svKA==
X-Gm-Message-State: APjAAAU84Uw6u5Rk9Z0SO2haSHGJKl3FGMVFSnhyye9X5FQgeUJYJNYH
        fITKPrH2mhAuK+2O9D5zwNzlEZllPXDBRA==
X-Google-Smtp-Source: APXvYqx99v08dcJZ7sEgFKZYrh1zh2r3FkrvMHhOvbk6cPisnYhZxpRqywocxDm0vdq0G8UJZuzCwA==
X-Received: by 2002:a17:902:9a49:: with SMTP id x9mr6980000plv.331.1574904549449;
        Wed, 27 Nov 2019 17:29:09 -0800 (PST)
Received: from SBL-PC-YZHAO.skyboxlabs.local ([184.67.13.114])
        by smtp.gmail.com with ESMTPSA id w15sm17507215pfn.13.2019.11.27.17.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 17:29:08 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [RFC PATCH 4/4] git-p4: use utf-8 encoding for file paths throughout
Date:   Wed, 27 Nov 2019 17:28:07 -0800
Message-Id: <20191128012807.3103-5-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20191128012807.3103-1-yang.zhao@skyboxlabs.com>
References: <20191128012807.3103-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Try to decode file paths in responses from p4 as soon as possible so
that we are working with unicode string throughout the rest of the flow.
This makes python 3 a lot happier.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
---

This is probably the most risky patch out of the set. It's very likely
that I've neglected to consider certain corner cases with decoding of
path data.

 git-p4.py | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 6821d6aafd..bd693e1404 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -650,11 +650,27 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
             if use_encoded_streams:
                 # Decode unmarshalled dict to use str keys and values, except for:
                 #   - `data` which may contain arbitrary binary data
-                #   - `depotFile` which may contain non-UTF8 encoded text
+                #   - `depotFile` which may contain non-UTF8 encoded text, and is decoded
+                #     according to git-p4.pathEncoding config
                 decoded_entry = {}
                 for key, value in entry.items():
                     key = key.decode()
-                    decoded_entry[key] = value.decode() if not (key in ['data', 'depotFile'] or isinstance(value, str)) else value
+                    if key == 'data':
+                        pass
+                    elif key == 'depotFile':
+                        try:
+                            value = value.decode('ascii')
+                        except:
+                            encoding = 'utf-8'
+                            if gitConfig('git-p4.pathEncoding'):
+                                encoding = gitConfig('git-p4.pathEncoding')
+                            path = path.decode(encoding, 'replace')
+                            if verbose:
+                                print('Path with non-ASCII characters detected. Used %s to decode: %s ' % (encoding, path))
+                    elif not isinstance(value, str):
+                        value = value.decode()
+
+                    decoded_entry[key] = value
                 entry = decoded_entry
             if skip_info:
                 if 'code' in entry and entry['code'] == 'info':
@@ -2758,24 +2774,11 @@ def writeToGitStream(self, gitMode, relPath, contents):
             self.gitStream.write(d)
         self.gitStream.write('\n')
 
-    def encodeWithUTF8(self, path):
-        try:
-            path.decode('ascii')
-        except:
-            encoding = 'utf8'
-            if gitConfig('git-p4.pathEncoding'):
-                encoding = gitConfig('git-p4.pathEncoding')
-            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
-            if self.verbose:
-                print('Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path))
-        return path
-
     # output one file from the P4 stream
     # - helper for streamP4Files
 
     def streamOneP4File(self, file, contents):
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
-        relPath = self.encodeWithUTF8(relPath)
         if verbose:
             if 'fileSize' in self.stream_file:
                 size = int(self.stream_file['fileSize'])
@@ -2858,7 +2861,6 @@ def streamOneP4File(self, file, contents):
 
     def streamOneP4Deletion(self, file):
         relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
-        relPath = self.encodeWithUTF8(relPath)
         if verbose:
             sys.stdout.write("delete %s\n" % relPath)
             sys.stdout.flush()
-- 
2.24.0.windows.2

