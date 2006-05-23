From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 4/6] In handle_body only read a line if we don't already
 have one.
Date: Tue, 23 May 2006 13:49:00 -0600
Message-ID: <m1r72kiksz.fsf_-_@ebiederm.dsl.xmission.com>
References: <m18xosjznu.fsf@ebiederm.dsl.xmission.com>
	<m14pzgjzlg.fsf@ebiederm.dsl.xmission.com>
	<m1zmh8ikym.fsf_-_@ebiederm.dsl.xmission.com>
	<m1verwikvj.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 23 21:49:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fict5-0003cK-O8
	for gcvg-git@gmane.org; Tue, 23 May 2006 21:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWEWTtt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 15:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWEWTtt
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 15:49:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52611 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751170AbWEWTtt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 15:49:49 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4NJn0Bc020731;
	Tue, 23 May 2006 13:49:00 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4NJn0Q0020730;
	Tue, 23 May 2006 13:49:00 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <m1verwikvj.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Tue, 23 May 2006 13:47:28 -0600")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20627>


This prepares for detecting non-email patches that don't have
mail headers.  In which case we have already read the first
line so handle_body should not ignore it.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 mailinfo.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

3ad0c255a351d771c7f301d4a4e9bfb6fdcbde5f
diff --git a/mailinfo.c b/mailinfo.c
index 3fa9505..99989c2 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -724,7 +724,7 @@ static void handle_body(void)
 {
 	int seen = 0;
 
-	if (fgets(line, sizeof(line), stdin) != NULL) {
+	if (line[0] || fgets(line, sizeof(line), stdin) != NULL) {
 		handle_commit_msg(&seen);
 		handle_patch();
 	}
-- 
1.3.2.g5041c-dirty
