From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] avoid NULL dereference on failed malloc
Date: Sun, 14 Jun 2009 21:46:10 +0200
Message-ID: <87hbyioayl.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 14 21:46:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFvet-0003Z6-Us
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 21:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758636AbZFNTqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jun 2009 15:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752221AbZFNTqQ
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jun 2009 15:46:16 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:56777 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbZFNTqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jun 2009 15:46:16 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id B47D1940134
	for <git@vger.kernel.org>; Sun, 14 Jun 2009 21:46:13 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id D6536940151
	for <git@vger.kernel.org>; Sun, 14 Jun 2009 21:46:10 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id B6EFC3B57E; Sun, 14 Jun 2009 21:46:10 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121554>


* builtin-remote.c (get_one_entry): Use xmalloc, not malloc.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 builtin-remote.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 709f8a6..406fb85 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -1282,7 +1282,7 @@ static int get_one_entry(struct remote *remote, void *priv)

 	if (remote->url_nr > 0) {
 		utilp = &(string_list_append(remote->name, list)->util);
-		*utilp = malloc(strlen(remote->url[0])+strlen(" (fetch)")+1);
+		*utilp = xmalloc(strlen(remote->url[0])+strlen(" (fetch)")+1);
 		strcpy((char *) *utilp, remote->url[0]);
 		strcat((char *) *utilp, " (fetch)");
 	} else
@@ -1297,7 +1297,7 @@ static int get_one_entry(struct remote *remote, void *priv)
 	for (i = 0; i < url_nr; i++)
 	{
 		utilp = &(string_list_append(remote->name, list)->util);
-		*utilp = malloc(strlen(url[i])+strlen(" (push)")+1);
+		*utilp = xmalloc(strlen(url[i])+strlen(" (push)")+1);
 		strcpy((char *) *utilp, url[i]);
 		strcat((char *) *utilp, " (push)");
 	}
--
1.6.3.2.406.gd6a466
