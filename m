From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH PARSEOPT 4/4] Use OPT_BIT in builtin-pack-refs
Date: Wed,  7 Nov 2007 11:20:30 +0100
Message-ID: <1194430832-6224-6-git-send-email-madcoder@debian.org>
References: <1194430832-6224-1-git-send-email-madcoder@debian.org>
 <1194430832-6224-2-git-send-email-madcoder@debian.org>
 <1194430832-6224-3-git-send-email-madcoder@debian.org>
 <1194430832-6224-4-git-send-email-madcoder@debian.org>
 <1194430832-6224-5-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 07 11:21:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipi2X-0001LP-II
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 11:21:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbXKGKUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 05:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbXKGKUo
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 05:20:44 -0500
Received: from pan.madism.org ([88.191.52.104]:35308 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137AbXKGKUg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 05:20:36 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id AF73228E26;
	Wed,  7 Nov 2007 11:20:34 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 2BA331CAA0; Wed,  7 Nov 2007 11:20:33 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1598.gdef4e
In-Reply-To: <1194430832-6224-5-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63798>

---
 builtin-pack-refs.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index a62f06b..1923fb1 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -122,19 +122,13 @@ static char const * const pack_refs_usage[] = {
 
 int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 {
-	int all = 0, prune = 1;
-	unsigned int flags = 0;
+	unsigned int flags = PACK_REFS_PRUNE;
 	struct option opts[] = {
-		OPT_BOOLEAN(0, "all", &all, "pack everything"),
-		OPT_BOOLEAN(0, "prune", &prune, "prune loose refs (default)"),
+		OPT_BIT(0, "all",   &flags, "pack everything", PACK_REFS_ALL),
+		OPT_BIT(0, "prune", &flags, "prune loose refs (default)", PACK_REFS_PRUNE),
 		OPT_END(),
 	};
-
 	if (parse_options(argc, argv, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
-	if (prune)
-		flags |= PACK_REFS_PRUNE;
-	if (all)
-		flags |= PACK_REFS_ALL;
 	return pack_refs(flags);
 }
-- 
1.5.3.5.1598.gdef4e
