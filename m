From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH] Don't parse any headers in the real body of an email message.
Date: Mon, 12 Jun 2006 13:48:35 -0600
Message-ID: <m18xo25f58.fsf_-_@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.64.0606111535310.5498@g5.osdl.org>
	<m1wtbn468o.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0606111735440.5498@g5.osdl.org>
	<m13bea6w13.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0606121204220.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 21:49:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpsP6-0005oj-30
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 21:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWFLTst (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 15:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWFLTst
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 15:48:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:40103 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932140AbWFLTss (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 15:48:48 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Debian-1) with ESMTP id k5CJmZXw007126;
	Mon, 12 Jun 2006 13:48:35 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Submit) id k5CJmZHi007125;
	Mon, 12 Jun 2006 13:48:35 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0606121204220.5498@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 12 Jun 2006 12:10:27 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21736>


It was pointed out that the current behaviour might mispart a patch comment
so remove this behaviour for now.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 mailinfo.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 3696d61..325c3b2 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -254,6 +254,8 @@ #define SEEN_PREFIX  020
 /* First lines of body can have From:, Date:, and Subject: or be blank */
 static void handle_inbody_header(int *seen, char *line)
 {
+	if (*seen & SEEN_PREFIX)
+		return;
 	if (!memcmp(">From", line, 5) && isspace(line[5])) {
 		if (!(*seen & SEEN_BOGUS_UNIX_FROM)) {
 			*seen |= SEEN_BOGUS_UNIX_FROM;
-- 
1.4.0.g25f48-dirty
