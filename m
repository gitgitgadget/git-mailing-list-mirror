From: "Peter J. Weisberg" <pj@irregularexpressions.net>
Subject: [PATCH] Demonstrate failure of 'core.ignorecase = true'
Date: Wed, 21 Mar 2012 15:50:22 -0700
Message-ID: <1332370222-5123-1-git-send-email-pj@irregularexpressions.net>
Cc: "Peter J. Weisberg" <pj@irregularexpressions.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 21 23:50:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAUMn-0000Df-VY
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 23:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291Ab2CUWut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 18:50:49 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47913 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab2CUWus (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 18:50:48 -0400
Received: by dajr28 with SMTP id r28so2202823daj.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 15:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=n1XtesNwAc03+KKT9EqdADADPW9qDxWKRRVdeE8r0QA=;
        b=PWbVOZ0jE46/4ZHdBUEAZkMp6JZzcgntKHRMeU3z6ThpOWSc+mpfA+F/mvsA7VxikP
         JPSiTK4cQGl4RKcJ8qZf60AaIRS3DMb9kG//UCrIehtCLILF1SH1e7PihmZpzC0Kyttx
         nhxgTCUV2v6H0+6ZOku2uqUkA/2dcwMC8aKZolANVaT+HaCQGzQqSZSJbKt8mpZsBF/N
         mqU6Zjdwuta+lMfcCs1Te6N8FoNo2CaEI333bS+ZlA/BIdGV9ABWZvnbGhw19RcxJXMs
         5a8idZHgv/l/CADUDwsXvP43m//xiP81k6S5MG8Lw2MCTMxL4n8X0eEpiUIkFmseeR0t
         E1Sg==
Received: by 10.68.202.195 with SMTP id kk3mr2885902pbc.96.1332370248214;
        Wed, 21 Mar 2012 15:50:48 -0700 (PDT)
Received: from localhost.localdomain (184-77-254-77.war.clearwire-wmx.net. [184.77.254.77])
        by mx.google.com with ESMTPS id z1sm2292425pbc.38.2012.03.21.15.50.46
        (version=SSLv3 cipher=OTHER);
        Wed, 21 Mar 2012 15:50:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193626>

From: "Peter J. Weisberg" <pj@irregularexpressions.net>

On a filesystem that *is* case-sensitive, renaming a file to a name
that would be equivalent on a case-insensitive filesystem makes Git
think the original file was deleted.  Add a test that demonstrates
this as a known error.
---
I have a repository that contains files that I sync from a place where
names are case-insensitive.  When I sync a file that has a change in
the case of the file name, I want Git to ignore that non-change.  I
would think core.ignorecase would accomplish this, but it does not.
---
 t/t2000-ignorecase-config.sh |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)
 create mode 100755 t/t2000-ignorecase-config.sh

diff --git a/t/t2000-ignorecase-config.sh b/t/t2000-ignorecase-config.sh
new file mode 100755
index 0000000..9d05cee
--- /dev/null
+++ b/t/t2000-ignorecase-config.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Peter J Weisberg
+#
+
+test_description='core.ignorecase'
+
+. ./test-lib.sh
+
+test_expect_failure "diff-files doesn't show case change when ignorecase=true" '
+	git config core.ignorecase true &&
+
+	touch foo &&
+	git add foo &&
+	git commit -m "foo" &&
+	mv foo FOO &&
+
+	test -z "$(git diff-files)"
+'
+
+test_done
-- 
1.7.9.1
