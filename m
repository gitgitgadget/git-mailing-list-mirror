From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] Fix detection of uname failure
Date: Fri, 17 Jul 2015 13:11:35 +0100
Message-ID: <1437135095-6244-1-git-send-email-charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 17 14:11:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG4UU-0000dJ-1L
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 14:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbbGQMLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 08:11:42 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:39237 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbbGQMLl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 08:11:41 -0400
Received: from hashpling.plus.com ([212.159.69.125]:39159)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1ZG4UN-0006yT-Bo; Fri, 17 Jul 2015 13:11:39 +0100
X-Mailer: git-send-email 2.4.0.53.g8440f74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274066>

From: Charles Bailey <cbailey32@bloomberg.net>

According to POSIX specification uname must return -1 on failure and a
non-negative value on success. Although many implementations do return 0
on success it is valid to return any positive value for success.  In
particular, Solaris returns 1.

Signed-off-by: Charles Bailey <cbailey32@bloomberg.net>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 8209f8b..52dbfd0 100644
--- a/dir.c
+++ b/dir.c
@@ -1848,7 +1848,7 @@ static const char *get_ident_string(void)
 
 	if (sb.len)
 		return sb.buf;
-	if (uname(&uts))
+	if (uname(&uts) == -1)
 		die_errno(_("failed to get kernel name and information"));
 	strbuf_addf(&sb, "Location %s, system %s %s %s", get_git_work_tree(),
 		    uts.sysname, uts.release, uts.version);
-- 
2.4.0.53.g8440f74
