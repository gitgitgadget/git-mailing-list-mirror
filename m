From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC PATCH v3 07/17] fetch: Allow transport -v -v -v to set verbosity to 3
Date: Wed, 14 Oct 2009 20:36:44 -0700
Message-ID: <1255577814-14745-8-git-send-email-spearce@spearce.org>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 05:43:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyHFS-0007IV-Ut
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 05:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762478AbZJODig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 23:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762470AbZJODid
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 23:38:33 -0400
Received: from george.spearce.org ([209.20.77.23]:33052 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762441AbZJODiO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 23:38:14 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id C92C238221; Thu, 15 Oct 2009 03:37:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id BD8E238222;
	Thu, 15 Oct 2009 03:36:56 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.52.g0ff2e
In-Reply-To: <1255577814-14745-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130374>

Helpers might want a higher level of verbosity than just +1 (the
porcelain default setting) and +2 (-v -v).  Expand the field to
allow verbosity in the range -1..3.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Daniel Barkalow <barkalow@iabervon.org>
---
 builtin-fetch.c |    2 +-
 transport.h     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index cb48c57..52a9a42 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -665,7 +665,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	transport = transport_get(remote, remote->url[0]);
 	if (verbosity >= 2)
-		transport->verbose = 1;
+		transport->verbose = verbosity <= 3 ? verbosity : 3;
 	if (verbosity < 0)
 		transport->verbose = -1;
 	if (upload_pack)
diff --git a/transport.h b/transport.h
index c14da6f..e4e6177 100644
--- a/transport.h
+++ b/transport.h
@@ -25,7 +25,7 @@ struct transport {
 
 	int (*disconnect)(struct transport *connection);
 	char *pack_lockfile;
-	signed verbose : 2;
+	signed verbose : 3;
 	/* Force progress even if the output is not a tty */
 	unsigned progress : 1;
 };
-- 
1.6.5.52.g0ff2e
