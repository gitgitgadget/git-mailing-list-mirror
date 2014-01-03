From: Vasily Makarov <einmalfel@gmail.com>
Subject: [PATCH] get_octopus_merge_bases(): cleanup redundant variable
Date: Fri,  3 Jan 2014 23:01:15 +0400
Message-ID: <1388775675-12228-1-git-send-email-einmalfel@gmail.com>
References: <xmqqeh4oncpo.fsf@gitster.dls.corp.google.com>
Cc: gitster@pobox.com, vmiklos@frugalware.org,
	Vasily Makarov <einmalfel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 03 20:02:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzA0b-0006aR-3X
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 20:02:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbaACTCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 14:02:04 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:52014 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbaACTCB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 14:02:01 -0500
Received: by mail-lb0-f171.google.com with SMTP id w7so8288509lbi.2
        for <git@vger.kernel.org>; Fri, 03 Jan 2014 11:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3VDyTHo2UOle5aY8TQjAH5Der8dNr2yHzMJQK11rvhQ=;
        b=uE1vzCCgo774syIKO+/Grr9Zf373GC0giKYgEWMgd3o8iy0D3aSodJ4Hnt1zBamecE
         MaCly9DI9bjIxUu1p8qsn75NZzkVPBbVkkU9utbpGOFTIyCDBuY5C2Je5lRi7eRADYM5
         qQzmh1OS2VGKhyvf5II0drCiJzKargd0uaw28SDUSfmr2xlOYzcvZLBSKE7tzNCPG7XX
         MEtA3TknvRMTO0TrT3okgNd3f+6C8QIbpYVBkPPqIChKl4t6dqlmQGR4HW1IIMdceljG
         Ip539L1tAoebisiv6Wg4VuEC0F/w0ZXAGbv24mMiQvXL8Lhqus5pcV/0wluj4wYM7zcF
         lQcg==
X-Received: by 10.152.26.72 with SMTP id j8mr235197lag.85.1388775719806;
        Fri, 03 Jan 2014 11:01:59 -0800 (PST)
Received: from Ubuntu13.10Home ([176.195.187.45])
        by mx.google.com with ESMTPSA id mq10sm37031911lbb.12.2014.01.03.11.01.58
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 03 Jan 2014 11:01:59 -0800 (PST)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <xmqqeh4oncpo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239926>

pptr is needless. Some related code got cleaned as well

Signed-off-by: Vasily Makarov <einmalfel@gmail.com>
---
 commit.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/commit.c b/commit.c
index de16a3c..8e48c49 100644
--- a/commit.c
+++ b/commit.c
@@ -834,26 +834,26 @@ static struct commit_list *merge_bases_many(struct commit *one, int n, struct co
 struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 {
 	struct commit_list *i, *j, *k, *ret = NULL;
-	struct commit_list **pptr = &ret;
 
-	for (i = in; i; i = i->next) {
-		if (!ret)
-			pptr = &commit_list_insert(i->item, pptr)->next;
-		else {
-			struct commit_list *new = NULL, *end = NULL;
-
-			for (j = ret; j; j = j->next) {
-				struct commit_list *bases;
-				bases = get_merge_bases(i->item, j->item, 1);
-				if (!new)
-					new = bases;
-				else
-					end->next = bases;
-				for (k = bases; k; k = k->next)
-					end = k;
-			}
-			ret = new;
+	if (!in)
+		return NULL;
+
+	commit_list_insert(in->item, &ret);
+
+	for (i = in->next; i; i = i->next) {
+		struct commit_list *new = NULL, *end = NULL;
+
+		for (j = ret; j; j = j->next) {
+			struct commit_list *bases;
+			bases = get_merge_bases(i->item, j->item, 1);
+			if (!new)
+				new = bases;
+			else
+				end->next = bases;
+			for (k = bases; k; k = k->next)
+				end = k;
 		}
+		ret = new;
 	}
 	return ret;
 }
-- 
1.8.3.2
