From: Pang Yan Han <pangyanhan@gmail.com>
Subject: [PATCH/RFCv2 1/2] format-patch: demonstrate that color.ui=always produces colorized patches
Date: Tue, 13 Sep 2011 01:46:40 +0800
Message-ID: <1315849601-26497-2-git-send-email-pangyanhan@gmail.com>
References: <1315849601-26497-1-git-send-email-pangyanhan@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, martin.von.zweigbergk@gmail.com,
	sdaoden@googlemail.com, ib@wupperonline.de,
	Pang Yan Han <pangyanhan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 19:49:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3AdP-00083s-UI
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 19:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808Ab1ILRt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 13:49:27 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51774 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab1ILRt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 13:49:26 -0400
Received: by vws1 with SMTP id 1so205065vws.19
        for <git@vger.kernel.org>; Mon, 12 Sep 2011 10:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uIaDc9iRf+toiad/6gQWnpTcICQLKq0xhj7WD0xlL78=;
        b=utYCNd+gaWW5HcbGts7EQFlCKHtUH5ElC9OJYpUOrxGJoPHN1ufWL8y2d7BK7WgXG0
         UcnzLmkAavemh7B1TEb3HWee7TZ8n4zseZHyqMeSa300Ws8jY9Tw4kLGRUxf6WgU/7GH
         kdThmW1+qH7DOfmnj+a/SUAUToc56qZ4+Qcvg=
Received: by 10.52.27.204 with SMTP id v12mr2835026vdg.173.1315849766039;
        Mon, 12 Sep 2011 10:49:26 -0700 (PDT)
Received: from localhost (bb219-74-111-93.singnet.com.sg [219.74.111.93])
        by mx.google.com with ESMTPS id by14sm10702551vdb.22.2011.09.12.10.49.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Sep 2011 10:49:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.190.g713ddd
In-Reply-To: <1315849601-26497-1-git-send-email-pangyanhan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181227>

commit c9bfb953 (want_color: automatically fallback to color.ui,
2011-08-17) introduced a regression where format-patch produces colorized
patches when color.ui is set to "always".

Demonstrate this through a new test.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Pang Yan Han <pangyanhan@gmail.com>
---
 t/t4051-format-patch-config.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100755 t/t4051-format-patch-config.sh

diff --git a/t/t4051-format-patch-config.sh b/t/t4051-format-patch-config.sh
new file mode 100755
index 0000000..cea9c7d
--- /dev/null
+++ b/t/t4051-format-patch-config.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description='check that format-patch does not respect porcelain config'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo foo >foo &&
+	git add foo &&
+	git commit -m "commit1" &&
+	echo bar >foo &&
+	git add foo &&
+	git commit -m "commit2"
+'
+
+test_expect_failure 'format patch with ui.color=always generates non colorized patch' '
+	git config color.ui always &&
+	git format-patch -1 &&
+	mv 0001-commit2.patch actual &&
+	test_must_fail grep "\[31m-" actual
+'
+
+test_done
-- 
1.7.7.rc0.190.gb47b6
