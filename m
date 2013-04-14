From: Philip Oakley <philipoakley@iee.org>
Subject: [RFC/PATCH 1/2] test git version string
Date: Sun, 14 Apr 2013 15:27:25 +0100
Message-ID: <1365949646-1988-2-git-send-email-philipoakley@iee.org>
References: <1365949646-1988-1-git-send-email-philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 14 16:27:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URNu9-00034e-7P
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 16:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858Ab3DNO1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 10:27:37 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:53317 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751834Ab3DNO1Y (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 10:27:24 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah0MAGG8alFZ8Yth/2dsb2JhbAAuIoMGNoJHvnQEAYECF3SCIAEFVjMISTkYBgYTiBi5dI1fG4Ekg0EDqBaBL4FdO4Eu
X-IronPort-AV: E=Sophos;i="4.87,471,1363132800"; 
   d="scan'208";a="415404135"
Received: from host-89-241-139-97.as13285.net (HELO localhost) ([89.241.139.97])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 14 Apr 2013 15:27:22 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1365949646-1988-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221138>

The git version string is used in the wild, and in git gui,
for capability checking purposes. Test the string format
and version X.Y.Z number.

The version string shall be:
* a single line
* less that 80 characters
* start with `git version `
* with a following numeric X.Y.Z version.

The remaining characters are undefined.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

Should this be applied to t0000, or another test file?
Should the version string be always limited to one line?
Should the maximum string length be <80 characters?
Is egrep OK, or should I use grep with a longer BRE?

 t/t0000-basic.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index cefe33d..052afca 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -610,4 +610,12 @@ test_expect_success 'very long name in the index handled sanely' '
 	test $len = 4098
 '
 
+test_expect_success 'git version string X.Y.Z' '
+	git --version >verstring &&
+	test_line_count =  1 verstring &&
+	len=$(wc -c verstring | sed "s/[^0-9]//g") &&
+	test $len -lt  80 &&
+	egrep -q "^git version [0-9]+\.[0-9]+\.[0-9]+.*" verstring
+'
+
 test_done
-- 
1.8.1.msysgit.1
