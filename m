From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH 2/3] Fix sed usage in tests to work around broken xpg4/sed on Solaris
Date: Sun, 19 Jul 2015 19:00:35 +0100
Message-ID: <1437328836-19156-3-git-send-email-bdwalton@gmail.com>
References: <1437328836-19156-1-git-send-email-bdwalton@gmail.com>
Cc: git@vger.kernel.org, sunshine@sunshineco.com, j6t@kdbg.org,
	johannes.schindelin@gmx.de, Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jul 19 19:58:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGsrO-00009o-JQ
	for gcvg-git-2@plane.gmane.org; Sun, 19 Jul 2015 19:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbbGSR6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2015 13:58:41 -0400
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:44635 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797AbbGSR6j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2015 13:58:39 -0400
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:35484 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bdwalton@benandwen.net>)
	 id 1ZGsrG-00036h-JP ; Sun, 19 Jul 2015 13:58:38 -0400
Received: from 86-42-134-176-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.134.176]:38625 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bdwalton@benandwen.net>)
	 id 1ZGsrF-0007fr-QF ; Sun, 19 Jul 2015 13:58:38 -0400
Received: from bdwalton by neilyoung with local (Exim 4.84)
	(envelope-from <bdwalton@benandwen.net>)
	id 1ZGstF-0004zq-Ns; Sun, 19 Jul 2015 19:00:41 +0100
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1437328836-19156-1-git-send-email-bdwalton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274271>

The space following the last / in a sed command caused Solaris'
xpg4/sed to fail, claiming the program was garbled and exit with
status 2:

% echo 'foo' | /usr/xpg4/bin/sed -e 's/foo/bar/ '
sed: command garbled: s/foo/bar/
% echo $?
2

Fix this by simply removing the unnecessary space.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 t/t5601-clone.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 8299d14..8b7f8e1 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -445,7 +445,7 @@ test_expect_success 'clone ssh://host.xz:22/~repo' '
 #IPv6
 for tuah in ::1 [::1] [::1]: user@::1 user@[::1] user@[::1]: [user@::1] [user@::1]:
 do
-	ehost=$(echo $tuah | sed -e "s/1]:/1]/ " | tr -d "$squarebrackets")
+	ehost=$(echo $tuah | sed -e "s/1]:/1]/" | tr -d "$squarebrackets")
 	test_expect_success "clone ssh://$tuah/home/user/repo" "
 	  test_clone_url ssh://$tuah/home/user/repo $ehost /home/user/repo
 	"
-- 
2.1.4
