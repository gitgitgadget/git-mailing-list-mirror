From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] archive tests: do not use .gitattributes in working
 directory
Date: Wed, 15 Apr 2009 19:28:33 -0700
Message-ID: <1239848917-14399-2-git-send-email-gitster@pobox.com>
References: <1239848917-14399-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 04:31:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuHNd-0000r0-8W
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 04:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365AbZDPC2p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2009 22:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753930AbZDPC2o
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 22:28:44 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772AbZDPC2n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 22:28:43 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A6FAEF2E3;
	Wed, 15 Apr 2009 22:28:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1DBCAF2E2; Wed,
 15 Apr 2009 22:28:40 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.rc0.6.g08087
In-Reply-To: <1239848917-14399-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4D9DC620-2A2E-11DE-99E2-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116663>

=46rom: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>

We are interested in using archive mostly from a bare repository, so it
should not add .gitattributes to the work tree.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5000-tar-tree.sh |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 7641e0d..abb41b0 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -50,7 +50,7 @@ test_expect_success \
 test_expect_success \
     'add ignored file' \
     'echo ignore me >a/ignored &&
-     echo ignored export-ignore >.gitattributes'
+     echo ignored export-ignore >.git/info/attributes'
=20
 test_expect_success \
     'add files to repository' \
@@ -64,7 +64,7 @@ test_expect_success \
 test_expect_success \
     'create bare clone' \
     'git clone --bare . bare.git &&
-     cp .gitattributes bare.git/info/attributes'
+     cp .git/info/attributes bare.git/info/attributes'
=20
 test_expect_success \
     'remove ignored file' \
@@ -139,10 +139,11 @@ test_expect_success \
=20
 test_expect_success \
     'create archives with substfiles' \
-    'echo "substfile?" export-subst >a/.gitattributes &&
+    'cp .git/info/attributes .git/info/attributes.before &&
+     echo "substfile?" export-subst >>.git/info/attributes &&
      git archive HEAD >f.tar &&
      git archive --prefix=3Dprefix/ HEAD >g.tar &&
-     rm a/.gitattributes'
+     mv .git/info/attributes.before .git/info/attributes'
=20
 test_expect_success \
     'extract substfiles' \
--=20
1.6.3.rc0.6.g08087
