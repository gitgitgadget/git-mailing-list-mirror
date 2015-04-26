From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 2/3] t5601: fix quotation error leading to skipped tests
Date: Sun, 26 Apr 2015 20:30:11 +0000
Message-ID: <1430080212-396370-3-git-send-email-sandals@crustytoothpaste.net>
References: <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
 <1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 22:30:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmTCC-000729-3r
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 22:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbbDZUaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 16:30:23 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:48888 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750776AbbDZUaW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2015 16:30:22 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id F0C4E282A7;
	Sun, 26 Apr 2015 20:30:20 +0000 (UTC)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267835>

One of the tests in t5601 used single quotes to delimit an argument
containing spaces.  However, this caused test_expect_success to be
passed three arguments instead of two, which in turn caused the test
name to be treated as a prerequisite instead of a test name.  As there
was no prerequisite called "bracketed hostnames are still ssh", the test
was always skipped.

Because this test was always skipped, the fact that it passed the
arguments in the wrong order was obscured.  Use double quotes inside the
test and reorder the arguments so that the test runs and properly
reflects the arguments that are passed to ssh.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t5601-clone.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 1befc45..aae2324 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -332,7 +332,7 @@ test_expect_success !MINGW,!CYGWIN 'clone local path foo:bar' '
 
 test_expect_success 'bracketed hostnames are still ssh' '
 	git clone "[myhost:123]:src" ssh-bracket-clone &&
-	expect_ssh myhost '-p 123' src
+	expect_ssh "-p 123" myhost src
 '
 
 counter=0
-- 
2.3.5
