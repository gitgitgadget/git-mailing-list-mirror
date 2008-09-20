From: Jonas Fonseca <fonseca@diku.dk>
Subject: [JGIT PATCH] Add test for OpenSshConfig separator parsing
Date: Sun, 21 Sep 2008 00:33:40 +0200
Message-ID: <20080920223340.GB18981@diku.dk>
References: <12219428213749-git-send-email-ggoudsmit@shebang.nl> <20080920214808.GA7426@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Gilion Goudsmit <ggoudsmit@shebang.nl>
X-From: git-owner@vger.kernel.org Sun Sep 21 00:34:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhB2T-0007Pm-UH
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 00:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbYITWdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 18:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbYITWdp
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 18:33:45 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:51041 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbYITWdp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 18:33:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id AFEC052C459;
	Sun, 21 Sep 2008 00:33:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mvVuJaBOdRhv; Sun, 21 Sep 2008 00:33:40 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id B058B52C3BC;
	Sun, 21 Sep 2008 00:33:40 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id F33A06DF823; Sun, 21 Sep 2008 00:33:13 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 64F941DE6D9; Sun, 21 Sep 2008 00:33:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080920214808.GA7426@diku.dk>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96377>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../spearce/jgit/transport/OpenSshConfigTest.java  |   24 ++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

 I sent the previous patch a bit too early. This one has the assertions.

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
index 959b6b7..8c1133d 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
@@ -81,6 +81,30 @@ public void testNoConfig() {
 		assertNull(h.getIdentityFile());
 	}
 
+	public void testSeparatorParsing() throws Exception {
+		config("Host\tfirst\n" +
+		       "\tHostName\tfirst.tld\n" +
+		       "\n" +
+		       "Host second\n" +
+		       " HostName\tsecond.tld\n" +
+		       "Host=third\n" +
+		       "HostName=third.tld\n\n\n" +
+		       "\t Host = fourth\n\n\n" +
+		       " \t HostName\t=fourth.tld\n" +
+		       "Host\t =     last\n" +
+		       "HostName  \t    last.tld");
+		assertNotNull(osc.lookup("first"));
+		assertEquals("first.tld", osc.lookup("first").getHostName());
+		assertNotNull(osc.lookup("second"));
+		assertEquals("second.tld", osc.lookup("second").getHostName());
+		assertNotNull(osc.lookup("third"));
+		assertEquals("third.tld", osc.lookup("third").getHostName());
+		assertNotNull(osc.lookup("fourth"));
+		assertEquals("fourth.tld", osc.lookup("fourth").getHostName());
+		assertNotNull(osc.lookup("last"));
+		assertEquals("last.tld", osc.lookup("last").getHostName());
+	}
+
 	public void testAlias_DoesNotMatch() throws Exception {
 		config("Host orcz\n" + "\tHostName repo.or.cz\n");
 		final Host h = osc.lookup("repo.or.cz");
-- 
1.6.0.2.444.gf2494

-- 
Jonas Fonseca
