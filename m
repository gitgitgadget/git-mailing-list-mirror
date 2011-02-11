From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH 4/4] Clean: Remove useless parameters from both get_commit_info() functions
Date: Fri, 11 Feb 2011 17:48:17 +0000
Message-ID: <d92be3a1-6f30-4b04-ac38-39058e5a6959-mfwitten@gmail.com>
References: <1fbceaa8-398c-44ec-8833-a03e4cca6805-mfwitten@gmail.com>
            <ca8eabbf-ed1b-4b46-a7f7-4b068a2de5b7-mfwitten@gmail.com>
            <5bddd028-bf38-46b9-a189-bdb09038dfdd-mfwitten@gmail.com>
            <a59d19d0-f279-43fe-8ac6-06c4bd13c941-mfwitten@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:03:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4yns-00021T-Dv
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 19:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932913Ab1C3RD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 13:03:27 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38370 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815Ab1C3RD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 13:03:26 -0400
Received: by mail-pz0-f46.google.com with SMTP id 9so231452pzk.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:cc:message-id:in-reply-to
         :references;
        bh=YrSm/UQcdRawWTdohB4y8oKEw1Z06VmzE3p+nbcv4KY=;
        b=qpsBQ1+F3udcApLnoAPAInKmJS1+407BP8nUWLILgoEXkOYHuwJKEDlCDJkcrDrWCl
         ok5wt8g4StgZ7jGtmqdbvk8g6Mi0a6ZkUIhiidrku8EUDT0zChIGFbuRu5u9bRl5C/KC
         z65w0PNuYcbuoAgG/yLGlobQHs8ED4cCmK7XA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        b=QBRfURRns7whI766NJHeYPnXaJsbTcE4SSqaRsB6mTqco7NaJwP6a11X8VZHIk9NQg
         2HHNdqTkfxy6U/SrrNswxuN3o9klzWSTv/kDQGh43kAMakm3JgXqt9Z2sOpcIxf+QAK4
         a+YM45wr5oDZwF1QAEXuajh1PmizV84J+zZQE=
Received: by 10.142.157.13 with SMTP id f13mr1024748wfe.392.1301504606723;
        Wed, 30 Mar 2011 10:03:26 -0700 (PDT)
Received: from gmail.com ([109.123.119.163])
        by mx.google.com with ESMTPS id 25sm307902wfb.22.2011.03.30.10.03.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 10:03:26 -0700 (PDT)
In-Reply-To: <1fbceaa8-398c-44ec-8833-a03e4cca6805-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170395>

Both `builtin/blame.c' and `reflog-walk.c' have static get_commit_info()
functions:

    $ echo; git grep get_commit_info 7811d9600f02e70c9f835719c71156c967a684f7 | cut -c42-

    builtin/blame.c:static void get_commit_info(struct commit *commit,
    builtin/blame.c:	get_commit_info(suspect->commit, &ci, 1);
    builtin/blame.c:	get_commit_info(suspect->commit, &ci, 1);
    builtin/blame.c:			get_commit_info(suspect->commit, &ci, 1);
    reflog-walk.c:static struct commit_info *get_commit_info(struct commit *commit,
    reflog-walk.c:		get_commit_info(commit, &info->reflogs, 0);

Every time one of the get_commit_info() functions is called, the
last parameter is invariably set to the same constant, rendering that
parameter effectively useless.

This commit removes those last parameters and updates the function bodies
and calls accordingly.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 builtin/blame.c |   14 ++++----------
 reflog-walk.c   |   18 ++++--------------
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index f6b03f7..5b5fc6a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1413,8 +1413,7 @@ static void get_ac_line(const char *inbuf, const char *what,
 }
 
 static void get_commit_info(struct commit *commit,
-			    struct commit_info *ret,
-			    int detailed)
+			    struct commit_info *ret)
 {
 	int len;
 	const char *subject;
@@ -1447,11 +1446,6 @@ static void get_commit_info(struct commit *commit,
 		    sizeof(author_mail), author_mail,
 		    &ret->author_time, &ret->author_tz);
 
-	if (!detailed) {
-		free(reencoded);
-		return;
-	}
-
 	ret->committer = committer_name;
 	ret->committer_mail = committer_mail;
 	get_ac_line(message, "\ncommitter ",
@@ -1493,7 +1487,7 @@ static int emit_one_suspect_detail(struct origin *suspect)
 		return 0;
 
 	suspect->commit->object.flags |= METAINFO_SHOWN;
-	get_commit_info(suspect->commit, &ci, 1);
+	get_commit_info(suspect->commit, &ci);
 	printf("author %s\n", ci.author);
 	printf("author-mail %s\n", ci.author_mail);
 	printf("author-time %lu\n", ci.author_time);
@@ -1664,7 +1658,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	char hex[41];
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
 
-	get_commit_info(suspect->commit, &ci, 1);
+	get_commit_info(suspect->commit, &ci);
 	strcpy(hex, sha1_to_hex(suspect->commit->object.sha1));
 
 	cp = nth_line(sb, ent->lno);
@@ -1850,7 +1844,7 @@ static void find_alignment(struct scoreboard *sb, int *option)
 			longest_file = num;
 		if (!(suspect->commit->object.flags & METAINFO_SHOWN)) {
 			suspect->commit->object.flags |= METAINFO_SHOWN;
-			get_commit_info(suspect->commit, &ci, 1);
+			get_commit_info(suspect->commit, &ci);
 			if (*option & OUTPUT_SHOW_EMAIL)
 				num = utf8_strwidth(ci.author_mail);
 			else
diff --git a/reflog-walk.c b/reflog-walk.c
index 5d81d39..3357331 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -87,22 +87,12 @@ struct commit_info_lifo {
 };
 
 static struct commit_info *get_commit_info(struct commit *commit,
-		struct commit_info_lifo *lifo, int pop)
+		struct commit_info_lifo *lifo)
 {
 	int i;
 	for (i = 0; i < lifo->nr; i++)
-		if (lifo->items[i].commit == commit) {
-			struct commit_info *result = &lifo->items[i];
-			if (pop) {
-				if (i + 1 < lifo->nr)
-					memmove(lifo->items + i,
-						lifo->items + i + 1,
-						(lifo->nr - i) *
-						sizeof(struct commit_info));
-				lifo->nr--;
-			}
-			return result;
-		}
+		if (lifo->items[i].commit == commit)
+			return &lifo->items[i];
 	return NULL;
 }
 
@@ -214,7 +204,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 {
 	struct commit_info *commit_info =
-		get_commit_info(commit, &info->reflogs, 0);
+		get_commit_info(commit, &info->reflogs);
 	struct commit_reflog *commit_reflog;
 	struct reflog_info *reflog;
 
-- 
1.7.4.18.g68fe8
