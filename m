From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 11/12] parse_commit: don't fail, if object is NULL
Date: Mon, 18 Feb 2008 21:48:02 +0100
Message-ID: <12033676841015-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12033676833730-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832769-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832231-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832653-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676833341-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676831961-git-send-email-mkoegler@auto.tuwien.ac.at>
 <1203367683563-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676833893-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676842301-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676841373-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:49:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRCvh-0000iE-3V
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 21:49:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324AbYBRUs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 15:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753997AbYBRUs0
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 15:48:26 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:40289 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761458AbYBRUsH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 15:48:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id D5C906CF0063;
	Mon, 18 Feb 2008 21:48:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yzJzXOxyoHe6; Mon, 18 Feb 2008 21:48:04 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 5021C680CD42; Mon, 18 Feb 2008 21:48:04 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12033676841373-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74351>

Some codepaths (eg. builtin-rev-parse -> get_merge_bases -> parse_commit)
can pass NULL.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 commit.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index 70f1266..5d57450 100644
--- a/commit.c
+++ b/commit.c
@@ -311,6 +311,8 @@ int parse_commit(struct commit *item)
 	unsigned long size;
 	int ret;
 
+	if (!item)
+		return -1;
 	if (item->object.parsed)
 		return 0;
 	buffer = read_sha1_file(item->object.sha1, &type, &size);
-- 
1.5.4.1.g96b77
