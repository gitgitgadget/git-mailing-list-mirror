From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH 06/11] Implement basic customizable label decorations with preferences
Date: Thu,  5 Feb 2009 02:00:13 +0100
Message-ID: <1233795618-20249-7-git-send-email-torarnv@gmail.com>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com>
 <1233795618-20249-2-git-send-email-torarnv@gmail.com>
 <1233795618-20249-3-git-send-email-torarnv@gmail.com>
 <1233795618-20249-4-git-send-email-torarnv@gmail.com>
 <1233795618-20249-5-git-send-email-torarnv@gmail.com>
 <1233795618-20249-6-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 02:02:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUsdM-0000xt-Hr
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 02:02:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbZBEBAX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2009 20:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756377AbZBEBAV
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 20:00:21 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:5805 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755697AbZBEA7y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 19:59:54 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1578fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 16:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=7/659hvuJ1v90/+bpTPTRRw4jutiEbrsfK06xZLpwE0=;
        b=LY/ej4MJt/y7oGVE09Kt56TwALTKUeugPN6gLdXSuwQJYLschIx064jcJjEhciuKQ9
         Ff3KMqpgnrZ9Y4T93adH4LeG/zcXzfduXsUYh1Vqq/Kl9oNBLU2oans+/uL5IUeOtvEE
         1RLz6Blk5O7gQXtRolhaYIAfyaZnVn9MvikLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=f7zgnXc++ygLhKv9gtmx1wYBJv1DWWU/IwHB91rTr6+CBhrq9ccL3lKJIXfcSPIeLK
         pz7lcgNKT9NkixbOaDYXDQqF2J7tFXyCjiDKmqx0tH8SqnwitT69TcvBn+cC8lp18bUZ
         +GBJejSnCsZUhVuqF/4GimtzQ2lT+e9tRJQe0=
Received: by 10.86.100.19 with SMTP id x19mr928fgb.18.1233795592944;
        Wed, 04 Feb 2009 16:59:52 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id 4sm20715fge.44.2009.02.04.16.59.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 16:59:52 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id A2AE8468004; Thu,  5 Feb 2009 02:00:19 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <1233795618-20249-6-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108487>

Currently the only binding available is the resource name, but
this commit enables a framework for adding more bindings.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 org.spearce.egit.ui/plugin.properties              |    1 +
 org.spearce.egit.ui/plugin.xml                     |   12 +-
 .../src/org/spearce/egit/ui/Activator.java         |   16 +
 .../egit/ui/PluginPreferenceInitializer.java       |    8 +
 .../src/org/spearce/egit/ui/UIPreferences.java     |    9 +
 .../src/org/spearce/egit/ui/UIText.java            |   63 ++-
 .../egit/ui/internal/actions/BranchAction.java     |    4 +-
 .../egit/ui/internal/actions/Disconnect.java       |    4 +-
 .../egit/ui/internal/actions/ResetAction.java      |    4 +-
 .../decorators/GitLightweightDecorator.java        |  538 ++++++++++++=
++
 .../internal/decorators/GitResourceDecorator.java  |  454 ------------
 .../internal/decorators/IDecoratableResource.java  |   31 +
 .../preferences/GitDecoratorPreferencePage.java    |  735 ++++++++++++=
++++++++
 .../src/org/spearce/egit/ui/uitext.properties      |   25 +-
 14 files changed, 1438 insertions(+), 466 deletions(-)
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/interna=
l/decorators/GitLightweightDecorator.java
 delete mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/interna=
l/decorators/GitResourceDecorator.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/interna=
l/decorators/IDecoratableResource.java
 create mode 100644 org.spearce.egit.ui/src/org/spearce/egit/ui/interna=
l/preferences/GitDecoratorPreferencePage.java

diff --git a/org.spearce.egit.ui/plugin.properties b/org.spearce.egit.u=
i/plugin.properties
index fa043f1..58b879f 100644
--- a/org.spearce.egit.ui/plugin.properties
+++ b/org.spearce.egit.ui/plugin.properties
@@ -64,3 +64,4 @@ Theme_CommitMessageFont_description=3DThis font is us=
ed to show a commit message.
 GitPreferences_name=3DGit
 GitPreferences_HistoryPreferencePage_name=3DHistory
 GitPreferences_WindowCachePreferencePage_name=3DWindow Cache
+GitPreferences_DecoratorPreferencePage_name=3DLabel Decorations
diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugi=
n.xml
index 869108c..2f23559 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -200,6 +200,14 @@
 		  id=3D"org.spearce.egit.ui.keyword.git">
 	    </keywordReference>
       </page>
+	  <page name=3D"%GitPreferences_DecoratorPreferencePage_name"
+	    category=3D"org.spearce.egit.ui.GitPreferences"
+            class=3D"org.spearce.egit.ui.internal.preferences.GitDecor=
atorPreferencePage"
+	    id=3D"org.spearce.egit.ui.internal.preferences.GitDecoratorPrefer=
encePage" >
+	    <keywordReference
+		  id=3D"org.spearce.egit.ui.keyword.git">
+	    </keywordReference>
+      </page>
    </extension>
=20
    <extension point=3D"org.eclipse.ui.propertyPages">
@@ -233,10 +241,10 @@
             lightweight=3D"true"
             adaptable=3D"true"
             label=3D"%Decorator_name"
-            class=3D"org.spearce.egit.ui.internal.decorators.GitResour=
ceDecorator"
+            class=3D"org.spearce.egit.ui.internal.decorators.GitLightw=
eightDecorator"
             state=3D"true"
             location=3D"BOTTOM_RIGHT"
-            id=3D"org.spearce.egit.ui.internal.decorators.GitResourceD=
ecorator">
+            id=3D"org.spearce.egit.ui.internal.decorators.GitLightweig=
htDecorator">
             <enablement>
               <objectClass name=3D"org.eclipse.core.resources.IResourc=
e"/>
             </enablement>
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java=
 b/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
index d4a9e8e..9d03c70 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/Activator.java
@@ -33,6 +33,7 @@
 import org.eclipse.jface.util.PropertyChangeEvent;
 import org.eclipse.jsch.core.IJSchService;
 import org.eclipse.swt.graphics.Font;
+import org.eclipse.swt.widgets.Display;
 import org.eclipse.ui.plugin.AbstractUIPlugin;
 import org.eclipse.ui.themes.ITheme;
 import org.osgi.framework.BundleContext;
@@ -80,6 +81,21 @@ public static String getPluginId() {
 	}
=20
 	/**
+	 * Returns the standard display to be used. The method first checks, =
if the
+	 * thread calling this method has an associated display. If so, this =
display
+	 * is returned. Otherwise the method returns the default display.
+	 *=20
+	 * @return the display to use
+	 */
+	public static Display getStandardDisplay() {
+		Display display =3D Display.getCurrent();
+		if (display =3D=3D null) {
+			display =3D Display.getDefault();
+		}
+		return display;
+	}
+
+	/**
 	 * Instantiate an error exception.
 	 *=20
 	 * @param message
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferen=
ceInitializer.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/Plugin=
PreferenceInitializer.java
index bb7381f..79c2665 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceIniti=
alizer.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/PluginPreferenceIniti=
alizer.java
@@ -35,6 +35,14 @@ public void initializeDefaultPreferences() {
 		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_REV_COMMENT, tru=
e);
 		prefs.setDefault(UIPreferences.RESOURCEHISTORY_SHOW_TOOLTIPS, false)=
;
=20
+		prefs.setDefault(UIPreferences.DECORATOR_FILETEXT_DECORATION,
+				UIText.DecoratorPreferencesPage_fileFormatDefault);
+		prefs.setDefault(UIPreferences.DECORATOR_FOLDERTEXT_DECORATION,
+				UIText.DecoratorPreferencesPage_folderFormatDefault);
+		prefs.setDefault(UIPreferences.DECORATOR_PROJECTTEXT_DECORATION,
+				UIText.DecoratorPreferencesPage_projectFormatDefault);
+		prefs.setDefault(UIPreferences.DECORATOR_CALCULATE_DIRTY, true);
+
 		w =3D new int[] { 500, 500 };
 		UIPreferences.setDefault(prefs,
 				UIPreferences.RESOURCEHISTORY_GRAPH_SPLIT, w);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.=
java b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
index 5ab6b25..a6168a0 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIPreferences.java
@@ -52,6 +52,15 @@
 	/** */
 	public final static String THEME_CommitMessageFont =3D "org.spearce.e=
git.ui.CommitMessageFont";
=20
+	/** */
+	public final static String DECORATOR_CALCULATE_DIRTY =3D "decorator_c=
alculate_dirty";
+	/** */
+	public final static String DECORATOR_FILETEXT_DECORATION =3D "decorat=
or_filetext_decoration";
+	/** */
+	public final static String DECORATOR_FOLDERTEXT_DECORATION =3D "decor=
ator_foldertext_decoration";
+	/** */
+	public final static String DECORATOR_PROJECTTEXT_DECORATION =3D "deco=
rator_projecttext_decoration";
+
 	/**
 	 * Get the preference values associated with a fixed integer array.
 	 *=20
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java b/=
org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
index 7a7d3ef..23498c8 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIText.java
@@ -446,9 +446,6 @@
 	public static String RefSpecPage_annotatedTagsNoTags;
=20
 	/** */
-	public static String Decorator_failedLazyLoading;
-
-	/** */
 	public static String QuickDiff_failedLoading;
=20
 	/** */
@@ -913,6 +910,66 @@
 	/** */
 	public static String BranchSelectionDialog_Refs;
