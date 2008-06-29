From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 02/21] Do not show URIish passwords in TransportExceptions
Date: Sun, 29 Jun 2008 03:59:12 -0400
Message-ID: <1214726371-93520-3-git-send-email-spearce@spearce.org>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org>
 <1214726371-93520-2-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 10:01:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCrqi-00005Q-WA
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbYF2IAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 04:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbYF2IAb
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:00:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36725 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbYF2H7r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 03:59:47 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCroz-0004Ll-Bu; Sun, 29 Jun 2008 03:59:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1007)
	id AF1EE20FBC9; Sun, 29 Jun 2008 03:59:41 -0400 (EDT)
Received: from localhost.localdomain (i2.home.spearce.org [10.123.0.15])
	by asimov.home.spearce.org (Postfix) with ESMTP id 40E0720FBCA;
	Sun, 29 Jun 2008 03:59:32 -0400 (EDT)
X-Mailer: git-send-email 1.5.6.74.g8a5e
In-Reply-To: <1214726371-93520-2-git-send-email-spearce@spearce.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86765>

When construction a transport exception the message may be shown
on screen.  If a password was in the URIish then we may wind up
showing the user's password, perhaps while there is someone else
looking over the user's shoulder and reading their monitor.  By
setting the field to null we avoid displaying it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../spearce/jgit/errors/TransportException.java    |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/errors/TransportException.java b/org.spearce.jgit/src/org/spearce/jgit/errors/TransportException.java
index 4a8e37c..7fbbc5a 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/errors/TransportException.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/errors/TransportException.java
@@ -58,7 +58,7 @@ public class TransportException extends IOException {
 	 *            message
 	 */
 	public TransportException(final URIish uri, final String s) {
-		super(uri + ": " + s);
+		super(uri.setPass(null) + ": " + s);
 	}
 
 	/**
@@ -74,7 +74,7 @@ public class TransportException extends IOException {
 	 */
 	public TransportException(final URIish uri, final String s,
 			final Throwable cause) {
-		this(uri + ": " + s, cause);
+		this(uri.setPass(null) + ": " + s, cause);
 	}
 
 	/**
-- 
1.5.6.74.g8a5e
