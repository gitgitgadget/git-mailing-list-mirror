From: =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>
Subject: [PATCH] date.c: print "1 second ago", not "1 seconds ago"
Date: Wed, 21 Apr 2010 07:31:00 +0200
Message-ID: <1271827860-20947-1-git-send-email-sunny@sunbase.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 21 07:37:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4Sd8-0000NB-Au
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 07:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200Ab0DUFhl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 01:37:41 -0400
Received: from smtp.domeneshop.no ([194.63.248.54]:47235 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab0DUFhj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 01:37:39 -0400
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Apr 2010 01:37:39 EDT
Received: from sfn-inkubator-70-227.hib.no ([158.37.70.227] helo=localhost.localdomain)
	by smtp.domeneshop.no with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <sunny@sunbase.org>)
	id 1O4SWi-0001VF-R3; Wed, 21 Apr 2010 07:31:08 +0200
X-Mailer: git-send-email 1.7.1.rc2.5.gddd02
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145406>

When using --date=3Drelative, print "1 second ago" instead of "1 second=
s
ago".

t0006: Add tests for 0, 1 and 2 seconds ago, to ensure that
--date=3Drelative prints "1 second ago" and "x seconds ago" when x !=3D=
 1.

Signed-off-by: =C3=98yvind A. Holm <sunny@sunbase.org>
---
 date.c          |    3 ++-
 t/t0006-date.sh |    4 ++++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/date.c b/date.c
index 002aa3c..6aec22b 100644
--- a/date.c
+++ b/date.c
@@ -96,7 +96,8 @@ const char *show_date_relative(unsigned long time, in=
t tz,
 		return "in the future";
 	diff =3D now->tv_sec - time;
 	if (diff < 90) {
-		snprintf(timebuf, timebuf_size, "%lu seconds ago", diff);
+		snprintf(timebuf, timebuf_size, "%lu second%s ago",
+				diff, (diff !=3D 1 ? "s" : ""));
 		return timebuf;
 	}
 	/* Turn it into minutes */
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 75b02af..3069545 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -15,6 +15,9 @@ check_show() {
 	"
 }
=20
+check_show 0 '0 seconds ago'
+check_show 1 '1 second ago'
+check_show 2 '2 seconds ago'
 check_show 5 '5 seconds ago'
 check_show 300 '5 minutes ago'
 check_show 18000 '5 hours ago'
@@ -48,6 +51,7 @@ check_approxidate() {
 }
=20
 check_approxidate now '2009-08-30 19:20:00'
+check_approxidate '1 second ago' '2009-08-30 19:19:59'
 check_approxidate '5 seconds ago' '2009-08-30 19:19:55'
 check_approxidate 5.seconds.ago '2009-08-30 19:19:55'
 check_approxidate 10.minutes.ago '2009-08-30 19:10:00'
--=20
1.7.1.rc2.5.gddd02
