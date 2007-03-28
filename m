From: Bruno Ribas <ribas@c3sl.ufpr.br>
Subject: [PATCH] use xmalloc in diff-delta.c
Date: Wed, 28 Mar 2007 00:03:19 -0300
Message-ID: <11750509991462-git-send-email-ribas@c3sl.ufpr.br>
Cc: git@vger.kernel.org, Bruno Ribas <ribas@c3sl.ufpr.br>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 05:03:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWORi-0007de-Hx
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 05:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbXC1DDb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 23:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbXC1DDb
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 23:03:31 -0400
Received: from urquell.c3sl.ufpr.br ([200.17.202.3]:43204 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbXC1DD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 23:03:29 -0400
Received: from localhost (labatt.c3sl.ufpr.br [200.17.202.89])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 945673019A2C;
	Wed, 28 Mar 2007 00:03:28 -0300 (BRT)
X-Mailer: git-send-email 1.5.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43345>

Signed-off-by: Bruno Ribas <ribas@c3sl.ufpr.br>
---
 builtin-pack-objects.c |    2 --
 diff-delta.c           |    8 ++------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index b5f9648..04a4abc 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1254,8 +1254,6 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	}
 	if (!src->index) {
 		src->index = create_delta_index(src->data, src_size);
-		if (!src->index)
-			die("out of memory");
 	}
 
 	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
diff --git a/diff-delta.c b/diff-delta.c
index 9f998d0..011d7d6 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -157,9 +157,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 	memsize = sizeof(*index) +
 		  sizeof(*hash) * hsize +
 		  sizeof(*entry) * entries;
-	mem = malloc(memsize);
-	if (!mem)
-		return NULL;
+	mem = xmalloc(memsize);
 	index = mem;
 	mem = index + 1;
 	hash = mem;
@@ -258,9 +256,7 @@ create_delta(const struct delta_index *index,
 	outsize = 8192;
 	if (max_size && outsize >= max_size)
 		outsize = max_size + MAX_OP_SIZE + 1;
-	out = malloc(outsize);
-	if (!out)
-		return NULL;
+	out = xmalloc(outsize);
 
 	/* store reference buffer size */
 	i = index->src_size;
-- 
1.5.0.3
