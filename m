From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 04/18] revert: Don't check lone argument in get_encoding
Date: Thu, 28 Jul 2011 22:22:17 +0530
Message-ID: <1311871951-3497-5-git-send-email-artagnon@gmail.com>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 18:55:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmTsL-0003XD-V9
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 18:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755787Ab1G1Qzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 12:55:55 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:60323 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773Ab1G1Qzz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 12:55:55 -0400
Received: by gxk21 with SMTP id 21so1954221gxk.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 09:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7dQHi8FCMVNQxGfcyA3i8k2GPTJzPEB966p3U1EkXYk=;
        b=m1BgpwBoVpmN9R2JoDeF3DcLjNApN0lO2V5oAGlc1/QS2aNxnqY3PFC686jlgWFFMa
         l6lSKUZ97cWAhp31Ci9HEVV5jfh3QDFFuNq3ExzoCzDGsTdmjhjnZW3a98paA/H5fb6N
         V3iMYafDXHYhKbk4Jdn/gYVuZGFVs2C11vXXg=
Received: by 10.42.117.73 with SMTP id s9mr129327icq.455.1311872154366;
        Thu, 28 Jul 2011 09:55:54 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id ue1sm1497759icb.8.2011.07.28.09.55.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 09:55:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178083>

The only place get_encoding uses the global "commit" variable is when
writing an error message explaining that its lone argument was NULL.
Since the function's only caller ensures that a NULL argument isn't
passed, we can remove this check wtih two beneficial consequences:

1. Since the function doesn't use the global "commit" variable any
   more, it won't need to change when we eliminate the global variable
   later in the series.
2. Translators no longer need to localize an error message that'll
   never be shown.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Jonathan Nieder <jrnieder@gmail.com>
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
