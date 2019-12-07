Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69B3C2BD09
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EA5205ED
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="Uuoqp20c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfLGAeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:34:04 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:43723 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfLGAeB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 19:34:01 -0500
Received: by mail-pj1-f68.google.com with SMTP id g4so3425728pjs.10
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 16:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0cPvVRg3ltl7mKdxuUrHifmSFOZ7d/OAdqtpr6njhWI=;
        b=Uuoqp20chA+cM1ffMs63ZuGyIfhDj0T3WHqMS30sLuj//6ioOsUpmUbVH948cp0De1
         FDtZpwSvSaEsUKg2OHXsjtRlbuCJXMomUe5T0eRJOtr/NIWgajUCZZZux3i64Zm12KTY
         PcEH9kONHFnGsJILNh8lxPSHHv9Kf0InVXXGzqOUJaZJUOIcfY8NvlyfXobPyUB9ykCg
         cUAzVPxjxck3GCRhaqVi70Y+31738NqVWbnlUeq1uMgjLM0St234dOjcqJn1meqD4LhR
         SDljlyq8q+zzGbgo8/7jrz1i2NRYZSKtjU3sVp+xuMyjLBryJQbM3nxVw0QsgE6rAzm/
         VC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0cPvVRg3ltl7mKdxuUrHifmSFOZ7d/OAdqtpr6njhWI=;
        b=U/yJsWaHLnOfpFiQbdGGvgzNjpOYDkt4ZiYBiUzppUbS+HC3CqmLHouhKacfv+u3Is
         rq/FvAzuON6Xk0fx1oHcM8mD2eSkAD6T3lldZYzJlAxikOUBv+vKM03hYvxUu6YAGLIf
         OEzZLRRfo4eyVmk0u7b14z3g13kE8Qo++r4eQWrNOAfoPdz7mweWiR3tR3gBeXEByoeo
         azfV4ms7yjiBpYFhuh9rtRBq+/0EpWEAm0y36cRaeYV3d4S4du4W5Vgo97BHDx6hOeBt
         h9K2rDlJfnQpYHi55rPKQq8DeT6Cluep6LbwBqGX4nRbKc+LPKzV3agPNUYt6T+eyWy4
         nxtg==
X-Gm-Message-State: APjAAAWmKs4QDnRp9EkzdfEUhe+pLiGefQoA8u2RMNTzRt/earp8YWAz
        E5BEcZIJU/CJ90rGGyBYCFTjTk5kK1nTFw==
X-Google-Smtp-Source: APXvYqxaYkJ5mqRuWq9GiB6FiKvJlPYOMIkN0tuNXw+uXehHOnxrD48+BM+JgMyCKofP6HcKJM+ZWA==
X-Received: by 2002:a17:90a:b318:: with SMTP id d24mr17203179pjr.142.1575678840306;
        Fri, 06 Dec 2019 16:34:00 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id b21sm18708949pfp.0.2019.12.06.16.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 16:33:59 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [PATCH 12/13] git-p4: simplify regex pattern generation for parsing diff-tree
Date:   Fri,  6 Dec 2019 16:33:32 -0800
Message-Id: <20191207003333.3228-15-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
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
---
 git-p4.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 867a8d42ef..f975f197a5 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -562,12 +562,7 @@ def getGitTags():
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
@@ -588,7 +583,11 @@ def parseDiffTreeEntry(entry):
 
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

