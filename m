From: Adam Roben <aroben@apple.com>
Subject: [PATCH 5/9] Add tests for git hash-object
Date: Thu, 25 Oct 2007 03:25:23 -0700
Message-ID: <1193307927-3592-6-git-send-email-aroben@apple.com>
References: <1193307927-3592-1-git-send-email-aroben@apple.com>
 <1193307927-3592-2-git-send-email-aroben@apple.com>
 <1193307927-3592-3-git-send-email-aroben@apple.com>
 <1193307927-3592-4-git-send-email-aroben@apple.com>
 <1193307927-3592-5-git-send-email-aroben@apple.com>
Cc: Junio Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 12:27:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikzvi-0007WS-VM
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 12:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756375AbXJYK0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 06:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755289AbXJYK0T
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 06:26:19 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:63569 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756064AbXJYK0G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 06:26:06 -0400
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out3.apple.com (Postfix) with ESMTP id AD1DF1639CF3;
	Thu, 25 Oct 2007 03:26:05 -0700 (PDT)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id 931FA280AB;
	Thu, 25 Oct 2007 03:26:05 -0700 (PDT)
X-AuditID: 11807134-a665bbb000000c52-45-47206f3dfc4b
Received: from localhost.localdomain (aroben3.apple.com [17.203.12.72])
	by relay14.apple.com (Apple SCV relay) with ESMTP id 7AC2F280A7;
	Thu, 25 Oct 2007 03:26:05 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.1342.g32de
In-Reply-To: <1193307927-3592-5-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62298>


Signed-off-by: Adam Roben <aroben@apple.com>
---
Johannes Sixt wrote:
> Adam Roben schrieb:
> > +test_expect_success \
> > +    'hash a file' \
> > +    "test $hello_sha1 = $(git hash-object hello)"
> 
> Put tests in double-quotes; otherwise, the substitutions happen before the test begins, and not as part of the test. 

I think escaping the $(...) is enough to delay command execution.

 t/t1006-hash-object.sh |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100755 t/t1006-hash-object.sh

diff --git a/t/t1006-hash-object.sh b/t/t1006-hash-object.sh
new file mode 100755
index 0000000..12f95f0
--- /dev/null
+++ b/t/t1006-hash-object.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+
+test_description='git hash-object'
+
+. ./test-lib.sh
+
+hello_content="Hello World"
+hello_sha1=557db03de997c86a4a028e1ebd3a1ceb225be238
+echo "$hello_content" > hello
+
+test_expect_success \
+    'hash a file' \
+    "test $hello_sha1 = \$(git hash-object hello)"
+
+test_expect_success \
+    'hash from stdin' \
+    "test $hello_sha1 = \$(echo '$hello_content' | git hash-object --stdin)"
+
+test_expect_success \
+    'hash a file and write to database' \
+    "test $hello_sha1 = \$(git hash-object -w hello)"
+
+test_expect_success \
+    'hash from stdin and write to database' \
+    "test $hello_sha1 = \$(echo '$hello_content' | git hash-object -w --stdin)"
+
+test_done
-- 
1.5.3.4.1337.g8e67d-dirty
