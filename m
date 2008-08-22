From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t9301-fast-export: move unset of config variable into its
 own test function
Date: Thu, 21 Aug 2008 19:48:49 -0500
Message-ID: <ZdQ6b4vecqtrZ-7Mze6M9UBwrI9qQRUu-BoApXUv0v2zM76stzXd3w@cipher.nrlssc.navy.mil>
References: <7vtzdhkfo2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 02:51:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWKsB-0005vt-TO
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 02:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562AbYHVAs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 20:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754429AbYHVAs6
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 20:48:58 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58126 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbYHVAs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 20:48:57 -0400
Received: by mail.nrlssc.navy.mil id m7M0mnik008938; Thu, 21 Aug 2008 19:48:49 -0500
In-Reply-To: <7vtzdhkfo2.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 22 Aug 2008 00:48:49.0164 (UTC) FILETIME=[D70B34C0:01C903F0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93239>

On platforms with a broken iconv it may be necessary to skip the fourth
test in this script. Test four sets the i18n.commitencoding config variable.
If test four is skipped, then a later unset of the i18n.commitencoding
config variable will return a non-zero exit status and cause a test to fail.
So move the 'config --unset' into its own test function which allows it to
be skipped independently.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t9301-fast-export.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 3cb9f80..41d444d 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -185,12 +185,17 @@ test_expect_success 'submodule fast-export | fast-import' '
 
 '
 
+test_expect_success 'unset i18n.commitencoding' '
+
+	git config --unset i18n.commitencoding
+
+'
+
 export GIT_AUTHOR_NAME='A U Thor'
 export GIT_COMMITTER_NAME='C O Mitter'
 
 test_expect_success 'setup copies' '
 
-	git config --unset i18n.commitencoding &&
 	git checkout -b copy rein &&
 	git mv file file3 &&
 	git commit -m move1 &&
-- 
1.6.0.21.g35a2e
