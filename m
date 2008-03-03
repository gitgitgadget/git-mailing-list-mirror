From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Paper bag fix git-describe on packed tags
Date: Mon, 3 Mar 2008 18:21:36 -0500
Message-ID: <20080303232136.GA15312@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:22:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWJz8-0006Ol-Ij
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 00:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534AbYCCXVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 18:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754319AbYCCXVl
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 18:21:41 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41646 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754132AbYCCXVk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 18:21:40 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWJyK-00061b-At; Mon, 03 Mar 2008 18:21:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B146520FBAE; Mon,  3 Mar 2008 18:21:36 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75996>

In 212945d ("Teach git-describe to verify annotated tag names")
we tried to access a possibly unparsed tag structure.  We must
make sure it was parsed before we try to read its tag name.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 As 212945d is already in master this probably should be
 fast-tracked there.  Whoops.  :-)

 builtin-describe.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index 2f1e7ba..d4204ee 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -156,7 +156,7 @@ static void display_name(struct commit_name *n)
 {
 	if (n->prio == 2 && !n->tag) {
 		n->tag = lookup_tag(n->sha1);
-		if (!n->tag || !n->tag->tag)
+		if (!n->tag || parse_tag(n->tag) || !n->tag->tag)
 			die("annotated tag %s not available", n->path);
 		if (strcmp(n->tag->tag, n->path))
 			warning("tag '%s' is really '%s' here", n->tag->tag, n->path);
-- 
1.5.4.3.509.gf785
