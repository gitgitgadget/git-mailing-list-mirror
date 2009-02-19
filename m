From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] branch: clean up repeated strlen
Date: Wed, 18 Feb 2009 22:35:45 -0500
Message-ID: <20090219033545.GB18970@coredump.intra.peff.net>
References: <20090219033329.GA13666@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 19 04:37:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZzix-0001Vs-EH
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 04:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753599AbZBSDft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 22:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753527AbZBSDfs
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 22:35:48 -0500
Received: from peff.net ([208.65.91.99]:48564 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753342AbZBSDfr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 22:35:47 -0500
Received: (qmail 19043 invoked by uid 107); 19 Feb 2009 03:36:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Feb 2009 22:36:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2009 22:35:45 -0500
Content-Disposition: inline
In-Reply-To: <20090219033329.GA13666@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110615>

Commit 45e2b61 fixed the initialization of a "len" struct
parameter via strlen. We can use that to clean up what is
now 3 strlens in a 6-line sequence.

Signed-off-by: Jeff King <peff@peff.net>
---
I guess a good compiler could optimize these out, but I think it
actually reads a little bit nicer.

 builtin-branch.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index 13e4de8..14d4b91 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -443,8 +443,8 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev, str
 		item.kind = REF_LOCAL_BRANCH;
 		item.dest = NULL;
 		item.commit = head_commit;
-		if (strlen(item.name) > ref_list.maxwidth)
-			ref_list.maxwidth = strlen(item.name);
+		if (item.len > ref_list.maxwidth)
+			ref_list.maxwidth = item.len;
 		print_ref_item(&item, ref_list.maxwidth, verbose, abbrev, 1, "");
 		free(item.name);
 	}
-- 
1.6.2.rc1.210.g1210c
