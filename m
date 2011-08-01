From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 04/18] revert: Don't check lone argument in get_encoding
Date: Mon,  1 Aug 2011 23:36:51 +0530
Message-ID: <1312222025-28453-5-git-send-email-artagnon@gmail.com>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:11:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnwxV-0003iO-Jx
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934Ab1HASLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:11:13 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49381 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab1HASLL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:11:11 -0400
Received: by gwaa12 with SMTP id a12so1565207gwa.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=OS2AuB1N3W4bpL7Y3R7MONSRy55whvKWgoEmVIVa4Mg=;
        b=Ld8g2uQIz0DiOPglErCwYxn47sXQy1emjiOGQGj3ZU9YW/euwcq/QfldICmQab9nCh
         xtYWNwRwJfmwYms9wZbdA7cgvG47cInhDE3hZQmZwgM+Q3D4hQPt6Y0qmzc99h9qPsNH
         xFa/aIhGk6L9y+YQVYNTuYiAS86fWS+Z4foO4=
Received: by 10.68.19.197 with SMTP id h5mr4769209pbe.93.1312222270220;
        Mon, 01 Aug 2011 11:11:10 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d3sm5789958pbh.37.2011.08.01.11.11.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 01 Aug 2011 11:11:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178375>

The only place get_encoding uses the global "commit" variable is when
writing an error message explaining that its lone argument was NULL.
Since the function's only caller ensures that a NULL argument isn't
passed, we can remove this check with two beneficial consequences:

1. Since the function doesn't use the global "commit" variable any
   more, it won't need to change when we eliminate the global variable
   later in the series.
2. Translators no longer need to localize an error message that will
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
