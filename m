From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 2/2] send-email: use UTF-8 rather than utf-8 for consistency
Date: Sat,  6 Jun 2009 20:12:31 -0500
Message-ID: <1244337151-6506-2-git-send-email-drafnel@gmail.com>
References: <1244337151-6506-1-git-send-email-drafnel@gmail.com>
Cc: gitster@pobox.com, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 03:10:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD6u1-0008H4-AI
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 03:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202AbZFGBKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 21:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754139AbZFGBKQ
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 21:10:16 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:56158 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073AbZFGBKO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 21:10:14 -0400
Received: by gxk10 with SMTP id 10so290536gxk.13
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 18:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8EUTxo5pGUdmvM18nCDcS/gw0xPLlGkbPX2NHSj9qlE=;
        b=qfKOqPLE/7ToMkzZv1rdy5NsWDJGBS+GzP/cJuZWHhDdDdgcUTNV7Ld/Rufm3I+NWg
         A0tG8QW7zYo4CiGnhTpVv2nkOkN1lNmCOhBVmSY7myQo3ihMZTR7y002Wo9dUB7uXuiW
         9bD0Y8oGPCJiWd7yO+usj84TisQDZQq+iqZO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ONnpTQSRHxbKmKudxQWCWakrp7Xdnu5E3UvQPgUctAkw21xpvUfOc2XGZgLOenH6m0
         sjU/GeXI++sgeXNqkla7HoFxNWfKA2vbdFItwh77t5KSRlKYY9PYsHnagc1eo9dj0adU
         py9LVoScl9jfQNBmyRO2qlkENtZuFLQmzwUys=
Received: by 10.90.69.7 with SMTP id r7mr4370580aga.47.1244337015224;
        Sat, 06 Jun 2009 18:10:15 -0700 (PDT)
Received: from localhost.localdomain ([96.19.141.3])
        by mx.google.com with ESMTPS id 1sm3927720agb.8.2009.06.06.18.10.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 18:10:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.1.9.g95405b
In-Reply-To: <1244337151-6506-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120949>

The rest of the git source has been converted to use upper-case character
encoding names to assist older platforms.  The charset attribute of MIME
is defined to be case-insensitive, but older platforms may still have an
easier time dealing with upper-case rather than lower-case.  So do so for
send-email too.

Update t9001 to handle the changes.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 git-send-email.perl   |    4 ++--
 t/t9001-send-email.sh |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e735815..1d48349 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -577,7 +577,7 @@ EOT
 			if ($need_8bit_cte) {
 				print C2 "MIME-Version: 1.0\n",
 					 "Content-Type: text/plain; ",
-					   "charset=utf-8\n",
+					   "charset=UTF-8\n",
 					 "Content-Transfer-Encoding: 8bit\n";
 			}
 		} elsif (/^MIME-Version:/i) {
@@ -766,7 +766,7 @@ sub unquote_rfc2047 {
 
 sub quote_rfc2047 {
 	local $_ = shift;
-	my $encoding = shift || 'utf-8';
+	my $encoding = shift || 'UTF-8';
 	s/([^-a-zA-Z0-9!*+\/])/sprintf("=%02X", ord($1))/eg;
 	s/(.*)/=\?$encoding\?q\?$1\?=/;
 	return $_;
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index ce26ea4..2ce24cd 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -533,7 +533,7 @@ test_expect_success 'utf8 Cc is rfc2047 encoded' '
 	--smtp-server="$(pwd)/fake.sendmail" \
 	outdir/*.patch &&
 	grep "^Cc:" msgtxt1 |
-	grep "=?utf-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"
+	grep "=?UTF-8?q?=C3=A0=C3=A9=C3=AC=C3=B6=C3=BA?= <utf8@example.com>"
 '
 
 test_expect_success '--compose adds MIME for utf8 body' '
@@ -550,7 +550,7 @@ test_expect_success '--compose adds MIME for utf8 body' '
 	  --smtp-server="$(pwd)/fake.sendmail" \
 	  $patches &&
 	grep "^utf8 body" msgtxt1 &&
-	grep "^Content-Type: text/plain; charset=utf-8" msgtxt1
+	grep "^Content-Type: text/plain; charset=UTF-8" msgtxt1
 '
 
 test_expect_success '--compose respects user mime type' '
@@ -573,7 +573,7 @@ test_expect_success '--compose respects user mime type' '
 	  $patches &&
 	grep "^utf8 body" msgtxt1 &&
 	grep "^Content-Type: text/plain; charset=iso-8859-1" msgtxt1 &&
-	! grep "^Content-Type: text/plain; charset=utf-8" msgtxt1
+	! grep "^Content-Type: text/plain; charset=UTF-8" msgtxt1
 '
 
 test_expect_success '--compose adds MIME for utf8 subject' '
@@ -586,7 +586,7 @@ test_expect_success '--compose adds MIME for utf8 subject' '
 	  --smtp-server="$(pwd)/fake.sendmail" \
 	  $patches &&
 	grep "^fake edit" msgtxt1 &&
-	grep "^Subject: =?utf-8?q?utf8-s=C3=BCbj=C3=ABct?=" msgtxt1
+	grep "^Subject: =?UTF-8?q?utf8-s=C3=BCbj=C3=ABct?=" msgtxt1
 '
 
 test_expect_success 'detects ambiguous reference/file conflict' '
-- 
1.6.3.1.9.g95405b
