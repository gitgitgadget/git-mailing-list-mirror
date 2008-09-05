From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] merge-recursive: get rid of virtual_id
Date: Fri,  5 Sep 2008 19:26:42 +0200
Message-ID: <1220635602-13796-1-git-send-email-vmiklos@frugalware.org>
References: <7vy7273f9v.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 05 19:27:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbf69-0003OY-UN
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 19:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbYIER0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 13:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbYIER0q
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 13:26:46 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:54357 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbYIER0q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 13:26:46 -0400
Received: from vmobile.example.net (dsl5401C0BB.pool.t-online.hu [84.1.192.187])
	by yugo.frugalware.org (Postfix) with ESMTP id 77CF01DDC5B;
	Fri,  5 Sep 2008 19:26:43 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id DC24F84CA; Fri,  5 Sep 2008 19:26:42 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <7vy7273f9v.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95026>

We now just leave the object->sha1 field of virtual commits 0{40} as it
is initialized, as a unique hash is not necessary in case of virtual
commits.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Thu, Sep 04, 2008 at 12:03:08PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Does it hurt if we get rid of virtual_id and always leave the
> object->sha1 field of virtual commits 0{40} as it is initialized?

I don't think so. Here is a patch that does it.

 merge-recursive.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1c24c31..dbdb9ac 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -35,18 +35,14 @@ static struct tree *shift_tree_object(struct tree *one, struct tree *two)
 }
 
 /*
- * A virtual commit has
- * - (const char *)commit->util set to the name, and
- * - *(int *)commit->object.sha1 set to the virtual id.
+ * A virtual commit has (const char *)commit->util set to the name.
  */
 
 struct commit *make_virtual_commit(struct tree *tree, const char *comment)
 {
 	struct commit *commit = xcalloc(1, sizeof(struct commit));
-	static unsigned virtual_id = 1;
 	commit->tree = tree;
 	commit->util = (void*)comment;
-	*(int*)commit->object.sha1 = virtual_id++;
 	/* avoid warnings */
 	commit->object.parsed = 1;
 	return commit;
-- 
1.6.0.1
