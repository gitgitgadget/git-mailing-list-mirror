From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH v2] am: invoke perl's strftime in C locale
Date: Tue, 15 Jan 2013 02:36:52 +0400
Message-ID: <20130114223651.GA26443@altlinux.org>
References: <20130114205933.GA25947@altlinux.org> <7vr4ln8mgd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 23:37:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tuseb-0003V2-P1
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 23:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759010Ab3ANWg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 17:36:56 -0500
Received: from vint.altlinux.org ([194.107.17.35]:37612 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758989Ab3ANWgy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 17:36:54 -0500
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id 084F2226C0AA;
	Mon, 14 Jan 2013 22:36:53 +0000 (UTC)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id 8E07F519000D; Tue, 15 Jan 2013 02:36:52 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <7vr4ln8mgd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213538>

This fixes "hg" patch format support for locales other than C and en_*.
Before the change, git-am was making "Date:" line from hg changeset
metadata according to the current locale, and this line was rejected
later with "invalid date format" diagnostics because localized date
strings are not supported.

Reported-by: Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

 v2: replaced "unfriendly" URL with a short description

 git-am.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-am.sh b/git-am.sh
index c682d34..64b88e4 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -334,7 +334,7 @@ split_patches () {
 			# Since we cannot guarantee that the commit message is in
 			# git-friendly format, we put no Subject: line and just consume
 			# all of the message as the body
-			perl -M'POSIX qw(strftime)' -ne 'BEGIN { $subject = 0 }
+			LC_ALL=C perl -M'POSIX qw(strftime)' -ne 'BEGIN { $subject = 0 }
 				if ($subject) { print ; }
 				elsif (/^\# User /) { s/\# User/From:/ ; print ; }
 				elsif (/^\# Date /) {

-- 
ldv
