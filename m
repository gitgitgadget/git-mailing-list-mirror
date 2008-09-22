From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH bc/maint-diff-hunk-header] t4018-diff-funcname: test syntax
 of builtin xfuncname patterns
Date: Mon, 22 Sep 2008 18:19:05 -0500
Message-ID: <b-t750rmbNQ3RJMPXbQJmYFebFR6SfB9QBkJdDzbG7GGT_3aZBkCfw@cipher.nrlssc.navy.mil>
References: <7vy71n482x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Git Mailing List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johan Herland <johan@herland.net>,
	Andreas Ericsson <ae@op5.se>, Kirill Smelkov <kirr@mns.spb.ru>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>,
	Jonathan del Strother <maillist@steelskies.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 01:22:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhujH-0007RC-64
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 01:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753914AbYIVXU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 19:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753911AbYIVXU5
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 19:20:57 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41198 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbYIVXU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 19:20:57 -0400
Received: by mail.nrlssc.navy.mil id m8MNJ556023825; Mon, 22 Sep 2008 18:19:05 -0500
In-Reply-To: <7vy71n482x.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 22 Sep 2008 23:19:05.0707 (UTC) FILETIME=[9B78DBB0:01C91D09]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96514>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


How about something like this on top of your ERE conversion patch.
It will test that regcomp() completes successfully.

-brandon


 t/t4018-diff-funcname.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 602d68f..76919a4 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -32,7 +32,18 @@ EOF
 
 sed 's/beer\\/beer,\\/' < Beer.java > Beer-correct.java
 
+builtin_patterns="bibtex java pascal ruby tex"
+for p in $builtin_patterns
+do
+	test_expect_success "builtin $p pattern compiles" '
+		echo "*.java diff=$p" > .gitattributes &&
+		git diff --no-index Beer.java Beer-correct.java 2>&1 |
+			test_must_fail grep "fatal" > /dev/null
+	'
+done
+
 test_expect_success 'default behaviour' '
+	rm -f .gitattributes &&
 	git diff --no-index Beer.java Beer-correct.java |
 	grep "^@@.*@@ public class Beer"
 '
-- 
1.6.0.1.244.gdc19
