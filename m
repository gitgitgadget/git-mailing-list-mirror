From: Pang Yan Han <pangyanhan@gmail.com>
Subject: [PATCH/RFC 1/2] format-patch: demonstrate that color.ui=always produces colorized patches
Date: Mon, 12 Sep 2011 23:56:55 +0800
Message-ID: <1315843016-10959-2-git-send-email-pangyanhan@gmail.com>
References: <1315843016-10959-1-git-send-email-pangyanhan@gmail.com>
Cc: gitster@pobox.com, peff@peff.net, martin.von.zweigbergk@gmail.com,
	sdaoden@googlemail.com, ib@wupperonline.de,
	Pang Yan Han <pangyanhan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 17:59:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R38up-0003e6-9k
	for gcvg-git-2@lo.gmane.org; Mon, 12 Sep 2011 17:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758253Ab1ILP7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Sep 2011 11:59:18 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53961 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758077Ab1ILP7R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2011 11:59:17 -0400
Received: by vws1 with SMTP id 1so113778vws.19
        for <git@vger.kernel.org>; Mon, 12 Sep 2011 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=z7+x4koiQ8Uhw7L1mFsFW329m5ARRlwyBayyDvkMLiM=;
        b=T+32Vmt7SDj2n8M+GlNRI1UmcsAYkkutPaMgNE22k9YZuztNcYQet1zzxgNnBP/bSe
         JW/S/AuU4voTV9o5Kubndua/nKt5NV8BaU8K4Pr26tjNYgw4YCL4jtcm8gr70Q1lXRD6
         lEgUqA+arqr7708lInCMszfB3k6o10xMzc29s=
Received: by 10.220.184.9 with SMTP id ci9mr87638vcb.227.1315843156639;
        Mon, 12 Sep 2011 08:59:16 -0700 (PDT)
Received: from localhost (bb219-74-111-93.singnet.com.sg [219.74.111.93])
        by mx.google.com with ESMTPS id jo8sm10508930vdb.20.2011.09.12.08.59.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Sep 2011 08:59:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.190.gee9b6
In-Reply-To: <1315843016-10959-1-git-send-email-pangyanhan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181219>

commit c9bfb953 (want_color: automatically fallback to color.ui) introduced
a regression where format-patch produces colorized patches when color.ui is
set to "always". Demonstrate this through a new test.

Signed-off-by: Pang Yan Han <pangyanhan@gmail.com>
---
Hi, I don't know if I actually understand the naming convention for tests
correctly here, so I used the next available number for the last 2 digits.

 t/t4051-format-patch-color.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100755 t/t4051-format-patch-color.sh

diff --git a/t/t4051-format-patch-color.sh b/t/t4051-format-patch-color.sh
new file mode 100755
index 0000000..db30840
--- /dev/null
+++ b/t/t4051-format-patch-color.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description='format-patch - check for non colorized output'
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
1.7.7.rc0.190.g816e
