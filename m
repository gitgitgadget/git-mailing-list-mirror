From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH v2 10/12] Don't decorate every single resource on repository change
Date: Wed, 11 Feb 2009 19:40:12 +0100
Message-ID: <1234377614-23798-11-git-send-email-torarnv@gmail.com>
References: <1234377614-23798-1-git-send-email-torarnv@gmail.com>
 <1234377614-23798-2-git-send-email-torarnv@gmail.com>
 <1234377614-23798-3-git-send-email-torarnv@gmail.com>
 <1234377614-23798-4-git-send-email-torarnv@gmail.com>
 <1234377614-23798-5-git-send-email-torarnv@gmail.com>
 <1234377614-23798-6-git-send-email-torarnv@gmail.com>
 <1234377614-23798-7-git-send-email-torarnv@gmail.com>
 <1234377614-23798-8-git-send-email-torarnv@gmail.com>
 <1234377614-23798-9-git-send-email-torarnv@gmail.com>
 <1234377614-23798-10-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:42:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXK26-0005RI-99
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920AbZBKSkM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2009 13:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756915AbZBKSkL
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:40:11 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:1116 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756884AbZBKSkH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:40:07 -0500
Received: by fg-out-1718.google.com with SMTP id 16so108715fgg.17
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 10:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=KeVMdpPEOQNR6wwwEvu8ZYmLWc7eqvqG6o1aWT1/au4=;
        b=axCxDIGwCZcG9aDfOCkpEMKze6/T2eKwfF9TC5E/g/GFiZrdKXuejqD5b7voaCB9a4
         N62Z4WzpjEuCk/ezNA3qQ4bNh1Jh+Vx0Zbrgg9ioXYPeAKklNPWLPhQkM9Wc9FZXPPuM
         MfelMEErttN6n9vBZOwQ1XFkL8bweM53i3qnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=mCClidoawTgKl3D3ZEWRtSRGCKTgj5o0RgSlDarsRFUiLwDAx4S0ITRVN2xHzUbBMC
         s1Qtub9NyhG9oSIX4AIURRRdBC3zCU00QV783DjjfLbFi0EQbhplAbYnW1r9Wn70wqpx
         tdUB37TZ99BA0dsf/8LOU1UCKB+Rc8zaeayks=
Received: by 10.86.92.7 with SMTP id p7mr845174fgb.74.1234377606837;
        Wed, 11 Feb 2009 10:40:06 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id e20sm4905571fga.56.2009.02.11.10.39.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Feb 2009 10:39:39 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id D535A468007; Wed, 11 Feb 2009 19:40:16 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <1234377614-23798-10-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109493>

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
index c23ce24..1e95369 100644
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
@@ -697,7 +694,7 @@ public void propertyChange(PropertyChangeEvent even=
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
@@ -824,29 +821,12 @@ public void refsChanged(RefsChangedEvent e) {
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
