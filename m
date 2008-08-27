From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 3/6] Handle null remoteName in RefSpecPanel better
Date: Wed, 27 Aug 2008 20:41:43 +0200
Message-ID: <1219862506-11075-4-git-send-email-marek.zawirski@gmail.com>
References: <1219862506-11075-1-git-send-email-marek.zawirski@gmail.com>
 <1219862506-11075-2-git-send-email-marek.zawirski@gmail.com>
 <1219862506-11075-3-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Aug 27 20:43:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYPz3-0005bI-OT
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 20:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbYH0SmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 14:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006AbYH0SmH
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 14:42:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:44159 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbYH0SmB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 14:42:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so37874fgg.17
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 11:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7opcRfEnSqVWpbGG/tXz7GUFAomZ6Qq3ubOKs2IpWzw=;
        b=CQJgFrVrxBgHFnj4fg8RV31zH5cloup+HW3d1jfAkpt0ym4wj//GZ3Z4uyFugGsu/Z
         ddPNKdS/Uvu3KNFoiP7+dHyThllm6QCjgfNbQDJkeyLJMoaKy4bOy8h9dVWd0QxOOF5I
         8OAYR+8ShF9P5M2JaM1WT/oOmeLPeWn762eG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bJ4QA99AO7R9JC6c4jSqegUqbUbUDWhmfD8B3IsnCA9MmWv6vNLZtyMovAgz7CfkiV
         RefIwVPxiMYtjsog247TMLBauQCRNRT6qvZ08V7JMCwHOtNg2cmkfA9T5D/YYX87escf
         JEdEnhIo1BmSrbpedWqglHh5C/YCytXroK7io=
Received: by 10.86.63.19 with SMTP id l19mr293637fga.77.1219862519408;
        Wed, 27 Aug 2008 11:41:59 -0700 (PDT)
Received: from localhost ( [62.21.4.140])
        by mx.google.com with ESMTPS id 4sm139488fgg.4.2008.08.27.11.41.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Aug 2008 11:41:58 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219862506-11075-3-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93918>

Create more sensible "all branches" ref spec
(refs/remotes/choose_remote_name/*), and don't use RemoteConfig
contructor with null remoteName value, as this behavior is unspecified.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/egit/ui/UIText.java            |    3 ++
 .../egit/ui/internal/components/RefSpecPanel.java  |   30 +++++++++++++------
 .../src/org/spearce/egit/ui/uitext.properties      |    1 +
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index b45d2e9..2bbe218 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -182,6 +182,9 @@
 	public static String RefSpecPanel_refChooseSomeWildcard;
 
 	/** */
+	public static String RefSpecPanel_refChooseRemoteName;
+
+	/** */
 	public static String RefSpecPanel_clickToChange;
 
 	/** */
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java
index de82480..a2661ae 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/components/RefSpecPanel.java
@@ -413,14 +413,18 @@ public void setAssistanceData(final Repository localRepo,
 		}
 
 		try {
-			final RemoteConfig rc = new RemoteConfig(localDb.getConfig(),
-					remoteName);
-			if (pushSpecs)
-				predefinedConfigured = rc.getPushRefSpecs();
-			else
-				predefinedConfigured = rc.getFetchRefSpecs();
-			for (final RefSpec spec : predefinedConfigured)
-				addRefSpec(spec);
+			if (remoteName == null)
+				predefinedConfigured = Collections.emptyList();
+			else {
+				final RemoteConfig rc = new RemoteConfig(localDb.getConfig(),
+						remoteName);
+				if (pushSpecs)
+					predefinedConfigured = rc.getPushRefSpecs();
+				else
+					predefinedConfigured = rc.getFetchRefSpecs();
+				for (final RefSpec spec : predefinedConfigured)
+					addRefSpec(spec);
+			}
 		} catch (URISyntaxException e) {
 			predefinedConfigured = null;
 			ErrorDialog.openError(panel.getShell(),
@@ -432,9 +436,15 @@ public void setAssistanceData(final Repository localRepo,
 		updateAddPredefinedButton(addConfiguredButton, predefinedConfigured);
 		if (pushSpecs)
 			predefinedBranches = Transport.REFSPEC_PUSH_ALL;
-		else
+		else {
+			final String r;
+			if (remoteName == null)
+				r = UIText.RefSpecPanel_refChooseRemoteName;
+			else
+				r = remoteName;
 			predefinedBranches = new RefSpec("refs/heads/*:refs/remotes/" //$NON-NLS-1$
-					+ remoteName + "/*"); //$NON-NLS-1$
+					+ r + "/*"); //$NON-NLS-1$
+		}
 		updateAddPredefinedButton(addBranchesButton, predefinedBranches);
 		setEnable(true);
 	}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index 7fcc77b..c2b91f7 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -116,6 +116,7 @@ RefSpecPanel_predefinedTagsDescription=Add specification covering all tags.
 RefSpecPanel_push=push
 RefSpecPanel_refChooseSome=choose/some/ref
 RefSpecPanel_refChooseSomeWildcard=choose/some/ref/*
+RefSpecPanel_refChooseRemoteName=choose_remote_name
 RefSpecPanel_removeAll=Remove all specs
 RefSpecPanel_removeAllDescription=Remove all speficications.
 RefSpecPanel_removeDescription=Click to remove this specification.
-- 
1.5.6.3
