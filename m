From: mhagger@alum.mit.edu
Subject: [PATCH v2 13/17] cmd_fetch_pack: return early if finish_connect() returns an error
Date: Sat, 25 Aug 2012 08:44:23 +0200
Message-ID: <1345877067-11841-14-git-send-email-mhagger@alum.mit.edu>
References: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 08:45:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5A7p-0002ps-Pj
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 08:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055Ab2HYGpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 02:45:32 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:45932 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752797Ab2HYGp1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 02:45:27 -0400
X-AuditID: 1207440d-b7f236d000000943-ba-503874860ce0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id CA.13.02371.68478305; Sat, 25 Aug 2012 02:45:26 -0400 (EDT)
Received: from michael.fritz.box (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P6igSo011615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 02:45:25 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1345877067-11841-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqNtWYhFg8PSMiUXXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M7oOvGAtuMJWsf7THPYGxlWsXYwcHBICJhLzlyV3MXICmWISF+6tZwOxhQQuM0rMmc3d
	xcgFZJ9lkli9aRULSIJNQEriZWMPO4gtIqAmMbHtEAtIEbNAF6PE8nW/wLqFBaIlev+9YQax
	WQRUJa61n2ACsXkFXCUe3PnADLFNUeLH9zVgNidQfMKvi+wQm10kmo5dYZnAyLuAkWEVo1xi
	Tmmubm5iZk5xarJucXJiXl5qka6RXm5miV5qSukmRkhA8e5g/L9O5hCjAAejEg/vjTPmAUKs
	iWXFlbmHGCU5mJREecUKLQKE+JLyUyozEosz4otKc1KLDzFKcDArifB+ZwDK8aYkVlalFuXD
	pKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkePcUAzUKFqWmp1akZeaUIKSZODhBBBfI
	Bh6gDfNBCnmLCxJzizPTIYpOMSpKifOeAkkIgCQySvPgBsBi/xWjONA/wrwzi4CqeIBpA677
	FdBgJqDB5a7mIINLEhFSUg2M+Vaf+Jcqp54M+FTZkXxT3Kds89mfG/i8VF/43vvYF2d1RWWW
	XaqfcOOW3fZ1ZiHvVHZFlZ9i9fka/un4rI/sT4yXvHaLy9+yZLfVNgtVcQednvBlb3b+n5qo
	fT2D3UFmn6HpmnCn6A3bUr1c7G48m3n32sZrwkIak3r2zXdZ0ijReUeiwK9biaU4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204255>

From: Michael Haggerty <mhagger@alum.mit.edu>

This simplifies the logic without changing the behavior.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/fetch-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 5ba1cef..f04fd59 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1025,10 +1025,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	close(fd[0]);
 	close(fd[1]);
 	if (finish_connect(conn))
-		ref = NULL;
-	ret = !ref;
+		return 1;
 
-	if (!ret && nr_heads) {
+	ret = !ref;
+	if (ref && nr_heads) {
 		/* If the heads to pull were given, we should have
 		 * consumed all of them by matching the remote.
 		 * Otherwise, 'git fetch remote no-such-ref' would
-- 
1.7.11.3
