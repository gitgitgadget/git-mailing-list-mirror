From: Junio C Hamano <gitster@pobox.com>
Subject: Re* git-remote SEGV on t5505 test.
Date: Thu, 17 Jul 2008 23:18:43 -0700
Message-ID: <7vsku7d8ak.fsf_-_@gitster.siamese.dyndns.org>
References: <g5osl6$4g3$1@ger.gmane.org>
 <7vsku7es3n.fsf@gitster.siamese.dyndns.org> <48802DCD.2090704@posdata.co.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SungHyun Nam <namsh@posdata.co.kr>
X-From: git-owner@vger.kernel.org Fri Jul 18 08:19:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJjJn-0000o3-9z
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 08:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbYGRGSx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2008 02:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbYGRGSx
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 02:18:53 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbYGRGSw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jul 2008 02:18:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 79DA5308D4;
	Fri, 18 Jul 2008 02:18:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B295A308D3; Fri, 18 Jul 2008 02:18:46 -0400 (EDT)
In-Reply-To: <48802DCD.2090704@posdata.co.kr> (SungHyun Nam's message of
 "Fri, 18 Jul 2008 14:44:45 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 63E05966-5491-11DD-B2E6-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88995>

SungHyun Nam <namsh@posdata.co.kr> writes:

>     Is it possible that we can use 'SHELL_PATH' here?

It is not just possible but we really should.  There are other test
scripts that use hardcoded /bin/sh, but by setting SHELL_PATH the user =
is
already telling us that what the vendor has in /bin/sh isn't adequately
POSIX enough, and we really should try to honor that.

"git grep -n /bin/sh t/t*sh | grep -v ':1:#!'" would tell you which one=
s
are suspect.

---

 t/t9001-send-email.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index de5b980..1c857cf 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -13,7 +13,7 @@ test_expect_success \
=20
 test_expect_success \
     'Setup helper tool' \
-    '(echo "#!/bin/sh"
+    '(echo "#!$SHELL_PATH"
       echo shift
       echo output=3D1
       echo "while test -f commandline\$output; do output=3D\$((\$outpu=
t+1)); done"
@@ -138,7 +138,7 @@ test_expect_success 'Valid In-Reply-To when prompti=
ng' '
 '
=20
 test_expect_success 'setup fake editor' '
-	(echo "#!/bin/sh" &&
+	(echo "#!$SHELL_PATH" &&
 	 echo "echo fake edit >>\"\$1\""
 	) >fake-editor &&
 	chmod +x fake-editor
@@ -235,7 +235,7 @@ test_expect_success 'sendemail.cc unset' '
=20
 test_expect_success '--compose adds MIME for utf8 body' '
 	clean_fake_sendmail &&
-	(echo "#!/bin/sh" &&
+	(echo "#!$SHELL_PATH" &&
 	 echo "echo utf8 body: =C3=A0=C3=A9=C3=AC=C3=B6=C3=BA >>\"\$1\""
 	) >fake-editor-utf8 &&
 	chmod +x fake-editor-utf8 &&
@@ -254,7 +254,7 @@ test_expect_success '--compose adds MIME for utf8 b=
ody' '
=20
 test_expect_success '--compose respects user mime type' '
 	clean_fake_sendmail &&
-	(echo "#!/bin/sh" &&
+	(echo "#!$SHELL_PATH" &&
 	 echo "(echo MIME-Version: 1.0"
 	 echo " echo Content-Type: text/plain\\; charset=3Diso-8859-1"
 	 echo " echo Content-Transfer-Encoding: 8bit"
