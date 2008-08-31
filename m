From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH] Disambiguate "push not supported" from "repository not found"
Date: Sun, 31 Aug 2008 10:28:58 +0200
Message-ID: <200808311028.59348.robin.rosenberg@dewire.com>
References: <1219969118-31672-1-git-send-email-spearce@spearce.org> <48B7E927.2000205@gmail.com> <20080829143116.GB7403@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 31 10:32:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZiML-0000Ri-VZ
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 10:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbYHaIbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 04:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752729AbYHaIbY
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 04:31:24 -0400
Received: from [83.140.172.130] ([83.140.172.130]:7277 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752714AbYHaIbX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 04:31:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 7CF0AA149A1;
	Sun, 31 Aug 2008 10:31:21 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UvlAb1Lz7eXD; Sun, 31 Aug 2008 10:31:21 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id EA328802806;
	Sun, 31 Aug 2008 10:31:20 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080829143116.GB7403@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94464>

fredagen den 29 augusti 2008 16.31.16 skrev Shawn O. Pearce:
> Marek Zawirski <marek.zawirski@gmail.com> wrote:
> > Robin Rosenberg wrote:
> >>
> >> Why an extra method for instantiating the exception?
> >
> > Isn't it overrode in subclass - BasePackPushConnection?
> 
> Correct.  I introduced the method so the subclass can inject its
> own implementation for the catch block.  But its required to give
> back a TransportException so the catch block can throw it, as we
> do not want the subclass to be able to continue at this point.

Mind if I squash this into the patch?

-- robin

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
index e35f850..16e4897 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/BasePackConnection.java
@@ -182,6 +182,15 @@ private void readAdvertisedRefsImpl() throws IOException {
                available(avail);
        }

+       /**
+        * Create an exception to indicate problems finding a remote repository. The
+        * caller is expected to throw the returned exception.
+        *
+        * Subclasses may override this method to provide better diagnostics.
+        *
+        * @return a TransportException saying a repository cannot be found and
+        *         possibly why.
+        */
        protected TransportException noRepository() {
                return new NoRemoteRepositoryException(uri, "not found.");
        }
