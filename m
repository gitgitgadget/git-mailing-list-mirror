From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: [PATCH] Fix a small memory leak in builtin-add
Date: Mon, 29 Oct 2007 08:00:33 +0100
Message-ID: <1193641233-3880-2-git-send-email-tsuna@lrde.epita.fr>
References: <1193641233-3880-1-git-send-email-tsuna@lrde.epita.fr>
Cc: gitster@pobox.com, Benoit Sigoure <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 29 08:00:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImOcK-0006pf-5c
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 08:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbXJ2HAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 03:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbXJ2HAj
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 03:00:39 -0400
Received: from quanta.tsunanet.net ([82.229.223.213]:60618 "EHLO
	quanta.tsunanet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbXJ2HAi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 03:00:38 -0400
Received: by quanta.tsunanet.net (Postfix, from userid 501)
	id 8E62FBEAC68; Mon, 29 Oct 2007 08:00:33 +0100 (CET)
X-Mailer: git-send-email 1.5.3.4.398.g859b
In-Reply-To: <1193641233-3880-1-git-send-email-tsuna@lrde.epita.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62604>

prune_directory and fill_directory allocated one byte per pathspec and never
freed it.

Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
---
I don't know whether this was intentionnal or not (since it's only a matter of
having small chunks of memory not being reclaimed and I don't think we can
enter these functions twice, so these are not leaks in the sense that the
program will consume more and more memory).  But if it was intentionnal,
wouldn't it be better to put a small comment in the code saying so (so that
casual readers like me won't get surprised).

 builtin-add.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index f9a6580..b8e6094 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -44,6 +44,7 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
 			die("pathspec '%s' did not match any files",
 					pathspec[i]);
 	}
+        free(seen);
 }
 
 static void fill_directory(struct dir_struct *dir, const char **pathspec,
@@ -135,6 +136,7 @@ static void refresh(int verbose, const char **pathspec)
 		if (!seen[i])
 			die("pathspec '%s' did not match any files", pathspec[i]);
 	}
+        free(seen);
 }
 
 static int git_add_config(const char *var, const char *value)
-- 
1.5.3.4.398.g859b
