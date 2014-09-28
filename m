From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH] Use SHELL_PATH as hash bang in test suite askpass helper script.
Date: Sun, 28 Sep 2014 23:21:07 +0100
Message-ID: <1411942867-3995-1-git-send-email-bdwalton@gmail.com>
Cc: git@vger.kernel.org, Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 29 00:20:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XYMpr-0002dB-IM
	for gcvg-git-2@plane.gmane.org; Mon, 29 Sep 2014 00:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbaI1WUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2014 18:20:51 -0400
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:36986 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbaI1WUv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2014 18:20:51 -0400
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:48220 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1XYMpm-00014P-LS ; Sun, 28 Sep 2014 18:20:50 -0400
Received: from 86-42-132-115-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.132.115]:56665 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bwalton@benandwen.net>)
	 id 1XYMpd-0000dY-Em ; Sun, 28 Sep 2014 18:20:41 -0400
Received: from bwalton by neilyoung with local (Exim 4.82)
	(envelope-from <bwalton@benandwen.net>)
	id 1XYMq6-000130-Ax; Sun, 28 Sep 2014 23:21:10 +0100
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257614>

The askpass script that is created for use by the test suite should
use SHELL_PATH for its hash bang instead of /bin/sh. Commit 5a4352024
introduced the use of idioms not supported in some legacy /bin/sh
implementations.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 t/lib-credential.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/lib-credential.sh b/t/lib-credential.sh
index 9e7d796..ca4a6de 100755
--- a/t/lib-credential.sh
+++ b/t/lib-credential.sh
@@ -278,8 +278,8 @@ helper_test_timeout() {
 	'
 }
 
-cat >askpass <<\EOF
-#!/bin/sh
+echo "#!$SHELL_PATH" >askpass
+cat >>askpass <<\EOF
 echo >&2 askpass: $*
 what=$(echo $1 | cut -d" " -f1 | tr A-Z a-z | tr -cd a-z)
 echo "askpass-$what"
-- 
1.9.1