=20
+	/** */
+	public static String Decorator_exceptionMessage;
+
+	/** */
+	public static String DecoratorPreferencesPage_addVariablesTitle;
+
+	/** */
+	public static String DecoratorPreferencesPage_addVariablesAction;
+
+	/** */
+	public static String DecoratorPreferencesPage_computeDeep;
+
+	/** */
+	public static String DecoratorPreferencesPage_description;
+
+	/** */
+	public static String DecoratorPreferencesPage_decorationSettings;
+
+	/** */
+	public static String DecoratorPreferencesPage_preview;
+
+	/** */
+	public static String DecoratorPreferencesPage_fileFormatLabel;
+
+	/** */
+	public static String DecoratorPreferencesPage_folderFormatLabel;
+
+	/** */
+	public static String DecoratorPreferencesPage_projectFormatLabel;
+
+	/** */
+	public static String DecoratorPreferencesPage_fileFormatDefault;
+
+	/** */
+	public static String DecoratorPreferencesPage_projectFormatDefault;
+
+	/** */
+	public static String DecoratorPreferencesPage_folderFormatDefault;
+
+	/** */
+	public static String DecoratorPreferencesPage_generalTabFolder;
+
+	/** */
+	public static String DecoratorPreferencesPage_nameResourceVariable;
+
+	/** */
+	public static String DecoratorPreferencesPage_selectFormats;
+
+	/** */
+	public static String DecoratorPreferencesPage_selectVariablesToAdd;
+
+	/** */
+	public static String DecoratorPreferencesPage_textLabel;
+
+	/** */
+	public static String DecoratorPreferencesPage_iconLabel;
+
+	/** */
+	public static String DecoratorPreferencesPage_labelDecorationsLink;
+
 	static {
 		initializeMessages(UIText.class.getPackage().getName() + ".uitext",
 				UIText.class);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actio=
ns/BranchAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/inte=
rnal/actions/BranchAction.java
index 7ca4d10..38ee3d8 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/Bran=
chAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/Bran=
chAction.java
@@ -19,7 +19,7 @@
 import org.eclipse.jface.operation.IRunnableWithProgress;
 import org.eclipse.swt.widgets.Display;
 import org.spearce.egit.core.op.BranchOperation;
-import org.spearce.egit.ui.internal.decorators.GitResourceDecorator;
+import org.spearce.egit.ui.internal.decorators.GitLightweightDecorator=
;
 import org.spearce.egit.ui.internal.dialogs.BranchSelectionDialog;
 import org.spearce.jgit.lib.Repository;
=20
@@ -56,7 +56,7 @@ public void run(final IProgressMonitor monitor)
 				throws InvocationTargetException {
 					try {
 						new BranchOperation(repository, refName).run(monitor);
-						GitResourceDecorator.refresh();
+						GitLightweightDecorator.refresh();
 					} catch (final CoreException ce) {
 						ce.printStackTrace();
 						Display.getDefault().asyncExec(new Runnable() {
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actio=
ns/Disconnect.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/intern=
al/actions/Disconnect.java
index 18d6b4b..4201822 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/Disc=
onnect.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/Disc=
onnect.java
@@ -13,7 +13,7 @@
 import org.eclipse.core.resources.IWorkspaceRunnable;
 import org.eclipse.jface.action.IAction;
 import org.spearce.egit.core.op.DisconnectProviderOperation;
-import org.spearce.egit.ui.internal.decorators.GitResourceDecorator;
+import org.spearce.egit.ui.internal.decorators.GitLightweightDecorator=
;
=20
 /**
  *	Action to disassociate a project from its Git repository.
@@ -27,6 +27,6 @@ protected IWorkspaceRunnable createOperation(final IA=
ction act,
 	}
=20
 	protected void postOperation() {
-		GitResourceDecorator.refresh();
+		GitLightweightDecorator.refresh();
 	}
 }
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actio=
ns/ResetAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/inter=
nal/actions/ResetAction.java
index b05cdd3..a329925 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/Rese=
tAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/Rese=
tAction.java
@@ -19,7 +19,7 @@
 import org.eclipse.jface.operation.IRunnableWithProgress;
 import org.spearce.egit.core.op.ResetOperation;
 import org.spearce.egit.core.op.ResetOperation.ResetType;
-import org.spearce.egit.ui.internal.decorators.GitResourceDecorator;
+import org.spearce.egit.ui.internal.decorators.GitLightweightDecorator=
;
 import org.spearce.egit.ui.internal.dialogs.BranchSelectionDialog;
 import org.spearce.jgit.lib.Repository;
=20
@@ -55,7 +55,7 @@ public void run(final IProgressMonitor monitor)
 					throws InvocationTargetException {
 						try {
 							new ResetOperation(repository, refName, type).run(monitor);
-							GitResourceDecorator.refresh();
+							GitLightweightDecorator.refresh();
 						} catch (CoreException ce) {
 							ce.printStackTrace();
 							throw new InvocationTargetException(ce);
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decor=
ators/GitLightweightDecorator.java b/org.spearce.egit.ui/src/org/spearc=
e/egit/ui/internal/decorators/GitLightweightDecorator.java
new file mode 100644
index 0000000..85b9173
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/G=
itLightweightDecorator.java
@@ -0,0 +1,538 @@
+/*********************************************************************=
**********
+ * Copyright (C) 2007, IBM Corporation and others
+ * Copyright (C) 2007, Dave Watson <dwatson@mimvista.com>
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Google Inc.
+ * Copyright (C) 2008, Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1=
=2E0
+ * See LICENSE for the full license text, also available.
+ *********************************************************************=
**********/
+
+package org.spearce.egit.ui.internal.decorators;
+
+import java.util.ArrayList;
+import java.util.HashMap;
+import java.util.HashSet;
+import java.util.List;
+import java.util.Map;
+import java.util.Set;
+
+import org.eclipse.core.resources.IProject;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.core.resources.IResourceChangeEvent;
+import org.eclipse.core.resources.IResourceChangeListener;
+import org.eclipse.core.resources.IResourceDelta;
+import org.eclipse.core.resources.IResourceDeltaVisitor;
+import org.eclipse.core.resources.IResourceVisitor;
+import org.eclipse.core.resources.ResourcesPlugin;
+import org.eclipse.core.resources.mapping.ResourceMapping;
+import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IAdaptable;
+import org.eclipse.core.runtime.IStatus;
+import org.eclipse.jface.preference.IPreferenceStore;
+import org.eclipse.jface.util.IPropertyChangeListener;
+import org.eclipse.jface.util.PropertyChangeEvent;
+import org.eclipse.jface.viewers.IDecoration;
+import org.eclipse.jface.viewers.ILightweightLabelDecorator;
+import org.eclipse.jface.viewers.LabelProvider;
+import org.eclipse.jface.viewers.LabelProviderChangedEvent;
+import org.eclipse.osgi.util.TextProcessor;
+import org.eclipse.swt.widgets.Display;
+import org.eclipse.team.ui.TeamUI;
+import org.eclipse.ui.IContributorResourceAdapter;
+import org.eclipse.ui.PlatformUI;
+import org.spearce.egit.core.internal.util.ExceptionCollector;
+import org.spearce.egit.core.project.GitProjectData;
+import org.spearce.egit.core.project.RepositoryChangeListener;
+import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.egit.ui.Activator;
+import org.spearce.egit.ui.UIPreferences;
+import org.spearce.egit.ui.UIText;
+import org.spearce.jgit.lib.IndexChangedEvent;
+import org.spearce.jgit.lib.RefsChangedEvent;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RepositoryChangedEvent;
+import org.spearce.jgit.lib.RepositoryListener;
+
+/**
+ * Supplies annotations for displayed resources
+ *=20
+ * This decorator provides annotations to indicate the status of each =
resource
+ * when compared to <code>HEAD</code>, as well as the index in the rel=
evant
+ * repository.
+ *=20
+ * TODO: Add support for colors and font decoration
+ */
+public class GitLightweightDecorator extends LabelProvider implements
+		ILightweightLabelDecorator, IPropertyChangeListener,
+		IResourceChangeListener, RepositoryChangeListener, RepositoryListene=
r {
+
+	/**
+	 * Property constant pointing back to the extension point id of the
+	 * decorator
+	 */
+	public static final String DECORATOR_ID =3D "org.spearce.egit.ui.inte=
rnal.decorators.GitLightweightDecorator"; //$NON-NLS-1$
+
+	/**
+	 * Bit-mask describing interesting changes for IResourceChangeListene=
r
+	 * events
+	 */
+	private static int INTERESTING_CHANGES =3D IResourceDelta.CONTENT
+			| IResourceDelta.MOVED_FROM | IResourceDelta.MOVED_TO
+			| IResourceDelta.OPEN | IResourceDelta.REPLACED
+			| IResourceDelta.TYPE;
+
+	/**
+	 * Collector for keeping the error view from filling up with exceptio=
ns
+	 */
+	private static ExceptionCollector exceptions =3D new ExceptionCollect=
or(
+			UIText.Decorator_exceptionMessage, Activator.getPluginId(),
+			IStatus.ERROR, Activator.getDefault().getLog());
+
+	/**
+	 * Constructs a new Git resource decorator
+	 */
+	public GitLightweightDecorator() {
+		TeamUI.addPropertyChangeListener(this);
+		Activator.addPropertyChangeListener(this);
+		PlatformUI.getWorkbench().getThemeManager().getCurrentTheme()
+				.addPropertyChangeListener(this);
+		Repository.addAnyRepositoryChangedListener(this);
+		GitProjectData.addRepositoryChangeListener(this);
+		ResourcesPlugin.getWorkspace().addResourceChangeListener(this,
+				IResourceChangeEvent.POST_CHANGE);
+	}
+
+	/*
+	 * (non-Javadoc)
+	 *=20
+	 * @see org.eclipse.jface.viewers.IBaseLabelProvider#dispose()
+	 */
+	@Override
+	public void dispose() {
+		super.dispose();
+		PlatformUI.getWorkbench().getThemeManager().getCurrentTheme()
+				.removePropertyChangeListener(this);
+		TeamUI.removePropertyChangeListener(this);
+		Activator.removePropertyChangeListener(this);
+		Repository.removeAnyRepositoryChangedListener(this);
+		GitProjectData.removeRepositoryChangeListener(this);
+		ResourcesPlugin.getWorkspace().removeResourceChangeListener(this);
+	}
+
+	/**
+	 * This method should only be called by the decorator thread.
+	 *=20
+	 * @see org.eclipse.jface.viewers.ILightweightLabelDecorator#decorate=
(java.lang.Object,
+	 *      org.eclipse.jface.viewers.IDecoration)
+	 */
+	public void decorate(Object element, IDecoration decoration) {
+		final IResource resource =3D getResource(element);
+		if (resource =3D=3D null)
+			return;
+
+		// Don't decorate the workspace root
+		if (resource.getType() =3D=3D IResource.ROOT)
+			return;
+
+		// Don't decorate non-existing resources
+		if (!resource.exists() && !resource.isPhantom())
+			return;
+
+		// Make sure we're dealing with a Git project
+		final RepositoryMapping mapping =3D RepositoryMapping
+				.getMapping(resource);
+		if (mapping =3D=3D null)
+			return;
+
+		// Cannot decorate linked resources
+		if (mapping.getRepoRelativePath(resource) =3D=3D null)
+			return;
+
+		// Don't decorate if UI plugin is not running
+		Activator activator =3D Activator.getDefault();
+		if (activator =3D=3D null)
+			return;
+
+		DecorationHelper helper =3D new DecorationHelper(activator
+				.getPreferenceStore());
+		helper.decorate(decoration, new DecoratableResourceAdapter(resource)=
);
+	}
+
+	private class DecoratableResourceAdapter implements IDecoratableResou=
rce {
+
+		private IResource resource;
+
+		public DecoratableResourceAdapter(IResource resourceToWrap) {
+			resource =3D resourceToWrap;
+		}
+
+		public String getName() {
+			return resource.getName();
+		}
+
+		public int getType() {
+			return resource.getType();
+		}
+	}
+
+	/**
+	 * Helper class for doing resource decoration, based on the given
+	 * preferences
+	 *=20
+	 * Used for real-time decoration, as well as in the decorator preview
+	 * preferences page
+	 */
+	public static class DecorationHelper {
+
+		private IPreferenceStore store;
+
+		/** */
+		public static final String BINDING_RESOURCE_NAME =3D "name"; //$NON-=
NLS-1$
+
+		/**
+		 * Constructs a decorator using the rules from the given
+		 * <code>preferencesStore</code>
+		 *=20
+		 * @param preferencesStore
+		 *            the preferences store with the preferred decorator rul=
es
+		 */
+		public DecorationHelper(IPreferenceStore preferencesStore) {
+			store =3D preferencesStore;
+		}
+
+		/**
+		 * Decorates the given <code>decoration</code> based on the state of=
 the
+		 * given <code>resource</code>, using the preferences passed when
+		 * constructing this decoration helper.
+		 *=20
+		 * @param decoration
+		 *            the decoration to decorate
+		 * @param resource
+		 *            the resource to retrieve state from
+		 */
+		public void decorate(IDecoration decoration,
+				IDecoratableResource resource) {
+			String format =3D "";
+			switch (resource.getType()) {
+			case IResource.FILE:
+				format =3D store
+						.getString(UIPreferences.DECORATOR_FILETEXT_DECORATION);
+				break;
+			case IResource.FOLDER:
+				format =3D store
+						.getString(UIPreferences.DECORATOR_FOLDERTEXT_DECORATION);
+				break;
+			case IResource.PROJECT:
+				format =3D store
+						.getString(UIPreferences.DECORATOR_PROJECTTEXT_DECORATION);
+				break;
+			}
+
+			Map<String, String> bindings =3D new HashMap<String, String>();
+			bindings.put(BINDING_RESOURCE_NAME, resource.getName());
+
+			decorate(decoration, format, bindings);
+		}
+
+		/**
+		 * Decorates the given <code>decoration</code>, using the given
+		 * <code>format</code>, and mapped using <code>bindings</code>
+		 *=20
+		 * @param decoration
+		 *            the decoration to decorate
+		 * @param format
+		 *            the format to base the decoration on
+		 * @param bindings
+		 *            the bindings between variables in the format and actua=
l
+		 *            values
+		 */
+		public static void decorate(IDecoration decoration, String format,
+				Map bindings) {
+			StringBuffer prefix =3D new StringBuffer();
+			StringBuffer suffix =3D new StringBuffer();
+			StringBuffer output =3D prefix;
+
+			int length =3D format.length();
+			int start =3D -1;
+			int end =3D length;
+			while (true) {
+				if ((end =3D format.indexOf('{', start)) > -1) {
+					output.append(format.substring(start + 1, end));
+					if ((start =3D format.indexOf('}', end)) > -1) {
+						String key =3D format.substring(end + 1, start);
+						String s;
+
+						// We use the BINDING_RESOURCE_NAME key to determine if
+						// we are doing the prefix or suffix. The name isn't
+						// actually part of either.
+						if (key.equals(BINDING_RESOURCE_NAME)) {
+							output =3D suffix;
+							s =3D null;
+						} else {
+							s =3D (String) bindings.get(key);
+						}
+
+						if (s !=3D null) {
+							output.append(s);
+						} else {
+							// Support removing prefix character if binding is
+							// null
+							int curLength =3D output.length();
+							if (curLength > 0) {
+								char c =3D output.charAt(curLength - 1);
+								if (c =3D=3D ':' || c =3D=3D '@') {
+									output.deleteCharAt(curLength - 1);
+								}
+							}
+						}
+					} else {
+						output.append(format.substring(end, length));
+						break;
+					}
+				} else {
+					output.append(format.substring(start + 1, length));
+					break;
+				}
+			}
+
+			String prefixString =3D prefix.toString().replaceAll("^\\s+", "");
+			if (prefixString !=3D null) {
+				decoration.addPrefix(TextProcessor.process(prefixString,
+						"()[].")); //$NON-NLS-1$
+			}
+			String suffixString =3D suffix.toString().replaceAll("\\s+$", "");
+			if (suffixString !=3D null) {
+				decoration.addSuffix(TextProcessor.process(suffixString,
+						"()[].")); //$NON-NLS-1$
+			}
+		}
+	}
+
+	// -------- Refresh handling --------
+
+	/**
+	 * Perform a blanket refresh of all decorations
+	 */
+	public static void refresh() {
+		Display.getDefault().asyncExec(new Runnable() {
+			public void run() {
+				Activator.getDefault().getWorkbench().getDecoratorManager()
+						.update(DECORATOR_ID);
+			}
+		});
+	}
+
+	/**
+	 * Callback for IPropertyChangeListener events
+	 *=20
+	 * If any of the relevant preferences has been changed we refresh all
+	 * decorations (all projects and their resources).
+	 *=20
+	 * @see org.eclipse.jface.util.IPropertyChangeListener#propertyChange=
(org.eclipse.jface.util.PropertyChangeEvent)
+	 */
+	public void propertyChange(PropertyChangeEvent event) {
+		final String prop =3D event.getProperty();
+		// If the property is of any interest to us
+		if (prop.equals(TeamUI.GLOBAL_IGNORES_CHANGED)
+				|| prop.equals(TeamUI.GLOBAL_FILE_TYPES_CHANGED)
+				|| prop.equals(Activator.DECORATORS_CHANGED)) {
+			postLabelEvent(new LabelProviderChangedEvent(this, null /* all */))=
;
+		}
+	}
+
+	/**
+	 * Callback for IResourceChangeListener events
+	 *=20
+	 * Schedules a refresh of the changed resource
+	 *=20
+	 * If the preference for computing deep dirty states has been set we =
walk
+	 * the ancestor tree of the changed resource and update all parents a=
s well.
+	 *=20
+	 * @see org.eclipse.core.resources.IResourceChangeListener#resourceCh=
anged(org.eclipse.core.resources.IResourceChangeEvent)
+	 */
+	public void resourceChanged(IResourceChangeEvent event) {
+		final Set<IResource> resourcesToUpdate =3D new HashSet<IResource>();
+
+		try { // Compute the changed resources by looking at the delta
+			event.getDelta().accept(new IResourceDeltaVisitor() {
+				public boolean visit(IResourceDelta delta) throws CoreException {
+					final IResource resource =3D delta.getResource();
+
+					if (resource.getType() =3D=3D IResource.ROOT) {
+						// Continue with the delta
+						return true;
+					}
+
+					if (resource.getType() =3D=3D IResource.PROJECT) {
+						// If the project is not accessible, don't process it
+						if (!resource.isAccessible())
+							return false;
+					}
+
+					// If the file has changed but not in a way that we care
+					// about
+					// (e.g. marker changes to files) then ignore the change
+					if (delta.getKind() =3D=3D IResourceDelta.CHANGED
+							&& (delta.getFlags() & INTERESTING_CHANGES) =3D=3D 0) {
+						return true;
+					}
+
+					// All seems good, schedule the resource for update
+					resourcesToUpdate.add(resource);
+					return true;
+				}
+			}, true /* includePhantoms */);
+		} catch (final CoreException e) {
+			handleException(null, e);
+		}
+
+		// If deep decorator calculation is enabled in the preferences we
+		// walk the ancestor tree of each of the changed resources and add
+		// their parents to the update set
+		final IPreferenceStore store =3D Activator.getDefault()
+				.getPreferenceStore();
+		if (store.getBoolean(UIPreferences.DECORATOR_CALCULATE_DIRTY)) {
+			final IResource[] changedResources =3D resourcesToUpdate
+					.toArray(new IResource[resourcesToUpdate.size()]);
+			for (int i =3D 0; i < changedResources.length; i++) {
+				IResource current =3D changedResources[i];
+				while (current.getType() !=3D IResource.ROOT) {
+					current =3D current.getParent();
+					resourcesToUpdate.add(current);
+				}
+			}
+		}
+
+		postLabelEvent(new LabelProviderChangedEvent(this, resourcesToUpdate
+				.toArray()));
+	}
+
+	/**
+	 * Callback for RepositoryListener events
+	 *=20
+	 * We resolve the repository mapping for the changed repository and f=
orward
+	 * that to repositoryChanged(RepositoryMapping).
+	 *=20
+	 * @param e
+	 *            The original change event
+	 */
+	private void repositoryChanged(RepositoryChangedEvent e) {
+		final Set<RepositoryMapping> ms =3D new HashSet<RepositoryMapping>()=
;
+		for (final IProject p : ResourcesPlugin.getWorkspace().getRoot()
+				.getProjects()) {
+			final RepositoryMapping mapping =3D RepositoryMapping.getMapping(p)=
;
+			if (mapping !=3D null && mapping.getRepository() =3D=3D e.getReposi=
tory())
+				ms.add(mapping);
+		}
+		for (final RepositoryMapping m : ms) {
+			repositoryChanged(m);
+		}
+	}
+
+	/*
+	 * (non-Javadoc)
+	 *=20
+	 * @see
+	 * org.spearce.jgit.lib.RepositoryListener#indexChanged(org.spearce.j=
git
+	 * .lib.IndexChangedEvent)
+	 */
+	public void indexChanged(IndexChangedEvent e) {
+		repositoryChanged(e);
+	}
+
+	/*
+	 * (non-Javadoc)
+	 *=20
+	 * @see
+	 * org.spearce.jgit.lib.RepositoryListener#refsChanged(org.spearce.jg=
it.
+	 * lib.RefsChangedEvent)
+	 */
+	public void refsChanged(RefsChangedEvent e) {
+		repositoryChanged(e);
+	}
+
+	/**
+	 * Callback for RepositoryChangeListener events, as well as
+	 * RepositoryListener events via repositoryChanged()
+	 *=20
+	 * We resolve the project and schedule a refresh of each resource in =
the
+	 * project.
+	 *=20
+	 * @see org.spearce.egit.core.project.RepositoryChangeListener#reposi=
toryChanged(org.spearce.egit.core.project.RepositoryMapping)
+	 */
+	public void repositoryChanged(RepositoryMapping mapping) {
+		final IProject project =3D mapping.getContainer().getProject();
+		if (project =3D=3D null)
+			return;
+
+		final List<IResource> resources =3D new ArrayList<IResource>();
+		try {
+			project.accept(new IResourceVisitor() {
+				public boolean visit(IResource resource) {
+					resources.add(resource);
+					return true;
+				}
+			});
+			postLabelEvent(new LabelProviderChangedEvent(this, resources
+					.toArray()));
+		} catch (final CoreException e) {
+			handleException(project, e);
+		}
+	}
+
+	// -------- Helper methods --------
+
+	private static IResource getResource(Object element) {
+		if (element instanceof ResourceMapping) {
+			element =3D ((ResourceMapping) element).getModelObject();
+		}
+
+		IResource resource =3D null;
+		if (element instanceof IResource) {
+			resource =3D (IResource) element;
+		} else if (element instanceof IAdaptable) {
+			final IAdaptable adaptable =3D (IAdaptable) element;
+			resource =3D (IResource) adaptable.getAdapter(IResource.class);
+			if (resource =3D=3D null) {
+				final IContributorResourceAdapter adapter =3D (IContributorResourc=
eAdapter) adaptable
+						.getAdapter(IContributorResourceAdapter.class);
+				if (adapter !=3D null)
+					resource =3D adapter.getAdaptedResource(adaptable);
+			}
+		}
+
+		return resource;
+	}
+
+	/**
+	 * Post the label event to the UI thread
+	 *=20
+	 * @param event
+	 *            The event to post
+	 */
+	private void postLabelEvent(final LabelProviderChangedEvent event) {
+		Display.getDefault().asyncExec(new Runnable() {
+			public void run() {
+				fireLabelProviderChanged(event);
+			}
+		});
+	}
+
+	/**
+	 * Handle exceptions that occur in the decorator. Exceptions are only=
 logged
+	 * for resources that are accessible (i.e. exist in an open project).
+	 *=20
+	 * @param resource
+	 *            The resource that triggered the exception
+	 * @param e
+	 *            The exception that occurred
+	 */
+	private static void handleException(IResource resource, CoreException=
 e) {
+		if (resource =3D=3D null || resource.isAccessible())
+			exceptions.handleException(e);
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decor=
ators/GitResourceDecorator.java b/org.spearce.egit.ui/src/org/spearce/e=
git/ui/internal/decorators/GitResourceDecorator.java
deleted file mode 100644
index f24b1eb..0000000
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/G=
itResourceDecorator.java
+++ /dev/null
@@ -1,454 +0,0 @@
-/*********************************************************************=
**********
- * Copyright (C) 2007, Dave Watson <dwatson@mimvista.com>
- * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
- * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
- * Copyright (C) 2008, Google Inc.
- *
- * All rights reserved. This program and the accompanying materials
- * are made available under the terms of the Eclipse Public License v1=
=2E0
- * See LICENSE for the full license text, also available.
- *********************************************************************=
**********/
-package org.spearce.egit.ui.internal.decorators;
-
-import java.io.IOException;
-import java.util.HashSet;
-import java.util.Iterator;
-import java.util.LinkedHashSet;
-import java.util.Set;
-
-import org.eclipse.core.resources.IContainer;
-import org.eclipse.core.resources.IFile;
-import org.eclipse.core.resources.IProject;
-import org.eclipse.core.resources.IResource;
-import org.eclipse.core.resources.IResourceChangeEvent;
-import org.eclipse.core.resources.IResourceChangeListener;
-import org.eclipse.core.resources.IResourceDelta;
-import org.eclipse.core.resources.IResourceDeltaVisitor;
-import org.eclipse.core.resources.IResourceVisitor;
-import org.eclipse.core.resources.ResourcesPlugin;
-import org.eclipse.core.runtime.CoreException;
-import org.eclipse.core.runtime.IAdaptable;
-import org.eclipse.core.runtime.IProgressMonitor;
-import org.eclipse.core.runtime.IStatus;
-import org.eclipse.core.runtime.QualifiedName;
-import org.eclipse.core.runtime.Status;
-import org.eclipse.core.runtime.jobs.ISchedulingRule;
-import org.eclipse.core.runtime.jobs.Job;
-import org.eclipse.jface.viewers.IDecoration;
-import org.eclipse.jface.viewers.ILightweightLabelDecorator;
-import org.eclipse.jface.viewers.LabelProvider;
-import org.eclipse.jface.viewers.LabelProviderChangedEvent;
-import org.eclipse.swt.widgets.Display;
-import org.eclipse.team.core.Team;
-import org.eclipse.ui.IDecoratorManager;
-import org.spearce.egit.core.project.GitProjectData;
-import org.spearce.egit.core.project.RepositoryChangeListener;
-import org.spearce.egit.core.project.RepositoryMapping;
-import org.spearce.egit.ui.Activator;
-import org.spearce.egit.ui.UIIcons;
-import org.spearce.egit.ui.UIText;
-import org.spearce.jgit.lib.Constants;
-import org.spearce.jgit.lib.GitIndex;
-import org.spearce.jgit.lib.IndexChangedEvent;
-import org.spearce.jgit.lib.RefsChangedEvent;
-import org.spearce.jgit.lib.Repository;
-import org.spearce.jgit.lib.RepositoryChangedEvent;
-import org.spearce.jgit.lib.RepositoryListener;
-import org.spearce.jgit.lib.RepositoryState;
-import org.spearce.jgit.lib.Tree;
-import org.spearce.jgit.lib.TreeEntry;
-import org.spearce.jgit.lib.GitIndex.Entry;
-
-/**
- * Supplies annotations for displayed resources.
- * <p>
- * This decorator provides annotations to indicate the status of each =
resource
- * when compared to <code>HEAD</code> as well as the index in the rele=
vant
- * repository.
- *=20
- * When either the index or the working directory is different from HE=
AD an
- * indicator is set.
- *=20
- * </p>
- */
-public class GitResourceDecorator extends LabelProvider implements
-		ILightweightLabelDecorator {
-
-	static final String decoratorId =3D "org.spearce.egit.ui.internal.dec=
orators.GitResourceDecorator";
-	static class ResCL extends Job implements IResourceChangeListener, Re=
positoryChangeListener, RepositoryListener {
-
-		ResCL() {
-			super("Git resource decorator trigger");
-		}
-
-		GitResourceDecorator getActiveDecorator() {
-			IDecoratorManager decoratorManager =3D Activator.getDefault()
-					.getWorkbench().getDecoratorManager();
-			if (decoratorManager.getEnabled(decoratorId))
-				return (GitResourceDecorator) decoratorManager
-						.getLightweightLabelDecorator(decoratorId);
-			return null;
-		}
-
-		private Set<IResource> resources =3D new LinkedHashSet<IResource>();
-
-		public void refsChanged(RefsChangedEvent e) {
-			repositoryChanged(e);
-		}
-
-		public void indexChanged(IndexChangedEvent e) {
-			repositoryChanged(e);
-		}
-
-		private void repositoryChanged(RepositoryChangedEvent e) {
-			Set<RepositoryMapping> ms =3D new HashSet<RepositoryMapping>();
-			for (IProject p : ResourcesPlugin.getWorkspace().getRoot().getProje=
cts()) {
-				RepositoryMapping mapping =3D RepositoryMapping.getMapping(p);
-				if (mapping !=3D null && mapping.getRepository() =3D=3D e.getRepos=
itory())
-					ms.add(mapping);
-			}
-			for (RepositoryMapping m : ms) {
-				repositoryChanged(m);
-			}
-		}
-
-		public void repositoryChanged(final RepositoryMapping which) {
-			synchronized (resources) {
-				resources.add(which.getContainer());
-			}
-			schedule();
-		}
-
-		@Override
-		protected IStatus run(IProgressMonitor arg0) {
-			try {
-				if (resources.size() > 0) {
-					IResource m;
-					synchronized(resources) {
-						Iterator<IResource> i =3D resources.iterator();
-						m =3D i.next();
-						i.remove();
-
-						while (!m.isAccessible()) {
-							if (!i.hasNext())
-								return Status.OK_STATUS;
-							m =3D i.next();
-							i.remove();
-						}
-
-						if (resources.size() > 0)
-							schedule();
-					}
-					ISchedulingRule markerRule =3D m.getWorkspace().getRuleFactory().=
markerRule(m);
-					getJobManager().beginRule(markerRule, arg0);
-					try {
-						m.accept(new IResourceVisitor() {
-							public boolean visit(IResource resource) throws CoreException {
-								GitResourceDecorator decorator =3D getActiveDecorator();
-								if (decorator !=3D null)
-									decorator.clearDecorationState(resource);
-								return true;
-							}
-						},
-						IResource.DEPTH_INFINITE,
-						true);
-					} finally {
-						getJobManager().endRule(markerRule);
-					}
-				}
-				return Status.OK_STATUS;
-			} catch (Exception e) {
-				// We must be silent here or the UI will panic with lots of error =
messages
-				Activator.logError("Failed to trigger resource re-decoration", e);
-				return Status.OK_STATUS;
-			}
-		}
-
-		public void resourceChanged(IResourceChangeEvent event) {
-			if (event.getType() !=3D IResourceChangeEvent.POST_CHANGE) {
-				return;
-			}
-			try {
-				event.getDelta().accept(new IResourceDeltaVisitor() {
-					public boolean visit(IResourceDelta delta)
-							throws CoreException {
-						for (IResource r =3D delta.getResource(); r.getType() !=3D IReso=
urce.ROOT; r =3D r
-								.getParent()) {
-							synchronized (resources) {
-								resources.add(r);
-							}
-						}
-						return true;
-					}
-				},
-				true
-				);
-			} catch (Exception e) {
-				Activator.logError("Problem during decorations. Stopped", e);
-			}
-			schedule();
-		}
-
-		void force() {
-			for (IProject p : ResourcesPlugin.getWorkspace().getRoot().getProje=
cts()) {
-				synchronized (resources) {
-					resources.add(p);
-				}
-			}
-			schedule();
-		}
-	} // End ResCL
-
-	void clearDecorationState(IResource r) throws CoreException {
-		if (r.isAccessible()) {
-			r.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, null);
-			fireLabelProviderChanged(new LabelProviderChangedEvent(this, r));
-		}
-	}
-
-	static ResCL myrescl =3D new ResCL();
-
-	static {
-		Repository.addAnyRepositoryChangedListener(myrescl);
-		GitProjectData.addRepositoryChangeListener(myrescl);
-		ResourcesPlugin.getWorkspace().addResourceChangeListener(myrescl,
-				IResourceChangeEvent.POST_CHANGE);
-	}
-
-	/**
-	 * Request that the decorator be updated, to reflect any recent chang=
es.
-	 * <p>
-	 * Can be invoked any any thread. If the current thread is not the UI
-	 * thread, an async update will be scheduled.
-	 * </p>
-	 */
-	public static void refresh() {
-		myrescl.force();
-	}
-
-	private static IResource toIResource(final Object e) {
-		if (e instanceof IResource)
-			return (IResource) e;
-		if (e instanceof IAdaptable) {
-			final Object c =3D ((IAdaptable) e).getAdapter(IResource.class);
-			if (c instanceof IResource)
-				return (IResource) c;
-		}
-		return null;
-	}
-
-	static QualifiedName GITFOLDERDIRTYSTATEPROPERTY =3D new QualifiedNam=
e(
-			"org.spearce.egit.ui.internal.decorators.GitResourceDecorator",
-			"dirty");
-
-	static final int UNCHANGED =3D 0;
-
-	static final int CHANGED =3D 1;
-
-	private Boolean isDirty(IResource rsrc) {
-		try {
-			if (rsrc.getType() =3D=3D IResource.FILE && Team.isIgnored((IFile)r=
src))
-				return Boolean.FALSE;
-
-			RepositoryMapping mapped =3D RepositoryMapping.getMapping(rsrc);
-			if (mapped !=3D null) {
-				if (rsrc instanceof IContainer) {
-					for (IResource r : ((IContainer) rsrc)
-							.members(IContainer.EXCLUDE_DERIVED)) {
-						Boolean f =3D isDirty(r);
-						if (f =3D=3D null || f.booleanValue())
-							return Boolean.TRUE;
-					}
-					return Boolean.FALSE;
-				}
-
-				return Boolean.valueOf(mapped.isResourceChanged(rsrc));
-			}
-			return null; // not mapped
-		} catch (CoreException e) {
-			// TODO Auto-generated catch block
-			e.printStackTrace();
-		} catch (IOException e) {
-			// TODO Auto-generated catch block
-			e.printStackTrace();
-		}
-		return null;
-	}
-
-	public void decorate(final Object element, final IDecoration decorati=
on) {
-		final IResource rsrc =3D toIResource(element);
-		if (rsrc =3D=3D null)
-			return;
-
-		// If the workspace has not been refreshed properly a resource might
-		// not actually exist, so we ignore these and do not decorate them
-		if (!rsrc.exists() && !rsrc.isPhantom()) {
-			Activator.trace("Tried to decorate non-existent resource "+rsrc);
-			return;
-		}
-
-		RepositoryMapping mapped =3D RepositoryMapping.getMapping(rsrc);
-
-		// TODO: How do I see a renamed resource?
-		// TODO: Even trickier: when a path change from being blob to tree?
-		try {
-			if (mapped !=3D null) {
-				Repository repository =3D mapped.getRepository();
-				GitIndex index =3D repository.getIndex();
-				String repoRelativePath =3D mapped.getRepoRelativePath(rsrc);
-
-				if (repoRelativePath =3D=3D null) {
-					Activator.trace("Cannot decorate linked resource " + rsrc);
-					return;
-				}
-
-				Tree headTree =3D repository.mapTree(Constants.HEAD);
-				TreeEntry blob =3D headTree!=3Dnull ? headTree.findBlobMember(repo=
RelativePath) : null;
-				Entry entry =3D index.getEntry(repoRelativePath);
-				if (entry =3D=3D null) {
-					if (blob =3D=3D null) {
-						if (rsrc instanceof IContainer) {
-							Integer df =3D (Integer) rsrc
-									.getSessionProperty(GITFOLDERDIRTYSTATEPROPERTY);
-							Boolean f =3D df =3D=3D null ? isDirty(rsrc)
-									: Boolean.valueOf(df.intValue() =3D=3D CHANGED);
-							if (f !=3D null) {
-								if (f.booleanValue()) {
-									decoration.addPrefix(">"); // Have not
-									// seen
-									orState(rsrc, CHANGED);
-								} else {
-									orState(rsrc, UNCHANGED);
-									// decoration.addSuffix("=3D?");
-								}
-							} else {
-								decoration.addSuffix(" ?* ");
-							}
-
-							if (rsrc instanceof IProject) {
-								Repository repo =3D mapped.getRepository();
-								try {
-									String branch =3D repo.getBranch();
-									RepositoryState repositoryState =3D repo.getRepositoryState()=
;
-									String statename;
-									if (repositoryState.equals(RepositoryState.SAFE))
-										statename =3D "";
-									else
-										statename =3D repositoryState.getDescription() + " ";
-									decoration.addSuffix(" [Git " + statename + "@ " + branch + "=
]");
-								} catch (IOException e) {
-									e.printStackTrace();
-									decoration.addSuffix(" [Git ?]");
-								}
-								decoration.addOverlay(UIIcons.OVR_SHARED);
-							}
-
-						} else {
-							if (Team.isIgnoredHint(rsrc)) {
-								decoration.addSuffix("(ignored)");
-							} else {
-								decoration.addPrefix(">");
-								decoration.addSuffix("(untracked)");
-								orState(rsrc.getParent(), CHANGED);
-							}
-						}
-					} else {
-						if (!(rsrc instanceof IContainer)) {
-							decoration.addSuffix("(deprecated)"); // Will drop on
-							// commit
-							decoration.addOverlay(UIIcons.OVR_PENDING_REMOVE);
-							orState(rsrc.getParent(), CHANGED);
-						}
-					}
-				} else {
-					if (entry.getStage() !=3D GitIndex.STAGE_0) {
-						decoration.addSuffix("(conflict)");
-						decoration.addOverlay(UIIcons.OVR_CONFLICT);
-						orState(rsrc.getParent(), CHANGED);
-						return;
-					}
-
-					if (blob =3D=3D null) {
-						decoration.addOverlay(UIIcons.OVR_PENDING_ADD);
-						orState(rsrc.getParent(), CHANGED);
-					} else {
-
-						if (entry.isAssumedValid()) {
-							decoration.addOverlay(UIIcons.OVR_ASSUMEVALID);
-							return;
-						}
-
-						decoration.addOverlay(UIIcons.OVR_SHARED);
-
-						if (entry.isModified(mapped.getWorkDir(), true)) {
-							decoration.addPrefix(">");
-							decoration.addSuffix("(not updated)");
-							orState(rsrc.getParent(), CHANGED);
-						} else {
-							if (!entry.getObjectId().equals(blob.getId()))
-								decoration.addPrefix(">");
-							else
-								decoration.addPrefix(""); // set it to avoid further calls
-						}
-					}
-				}
-			}
-		} catch (IOException e) {
-			decoration.addSuffix("?");
-			// If we throw an exception Eclipse will log the error and
-			// unregister us thereby preventing us from dragging down the
-			// entire workbench because we are crashing.
-			//
-			throw new RuntimeException(UIText.Decorator_failedLazyLoading, e);
-		} catch (CoreException e) {
-			throw new RuntimeException(UIText.Decorator_failedLazyLoading, e);
-		}
-	}
-
-	private void orState(final IResource rsrc, int flag) {
-		if (rsrc =3D=3D null || rsrc.getType() =3D=3D IResource.ROOT) {
-			return;
-		}
-
-		try {
-			Integer dirty =3D (Integer) rsrc.getSessionProperty(GITFOLDERDIRTYS=
TATEPROPERTY);
-			Runnable runnable =3D new Runnable() {
-				public void run() {
-					// Async could be called after a
-					// project is closed or a
-					// resource is deleted
-					if (!rsrc.isAccessible())
-						return;
-					fireLabelProviderChanged(new LabelProviderChangedEvent(
-							GitResourceDecorator.this, rsrc));
-				}
-			};
-			if (dirty =3D=3D null) {
-				rsrc.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, new Integer(f=
lag));
-				orState(rsrc.getParent(), flag);
-//				if (Thread.currentThread() =3D=3D Display.getDefault().getThread=
())
-//					runnable.run();
-//				else
-					Display.getDefault().asyncExec(runnable);
-			} else {
-				if ((dirty.intValue() | flag) !=3D dirty.intValue()) {
-					dirty =3D new Integer(dirty.intValue() | flag);
-					rsrc.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, dirty);
-					orState(rsrc.getParent(), dirty.intValue());
-//					if (Thread.currentThread() =3D=3D Display.getDefault().getThrea=
d())
-//						runnable.run();
-//					else
-						Display.getDefault().asyncExec(runnable);
-				}
-			}
-		} catch (CoreException e) {
-			// TODO Auto-generated catch block
-			e.printStackTrace();
-		}
-	}
-=09
-	@Override
-	public boolean isLabelProperty(Object element, String property) {
-		return super.isLabelProperty(element, property);
-	}
-}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decor=
ators/IDecoratableResource.java b/org.spearce.egit.ui/src/org/spearce/e=
git/ui/internal/decorators/IDecoratableResource.java
new file mode 100644
index 0000000..8d6c741
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/I=
DecoratableResource.java
@@ -0,0 +1,31 @@
+/*********************************************************************=
**********
+ * Copyright (C) 2008, Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1=
=2E0
+ * See LICENSE for the full license text, also available.
+ *********************************************************************=
**********/
+
+package org.spearce.egit.ui.internal.decorators;
+
+import org.eclipse.core.resources.IResource;
+
+/**
+ * Represents the state of a resource that can be used as a basis for =
decoration
+ */
+public interface IDecoratableResource {
+
+	/**
+	 * Gets the type of the resource as defined by {@link IResource}
+	 *=20
+	 * @return the type of the resource
+	 */
+	int getType();
+
+	/**
+	 * Gets the name of the resource
+	 *=20
+	 * @return the name of the resource
+	 */
+	String getName();
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/prefe=
rences/GitDecoratorPreferencePage.java b/org.spearce.egit.ui/src/org/sp=
earce/egit/ui/internal/preferences/GitDecoratorPreferencePage.java
new file mode 100644
index 0000000..2ef0292
--- /dev/null
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/preferences/=
GitDecoratorPreferencePage.java
@@ -0,0 +1,735 @@
+/*********************************************************************=
**********
+ * Copyright (C) 2003, 2006 Subclipse project and others.
+ * Copyright (C) 2008, Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1=
=2E0
+ * See LICENSE for the full license text, also available.
+ *********************************************************************=
**********/
+package org.spearce.egit.ui.internal.preferences;
+
+import java.util.ArrayList;
+import java.util.Collection;
+import java.util.Collections;
+import java.util.HashMap;
+import java.util.Iterator;
+import java.util.List;
+import java.util.Map;
+import java.util.Observable;
+import java.util.Observer;
+
+import org.eclipse.core.resources.IResource;
+import org.eclipse.jface.dialogs.Dialog;
+import org.eclipse.jface.dialogs.IDialogConstants;
+import org.eclipse.jface.preference.IPreferenceStore;
+import org.eclipse.jface.preference.PreferencePage;
+import org.eclipse.jface.preference.PreferenceStore;
+import org.eclipse.jface.resource.ImageDescriptor;
+import org.eclipse.jface.resource.JFaceResources;
+import org.eclipse.jface.resource.LocalResourceManager;
+import org.eclipse.jface.resource.ResourceManager;
+import org.eclipse.jface.util.IPropertyChangeListener;
+import org.eclipse.jface.util.PropertyChangeEvent;
+import org.eclipse.jface.viewers.DecorationContext;
+import org.eclipse.jface.viewers.DecorationOverlayIcon;
+import org.eclipse.jface.viewers.IDecoration;
+import org.eclipse.jface.viewers.IDecorationContext;
+import org.eclipse.jface.viewers.ILabelProvider;
+import org.eclipse.jface.viewers.IStructuredContentProvider;
+import org.eclipse.jface.viewers.ITreeContentProvider;
+import org.eclipse.jface.viewers.LabelProvider;
+import org.eclipse.jface.viewers.TreeViewer;
+import org.eclipse.jface.viewers.Viewer;
+import org.eclipse.jface.window.Window;
+import org.eclipse.swt.SWT;
+import org.eclipse.swt.events.ModifyEvent;
+import org.eclipse.swt.events.ModifyListener;
+import org.eclipse.swt.graphics.Color;
+import org.eclipse.swt.graphics.Font;
+import org.eclipse.swt.graphics.Image;
+import org.eclipse.swt.layout.GridData;
+import org.eclipse.swt.layout.GridLayout;
+import org.eclipse.swt.widgets.Button;
+import org.eclipse.swt.widgets.Composite;
+import org.eclipse.swt.widgets.Control;
+import org.eclipse.swt.widgets.Event;
+import org.eclipse.swt.widgets.Listener;
+import org.eclipse.swt.widgets.TabFolder;
+import org.eclipse.swt.widgets.TabItem;
+import org.eclipse.swt.widgets.Text;
+import org.eclipse.swt.widgets.TreeItem;
+import org.eclipse.ui.ISharedImages;
+import org.eclipse.ui.IWorkbench;
+import org.eclipse.ui.IWorkbenchPreferencePage;
+import org.eclipse.ui.PlatformUI;
+import org.eclipse.ui.dialogs.ListSelectionDialog;
+import org.eclipse.ui.ide.IDE.SharedImages;
+import org.eclipse.ui.preferences.IWorkbenchPreferenceContainer;
+import org.spearce.egit.ui.Activator;
+import org.spearce.egit.ui.UIPreferences;
+import org.spearce.egit.ui.UIText;
+import org.spearce.egit.ui.internal.SWTUtils;
+import org.spearce.egit.ui.internal.decorators.GitLightweightDecorator=
=2EDecorationHelper;
+import org.spearce.egit.ui.internal.decorators.IDecoratableResource;
+
+/**
+ * Preference page for customizing Git label decorations
+ */
+public class GitDecoratorPreferencePage extends PreferencePage impleme=
nts
+		IWorkbenchPreferencePage {
+
+	private Text fileTextFormat;
+
+	private Text folderTextFormat;
+
+	private Text projectTextFormat;
+
+	private Button showDirty;
+
+	private Preview fPreview;
+
+	private static final Collection PREVIEW_FILESYSTEM_ROOT;
+
+	private static ThemeListener fThemeListener;
+
+	static {
+		final PreviewResource project =3D new PreviewResource(
+				"Project", IResource.PROJECT); //$NON-NLS-1$1
+		final ArrayList<PreviewResource> children =3D new ArrayList<PreviewR=
esource>();
+		children.add(new PreviewResource("folder", IResource.FOLDER)); //$NO=
N-NLS-1$
+		children.add(new PreviewResource("file.txt", IResource.FILE)); //$NO=
N-NLS-1$
+		project.children =3D children;
+		PREVIEW_FILESYSTEM_ROOT =3D Collections.singleton(project);
+	}
+
+	/**
+	 * Constructs a decorator preference page
+	 */
+	public GitDecoratorPreferencePage() {
+		setDescription(UIText.DecoratorPreferencesPage_description);
+	}
+
+	/**
+	 * @see PreferencePage#createContents(Composite)
+	 */
+	protected Control createContents(Composite parent) {
+		Composite headerGroup =3D new Composite(parent, SWT.NULL);
+		GridLayout layout =3D new GridLayout();
+		layout.marginWidth =3D 0;
+		layout.marginHeight =3D 0;
+		layout.verticalSpacing =3D 10;
+		headerGroup.setLayout(layout);
+		GridData data =3D new GridData();
+		data.horizontalAlignment =3D GridData.FILL;
+		headerGroup.setLayoutData(data);
+
+		SWTUtils.createPreferenceLink(
+				(IWorkbenchPreferenceContainer) getContainer(), headerGroup,
+				"org.eclipse.ui.preferencePages.Decorators",
+				UIText.DecoratorPreferencesPage_labelDecorationsLink); //$NON-NLS-=
1$
+
+		SWTUtils.createLabel(headerGroup,
+				UIText.DecoratorPreferencesPage_decorationSettings);
+
+		TabFolder tabFolder =3D new TabFolder(parent, SWT.NONE);
+		GridData tabData =3D SWTUtils.createHVFillGridData();
+		tabData.heightHint =3D 100;
+		tabFolder.setLayoutData(tabData);
+
+		TabItem tabItem =3D new TabItem(tabFolder, SWT.NONE);
+		tabItem.setText(UIText.DecoratorPreferencesPage_generalTabFolder);
+		tabItem.setControl(createGeneralDecoratorPage(tabFolder));
+
+		tabItem =3D new TabItem(tabFolder, SWT.NONE);
+		tabItem.setText(UIText.DecoratorPreferencesPage_textLabel);
+		tabItem.setControl(createTextDecoratorPage(tabFolder));
+
+		tabItem =3D new TabItem(tabFolder, SWT.NONE);
+		tabItem.setText(UIText.DecoratorPreferencesPage_iconLabel);
+		tabItem.setControl(createIconDecoratorPage(tabFolder));
+
+		initializeValues();
+
+		fPreview =3D new Preview(parent);
+		fPreview.refresh();
+
+		// TODO: Add help text for this preference page
+
+		fThemeListener =3D new ThemeListener(fPreview);
+		PlatformUI.getWorkbench().getThemeManager().addPropertyChangeListene=
r(
+				fThemeListener);
+		Dialog.applyDialogFont(parent);
+		return tabFolder;
+	}
+
+	private Control createGeneralDecoratorPage(Composite parent) {
+		Composite composite =3D new Composite(parent, SWT.NULL);
+
+		GridLayout layout =3D new GridLayout();
+		composite.setLayout(layout);
+		GridData data =3D new GridData();
+		data.horizontalAlignment =3D GridData.FILL;
+		composite.setLayoutData(data);
+
+		showDirty =3D SWTUtils.createCheckBox(composite,
+				UIText.DecoratorPreferencesPage_computeDeep);
+
+		return composite;
+	}
+
+	/**
+	 * Creates the controls for the first tab folder
+	 *=20
+	 * @param parent
+	 *=20
+	 * @return the control
+	 */
+	private Control createTextDecoratorPage(Composite parent) {
+		Composite fileTextGroup =3D new Composite(parent, SWT.NULL);
+		GridLayout layout =3D new GridLayout();
+		layout.numColumns =3D 3;
+		fileTextGroup.setLayout(layout);
+		GridData data =3D new GridData();
+		data.horizontalAlignment =3D GridData.FILL;
+		fileTextGroup.setLayoutData(data);
+
+		TextPair format =3D createFormatEditorControl(fileTextGroup,
+				UIText.DecoratorPreferencesPage_fileFormatLabel,
+				UIText.DecoratorPreferencesPage_addVariablesAction,
+				getFileBindingDescriptions());
+		fileTextFormat =3D format.t1;
+
+		format =3D createFormatEditorControl(fileTextGroup,
+				UIText.DecoratorPreferencesPage_folderFormatLabel,
+				UIText.DecoratorPreferencesPage_addVariablesAction,
+				getFolderBindingDescriptions());
+		folderTextFormat =3D format.t1;
+
+		format =3D createFormatEditorControl(fileTextGroup,
+				UIText.DecoratorPreferencesPage_projectFormatLabel,
+				UIText.DecoratorPreferencesPage_addVariablesAction,
+				getProjectBindingDescriptions());
+		projectTextFormat =3D format.t1;
+
+		return fileTextGroup;
+	}
+
+	private Control createIconDecoratorPage(Composite parent) {
+		Composite imageGroup =3D new Composite(parent, SWT.NULL);
+		GridLayout layout =3D new GridLayout();
+		imageGroup.setLayout(layout);
+		GridData data =3D new GridData();
+		data.horizontalAlignment =3D GridData.FILL;
+		imageGroup.setLayoutData(data);
+
+		return imageGroup;
+	}
+
+	private TextPair createFormatEditorControl(Composite composite,
+			String title, String buttonText, final Map supportedBindings) {
+
+		SWTUtils.createLabel(composite, title);
+
+		Text format =3D new Text(composite, SWT.BORDER);
+		format.setLayoutData(new GridData(GridData.FILL_HORIZONTAL));
+		format.addModifyListener(new ModifyListener() {
+			public void modifyText(ModifyEvent e) {
+				updatePreview();
+			}
+		});
+		Button b =3D new Button(composite, SWT.NONE);
+		b.setText(buttonText);
+		GridData data =3D new GridData();
+		data.horizontalAlignment =3D GridData.FILL;
+		int widthHint =3D convertHorizontalDLUsToPixels(IDialogConstants.BUT=
TON_WIDTH);
+		data.widthHint =3D Math.max(widthHint, b.computeSize(SWT.DEFAULT,
+				SWT.DEFAULT, true).x);
+		b.setLayoutData(data);
+		final Text formatToInsert =3D format;
+		b.addListener(SWT.Selection, new Listener() {
+			public void handleEvent(Event event) {
+				addVariables(formatToInsert, supportedBindings);
+			}
+		});
+
+		return new TextPair(format, null);
+	}
+
+	/**
+	 * Initializes states of the controls from the preference store.
+	 */
+	private void initializeValues() {
+		final IPreferenceStore store =3D getPreferenceStore();
+
+		fileTextFormat.setText(store
+				.getString(UIPreferences.DECORATOR_FILETEXT_DECORATION));
+		folderTextFormat.setText(store
+				.getString(UIPreferences.DECORATOR_FOLDERTEXT_DECORATION));
+		projectTextFormat.setText(store
+				.getString(UIPreferences.DECORATOR_PROJECTTEXT_DECORATION));
+
+		showDirty.setSelection(store
+				.getBoolean(UIPreferences.DECORATOR_CALCULATE_DIRTY));
+
+		setValid(true);
+	}
+
+	/**
+	 * @see IWorkbenchPreferencePage#init(IWorkbench)
+	 */
+	public void init(IWorkbench workbench) {
+		// No-op
+	}
+
+	/**
+	 * OK was clicked. Store the preferences to the plugin store
+	 *=20
+	 * @return whether it is okay to close the preference page
+	 */
+	public boolean performOk() {
+		IPreferenceStore store =3D getPreferenceStore();
+		final boolean okToClose =3D performOk(store);
+		if (store.needsSaving()) {
+			Activator.getDefault().savePluginPreferences();
+			Activator.broadcastPropertyChange(new PropertyChangeEvent(this,
+					Activator.DECORATORS_CHANGED, null, null));
+		}
+		return okToClose;
+	}
+
+	/**
+	 * Store the preferences to the given preference store
+	 *=20
+	 * @param store
+	 *            the preference store to store the preferences to
+	 *=20
+	 * @return whether it operation succeeded
+	 */
+	private boolean performOk(IPreferenceStore store) {
+
+		store.setValue(UIPreferences.DECORATOR_FILETEXT_DECORATION,
+				fileTextFormat.getText());
+		store.setValue(UIPreferences.DECORATOR_FOLDERTEXT_DECORATION,
+				folderTextFormat.getText());
+		store.setValue(UIPreferences.DECORATOR_PROJECTTEXT_DECORATION,
+				projectTextFormat.getText());
+
+		store.setValue(UIPreferences.DECORATOR_CALCULATE_DIRTY, showDirty
+				.getSelection());
+
+		return true;
+	}
+
+	/**
+	 * Defaults was clicked. Restore the Git decoration preferences to th=
eir
+	 * default values
+	 */
+	protected void performDefaults() {
+		super.performDefaults();
+		IPreferenceStore store =3D getPreferenceStore();
+
+		fileTextFormat.setText(store
+				.getDefaultString(UIPreferences.DECORATOR_FILETEXT_DECORATION));
+		folderTextFormat
+				.setText(store
+						.getDefaultString(UIPreferences.DECORATOR_FOLDERTEXT_DECORATION)=
);
+		projectTextFormat
+				.setText(store
+						.getDefaultString(UIPreferences.DECORATOR_PROJECTTEXT_DECORATION=
));
+
+		showDirty.setSelection(store
+				.getDefaultBoolean(UIPreferences.DECORATOR_CALCULATE_DIRTY));
+	}
+
+	/**
+	 * Returns the preference store that belongs to the our plugin.
+	 *=20
+	 * This is important because we want to store our preferences separat=
ely
+	 * from the desktop.
+	 *=20
+	 * @return the preference store for this plugin
+	 */
+	protected IPreferenceStore doGetPreferenceStore() {
+		return Activator.getDefault().getPreferenceStore();
+	}
+
+	/*
+	 * (non-Javadoc)
+	 *=20
+	 * @see org.eclipse.jface.dialogs.DialogPage#dispose()
+	 */
+	public void dispose() {
+		PlatformUI.getWorkbench().getThemeManager()
+				.removePropertyChangeListener(fThemeListener);
+		super.dispose();
+	}
+
+	private static class ThemeListener implements IPropertyChangeListener=
 {
+		private final Preview preview;
+
+		ThemeListener(Preview preview) {
+			this.preview =3D preview;
+		}
+
+		public void propertyChange(PropertyChangeEvent event) {
+			preview.refresh();
+		}
+	}
+
+	/**
+	 * Adds another variable to the given target text
+	 *=20
+	 * A ListSelectionDialog pops up and allow the user to choose the var=
iable,
+	 * which is then inserted at current position in <code>text</code>
+	 *=20
+	 * @param target
+	 *            the target to add the variable to
+	 * @param bindings
+	 *            the map of bindings
+	 */
+	private void addVariables(Text target, Map bindings) {
+
+		final List<StringPair> variables =3D new ArrayList<StringPair>(bindi=
ngs
+				.size());
+
+		ILabelProvider labelProvider =3D new LabelProvider() {
+			public String getText(Object element) {
+				return ((StringPair) element).s1
+						+ " - " + ((StringPair) element).s2; //$NON-NLS-1$
+			}
+		};
+
+		IStructuredContentProvider contentsProvider =3D new IStructuredConte=
ntProvider() {
+			public Object[] getElements(Object inputElement) {
+				return variables.toArray(new StringPair[variables.size()]);
+			}
+
+			public void dispose() {
+				// No-op
+			}
+
+			public void inputChanged(Viewer viewer, Object oldInput,
+					Object newInput) {
+				// No-op
+			}
+		};
+
+		for (Iterator it =3D bindings.keySet().iterator(); it.hasNext();) {
+			StringPair variable =3D new StringPair();
+			variable.s1 =3D (String) it.next(); // variable
+			variable.s2 =3D (String) bindings.get(variable.s1); // description
+			variables.add(variable);
+		}
+
+		ListSelectionDialog dialog =3D new ListSelectionDialog(this.getShell=
(),
+				this, contentsProvider, labelProvider,
+				UIText.DecoratorPreferencesPage_selectVariablesToAdd);
+		dialog.setTitle(UIText.DecoratorPreferencesPage_addVariablesTitle);
+		if (dialog.open() !=3D Window.OK)
+			return;
+
+		Object[] result =3D dialog.getResult();
+
+		for (int i =3D 0; i < result.length; i++) {
+			target.insert("{" + ((StringPair) result[i]).s1 + "}"); //$NON-NLS-=
1$ //$NON-NLS-2$
+		}
+	}
+
+	class StringPair {
+		String s1;
+
+		String s2;
+	}
+
+	class TextPair {
+		TextPair(Text t1, Text t2) {
+			this.t1 =3D t1;
+			this.t2 =3D t2;
+		}
+
+		Text t1;
+
+		Text t2;
+	}
+
+	/**
+	 * Gets the map of bindings between variables and description, to use=
 for
+	 * the format editors for files
+	 *=20
+	 * @return the bindings
+	 */
+	private Map getFileBindingDescriptions() {
+		Map<String, String> bindings =3D new HashMap<String, String>();
+		bindings.put(DecorationHelper.BINDING_RESOURCE_NAME,
+				UIText.DecoratorPreferencesPage_nameResourceVariable);
+		return bindings;
+	}
+
+	/**
+	 * Gets the map of bindings between variables and description, to use=
 for
+	 * the format editors for folders
+	 *=20
+	 * @return the bindings
+	 */
+	private Map getFolderBindingDescriptions() {
+		Map<String, String> bindings =3D new HashMap<String, String>();
+		bindings.put(DecorationHelper.BINDING_RESOURCE_NAME,
+				UIText.DecoratorPreferencesPage_nameResourceVariable);
+		return bindings;
+	}
+
+	/**
+	 * Gets the map of bindings between variables and description, to use=
 for
+	 * the format editors for projects
+	 *=20
+	 * @return the bindings
+	 */
+	private Map getProjectBindingDescriptions() {
+		Map<String, String> bindings =3D new HashMap<String, String>();
+		bindings.put(DecorationHelper.BINDING_RESOURCE_NAME,
+				UIText.DecoratorPreferencesPage_nameResourceVariable);
+		return bindings;
+	}
+
+	private void updatePreview() {
+		if (fPreview !=3D null)
+			fPreview.refresh();
+	}
+
+	/**
+	 * Preview control for showing how changes in the dialog will affect
+	 * decoration
+	 */
+	private class Preview extends LabelProvider implements Observer,
+			ITreeContentProvider {
+
+		private final ResourceManager fImageCache;
+
+		private final TreeViewer fViewer;
+
+		private DecorationHelper fHelper;
+
+		public Preview(Composite composite) {
+			reloadDecorationHelper(); // Has to happen before the tree control
+										// is constructed
+			SWTUtils.createLabel(composite,
+					UIText.DecoratorPreferencesPage_preview);
+			fImageCache =3D new LocalResourceManager(JFaceResources
+					.getResources());
+			fViewer =3D new TreeViewer(composite);
+			GridData previewGridData =3D SWTUtils.createHVFillGridData();
+			previewGridData.heightHint =3D 100;
+			fViewer.getControl().setLayoutData(previewGridData);
+			fViewer.setContentProvider(this);
+			fViewer.setLabelProvider(this);
+			fViewer.setInput(PREVIEW_FILESYSTEM_ROOT);
+			fViewer.expandAll();
+			fHelper =3D new DecorationHelper(new PreferenceStore());
+		}
+
+		private void reloadDecorationHelper() {
+			PreferenceStore store =3D new PreferenceStore();
+			performOk(store);
+			fHelper =3D new DecorationHelper(store);
+		}
+
+		public void refresh() {
+			reloadDecorationHelper();
+			fViewer.refresh(true);
+			setColorsAndFonts(fViewer.getTree().getItems());
+		}
+
+		@SuppressWarnings("unused")
+		private void setColorsAndFonts(TreeItem[] items) {
+			// TODO: Implement colors and fonts
+		}
+
+		public void update(Observable o, Object arg) {
+			refresh();
+		}
+
+		public Object[] getChildren(Object parentElement) {
+			return ((PreviewResource) parentElement).children.toArray();
+		}
+
+		public Object getParent(Object element) {
+			return null;
+		}
+
+		public boolean hasChildren(Object element) {
+			return !((PreviewResource) element).children.isEmpty();
+		}
+
+		public Object[] getElements(Object inputElement) {
+			return ((Collection) inputElement).toArray();
+		}
+
+		public void dispose() {
+			fImageCache.dispose();
+		}
+
+		public void inputChanged(Viewer viewer, Object oldInput, Object newI=
nput) {
+			// No-op
+		}
+
+		public Color getBackground(Object element) {
+			return getDecoration(element).getBackgroundColor();
+		}
+
+		public Color getForeground(Object element) {
+			return getDecoration(element).getForegroundColor();
+		}
+
+		public Font getFont(Object element) {
+			return getDecoration(element).getFont();
+		}
+
+		public String getText(Object element) {
+			final PreviewDecoration decoration =3D getDecoration(element);
+			final StringBuffer buffer =3D new StringBuffer();
+			final String prefix =3D decoration.getPrefix();
+			if (prefix !=3D null)
+				buffer.append(prefix);
+			buffer.append(((PreviewResource) element).getName());
+			final String suffix =3D decoration.getSuffix();
+			if (suffix !=3D null)
+				buffer.append(suffix);
+			return buffer.toString();
+		}
+
+		public Image getImage(Object element) {
+			final String s;
+			switch (((PreviewResource) element).type) {
+			case IResource.PROJECT:
+				s =3D SharedImages.IMG_OBJ_PROJECT;
+				break;
+			case IResource.FOLDER:
+				s =3D ISharedImages.IMG_OBJ_FOLDER;
+				break;
+			default:
+				s =3D ISharedImages.IMG_OBJ_FILE;
+				break;
+			}
+			final Image baseImage =3D PlatformUI.getWorkbench().getSharedImages=
()
+					.getImage(s);
+			final ImageDescriptor overlay =3D getDecoration(element).getOverlay=
();
+			if (overlay =3D=3D null)
+				return baseImage;
+			try {
+				return fImageCache.createImage(new DecorationOverlayIcon(
+						baseImage, overlay, IDecoration.BOTTOM_RIGHT));
+			} catch (Exception e) {
+				Activator.logError(e.getMessage(), e);
+			}
+
+			return null;
+		}
+
+		private PreviewDecoration getDecoration(Object element) {
+			PreviewDecoration decoration =3D new PreviewDecoration();
+			fHelper.decorate(decoration, (PreviewResource) element);
+			return decoration;
+		}
+	}
+
+	private static class PreviewResource implements IDecoratableResource =
{
+		public final String name;
+
+		public final int type;
+
+		public Collection children;
+
+		public PreviewResource(String name, int type) {
+			this.name =3D name;
+			this.type =3D type;
+			this.children =3D Collections.EMPTY_LIST;
+		}
+
+		public String getName() {
+			return name;
+		}
+
+		public int getType() {
+			return type;
+		}
+	}
+
+	private class PreviewDecoration implements IDecoration {
+
+		private List<String> prefixes =3D new ArrayList<String>();
+
+		private List<String> suffixes =3D new ArrayList<String>();
+
+		private ImageDescriptor overlay =3D null;
+
+		private Font font;
+
+		private Color backgroundColor;
+
+		private Color foregroundColor;
+
+		public void addOverlay(ImageDescriptor overlayImage) {
+			overlay =3D overlayImage;
+		}
+
+		public void addOverlay(ImageDescriptor overlayImage, int quadrant) {
+			overlay =3D overlayImage;
+		}
+
+		public void addPrefix(String prefix) {
+			prefixes.add(prefix);
+		}
+
+		public void addSuffix(String suffix) {
+			suffixes.add(suffix);
+		}
+
+		public IDecorationContext getDecorationContext() {
+			return new DecorationContext();
+		}
+
+		public void setBackgroundColor(Color color) {
+			backgroundColor =3D color;
+		}
+
+		public void setForegroundColor(Color color) {
+			foregroundColor =3D color;
+		}
+
+		public void setFont(Font font) {
+			this.font =3D font;
+		}
+
+		public ImageDescriptor getOverlay() {
+			return overlay;
+		}
+
+		public String getPrefix() {
+			StringBuffer sb =3D new StringBuffer();
+			for (Iterator<String> iter =3D prefixes.iterator(); iter.hasNext();=
) {
+				sb.append(iter.next());
+			}
+			return sb.toString();
+		}
+
+		public String getSuffix() {
+			StringBuffer sb =3D new StringBuffer();
+			for (Iterator<String> iter =3D suffixes.iterator(); iter.hasNext();=
) {
+				sb.append(iter.next());
+			}
+			return sb.toString();
+		}
+
+		public Font getFont() {
+			return font;
+		}
+
+		public Color getBackgroundColor() {
+			return backgroundColor;
+		}
+
+		public Color getForegroundColor() {
+			return foregroundColor;
+		}
+	}
+}
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.propert=
ies b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
index a86e58b..4a0a387 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/uitext.properties
@@ -169,7 +169,6 @@ RefSpecPage_annotatedTagsAutoFollow=3DAutomatically=
 follow tags if we fetch the th
 RefSpecPage_annotatedTagsFetchTags=3DAlways fetch tags, even if we do =
not have the thing it points at
 RefSpecPage_annotatedTagsNoTags=3DNever fetch tags, even if we have th=
e thing it points at
=20
-Decorator_failedLazyLoading=3DResource decorator failed to load tree c=
ontents on demand.
 QuickDiff_failedLoading=3DQuick diff failed to obtain file data.
=20
 ResourceHistory_toggleCommentWrap=3DWrap Comments
@@ -340,3 +339,27 @@ BranchSelectionDialog_ResetTypeMixed=3D&Mixed (wor=
king directory unmodified)
 BranchSelectionDialog_ResetTypeSoft=3D&Soft (Index and working directo=
ry unmodified)
 BranchSelectionDialog_Tags=3DTags
 BranchSelectionDialog_Refs=3D&Refs
+
+Decorator_exceptionMessage=3DErrors occurred while applying Git decora=
tions to resources.
+
+DecoratorPreferencesPage_addVariablesTitle=3DAdd Variables
+DecoratorPreferencesPage_addVariablesAction=3DAdd &Variables...
+DecoratorPreferencesPage_computeDeep=3DInclude &ancestors when re-deco=
rating changed resources
+DecoratorPreferencesPage_description=3DShows Git specific information =
on resources in projects under version control.
+
+DecoratorPreferencesPage_decorationSettings=3DDecoration &settings:
+DecoratorPreferencesPage_preview=3DPreview:
+DecoratorPreferencesPage_fileFormatLabel=3D&Files:
+DecoratorPreferencesPage_folderFormatLabel=3DF&olders:
+DecoratorPreferencesPage_projectFormatLabel=3D&Projects:
+DecoratorPreferencesPage_fileFormatDefault=3D{name}
+DecoratorPreferencesPage_folderFormatDefault=3D{name}
+DecoratorPreferencesPage_projectFormatDefault=3D{name}
+DecoratorPreferencesPage_labelDecorationsLink=3DSee <a>''{0}''</a> to =
enable or disable Git decorations.
+DecoratorPreferencesPage_generalTabFolder=3D&General
+DecoratorPreferencesPage_nameResourceVariable=3Dname of the resource b=
eing decorated
+DecoratorPreferencesPage_selectFormats=3DSelect the format for file, f=
olders, and project text labels:
+DecoratorPreferencesPage_selectVariablesToAdd=3DSelect the &variables =
to add to the decoration format:
+DecoratorPreferencesPage_textLabel=3DT&ext Decorations
+DecoratorPreferencesPage_iconLabel=3D&Icon Decorations
+
--=20
1.6.1.2.309.g2ea3
