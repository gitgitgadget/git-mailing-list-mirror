From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] guilt: fix date parsing
Date: Tue, 21 May 2013 23:13:31 -0400
Message-ID: <1369192411-8842-1-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
To: jeffpc@josefsipek.net
X-From: git-owner@vger.kernel.org Wed May 22 05:13:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UezUm-0001WS-U2
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 05:13:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845Ab3EVDNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 23:13:38 -0400
Received: from li9-11.members.linode.com ([67.18.176.11]:50514 "EHLO
	imap.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754529Ab3EVDNg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 23:13:36 -0400
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1UezXD-0004Ad-7Z; Wed, 22 May 2013 03:16:15 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id CB1ED580FC5; Tue, 21 May 2013 23:13:31 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc0.22.gcdd159b
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225125>

If the date field has a space in it, such as:

   Date: Tue, 14 May 2013 18:37:15 +0200

previously guilt would go belly up:

   + export GIT_AUTHOR_DATE=Tue, 14 May 2013 18:37:15 +0200
   /usr/local/bin/guilt: 571: export: 14: bad variable name

Fix this.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 guilt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/guilt b/guilt
index 9953bdf..6e8d542 100755
--- a/guilt
+++ b/guilt
@@ -568,7 +568,7 @@ commit()
 				author_date_str=`sed -n -e '/^Date:/ { s/^Date: //; p; q; }; /^(diff |---$|--- )/ q' "$p"`
 			fi
 			if [ ! -z "$author_date_str" ]; then
-				export GIT_AUTHOR_DATE=`echo $author_date_str`
+				export GIT_AUTHOR_DATE="$author_date_str"
 			fi
 		fi
 
-- 
1.7.12.rc0.22.gcdd159b
