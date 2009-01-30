From: Kristian Amlie <kristian.amlie@trolltech.com>
Subject: [PATCH] Add a test for checking whether gitattributes is honored by checkout.
Date: Fri, 30 Jan 2009 14:00:13 +0100
Message-ID: <1233320413-28069-2-git-send-email-kristian.amlie@trolltech.com>
References: <498094F9.5070201@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Cc: Kristian Amlie <kristian.amlie@trolltech.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 14:02:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSt0H-0001e5-B8
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 14:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbZA3NAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 08:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbZA3NAW
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 08:00:22 -0500
Received: from hoat.troll.no ([62.70.27.150]:46801 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752374AbZA3NAU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jan 2009 08:00:20 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 255FB2111D
	for <git@vger.kernel.org>; Fri, 30 Jan 2009 14:00:15 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 1A79B210CF
	for <git@vger.kernel.org>; Fri, 30 Jan 2009 14:00:15 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n0UD0EcH025832
	for <git@vger.kernel.org>; Fri, 30 Jan 2009 14:00:14 +0100
Received: from axis.localdomain ( [172.24.90.99])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Fri, 30 Jan 2009 14:00:14 +0100 (CET)
Received: by axis.localdomain (Postfix, from userid 1000)
	id ED77636182D8; Fri, 30 Jan 2009 14:00:13 +0100 (CET)
In-Reply-To: <1233320413-28069-1-git-send-email-kristian.amlie@trolltech.com>
References: <1233320413-28069-1-git-send-email-kristian.amlie@trolltech.com>
x-scalix-Hops: 1
X-Mailer: git-send-email 1.6.1.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107807>

The original bug will not honor new entries in gitattributes if they
are changed in the same checkout as the files they affect.
---
 t/t2012-checkout-crlf.sh |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100755 t/t2012-checkout-crlf.sh

diff --git a/t/t2012-checkout-crlf.sh b/t/t2012-checkout-crlf.sh
new file mode 100755
index 0000000..cb997a8
--- /dev/null
+++ b/t/t2012-checkout-crlf.sh
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
1.6.0.3
