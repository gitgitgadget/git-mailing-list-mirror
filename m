From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 13/15] reflog-walk.c: rearrange xcalloc arguments
Date: Tue, 27 May 2014 00:33:54 +0900
Message-ID: <1401118436-66090-14-git-send-email-modocache@gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 26 17:35:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wowvg-0005AU-6X
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 17:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045AbaEZPfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 11:35:07 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:38730 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbaEZPfF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 11:35:05 -0400
Received: by mail-pa0-f54.google.com with SMTP id bj1so7769202pad.13
        for <git@vger.kernel.org>; Mon, 26 May 2014 08:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BqIryutXudrubUCDSHcqoW9siSwF0i2MLftA0Du2CDU=;
        b=btomOY2vsSvI1KbHU3sBSYHxUq2nqpuphnKfRz7yTx/JdsrF+nsTl2vh7VNQo5hxva
         jxQbxkW9YE13ShQPaZtgJLQcjFSnB4OUaMX+q4V4GRtaRrbaTgxPocQeQpgC9xPLaQzu
         ckBHJ8hVqYFxkVlmwb7Gb8+LZxhV+U6rle6bI0d+usS/Lr7/1hE7EfwydugOs7+Ti2kH
         rfNrCUWN1DmSay93rC97Lzgd3UbrPx4z5W50GoF4eFu6eOP/l0/m3Vdsg/TdLQFSaE3e
         17SuyNW5b6bI4dj4Kg43/GKbgSdTpCFavOpjZvIOPH86jvDFFWD6LWnHCKwFRtgMvcMR
         9qPw==
X-Received: by 10.66.66.72 with SMTP id d8mr29617110pat.8.1401118505266;
        Mon, 26 May 2014 08:35:05 -0700 (PDT)
Received: from localhost.localdomain (p3080-ipbf5805marunouchi.tokyo.ocn.ne.jp. [60.46.42.80])
        by mx.google.com with ESMTPSA id mt1sm18850446pbb.31.2014.05.26.08.35.04
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 08:35:04 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.543.gc8042da
In-Reply-To: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250100>

xcalloc takes two arguments: the number of elements and their size.
reflog-walk.c includes several calls to xcalloc that pass the arguments
in reverse order. Rearrgange them so they are in the correct order.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 reflog-walk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index b2fbdb2..f8d8f13 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -45,7 +45,7 @@ static int read_one_reflog(unsigned char *osha1, unsigned char *nsha1,
 static struct complete_reflogs *read_complete_reflog(const char *ref)
 {
 	struct complete_reflogs *reflogs =
-		xcalloc(sizeof(struct complete_reflogs), 1);
+		xcalloc(1, sizeof(struct complete_reflogs));
 	reflogs->ref = xstrdup(ref);
 	for_each_reflog_ent(ref, read_one_reflog, reflogs);
 	if (reflogs->nr == 0) {
@@ -143,7 +143,7 @@ struct reflog_walk_info {
 
 void init_reflog_walk(struct reflog_walk_info** info)
 {
-	*info = xcalloc(sizeof(struct reflog_walk_info), 1);
+	*info = xcalloc(1, sizeof(struct reflog_walk_info));
 }
 
 int add_reflog_for_walk(struct reflog_walk_info *info,
@@ -207,7 +207,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 			= reflogs;
 	}
 
-	commit_reflog = xcalloc(sizeof(struct commit_reflog), 1);
+	commit_reflog = xcalloc(1, sizeof(struct commit_reflog));
 	if (recno < 0) {
 		commit_reflog->recno = get_reflog_recno_by_time(reflogs, timestamp);
 		if (commit_reflog->recno < 0) {
@@ -250,7 +250,7 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 		return;
 	}
 
-	commit->parents = xcalloc(sizeof(struct commit_list), 1);
+	commit->parents = xcalloc(1, sizeof(struct commit_list));
 	commit->parents->item = commit_info->commit;
 }
 
-- 
2.0.0.rc1.543.gc8042da
