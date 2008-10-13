From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 2/2] Add --[no-]thin and --[no-]fsck optiosn to fetch command line tool
Date: Mon, 13 Oct 2008 10:36:41 -0700
Message-ID: <1223919401-15873-2-git-send-email-spearce@spearce.org>
References: <1223919401-15873-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 19:38:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpRMk-00079b-OO
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 19:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635AbYJMRgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 13:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754593AbYJMRgq
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 13:36:46 -0400
Received: from george.spearce.org ([209.20.77.23]:35100 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528AbYJMRgo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 13:36:44 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 543EF38360; Mon, 13 Oct 2008 17:36:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 83A573835F;
	Mon, 13 Oct 2008 17:36:42 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.2.706.g340fc
In-Reply-To: <1223919401-15873-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98130>

This way users can force verification on the fly, such as when
fetching from an untrusted URL pasted on the command line.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../src/org/spearce/jgit/pgm/Fetch.java            |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
index e14e213..ad7e08f 100644
--- a/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
+++ b/org.spearce.jgit.pgm/src/org/spearce/jgit/pgm/Fetch.java
@@ -54,6 +54,22 @@
 	@Option(name = "--verbose", aliases = { "-v" }, usage = "be more verbose")
 	private boolean verbose;
 
+	@Option(name = "--fsck", usage = "perform fsck style checks on receive")
+	private Boolean fsck;
+
+	@Option(name = "--no-fsck")
+	void nofsck(final boolean ignored) {
+		fsck = Boolean.FALSE;
+	}
+
+	@Option(name = "--thin", usage = "fetch thin pack")
+	private Boolean thin;
+
+	@Option(name = "--no-thin")
+	void nothin(final boolean ignored) {
+		thin = Boolean.FALSE;
+	}
+
 	@Argument(index = 0, metaVar = "uri-ish")
 	private String remote = "origin";
 
@@ -63,6 +79,10 @@
 	@Override
 	protected void run() throws Exception {
 		final Transport tn = Transport.open(db, remote);
+		if (fsck != null)
+			tn.setCheckFetchedObjects(fsck.booleanValue());
+		if (thin != null)
+			tn.setFetchThin(thin.booleanValue());
 		final FetchResult r;
 		try {
 			r = tn.fetch(new TextProgressMonitor(), toget);
-- 
1.6.0.2.706.g340fc
