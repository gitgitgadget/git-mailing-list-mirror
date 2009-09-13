From: mr.gaffo@gmail.com
Subject: [PATCH JGit 03/19] Add abstract method for updating the object db's info cache Implemented passthrough on Alternate for the update of infocache
Date: Sun, 13 Sep 2009 13:44:19 -0500
Message-ID: <1252867475-858-4-git-send-email-mr.gaffo@gmail.com>
References: <1252867475-858-1-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-2-git-send-email-mr.gaffo@gmail.com>
 <1252867475-858-3-git-send-email-mr.gaffo@gmail.com>
Cc: "mike.gaffney" <mike.gaffney@asolutions.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:45:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmu4L-00038i-4H
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 20:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbZIMSou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 14:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752956AbZIMSos
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 14:44:48 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:20766 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbZIMSom (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 14:44:42 -0400
Received: by an-out-0708.google.com with SMTP id d40so7549088and.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 11:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9mlCAW02nd3EOTcBeVX229jJF60XKn/cQc9hIPQxUuo=;
        b=P+4k0s3kOQGRIobzxGQx0ltApGTrHv8L5er0TsUdclfRQSIICGbJUMFQ7V7wMCVYJV
         ZvVlSPIQZZ2hpJ313yX3DVoUCz27nHDKKn3QHX46LbFge+1/5wN8PgO8P07CQmhjtChl
         /HNwqZ/1bmn02q8s0+yZdYKydAD+wpizkmGRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RzWoTwS0MGNH4XCyn5/WfC8Q830ePMOqDm106mC/r+m6sgdCgf6Ag6fstsO0Dv6ZEu
         3LDpoP5Afn2IvqFJtEr47oNqKatkVhddhfZ0ueCKNUvIf49dLR60jbj+6ANlbipk+X33
         +VdOhfIlF6fQRZfTaF/CE1kx3lYy4+8Kpyrec=
Received: by 10.101.41.3 with SMTP id t3mr5566704anj.86.1252867486299;
        Sun, 13 Sep 2009 11:44:46 -0700 (PDT)
Received: from localhost.localdomain ([70.230.157.86])
        by mx.google.com with ESMTPS id 23sm1238736yxe.0.2009.09.13.11.44.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 11:44:45 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.2
In-Reply-To: <1252867475-858-3-git-send-email-mr.gaffo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128387>

From: mike.gaffney <mike.gaffney@asolutions.com>

---
 .../jgit/lib/AlternateRepositoryDatabase.java      |    5 +++++
 .../src/org/spearce/jgit/lib/ObjectDatabase.java   |    7 +++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
index 68ad488..5cb0579 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AlternateRepositoryDatabase.java
@@ -130,4 +130,9 @@ protected void closeAlternates(final ObjectDatabase[] alt) {
 	public List<PackFile> listLocalPacks() {
 		return odb.listLocalPacks();
 	}
+
+	@Override
+	public void updateInfoCache() {
+		odb.updateInfoCache();
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
index 722c802..68ff523 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectDatabase.java
@@ -75,6 +75,13 @@ protected ObjectDatabase() {
 	public abstract List<PackFile> listLocalPacks();
 	
 	/**
+	 * Creates the caches that are typically done by 
+	 * update-server-info, namely objects/info/packs and 
+	 * info/refs
+	 */
+	public abstract void updateInfoCache();
+	
+	/**
 	 * Does this database exist yet?
 	 *
 	 * @return true if this database is already created; false if the caller
-- 
1.6.4.2
