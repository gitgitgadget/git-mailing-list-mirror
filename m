Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24F6C1FF40
	for <e@80x24.org>; Wed, 22 Jun 2016 05:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbcFVFgE (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 01:36:04 -0400
Received: from zangief.bwidawsk.net ([107.170.211.233]:48000 "EHLO
	mail.bwidawsk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbcFVFgD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 01:36:03 -0400
X-Greylist: delayed 842 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jun 2016 01:36:03 EDT
Received: by mail.bwidawsk.net (Postfix, from userid 5001)
	id D2285122A57; Tue, 21 Jun 2016 22:10:24 -0700 (PDT)
X-Spam-Checker-Version:	SpamAssassin 3.4.1 (2015-04-28) on zangief.bwidawsk.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-1.0 required=4.1 tests=ALL_TRUSTED=-1
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from bolo_yeung.intel.com (c-73-96-96-186.hsd1.or.comcast.net [73.96.96.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.bwidawsk.net (Postfix) with ESMTPSA id 70109122A55;
	Tue, 21 Jun 2016 22:10:20 -0700 (PDT)
From:	Ben Widawsky <ben@bwidawsk.net>
To:	git@vger.kernel.org
Cc:	Ben Widawsky <ben@bwidawsk.net>,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH] git-p4: Fix verbose printing
Date:	Tue, 21 Jun 2016 22:10:15 -0700
Message-Id: <20160622051015.28946-1-ben@bwidawsk.net>
X-Mailer: git-send-email 2.9.0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The current logic seems to invert the error message when using verbose messages.
The inversion seems to be indicated by the caller:
if self.inClientSpec(f['path']) and self.hasBranchPrefix(f['path'])]

This behavior has existed since the original commit:
commit 4ae048e67e5f0d786b9febc438433d95f18e5937
Author: Lars Schneider <larsxschneider@gmail.com>
Date:   Tue Dec 8 10:36:22 2015 +0100

    git-p4: add option to keep empty commits

Note that there are no behavioral changes with this patch since the code did the
right thing, just with the wrong messages.

Cc: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Ben Widawsky <ben@bwidawsk.net>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index b6593cf..b123aa2 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2674,7 +2674,7 @@ class P4Sync(Command, P4UserMap):
             return True
         hasPrefix = [p for p in self.branchPrefixes
                         if p4PathStartsWith(path, p)]
-        if hasPrefix and self.verbose:
+        if not hasPrefix and self.verbose:
             print('Ignoring file outside of prefix: {0}'.format(path))
         return hasPrefix
 
-- 
2.9.0

