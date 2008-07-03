From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Fix describe --tags --long so it does not segfault
Date: Thu, 3 Jul 2008 02:32:45 +0000
Message-ID: <20080703023245.GA31579@spearce.org>
References: <237967ef0807021256j3e67bceaoecbb8f37112db2ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Mikael Magnusson <mikachu@gmail.com>,
	Mark Burton <markb@ordern.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 09:00:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEInp-0002Wt-Ey
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 09:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883AbYGCG7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754414AbYGCG5h
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:57:37 -0400
Received: from george.spearce.org ([209.20.77.23]:59776 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbYGCCcp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 22:32:45 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 16A9438265; Thu,  3 Jul 2008 02:32:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <237967ef0807021256j3e67bceaoecbb8f37112db2ab@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87222>

If we match a lightweight (non-annotated tag) as the name to
output and --long was requested we do not have a tag, nor do
we have a tagged object to display.  Instead we must use the
object we were passed as input for the long format display.

Reported-by: Mark Burton <markb@ordern.com>
Backtraced-by: Mikael Magnusson <mikachu@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Thanks Mikael, the backtrace really made it easy to figure out
 what the breakage was here.

 builtin-describe.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index 3da99c1..e515f9c 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -204,7 +204,7 @@ static void describe(const char *arg, int last_one)
 		 */
 		display_name(n);
 		if (longformat)
-			show_suffix(0, n->tag->tagged->sha1);
+			show_suffix(0, n->tag ? n->tag->tagged->sha1 : sha1);
 		printf("\n");
 		return;
 	}
-- 
1.5.6.74.g8a5e
