From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] remote-helpers: tests: use python directly
Date: Fri, 17 May 2013 16:10:07 -0500
Message-ID: <1368825008-2815-2-git-send-email-felipe.contreras@gmail.com>
References: <1368825008-2815-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 17 23:11:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdRwO-0000bW-Ln
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 23:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756318Ab3EQVLn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 May 2013 17:11:43 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:60072 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755870Ab3EQVLm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 17:11:42 -0400
Received: by mail-yh0-f48.google.com with SMTP id f35so1097922yha.35
        for <git@vger.kernel.org>; Fri, 17 May 2013 14:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=VfH2LCKIGDHnhDy+Wi8Sb512nPnyYb+MIyXADomqHbY=;
        b=GC+r/4vkbGU1AiRo1SoR4W+l4byiypSZZeuAylayHivFehLeYrF7oyCs9rbhlqPv7p
         aGDVRQgtTcu8koPirlQPwSCq7k5p/mQXvgDv04rUhW2xYOMGXfkaftoqPs8sx26uF+oF
         RQygvgOQ4MAH0XO6evhGLJUCMt4LDz9Ggv3z39+NO/JKLUxJNLNAShlJ6SbxUEbtEnzI
         64Hej81/TsmFvn4OdBfm51Y8Whirf1xnsCw2c4eRuLToug4ZyZ5DaHnMbtwa0WnHLil7
         6o17J+Hg3qgwKXRM/RLablyJsM+e9zPGDdPklVuiJpYkexQs0XhIdqrDU28tSEMLe5T4
         WD0g==
X-Received: by 10.236.154.105 with SMTP id g69mr15420512yhk.153.1368825102092;
        Fri, 17 May 2013 14:11:42 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id d91sm19930050yhq.16.2013.05.17.14.11.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 May 2013 14:11:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc2.542.g24820ba
In-Reply-To: <1368825008-2815-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224739>

These remote helpers use 'env python', not PYTHON_PATH, so that's where
we should check for the extensions. Otherwise, if 'python' is not
PYTHON_PATH (e.g. /usr/bin/python: Makefile's default), there will be a
mismatch between the python libraries actually accessible to the remote
helpers.

Suggested by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-bzr.sh       | 2 +-
 contrib/remote-helpers/test-hg-bidi.sh   | 2 +-
 contrib/remote-helpers/test-hg-hg-git.sh | 4 ++--
 contrib/remote-helpers/test-hg.sh        | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helper=
s/test-bzr.sh
index 5dfa070..2c89caa 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -12,7 +12,7 @@ if ! test_have_prereq PYTHON; then
 	test_done
 fi
=20
-if ! "$PYTHON_PATH" -c 'import bzrlib'; then
+if ! python -c 'import bzrlib'; then
 	skip_all=3D'skipping remote-bzr tests; bzr not available'
 	test_done
 fi
diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-he=
lpers/test-hg-bidi.sh
index f569697..2c693d0 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -15,7 +15,7 @@ if ! test_have_prereq PYTHON; then
 	test_done
 fi
=20
-if ! "$PYTHON_PATH" -c 'import mercurial'; then
+if ! python -c 'import mercurial'; then
 	skip_all=3D'skipping remote-hg tests; mercurial not available'
 	test_done
 fi
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-=
helpers/test-hg-hg-git.sh
index 8440341..fbad2b9 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -15,12 +15,12 @@ if ! test_have_prereq PYTHON; then
 	test_done
 fi
=20
-if ! "$PYTHON_PATH" -c 'import mercurial'; then
+if ! python -c 'import mercurial'; then
 	skip_all=3D'skipping remote-hg tests; mercurial not available'
 	test_done
 fi
=20
-if ! "$PYTHON_PATH" -c 'import hggit'; then
+if ! python -c 'import hggit'; then
 	skip_all=3D'skipping remote-hg tests; hg-git not available'
 	test_done
 fi
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers=
/test-hg.sh
index 8de2aa7..ce03fa3 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -15,7 +15,7 @@ if ! test_have_prereq PYTHON; then
 	test_done
 fi
=20
-if ! "$PYTHON_PATH" -c 'import mercurial'; then
+if ! python -c 'import mercurial'; then
 	skip_all=3D'skipping remote-hg tests; mercurial not available'
 	test_done
 fi
--=20
1.8.3.rc2.542.g24820ba
