From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] diff-tree: call free_commit_list() instead of duplicating
 its code
Date: Tue, 08 Jul 2014 18:21:05 +0200
Message-ID: <53BC1A71.2010904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 08 18:21:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4Y8p-0001rM-SL
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 18:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbaGHQVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 12:21:11 -0400
Received: from mout.web.de ([212.227.17.12]:53582 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751581AbaGHQVK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 12:21:10 -0400
Received: from [192.168.178.27] ([79.253.167.50]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MLPRu-1X566T1cYs-000csy; Tue, 08 Jul 2014 18:21:07
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:VLKICmt+2jDGEwsxcViHcYstmLDbe8pSgXgWcYis9nTTfqZexkB
 BkzKKqU+vJ2UONwGO83h0rkMOFcGtgI/MAqYtG4KsQyAHBC3o4/BzlQ/pnLOVG7RW96o6Xj
 Z4UV61F+JA1xIRl5Adc4P+idYoaNXHwTQ1QVQJBhDjfgAa3BPGNOQQ+PJ7YHilZ0kBGzHzn
 aeMxdesL2mLdngY68Nj7g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253031>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/diff-tree.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index be6417d..ce0e019 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -22,14 +22,10 @@ static int stdin_diff_commit(struct commit *commit, char *line, int len)
 	if (isspace(line[40]) && !get_sha1_hex(line+41, sha1)) {
 		/* Graft the fake parents locally to the commit */
 		int pos = 41;
-		struct commit_list **pptr, *parents;
+		struct commit_list **pptr;
 
 		/* Free the real parent list */
-		for (parents = commit->parents; parents; ) {
-			struct commit_list *tmp = parents->next;
-			free(parents);
-			parents = tmp;
-		}
+		free_commit_list(commit->parents);
 		commit->parents = NULL;
 		pptr = &(commit->parents);
 		while (line[pos] && !get_sha1_hex(line + pos, sha1)) {
-- 
2.0.0
