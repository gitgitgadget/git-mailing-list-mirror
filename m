From: Chris Packham <judge.packham@gmail.com>
Subject: [PATCH] Add test for ambiguous patch dates
Date: Wed, 12 Sep 2012 21:35:51 +1200
Message-ID: <1347442551-7105-2-git-send-email-judge.packham@gmail.com>
References: <1347442551-7105-1-git-send-email-judge.packham@gmail.com>
Cc: Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 12 11:35:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBjMJ-000740-QG
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 11:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075Ab2ILJfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 05:35:40 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42533 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879Ab2ILJfi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 05:35:38 -0400
Received: by obbuo13 with SMTP id uo13so2297554obb.19
        for <git@vger.kernel.org>; Wed, 12 Sep 2012 02:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jTeQRf9x7ft69GdlReh4dHBEtFGXNe3D8lArXalw5i4=;
        b=J335NXhrrAOmDtYgeIG+Jn/Z+FYDjgovPU74k50kiYMvgpsM5fKcCWPGMQXloZL7K+
         vR8qPazUNabufYw12oTlK/LRvUzHbPUjE8Yz2kjmVfGkcO42yVBkiN2BvxzGEDug9frz
         QFWomzlwvj/YonGQM1sUM9+ClZ3C6r0qw6dIIYDqnn6ioYhZMYpjZyGUakNZD3VfzI4R
         6HL6e0EFjINK8IKytpu3b4yuqmA9xHmbaCcLWH90jaBEJC5T7/s767jyyyfp8NoHHkA9
         dh1cRbMkxEKQVGqOh+40Ymr+pC63WwbQ4N2DgBaoPuB7Te7woqGCxwasxwAo+fosT5ar
         lI3g==
Received: by 10.182.38.71 with SMTP id e7mr21316126obk.67.1347442536109;
        Wed, 12 Sep 2012 02:35:36 -0700 (PDT)
Received: from localhost.localdomain (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPS id j10sm15693057oej.10.2012.09.12.02.35.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Sep 2012 02:35:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1347442551-7105-1-git-send-email-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205274>

--
This testcase is only good for the next couple of months. For a longer term
test the current time would need to be set in the test setup.

---
 t/t4255-am-author-date.sh |   85 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100755 t/t4255-am-author-date.sh

diff --git a/t/t4255-am-author-date.sh b/t/t4255-am-author-date.sh
new file mode 100755
index 0000000..62bceee
--- /dev/null
+++ b/t/t4255-am-author-date.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+
+test_description='git am with ambiguous date'
+. ./test-lib.sh
+
+cat >patch.diff <<EOF
+From:   A U Thor <au.thor@example.com>
+To:     C O Mmitter <co.mmitter@example.com>
+Date:   12/9/2012 12:00 AM
+Subject:       [PATCH] add file.txt
+---
+ file.txt |    7 +++++++
+ 1 file changed, 7 insertions(+)
+ create mode 100644 file.txt
+
+diff --git a/file.txt b/file.txt
+new file mode 100644
+index 0000000..fe745d6
+--- /dev/null
++++ b/file.txt
+@@ -0,0 +1,7 @@
++Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam pulvinar
++tempus ligula vitae ornare. Vestibulum ante ipsum primis in faucibus orci
++luctus et ultrices posuere cubilia Curae; Aenean dapibus mauris non quam
++commodo a porta sapien suscipit. Mauris venenatis, dui nec malesuada mattis,
++ante mauris ornare ipsum, ac tincidunt ipsum lectus aliquet tortor. Nulla ipsum
++felis, egestas at condimentum quis, accumsan nec arcu. Phasellus fringilla
++viverra tempus. Integer vel rhoncus odio.
+EOF
+
+test_expect_success 'apply patch with ambiguous date' '
+	git am patch.diff
+'
+
+cat >expected <<EOF
+Date:   Wed Sep 12 00:00:00 2012 +0000
+EOF
+
+test_expect_failure 'check ambiguous date' '
+	git show HEAD | grep Date >actual &&
+	test_cmp expected actual
+'
+
+cat >patch.diff <<EOF
+From:   A N Other <an.other@example.com>
+To:     C O Mmitter <co.mmitter@example.com>
+Date:   12.9.2012 12:00 AM
+Subject:       [PATCH] update file.txt
+---
+ file.txt |    9 +++++++++
+ 1 file changed, 9 insertions(+)
+
+diff --git a/file.txt b/file.txt
+index fe745d6..cd45361 100644
+--- a/file.txt
++++ b/file.txt
+@@ -5,3 +5,12 @@ commodo a porta sapien suscipit. Mauris venenatis, dui nec malesuada mattis,
+ ante mauris ornare ipsum, ac tincidunt ipsum lectus aliquet tortor. Nulla ipsum
+ felis, egestas at condimentum quis, accumsan nec arcu. Phasellus fringilla
+ viverra tempus. Integer vel rhoncus odio.
++
++Donec et ante eu mi aliquam sodales non ut massa. Nullam a luctus dui. Etiam ac
++eros elit. Pellentesque habitant morbi tristique senectus et netus et malesuada
++fames ac turpis egestas. Curabitur commodo ligula id leo iaculis vel lobortis
++leo pulvinar. Aenean adipiscing cursus arcu quis consectetur. Morbi eget lectus
++nec neque interdum lacinia. Nam quis metus eget ligula faucibus imperdiet in et
++ligula. Aenean eu urna sit amet metus sagittis interdum non cursus orci.
++Maecenas imperdiet feugiat tellus, non ultrices nulla dictum sed. Nulla vel
++lorem ac massa euismod faucibus et ut leo.
+EOF
+
+test_expect_success 'apply patch with european date separator' '
+	git am patch.diff
+'
+
+cat >expected <<EOF
+Date:   Wed Sep 12 00:00:00 2012 +0000
+EOF
+
+test_expect_success 'check european date' '
+	git show HEAD | grep Date >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
1.7.10.4
