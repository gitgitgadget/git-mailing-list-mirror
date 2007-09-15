From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/5] Don't bother passing ref log details to walker in builtin-fetch
Date: Sat, 15 Sep 2007 03:23:04 -0400
Message-ID: <20070915072304.GB20346@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 09:23:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWRzl-0003al-OR
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 09:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbXIOHXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 03:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbXIOHXJ
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 03:23:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35938 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbXIOHXH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 03:23:07 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IWRzc-0006hm-7I; Sat, 15 Sep 2007 03:23:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2C18F20FBAE; Sat, 15 Sep 2007 03:23:04 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58223>

When using the walker API within builtin-fetch we don't allow
it to update refs locally; instead that action is reserved for
builtin-fetch's own main loop once the objects have actually
been downloaded.

Passing NULL here will bypass the unnecessary malloc/free of a
string buffer within the walker API.  That buffer is never used
because the prior argument (the refs to update) is also NULL.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 transport.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/transport.c b/transport.c
index 0338ed4..0021190 100644
--- a/transport.c
+++ b/transport.c
@@ -26,7 +26,7 @@ static int fetch_objs_via_walker(struct transport *transport,
 	for (i = 0; i < nr_objs; i++)
 		objs[i] = xstrdup(sha1_to_hex(to_fetch[i]->old_sha1));
 
-	if (walker_fetch(walker, nr_objs, objs, NULL, dest))
+	if (walker_fetch(walker, nr_objs, objs, NULL, NULL))
 		die("Fetch failed.");
 
 	for (i = 0; i < nr_objs; i++)
-- 
1.5.3.1.84.gaf82-dirty
