From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: [PATCH 1/6] templates: Use heredoc in pre-commit hook
Date: Sun, 14 Jul 2013 18:21:14 +0200
Message-ID: <1373818879-1698-2-git-send-email-richih.mailinglist@gmail.com>
References: <CAD77+gSX1ggBWHhGwxRUBPGQ6ONJd76SO-3tU05QT47iKCv9hg@mail.gmail.com>
 <1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
Cc: Richard Hartmann <richih.mailinglist@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 14 18:21:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyP3F-0006sj-4Q
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 18:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735Ab3GNQV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 12:21:29 -0400
Received: from mail-bk0-f43.google.com ([209.85.214.43]:58560 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab3GNQV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 12:21:27 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm2so4334763bkc.16
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 09:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=G5GneQKV9gsuCiU1ahaYVTXvjS6HHJVzeqfK+JsvUYo=;
        b=paISs481rpv7B1UwsSMRpO/RlShxL3wQwwMTiRrDEbfw0IVC+R8Ee8p2TaiDRINw7K
         yiI09ITKdZm1GWf7muQM0GgU5gwLONvRa35u2XqvlnzrD2vUW1MLnUoKJdXAypOq//xE
         16CBztWI6NM9AyNMfhxseJhbKxtPxl6sGr0/gbT8vjSoBU08NDkb/ICga6ojslfbLbk0
         ltBD7vsDCDQwRMSd/TxXXUdvsb3G2/LkNtzJFOrc72iO2JbzKRyAiD+BWReyfXDScIea
         3Smj4h6khZPkWZ74m6lteXGRz8dXHOBt6/7CZvG7bYAPQzu/xeRolnroRqSsr24wRLsI
         7N3g==
X-Received: by 10.204.238.136 with SMTP id ks8mr7428472bkb.32.1373818883279;
        Sun, 14 Jul 2013 09:21:23 -0700 (PDT)
Received: from rockhopper.fritz.box (p5499AB9B.dip0.t-ipconnect.de. [84.153.171.155])
        by mx.google.com with ESMTPSA id ct12sm496595bkb.12.2013.07.14.09.21.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 09:21:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230371>

Spawning a new subprocess for every line printed is inefficient.
Use heredoc, instead.

Based on 98770971aef8d1cbc78876d9023d10aa25df0526 in original patch
series from 2013-06-10.

Signed-off-by: Richard Hartmann <richih.mailinglist@gmail.com>
---
 templates/hooks--pre-commit.sample |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index 18c4829..889967c 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -31,18 +31,19 @@ if [ "$allownonascii" != "true" ] &&
 	test $(git diff --cached --name-only --diff-filter=A -z $against |
 	  LC_ALL=C tr -d '[ -~]\0' | wc -c) != 0
 then
-	echo "Error: Attempt to add a non-ascii file name."
-	echo
-	echo "This can cause problems if you want to work"
-	echo "with people on other platforms."
-	echo
-	echo "To be portable it is advisable to rename the file ..."
-	echo
-	echo "If you know what you are doing you can disable this"
-	echo "check using:"
-	echo
-	echo "  git config hooks.allownonascii true"
-	echo
+	cat <<-EOF
+Error: Attempt to add a non-ascii file name.
+
+This can cause problems if you want to work
+with people on other platforms.
+
+To be portable it is advisable to rename the file.
+
+If you know what you are doing you can disable this
+check using:
+
+  git config hooks.allownonascii true
+EOF
 	exit 1
 fi
 
-- 
1.7.10.4
