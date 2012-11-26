From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 02/11] t/test-lib-functions.sh: allow to specify the tag name to test_commit
Date: Sun, 25 Nov 2012 17:45:50 -0800
Message-ID: <1353894359-6733-3-git-send-email-drafnel@gmail.com>
References: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Cc: pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 02:47:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcnmm-00074p-53
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 02:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473Ab2KZBqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 20:46:46 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39847 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412Ab2KZBqp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 20:46:45 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so7623405pbc.19
        for <git@vger.kernel.org>; Sun, 25 Nov 2012 17:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=VmQTcQlAu7tH+Pn8fYUruA2r+x7D/UNBIFYlXhYORhs=;
        b=sMRKbmWtmcNEszYx7ezNEn+Oe8ecT/Jw7McWYrveVoC7Cf7rOv28kqsu8jmzJZeup6
         HctZupdU46a1Nmi5lGzfJR6YCti4tQmWQlR0usc+AjhWH1lwYp3q2iuirRfdwrVhk3qs
         6fN2PW8TR9MwaEz2RetoUnWErcRQj8Fk+OmFinbgNpzii7M1AWkihtx83HRxsM6HwPTu
         iZInUkAmvqPLNSzCXVquFJtfG3DBJzkSodDW4znf24MkxJGSlMhmvnNEYQVGW0gWuLm3
         D6vIGyRXUIXmOKDveOIIZ5qnWdwXodKHXqMOGWrHusF+pYkqs8QcCLcQ2jdnX5G0hDqt
         0i9w==
Received: by 10.68.224.8 with SMTP id qy8mr32641511pbc.88.1353894405286;
        Sun, 25 Nov 2012 17:46:45 -0800 (PST)
Received: from charliebrown.sbx05686.santaca.wayport.net (dhcp64-134-221-228.hoic.dca.wayport.net. [64.134.221.228])
        by mx.google.com with ESMTPS id ot5sm7828428pbb.29.2012.11.25.17.46.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Nov 2012 17:46:44 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353894359-6733-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210392>

The <message> part of test_commit() may not be appropriate for a tag name.
So let's allow test_commit to accept a fourth argument to specify the tag
name.

Signed-off-by: Brandon Casey <bcasey@nvidia.com>
---
 t/test-lib-functions.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 8889ba5..9e2b8b8 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -135,12 +135,13 @@ test_pause () {
 	fi
 }
 
-# Call test_commit with the arguments "<message> [<file> [<contents>]]"
+# Call test_commit with the arguments "<message> [<file> [<contents> [<tag>]]]"
 #
 # This will commit a file with the given contents and the given commit
-# message.  It will also add a tag with <message> as name.
+# message.  It will also add a tag with <message> as name unless <tag> is
+# given.
 #
-# Both <file> and <contents> default to <message>.
+# <file>, <contents>, and <tag> all default to <message>.
 
 test_commit () {
 	notick= &&
@@ -168,7 +169,7 @@ test_commit () {
 		test_tick
 	fi &&
 	git commit $signoff -m "$1" &&
-	git tag "$1"
+	git tag "${4:-$1}"
 }
 
 # Call test_merge with the arguments "<message> <commit>", where <commit>
-- 
1.8.0.284.g959048a
