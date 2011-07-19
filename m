From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 04/18] revert: Don't check lone argument in get_encoding
Date: Tue, 19 Jul 2011 22:47:42 +0530
Message-ID: <1311095876-3098-5-git-send-email-artagnon@gmail.com>
References: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 19 19:19:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjDwl-0002wg-Su
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 19:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187Ab1GSRTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 13:19:00 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36451 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab1GSRS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 13:18:57 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so4030753pvg.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zH4jtYIMaNijlWLhSnRRUUmjlqcFtudxvRPPc6Q68Zo=;
        b=Zga3rc2kR9We0X/0JY4QDU99hfP3aT3VkAMaUrQmHq6Ycc73wDe0zUSG71xBl4aRAE
         untrJWlHsa2RUjyE0eM7MQg5lDX0mt9wJLfHM/garmhpYg60Qa7QryDO8UGlDqFBuiIO
         XN3F2rGrv1LfCU11UDevQ9p0Gmr8KQMSb439M=
Received: by 10.142.195.6 with SMTP id s6mr1479509wff.167.1311095937345;
        Tue, 19 Jul 2011 10:18:57 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id r12sm4276415wfe.1.2011.07.19.10.18.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 10:18:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311095876-3098-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177469>

The get_encoding function has only one callsite, and its caller makes
sure that a NULL argument isn't passed.  Remove a string marked for
translation that will never be shown by not unnecessarily
double-checking the argument.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 7dfe295..30b39c0 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -167,9 +167,6 @@ static char *get_encoding(const char *message)
 {
 	const char *p = message, *eol;
 
-	if (!p)
-		die (_("Could not read commit message of %s"),
-				sha1_to_hex(commit->object.sha1));
 	while (*p && *p != '\n') {
 		for (eol = p + 1; *eol && *eol != '\n'; eol++)
 			; /* do nothing */
-- 
1.7.4.rc1.7.g2cf08.dirty
