From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH 10/11] Don't decorate every single resource on repository change
Date: Thu,  5 Feb 2009 02:00:17 +0100
Message-ID: <1233795618-20249-11-git-send-email-torarnv@gmail.com>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com>
 <1233795618-20249-2-git-send-email-torarnv@gmail.com>
 <1233795618-20249-3-git-send-email-torarnv@gmail.com>
 <1233795618-20249-4-git-send-email-torarnv@gmail.com>
 <1233795618-20249-5-git-send-email-torarnv@gmail.com>
 <1233795618-20249-6-git-send-email-torarnv@gmail.com>
 <1233795618-20249-7-git-send-email-torarnv@gmail.com>
 <1233795618-20249-8-git-send-email-torarnv@gmail.com>
 <1233795618-20249-9-git-send-email-torarnv@gmail.com>
 <1233795618-20249-10-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 02:02:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUsdO-0000xt-01
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 02:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756658AbZBEBA1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2009 20:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756443AbZBEBAY
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 20:00:24 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:9996 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756169AbZBEA74 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 19:59:56 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1591fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 16:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=HU6BNZwW2CEyCa4DwURk1pNjhCrIgIhuDXw1OfEXBI4=;
        b=fEXDNgh+lRoJ166arP6JDz2TpfQXT98HoZV6omxrobdb+yRb24s1Cgh50jkzAxYFcv
         NLha0MyxZlb3OIAkG8CpfGo6bPy3YsfEnR8Su7q5O0QS2eyeXvHe8sYvDbcOWIdiJUCJ
         vpIZhn0kgaYWJXT7WXwTXufWly33VgRTdJkFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=e/UEEtwiKrXyaOOuV8m4w1fGiFLDVgt9ihW4jHXHfJHLe/KVQ9bKa6YVnvkkBGrKgq
         1yOaD5+/SdIcGUazJYs/9iJrAVXPPmu7ASAmrZz+mXCQ0PI/pF7v3S95crIGtdXc/OB/
         q17l9hLppdpgLTouRtBGylTTAcwNwTq88NDHI=
Received: by 10.86.59.2 with SMTP id h2mr902150fga.30.1233795592293;
        Wed, 04 Feb 2009 16:59:52 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id l12sm28186fgb.51.2009.02.04.16.59.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 16:59:51 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id C44CE468007; Thu,  5 Feb 2009 02:00:19 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <1233795618-20249-10-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108483>

Not all resources have corresponding labels that are visible,
so by using LabelProviderChangedEvent() we ensure that only
the visible labels are refreshed.

The downside is that we lose project precition, so all
projects are included, but only visible labels in those
projects are re-decorated, so it is OK for now.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 .../decorators/GitLightweightDecorator.java        |   28 +++---------=
--------
 1 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decor=
ators/GitLightweightDecorator.java b/org.spearce.egit.ui/src/org/spearc=
e/egit/ui/internal/decorators/GitLightweightDecorator.java
index aa6a261..45b9f83 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/G=
itLightweightDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/G=
itLightweightDecorator.java
@@ -14,11 +14,9 @@
 package org.spearce.egit.ui.internal.decorators;
=20
 import java.io.IOException;
-import java.util.ArrayList;
 import java.util.Collections;
 import java.util.HashMap;
 import java.util.HashSet;
-import java.util.List;
 import java.util.Map;
 import java.util.Set;
=20
@@ -28,7 +26,6 @@
 import org.eclipse.core.resources.IResourceChangeListener;
 import org.eclipse.core.resources.IResourceDelta;
 import org.eclipse.core.resources.IResourceDeltaVisitor;
-import org.eclipse.core.resources.IResourceVisitor;
 import org.eclipse.core.resources.ResourcesPlugin;
 import org.eclipse.core.resources.mapping.ResourceMapping;
 import org.eclipse.core.runtime.CoreException;
@@ -682,7 +679,7 @@ public void propertyChange(PropertyChangeEvent even=
t) {
 		if (prop.equals(TeamUI.GLOBAL_IGNORES_CHANGED)
 				|| prop.equals(TeamUI.GLOBAL_FILE_TYPES_CHANGED)
 				|| prop.equals(Activator.DECORATORS_CHANGED)) {
-			postLabelEvent(new LabelProviderChangedEvent(this, null /* all */))=
;
+			postLabelEvent(new LabelProviderChangedEvent(this));
 		}
 	}
=20
@@ -809,29 +806,12 @@ public void refsChanged(RefsChangedEvent e) {
 	 * Callback for RepositoryChangeListener events, as well as
 	 * RepositoryListener events via repositoryChanged()
 	 *=20
-	 * We resolve the project and schedule a refresh of each resource in =
the
-	 * project.
-	 *=20
 	 * @see org.spearce.egit.core.project.RepositoryChangeListener#reposi=
toryChanged(org.spearce.egit.core.project.RepositoryMapping)
 	 */
 	public void repositoryChanged(RepositoryMapping mapping) {
-		final IProject project =3D mapping.getContainer().getProject();
-		if (project =3D=3D null)
-			return;
-
-		final List<IResource> resources =3D new ArrayList<IResource>();
-		try {
-			project.accept(new IResourceVisitor() {
-				public boolean visit(IResource resource) {
-					resources.add(resource);
-					return true;
-				}
-			});
-			postLabelEvent(new LabelProviderChangedEvent(this, resources
-					.toArray()));
-		} catch (final CoreException e) {
-			handleException(project, e);
-		}
+		// Until we find a way to refresh visible labels within a project
+		// we have to use this blanket refresh that includes all projects.
+		postLabelEvent(new LabelProviderChangedEvent(this));
 	}
=20
 	// -------- Helper methods --------
--=20
1.6.1.2.309.g2ea3
