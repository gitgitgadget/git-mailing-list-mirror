From: Brian Campbell <brian.p.campbell@Dartmouth.EDU>
Subject: [PATCH 1/2] [TopGit] Portability: Use tr instead of sed for translating spaces to newlines
Date: Thu, 12 Mar 2009 01:56:28 -0400
Message-ID: <1236837389-35687-1-git-send-email-brian.p.campbell@dartmouth.edu>
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Brian Campbell <brian.p.campbell@Dartmouth.EDU>
To: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Mar 12 07:11:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhe8y-00009C-D8
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 07:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbZCLGKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 02:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbZCLGKL
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 02:10:11 -0400
Received: from mailhub2.dartmouth.edu ([129.170.17.107]:42246 "EHLO
	mailhub2.dartmouth.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbZCLGKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 02:10:09 -0400
Received: from localhost.localdomain (c-75-69-96-104.hsd1.nh.comcast.net [75.69.96.104])
	(authenticated bits=0)
	by mailhub2.dartmouth.edu (8.13.5/DND2.0/8.13.5) with ESMTP id n2C5uUum012861
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 12 Mar 2009 01:56:31 -0400
X-Mailer: git-send-email 1.6.2.185.g8b635.dirty
X-MailScanner: Found to be clean by mailhub.Dartmouth.EDU
X-MailScanner-From: brian.p.campbell@dartmouth.edu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113003>

It is not portable to use \n in the replacement of a sed substitute
command.  On Mac OS X (and presumably FreeBSD, as Mac OS X uses
sed from FreeBSD), \n in the replacement of a substitution gives a
literal "n" instead of a newline.

This patch replaces the sed command with tr, which should be more
portable.

Signed-off-by: Brian Campbell <brian.p.campbell@dartmouth.edu>
---
 tg-create.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tg-create.sh b/tg-create.sh
index 2edd537..ef9a955 100644
--- a/tg-create.sh
+++ b/tg-create.sh
@@ -116,7 +116,7 @@ done
 git update-ref "refs/top-bases/$name" "HEAD" ""
 git checkout -b "$name"
 
-echo "$deps" | sed 's/ /\n/g' >"$root_dir/.topdeps"
+echo "$deps" | tr ' ' '\n' >"$root_dir/.topdeps"
 git add -f "$root_dir/.topdeps"
 
 author="$(git var GIT_AUTHOR_IDENT)"
-- 
1.6.2.185.g8b635.dirty
