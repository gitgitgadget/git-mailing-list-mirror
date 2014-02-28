From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v2 05/11] diff.c: use ALLOC_GROW() instead of inline code
Date: Fri, 28 Feb 2014 13:43:19 +0400
Message-ID: <53105A37.5060603@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 10:44:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJJzB-0006xb-Pe
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbaB1Jn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:43:59 -0500
Received: from forward8l.mail.yandex.net ([84.201.143.141]:58173 "EHLO
	forward8l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbaB1Jn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:43:57 -0500
Received: from smtp14.mail.yandex.net (smtp14.mail.yandex.net [95.108.131.192])
	by forward8l.mail.yandex.net (Yandex) with ESMTP id 254101A40F02
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:43:55 +0400 (MSK)
Received: from smtp14.mail.yandex.net (localhost [127.0.0.1])
	by smtp14.mail.yandex.net (Yandex) with ESMTP id D90FD1B600AC
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:43:54 +0400 (MSK)
Received: from unknown (unknown [46.159.228.134])
	by smtp14.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id hWC71LRwlO-hs2m5MB8;
	Fri, 28 Feb 2014 13:43:54 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 4a1c5a87-e33a-4531-b1b6-d763995cbb84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393580634;
	bh=8oArpF2pAzG1dt1iBa9Rc+VcxcZSWOJ2FWbpVdmGjjM=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=HGpmj+2GJWuqcl54PFi9p+p0VwkaC8O0tBt4SX5YYyEqn9v44MByPZ2ElhMduaMqv
	 tH1VBi161weYr/b/jqRksoXpjFVnrWjrqpGdt0jro5zaBJaiXTUMDsETiDJrK9vS74
	 DnFrK1d5YpomMXSlAvydpJkNhBodxWGbXC8oiAMQ=
Authentication-Results: smtp14.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <531056E7.3010305@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242924>

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 diff.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index e800666..aebdfda 100644
--- a/diff.c
+++ b/diff.c
@@ -1361,11 +1361,7 @@ static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
 {
 	struct diffstat_file *x;
 	x = xcalloc(sizeof (*x), 1);
-	if (diffstat->nr == diffstat->alloc) {
-		diffstat->alloc = alloc_nr(diffstat->alloc);
-		diffstat->files = xrealloc(diffstat->files,
-				diffstat->alloc * sizeof(x));
-	}
+	ALLOC_GROW(diffstat->files, diffstat->nr + 1, diffstat->alloc);
 	diffstat->files[diffstat->nr++] = x;
 	if (name_b) {
 		x->from_name = xstrdup(name_a);
@@ -3965,11 +3961,7 @@ struct diff_queue_struct diff_queued_diff;
 
 void diff_q(struct diff_queue_struct *queue, struct diff_filepair *dp)
 {
-	if (queue->alloc <= queue->nr) {
-		queue->alloc = alloc_nr(queue->alloc);
-		queue->queue = xrealloc(queue->queue,
-					sizeof(dp) * queue->alloc);
-	}
+	ALLOC_GROW(queue->queue, queue->nr + 1, queue->alloc);
 	queue->queue[queue->nr++] = dp;
 }
 
-- 
1.8.5.3
