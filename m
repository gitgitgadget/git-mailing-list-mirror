From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 09/19] reset.c: replace switch by if-else
Date: Wed,  9 Jan 2013 00:16:06 -0800
Message-ID: <1357719376-16406-10-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:17:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsqr8-0002P4-Kc
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757353Ab3AIIRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:17:21 -0500
Received: from mail-ea0-f202.google.com ([209.85.215.202]:50363 "EHLO
	mail-ea0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757287Ab3AIIRG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:17:06 -0500
Received: by mail-ea0-f202.google.com with SMTP id j12so91350eaa.5
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=UiDzwY3XcRADXxK7/ezhCRJI1XOAFY+s/mw0pCNZDqo=;
        b=j80vDDPXZ+xMaAsBOsRnnTd6bF/oyVf1ybq+GgnD/DP/pXjU0yfxTxIWNVuI8eNWgW
         Zg+iuZ1SGXqxEhdNva9oIHaU9n1e/tQxT/nSW2MNUfij1dH4mxs+z4qM0tu9o2td4Pw2
         ZTBEABnhbepNYGlGtN4bPxB15bJ+bQuHE4Xu2gjmlBDdiezaL7Nr9JVtReDbOQ1JyEMr
         01PvaFXA8pC4AYGAinTFsBywa30CE0Yzqn3MgOfW5nZNaAubcNocwSNCsf0yDuNiotNN
         L2hCseqxcRYWD5rpSUZxcAvAhU4wnRmEUB3SyF5kNazhGfiesxpXU1/ltrfHOJcJ72Na
         Wu4Q==
X-Received: by 10.14.208.198 with SMTP id q46mr83817214eeo.0.1357719425397;
        Wed, 09 Jan 2013 00:17:05 -0800 (PST)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id g9si11043600eeo.1.2013.01.09.00.17.05
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:17:05 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id ED2E5200069;
	Wed,  9 Jan 2013 00:17:04 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 329E3102FCC; Wed,  9 Jan 2013 00:17:04 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQmT7q9FV74TCKeieED/XTxrdsCOG292r1/tx1/SFQXPkjeBp7Uimv8hOsi2TAs1kMgoYwI82EvvXWVpa69JQWovXiSs0Iv/lS094o7fcnmLr5Cb5IV+2l0fZQcnh2AuNpR7IsvT5Wo7QFedG17USHcgJcFPDgKv/TT1H06PwRr8cmAUhqislqi5bVejkxm5wkYqCF8D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213037>

---
 builtin/reset.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 42d1563..05ccfd4 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -351,18 +351,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	 * saving the previous head in ORIG_HEAD before. */
 	update_ref_status = update_refs(rev, sha1);
 
-	switch (reset_type) {
-	case HARD:
-		if (!update_ref_status && !quiet)
-			print_new_head_line(commit);
-		break;
-	case SOFT: /* Nothing else to do. */
-		break;
-	case MIXED: /* Report what has not been updated. */
+	if (reset_type == HARD && !update_ref_status && !quiet)
+		print_new_head_line(commit);
+	else if (reset_type == MIXED) /* Report what has not been updated. */
 		update_index_refresh(0, NULL,
 				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
-		break;
-	}
 
 	remove_branch_state();
 
-- 
1.8.1.rc3.331.g1ef2165
