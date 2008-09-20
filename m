From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [JGIT PATCH] Fixed a bug that caused tabs in ~/.ssh/config to
	break parsing
Date: Sun, 21 Sep 2008 00:29:58 +0200
Message-ID: <20080920222958.GA18981@diku.dk>
References: <12219428213749-git-send-email-ggoudsmit@shebang.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Gilion Goudsmit <ggoudsmit@shebang.nl>
X-From: git-owner@vger.kernel.org Sun Sep 21 00:31:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhAyt-0006EW-28
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 00:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbYITWaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 18:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbYITWaB
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 18:30:01 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:39515 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707AbYITWaA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 18:30:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 920FC19BCBB;
	Sun, 21 Sep 2008 00:29:59 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04386-07; Sun, 21 Sep 2008 00:29:58 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 686C419BC5F;
	Sun, 21 Sep 2008 00:29:58 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id BC63B6DF88D; Sun, 21 Sep 2008 00:29:31 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 507321DE6D9; Sun, 21 Sep 2008 00:29:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <12219428213749-git-send-email-ggoudsmit@shebang.nl>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96376>

Gilion Goudsmit <ggoudsmit@shebang.nl> wrote Sat, Sep 20, 2008:
> Having only tab-characters separating a key and value in the
> users ~/.ssh/config would cause the config-parser to fail with
> a "String index out of range: -1" exception. Also simplified
> the line parsing code my using a two argument split.
> 
> Signed-off-by: Gilion Goudsmit <ggoudsmit@shebang.nl>
> ---

With the following on top, the code will also pass the updated test for:

	Host	= somewhere

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
index 5bfcf5f..a9c6c12 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
@@ -167,7 +167,7 @@ public Host lookup(final String hostName) {
 			if (line.length() == 0 || line.startsWith("#"))
 				continue;
 
-			final String[] parts = line.split("[ \t=]", 2);
+			final String[] parts = line.split("[ \t]*[= \t]", 2);
 			final String keyword = parts[0].trim();
 			final String argValue = parts[1].trim();

-- 
Jonas Fonseca
