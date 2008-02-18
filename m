From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 07/12] peel_onion: handle NULL
Date: Mon, 18 Feb 2008 21:47:58 +0100
Message-ID: <1203367683563-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12033676833730-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832769-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832231-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832653-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676833341-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676831961-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:49:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRCve-0000iE-A4
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 21:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbYBRUsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 15:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755928AbYBRUsS
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 15:48:18 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:40285 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761432AbYBRUsH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 15:48:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 75DAD6CF006D;
	Mon, 18 Feb 2008 21:48:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J9lZ03yUrSFJ; Mon, 18 Feb 2008 21:48:04 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id E5B686CF0061; Mon, 18 Feb 2008 21:48:03 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12033676831961-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74349>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 sha1_name.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index f8506bf..c2805e7 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -494,8 +494,11 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 				return error("%.*s: expected %s type, but the object dereferences to %s type",
 					     len, name, typename(expected_type),
 					     typename(o->type));
+			if (!o)
+				return -1;
 			if (!o->parsed)
-				parse_object(o->sha1);
+				if (!parse_object(o->sha1))
+					return -1;
 		}
 	}
 	return 0;
-- 
1.5.4.1.g96b77
