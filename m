From: Jon Seymour <jon.seymour@gmail.com>
Subject: [v4 1/2] Add a test to check that git ls-tree sets non-zero exit code on error.
Date: Tue, 26 Jul 2011 08:03:10 +1000
Message-ID: <1311631391-12842-2-git-send-email-jon.seymour@gmail.com>
References: <1311631391-12842-1-git-send-email-jon.seymour@gmail.com>
Cc: Jens.Lehmann@web.de, pclouds@gmail.com, schwab@linux-m68k.org,
	gitster@pobox.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 00:04:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlTFc-0007lq-Tq
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 00:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519Ab1GYWDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 18:03:45 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:64333 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab1GYWDn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 18:03:43 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so9174086pzk.1
        for <git@vger.kernel.org>; Mon, 25 Jul 2011 15:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1VG+MwMn5m1t/BcDt9ypoFEwyDuzorlsOERoH27bDbo=;
        b=cIyE3cE+XfTQAEZo373ZREah77yQigCOzGzEhmXD9+lWwBmzXFmU9XmdiocA1ja+QS
         msQVDjLV8bss8WZFx/aIx0GhO731xLJ+4PW6/VSW3U49OGx5PAzR619/PSFPUEvIUljZ
         7B6160zYB5SYw7vz6PkRPkEbwmyW1KedI91XY=
Received: by 10.68.25.6 with SMTP id y6mr331122pbf.473.1311631422873;
        Mon, 25 Jul 2011 15:03:42 -0700 (PDT)
Received: from localhost.localdomain ([120.17.170.52])
        by mx.google.com with ESMTPS id d1sm4966401pbj.88.2011.07.25.15.03.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jul 2011 15:03:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g8394c
In-Reply-To: <1311631391-12842-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177826>

Expected to fail at this commit, fixed by subsequent commit.

Additional tests of adhoc or uncategorised nature should be added to this
file.

Improved-by: Jens Lehmann <Jens.Lehmann@web.de>
Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t3103-ls-tree-misc.sh |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100755 t/t3103-ls-tree-misc.sh

diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
new file mode 100755
index 0000000..c9c20f9
--- /dev/null
+++ b/t/t3103-ls-tree-misc.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+test_description='
+Miscellaneous tests for git ls-tree.
+
+	      1. git ls-tree fails in presence of tree damage.
+
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir a &&
+	touch a/one &&
+	git add a/one &&
+	git commit -m test
+'
+
+test_expect_failure 'ls-tree fails with non-zero exit code on broken tree' '
+	rm -f .git/objects/5f/cffbd6e4c5c5b8d81f5e9314b20e338e3ffff5 &&
+	test_must_fail git ls-tree -r HEAD
+'
+
+test_done
-- 
1.7.6.347.g8394c
