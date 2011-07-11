From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 03/17] revert: Don't check lone argument in get_encoding
Date: Mon, 11 Jul 2011 14:53:54 +0000
Message-ID: <1310396048-24925-4-git-send-email-artagnon@gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 16:54:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgHsd-0005F4-1C
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 16:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757769Ab1GKOyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 10:54:18 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46637 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756001Ab1GKOyR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 10:54:17 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so2716724vxb.19
        for <git@vger.kernel.org>; Mon, 11 Jul 2011 07:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3NnFVc+To6ARfIdPAKWLAhB1WNgfV601ekz2wzXVgMI=;
        b=ci/Uea9B1iMQaq8lC5OX7quHRrkpRqC9uqTQM5Iy6ig5t8Rm6DLe4KJp628a9MHZCp
         Pl4TZcmZztfGrwODEPq+U8sFXUZ9Cy0lq+J3dd0RQm9TXWh6kQsfTIBQ50PTKyirwznz
         aCXVdLGdtcAG7WYpJ5gnWfPz3rq6jp1s17Xos=
Received: by 10.52.116.242 with SMTP id jz18mr2402110vdb.379.1310396056905;
        Mon, 11 Jul 2011 07:54:16 -0700 (PDT)
Received: from localhost.localdomain (ec2-184-72-137-52.compute-1.amazonaws.com [184.72.137.52])
        by mx.google.com with ESMTPS id b9sm4510527vdk.25.2011.07.11.07.54.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jul 2011 07:54:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176845>

The get_encoding function has only one callsite, and its caller makes
sure that a NULL argument isn't passed.  Don't unnecessarily double
check the same argument in get_encoding.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index f88e007..6c826e1 100644
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
1.7.5.GIT
