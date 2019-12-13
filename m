Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B25CC2D0C9
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54625206EE
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="diq3zjuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfLMXxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:53:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42543 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfLMXxc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 18:53:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id 4so2286891pfz.9
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 15:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=34T1a/IEmgMUS4B/nrxuttRxXmASlCVG0uMyRUBcR7I=;
        b=diq3zjuogGJE8egaMWF1eYiXU9cba8a1QAOy6XoI7GAls+yraNqk8fKN/wQ44cJfFk
         PZTYqcrpTuFFiF8qEIraRkMu5jAGIV250jWsLY5entXlfGT6cgSSdL0WYjVT/SaJfCc3
         DFYzrH7tRly0/JWWA569LluRCjws2fp/6gsLbhUpDjFl1M508lPmiEdZd4l3Suxdjbbm
         lfMcb+T6NQqad46Ou6abWm2u4G6xmU4IcxFSAA51bqTHmfs9AcXJ5Kqkzn2nx+WXlmpo
         Y0YtIOVX8PmEpsPUnXS5n/QR60oWjPNN9aBN708sFRP9VhFRJEqoxkeKxqNOrLf34/H/
         kXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=34T1a/IEmgMUS4B/nrxuttRxXmASlCVG0uMyRUBcR7I=;
        b=nZ1QfglmSM3c9ZFIRw0+Z+GPm1jH93RCXtokdiodFJkZLIDV9HX6/4YDUU5XQ9rI5R
         FII2+ztf65wKeyfKDBTTWMw9rbBWbLPei7ojef+hb0D95YMFIP6nZrycBoCimcPMIUSs
         UvpDXjWFfac7+1JeoU0WFnaPS5fwf2fJM4lwuhAebPasUFBud0tJgxQHjr4vTYf0Fbv1
         0Iz10ZmPTrWjFRf+6rf8a1AN12+A1TCIPRo8JG9A3mPlu1BXqPtSlGzo5yzBHJdRM2yc
         fVnd32FxbwMSKfTGiqvC901EVkYaA3ZZLaRIDi7+KwELcpv4RFItZ/sLHvM0KN848ql7
         1c3A==
X-Gm-Message-State: APjAAAWzTmo1ulEdFHsQ6gVYesoi3AwcIfY8ATYX+Qf0Womuvh7b4mwt
        rgCb5e0tcuGfkmLQKwDufWOFP8g3MILXdxVa
X-Google-Smtp-Source: APXvYqxBEBF6co8Hh6NA10xHg5utwrHXcUu3P3PYUw9BNw50nqXmNVFn2kdbl1ho88WsUfBw3GDmdw==
X-Received: by 2002:a63:5442:: with SMTP id e2mr2412657pgm.18.1576281211931;
        Fri, 13 Dec 2019 15:53:31 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id r2sm11926036pgv.16.2019.12.13.15.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 15:53:31 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>, luke@diamand.org,
        liu.denton@gmail.com, seraphire@gmail.com
Subject: [PATCH v2 12/14] git-p4: simplify regex pattern generation for parsing diff-tree
Date:   Fri, 13 Dec 2019 15:52:46 -0800
Message-Id: <20191213235247.23660-14-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is not clear why a generator was used to create the regex used to
parse git-diff-tree output; I assume an early implementation required
it, but is not part of the mainline change.

Simply use a lazily initialized global instead.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
Reviewed-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index b7e31d4738..3af8df9f83 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -544,12 +544,7 @@ def getGitTags():
         gitTags.add(tag)
     return gitTags
 
-def diffTreePattern():
-    # This is a simple generator for the diff tree regex pattern. This could be
-    # a class variable if this and parseDiffTreeEntry were a part of a class.
-    pattern = re.compile(':(\d+) (\d+) (\w+) (\w+) ([A-Z])(\d+)?\t(.*?)((\t(.*))|$)')
-    while True:
-        yield pattern
+_diff_tree_pattern = None
 
 def parseDiffTreeEntry(entry):
     """Parses a single diff tree entry into its component elements.
@@ -570,7 +565,11 @@ def parseDiffTreeEntry(entry):
 
     If the pattern is not matched, None is returned."""
 
-    match = diffTreePattern().next().match(entry)
+    global _diff_tree_pattern
+    if not _diff_tree_pattern:
+        _diff_tree_pattern = re.compile(':(\d+) (\d+) (\w+) (\w+) ([A-Z])(\d+)?\t(.*?)((\t(.*))|$)')
+
+    match = _diff_tree_pattern.match(entry)
     if match:
         return {
             'src_mode': match.group(1),
-- 
2.21.0.windows.1

