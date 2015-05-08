From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] sequencer.c: abbreviate hashs placed in the middle of messages
Date: Fri,  8 May 2015 18:53:55 +0200
Message-ID: <1431104035-2056-1-git-send-email-ralf.thielow@gmail.com>
Cc: Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 08 18:54:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqlXd-0008Es-BX
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 18:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbbEHQyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 12:54:08 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:35255 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbbEHQyG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 12:54:06 -0400
Received: by wgyo15 with SMTP id o15so78001783wgy.2
        for <git@vger.kernel.org>; Fri, 08 May 2015 09:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=it9FGUsATTOBoIqjHjUaxqBI5t2pAG6ZflqWwr/Z3wE=;
        b=k0wos2p1DbnAK+mi78dRv/iHiMMUOF9OA+w2SuKS3dc4TfQ7i0sPxq8wh4jzzJDK/9
         3VhlBzysNq0kp37W07lpXmjNdB2kHbEH06EFap37QKOR5mTG9PHdibaXNJmodb/1qpV5
         n00AUZl+RN+DCosJmepmC8jTokd3jE3fGNUX4Id0FahLA9Re+J6M8kwBbv7Iyu5T1vmq
         MAhUksgncwrJPPILroNtX73M47lYU5b+HSS7l95fg1K1RgdyFfItLDfk75x7xugjVPJy
         sjcuVUYGpWRUudkYFkkGA1Gzn7aHl0IYk/lVS0owQRQsUZptbeIRkbJzZMW1KMgxoIXj
         xCFg==
X-Received: by 10.180.95.10 with SMTP id dg10mr7940268wib.41.1431104044214;
        Fri, 08 May 2015 09:54:04 -0700 (PDT)
Received: from localhost (dslb-092-078-236-214.092.078.pools.vodafone-ip.de. [92.78.236.214])
        by mx.google.com with ESMTPSA id i13sm13124469wic.13.2015.05.08.09.54.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 08 May 2015 09:54:02 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.228.gc627b12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268624>

Printing a 40 character sha1 hash in the middle of a message
stretches the sentence a lot. Print the abbreviated version
instead.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 sequencer.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index c4f4b7d..2a39ab6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -498,20 +498,21 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		struct commit_list *p;
 
 		if (!opts->mainline)
-			return error(_("Commit %s is a merge but no -m option was given."),
-				sha1_to_hex(commit->object.sha1));
+			return error(_("Commit %s... is a merge but no -m option was given."),
+				find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
 
 		for (cnt = 1, p = commit->parents;
 		     cnt != opts->mainline && p;
 		     cnt++)
 			p = p->next;
 		if (cnt != opts->mainline || !p)
-			return error(_("Commit %s does not have parent %d"),
-				sha1_to_hex(commit->object.sha1), opts->mainline);
+			return error(_("Commit %s... does not have parent %d"),
+				find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
+				opts->mainline);
 		parent = p->item;
 	} else if (0 < opts->mainline)
-		return error(_("Mainline was specified but commit %s is not a merge."),
-			sha1_to_hex(commit->object.sha1));
+		return error(_("Mainline was specified but commit %s... is not a merge."),
+			find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
 	else
 		parent = commit->parents->item;
 
-- 
2.4.0.228.gc627b12
