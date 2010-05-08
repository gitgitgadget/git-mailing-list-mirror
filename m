From: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
Subject: [PATCH REMINDER] date.c: print "1 second ago", not "1 seconds ago"
Date: Sat, 8 May 2010 11:27:30 +0200
Message-ID: <20100508092730.GB26678@triton>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	sunny@sunbase.org
X-From: git-owner@vger.kernel.org Sat May 08 11:31:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAgNc-0003F8-N0
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 11:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144Ab0EHJ1g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 May 2010 05:27:36 -0400
Received: from smtp.domeneshop.no ([194.63.248.54]:50207 "EHLO
	smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681Ab0EHJ1f (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 05:27:35 -0400
Received: from sfn-inkubator-70-227.hib.no ([158.37.70.227] helo=triton)
	by smtp.domeneshop.no with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71)
	(envelope-from <sunny@sunbase.org>)
	id 1OAgJo-0003PU-HW; Sat, 08 May 2010 11:27:32 +0200
Mail-Followup-To: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
OpenPGP: id=94A506E5; url=http://www.sunbase.org/pubkey.asc
X-Request-PGP: http://www.sunbase.org/pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146652>

Hi,
resending a trivial patch for correcting the output of "1 seconds" to=20
"1 second" when using --date=3Drelative. The original patch was sent=20
2010-04-21 07:31:00+0200. The patch is created against current master=20
(ec768ed5) and passes all tests.


=46rom ec768ed5659b0e0f91c98a01c981bc359153a7b4 Mon Sep 17 00:00:00 200=
1
=46rom: =3D?UTF-8?q?=3DC3=3D98yvind=3D20A.=3D20Holm?=3D <sunny@sunbase.=
org>
Date: Wed, 21 Apr 2010 06:21:06 +0200
Subject: [PATCH] date.c: print "1 second ago", not "1 seconds ago"
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

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
1.7.1.11.g3bf78




Regards,
=C3=98yvind A. Holm
(sunny256)
