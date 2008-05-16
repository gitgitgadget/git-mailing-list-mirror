From: Marcel Koeppen <git-dev@marzelpan.de>
Subject: [PATCH] Replace in-place sed in t7502-commit
Date: Fri, 16 May 2008 02:21:43 +0200
Message-ID: <1210897303-80828-1-git-send-email-git-dev@marzelpan.de>
References: <7vwslwgdyi.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, sbejar@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 16 02:22:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwniX-0002Rj-Mp
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 02:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684AbYEPAVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 20:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbYEPAVs
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 20:21:48 -0400
Received: from smtprelay08.ispgateway.de ([80.67.29.8]:39415 "EHLO
	smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbYEPAVr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 20:21:47 -0400
Received: from [80.145.222.138] (helo=localhost.localdomain)
	by smtprelay08.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <git-dev@marzelpan.de>)
	id 1Jwnhg-0006Ed-CV; Fri, 16 May 2008 02:21:44 +0200
X-Mailer: git-send-email 1.5.5.1.215.g64c0d
In-Reply-To: <7vwslwgdyi.fsf@gitster.siamese.dyndns.org>
X-Df-Sender: 893553
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82249>

The in-place mode of sed used in t7502-commit is a non-POSIX extension.
That call of sed is replaced by a more portable version using a temporary file.

Signed-off-by: Marcel Koeppen <git-dev@marzelpan.de>
---
 t/t7502-commit.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 018060c..3531a99 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -166,7 +166,9 @@ test_expect_success 'author different from committer' '
 	test_cmp expect actual
 '
 
-sed -i '$d' expect
+mv expect expect.tmp
+sed '$d' < expect.tmp > expect
+rm -f expect.tmp
 echo "# Committer:
 #" >> expect
 unset GIT_COMMITTER_EMAIL
-- 
1.5.5.1.215.g64c0d
