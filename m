From: Johan Herland <johan@herland.net>
Subject: [PATCH 4/3] --dirstat: In case of renames,
 use target filename instead of source filename
Date: Tue, 12 Apr 2011 11:24:34 +0200
Message-ID: <201104121124.35128.johan@herland.net>
References: <7vtye834al.fsf@alter.siamese.dyndns.org>
 <7vwrj0sap3.fsf@alter.siamese.dyndns.org>
 <201104121122.56870.johan@herland.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	johan@herland.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 11:24:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Zq2-0006My-HW
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 11:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756895Ab1DLJYi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 05:24:38 -0400
Received: from smtp.getmail.no ([84.208.15.66]:40836 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756880Ab1DLJYh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 05:24:37 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJJ0060O8T04J90@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 12 Apr 2011 11:24:36 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 328201EA57EB_DA41A54B	for <git@vger.kernel.org>; Tue,
 12 Apr 2011 09:24:36 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id AC10E1EA2BC8_DA41A53F	for <git@vger.kernel.org>; Tue,
 12 Apr 2011 09:24:35 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJJ00EG48SZEZ20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 12 Apr 2011 11:24:35 +0200 (MEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-ARCH; KDE/4.6.2; x86_64; ; )
In-reply-to: <201104121122.56870.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171385>

This changes --dirstat analysis to count "damage" toward the target filename,
rather than the source filename. For renames within a directory, this won't
matter to the final output, but when moving files between diretories, the
output now lists the target directory rather than the source directory.

Signed-off-by: Johan Herland <johan@herland.net>
---
 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 3e0bc1f..5376d01 100644
--- a/diff.c
+++ b/diff.c
@@ -1540,7 +1540,7 @@ static void show_dirstat(struct diff_options *options)
 		unsigned long copied, added, damage;
 		int content_changed;
 
-		name = p->one->path ? p->one->path : p->two->path;
+		name = p->two->path ? p->two->path : p->one->path;
 
 		if (p->one->sha1_valid && p->two->sha1_valid)
 			content_changed = hashcmp(p->one->sha1, p->two->sha1);
-- 
1.7.5.rc1.3.g4d7b



-- 
Johan Herland, <johan@herland.net>
www.herland.net
