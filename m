From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] git-am: Add colon before the subject that is printed out as being applied
Date: Wed, 23 Jul 2008 18:46:36 +0200
Message-ID: <1216831596-30870-1-git-send-email-s-beyer@gmx.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 18:47:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLhVE-00053X-GK
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 18:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbYGWQqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 12:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753032AbYGWQqr
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 12:46:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:58403 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752994AbYGWQqq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 12:46:46 -0400
Received: (qmail invoked by alias); 23 Jul 2008 16:46:45 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp045) with SMTP; 23 Jul 2008 18:46:45 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+yzl0ImEay8olJY03YYurp2RehpGEuVzht30aNLL
	M5xDLwIPBc7iqP
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KLhU4-00082I-S6; Wed, 23 Jul 2008 18:46:36 +0200
X-Mailer: git-send-email 1.6.0.rc0.102.ga1791
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89708>

git-am output can be confusing, because the subject of the applied
patch can look like the rest of a sentence starting with "Applying".
The added colon should make this clearer.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Hi,

Linus added single quotes to applypatch in 610968199,
writing:

    Add quotes around the subject line that we print out as being applied.

    My brain just flipped when it tried to read the "Applying" as part
    of the explanation of the patch, and the sentence didn't make any
    sense. The quotes make it clear what's going on.

I think he is right ;)

Of course, it's debatable whether
	Applying: foo
or
	Applying "foo"
or
	Applying 'foo'
may be the best. I don't really care :)

The main reason I chose the colon variant is because the change in t4151
is less ugly.

Another reason: thinking of "ambiguous" subjects:
 -	Applying "Remove "string" from foo.c"
 -	Applying 'Remove 'string' from foo.sh'
 -	Applying: foo.c: Remove "string"

Regards,
  Stephan

 git-am.sh           |    2 +-
 t/t4151-am-abort.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 7864b5f..f4abd9d 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -456,7 +456,7 @@ do
 		stop_here $this
 	fi
 
-	printf 'Applying %s\n' "$FIRSTLINE"
+	printf 'Applying: %s\n' "$FIRSTLINE"
 
 	case "$resolved" in
 	'')
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 249093b..f45ab0a 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -43,7 +43,7 @@ do
 
 	test_expect_success "am$with3 --skip continue after failed am$with3" '
 		test_must_fail git-am$with3 --skip >output &&
-		test "$(grep "^Applying" output)" = "Applying 6" &&
+		test "$(grep "^Applying" output)" = "Applying: 6" &&
 		test_cmp file-2-expect file-2 &&
 		test ! -f .git/rr-cache/MERGE_RR
 	'
-- 
1.6.0.rc0.102.ga1791
