From: Kristian Amlie <kristian.amlie@nokia.com>
Subject: [PATCH 1/2] Add a test for checking whether gitattributes is honored by checkout.
Date: Thu, 12 Mar 2009 10:36:14 +0100
Message-ID: <1236850575-27973-2-git-send-email-kristian.amlie@nokia.com>
References: <1233320413-28069-1-git-send-email-kristian.amlie@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: Kristian Amlie <kristian.amlie@nokia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 12 10:38:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhhMy-0004cN-DB
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 10:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051AbZCLJgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 05:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753635AbZCLJgr
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 05:36:47 -0400
Received: from hoat.troll.no ([62.70.27.150]:41193 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753359AbZCLJgq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 05:36:46 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 105F72115B;
	Thu, 12 Mar 2009 10:36:44 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id EA0B12114D;
	Thu, 12 Mar 2009 10:36:43 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n2C9ahSk026017;
	Thu, 12 Mar 2009 10:36:43 +0100
Received: from axis.localdomain ( [172.24.90.99])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Thu, 12 Mar 2009 10:36:43 +0100 (CET)
Received: by axis.localdomain (Postfix, from userid 1000)
	id 36D643618806; Thu, 12 Mar 2009 10:36:40 +0100 (CET)
In-Reply-To: <1236850575-27973-1-git-send-email-kristian.amlie@nokia.com>
References: <1236850575-27973-1-git-send-email-kristian.amlie@nokia.com>
x-scalix-Hops: 1
X-Mailer: git-send-email 1.6.2.105.g16bc7.dirty
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113030>

The original bug will not honor new entries in gitattributes if they
are changed in the same checkout as the files they affect.
---
 t/t2013-checkout-crlf.sh |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100755 t/t2013-checkout-crlf.sh

diff --git a/t/t2013-checkout-crlf.sh b/t/t2013-checkout-crlf.sh
new file mode 100755
index 0000000..cb997a8
--- /dev/null
+++ b/t/t2013-checkout-crlf.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description='checkout should honor .gitattributes'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+
+	git config core.autocrlf true &&
+	printf "dummy dummy=true\r\n" > .gitattributes &&
+	git add .gitattributes &&
+	git commit -m initial &&
+	printf "file -crlf\n" >> .gitattributes &&
+	printf "contents\n" > file &&
+	git add .gitattributes file &&
+	git commit -m second
+
+'
+
+test_expect_success 'checkout with existing .gitattributes' '
+
+	git checkout master~1 &&
+	git checkout master &&
+	test "$(git diff-files --raw)" = ""
+
+'
+
+test_done
+
-- 
1.6.2.105.g16bc7.dirty
