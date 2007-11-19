From: =?utf-8?q?Ask=20Bj=C3=B8rn=20Hansen?= <ask@develooper.com>
Subject: [PATCH] Don't print an empty Cc header in SMTP mode when there's no cc recipient defined
Date: Mon, 19 Nov 2007 02:48:14 -0800
Message-ID: <1195469295-5774-1-git-send-email-ask@develooper.com>
References: <7voddqodhs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Ask=20Bj=C3=B8rn=20Hansen?= <ask@develooper.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 12:00:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu4MM-00059G-EK
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 12:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbXKSK7s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Nov 2007 05:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbXKSK7s
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 05:59:48 -0500
Received: from gw.develooper.com ([64.81.84.140]:50436 "EHLO
	freja.develooper.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751910AbXKSK7s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 05:59:48 -0500
X-Greylist: delayed 690 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Nov 2007 05:59:48 EST
Received: by freja.develooper.com (Postfix, from userid 500)
	id 03CE117D028; Mon, 19 Nov 2007 02:48:15 -0800 (PST)
X-Mailer: git-send-email 1.5.3.6.735.ge0de
In-Reply-To: <7voddqodhs.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65424>


Signed-off-by: Ask Bj=C3=B8rn Hansen <ask@develooper.com>
---

There's some duplicate code between "what we do for sendmail"
and "what we do for SMTP" paths that should be fixed - this doesn't
do that, it only makes the SMTP path skip empty Cc lines...

 git-send-email.perl |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index fd0a4ad..65620ab 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -651,7 +651,11 @@ X-Mailer: git-send-email $gitversion
 		} else {
 			print "Sendmail: $smtp_server ".join(' ',@sendmail_parameters)."\n"=
;
 		}
-		print "From: $sanitized_sender\nSubject: $subject\nCc: $cc\nTo: $to\=
n\n";
+		print "From: $sanitized_sender\n"
+		     . "Subject: $subject\n"
+		     . ($cc ? "Cc: $cc\n" : "")
+		     . "To: $to\n"
+		     . "\n";
 		if ($smtp) {
 			print "Result: ", $smtp->code, ' ',
 				($smtp->message =3D~ /\n([^\n]+\n)$/s), "\n";
--=20
1.5.3.5.561.g140d
