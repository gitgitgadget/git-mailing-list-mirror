From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH] Ensure SHELL_PATH is the hash bang for test suite askpass helper script.
Date: Mon, 29 Sep 2014 08:02:07 +0100
Message-ID: <1411974127-5258-1-git-send-email-bdwalton@gmail.com>
References: <20140928231428.GA9061@peff.net>
Cc: git@vger.kernel.org, Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com, peff@peff.net
X-From: git-owner@vger.kernel.org Mon Sep 29 09:01:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYUy3-0005hW-Ob
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 09:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbaI2HBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2014 03:01:52 -0400
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:37893 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbaI2HBv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2014 03:01:51 -0400
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:53806 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1XYUxx-0003uH-Fj ; Mon, 29 Sep 2014 03:01:49 -0400
Received: from 86-42-132-115-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.132.115]:57215 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1XYUxn-0007i0-Sz ; Mon, 29 Sep 2014 03:01:40 -0400
Received: from bwalton by neilyoung with local (Exim 4.82)
	(envelope-from <bwalton@benandwen.net>)
	id 1XYUyG-0001NS-Fo; Mon, 29 Sep 2014 08:02:08 +0100
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20140928231428.GA9061@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257616>

The askpass script that is created for use by the test suite should
use SHELL_PATH for its hash bang instead of /bin/sh. Commit 5a4352024
introduced the use of idioms not supported in some legacy /bin/sh
implementations.

Use write_script to ensure this happens automatically. This lets us
remove the chmod step as well, since write_script handles that.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 t/lib-credential.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 9e7d796..d8e41f7 100755
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -278,12 +278,10 @@ helper_test_timeout() {
 	'
 }
 
-cat >askpass <<\EOF
-#!/bin/sh
+write_script askpass <<\EOF
 echo >&2 askpass: $*
 what=$(echo $1 | cut -d" " -f1 | tr A-Z a-z | tr -cd a-z)
 echo "askpass-$what"
 EOF
-chmod +x askpass
 GIT_ASKPASS="$PWD/askpass"
 export GIT_ASKPASS
-- 
1.9.1
