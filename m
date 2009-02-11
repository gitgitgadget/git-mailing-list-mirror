From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] Add "compare with index" action.
Date: Wed, 11 Feb 2009 16:44:17 +0100
Message-ID: <4992F251.9090901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 16:46:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXHIJ-0005Yh-3p
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 16:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757127AbZBKPoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 10:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757061AbZBKPod
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 10:44:33 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:35911 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757059AbZBKPoc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 10:44:32 -0500
Received: by bwz5 with SMTP id 5so366132bwz.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 07:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=e/zsKyphYhIYyq2Pk/jGIHOKKz3/vKesnNtqs01JT7U=;
        b=F8XMUCEuYkiFmdE4j5D8Wl927aaTDzWn2F1uGuq3ql58Jw9Pp18BnbiODD/vCOHRfk
         gfMgxSxCWnpLUgcRUBWPZ0lahQArlVzLUdRFGpWfUX3svHLqwkf7BX2xdLQBt2eRcrQy
         JqZRln/OdPOG30qeEOQ1P9kF/RpGeF2EVnE70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=bjK7oGnK9dJetc7cqUPk3mB9r7lerZhhGVDDGnFKt6ga/4gaqqqe90X8dlrw1aY1FV
         cnZakrpmPcb9nnvGbhjkF4+4hYO/HA4vHgDPE9SQd0r/XBC987+hPI/jbg3W0Id9Ex3i
         cX8lKOv5FX59tJPPxJzqbbORBz1u5EEw9/zqE=
Received: by 10.223.107.19 with SMTP id z19mr3455582fao.27.1234367069277;
        Wed, 11 Feb 2009 07:44:29 -0800 (PST)
Received: from ?10.11.2.21? (port-87-193-216-74.static.qsc.de [87.193.216.74])
        by mx.google.com with ESMTPS id 4sm4567463fgg.55.2009.02.11.07.44.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Feb 2009 07:44:28 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109431>

In the Compare With... menu, the "compare with index" action opens
a diff editor that compares the workspace version of a file and its
index version.

Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
My plan with the compare editor is to allow to add some contents into
the index (partial commits).
I do not know yet how to achieve this.

I did not find how to commit only the index with the eclipse interface.
So I guess comparing with index does not bring a lot of value for the
moment.

-- yann

 .../core/internal/storage/GitFileRevision.java     |   24 ++++++
 org.spearce.egit.ui/plugin.properties              |    3 +
 org.spearce.egit.ui/plugin.xml                     |    7 ++
 .../internal/actions/CompareWithIndexAction.java   |   87
++++++++++++++++++++
 4 files changed, 121 insertions(+), 0 deletions(-)
 create mode 100644
org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CompareWithIndexAction.java

diff --git
a/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileRevision.java
b/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileRevision.java
index 21ba19e..3c78dfc 100644
---
a/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileRevision.java
+++
b/org.spearce.egit.core/src/org/spearce/egit/core/internal/storage/GitFileRevision.java
@@ -11,6 +11,7 @@
 import java.net.URI;
 import java.net.URISyntaxException;
 
+import org.eclipse.core.resources.IResource;
 import org.eclipse.core.runtime.CoreException;
 import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.team.core.history.IFileRevision;
@@ -49,6 +50,29 @@ public static GitFileRevision inCommit(final
Repository db,
         return new CommitFileRevision(db, commit, path, blobId);
     }
 
+    /**
+     * Obtain a file revision for a file in the working repository.
+     *
+     * @param resource
+     *            resource identifying the file in the working repository.
+     * @return revision implementation for the resource in the working
+     *         repository.
+     */
+    public static GitFileRevision inWorkspace(final IResource resource) {
+        return new WorkspaceFileRevision(resource);
+    }
+
+    /**
+     * @param db
+     *            the repository which contains the index to use.
+     * @param path
+     *            path of the resource in the index
+     * @return revision implementation for the given path in the index
+     */
+    public static GitFileRevision inIndex(final Repository db, final
String path) {
+        return new IndexFileRevision(db, path);
+    }
+
     private final String path;
 
     GitFileRevision(final String fileName) {
diff --git a/org.spearce.egit.ui/plugin.properties
b/org.spearce.egit.ui/plugin.properties
index fa043f1..0fc869b 100644
--- a/org.spearce.egit.ui/plugin.properties
+++ b/org.spearce.egit.ui/plugin.properties
@@ -31,6 +31,9 @@ Decorator_description=Shows Git specific information
on resources in projects un
 CompareWithRevisionAction_label=Compare With Git Revision
 CompareWithRevisionAction_tooltip=Compare With a Git Revision
 
+CompareWithIndexAction_label=Compare with index version
+CompareWithIndexAction_tooltip=Compare with index version
+
 ShowResourceInHistoryAction_label=Show in Resource History
 ShowResourceInHistoryAction_tooltip=Show selected files in the resource
history view.
 
diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index 869108c..c706309 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -108,6 +108,13 @@
                label="%CommitAction_label"
                menubarPath="team.main/group1"
                tooltip="%CommitAction_tooltip"/>
+         <action
+              
class="org.spearce.egit.ui.internal.actions.CompareWithIndexAction"
+              
id="org.spearce.egit.ui.internal.actions.CompareWithIndexAction"
+               label="%CompareWithIndexAction_label"
+               menubarPath="compareWithMenu/gitCompareWithGroup"
+               tooltip="&amp;CompareWithIndexAction_tooltip">
+         </action>
       </objectContribution>
       <objectContribution
          id="org.spearce.egit.ui.resetto"
diff --git
a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CompareWithIndexAction.java
b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CompareWithIndexAction.java
new file mode 100644
index 0000000..a4af944
--- /dev/null
+++
b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CompareWithIndexAction.java
@@ -0,0 +1,87 @@
+/*
+ * Copyright (C) 2009, Yann Simon <yann.simon.fr@gmail.com>
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.egit.ui.internal.actions;
+
+import org.eclipse.compare.CompareUI;
+import org.eclipse.compare.ITypedElement;
+import org.eclipse.core.resources.IResource;
+import org.eclipse.jface.action.IAction;
+import org.eclipse.team.core.history.IFileRevision;
+import org.eclipse.team.internal.ui.history.FileRevisionTypedElement;
+import org.spearce.egit.core.internal.storage.GitFileRevision;
+import org.spearce.egit.core.project.RepositoryMapping;
+import org.spearce.egit.ui.internal.GitCompareFileRevisionEditorInput;
+import org.spearce.jgit.lib.Repository;
+
+/**
+ * The "compare with index" action. This action opens a diff editor
comparing
+ * the file as found in the working directory and the version found in
the index
+ * of the repository.
+ */
+@SuppressWarnings("restriction")
+public class CompareWithIndexAction extends RepositoryAction {
+
+    @Override
+    public void execute(IAction action) {
+        final IResource resource = getSelectedResources()[0];
+        final RepositoryMapping mapping =
RepositoryMapping.getMapping(resource.getProject());
+        final Repository repository = mapping.getRepository();
+        final String gitPath = mapping.getRepoRelativePath(resource);
+
+        final IFileRevision baseFile =
GitFileRevision.inWorkspace(resource);
+        final IFileRevision nextFile =
GitFileRevision.inIndex(repository, gitPath);
+
+        final ITypedElement base = new FileRevisionTypedElement(baseFile);
+        final ITypedElement next = new FileRevisionTypedElement(nextFile);
+
+        final GitCompareFileRevisionEditorInput in = new
GitCompareFileRevisionEditorInput(
+                base, next, null);
+        CompareUI.openCompareEditor(in);
+    }
+
+    @Override
+    public boolean isEnabled() {
+        final IResource[] selectedResources = getSelectedResources();
+        if (selectedResources.length != 1)
+            return false;
+        final IResource resource = selectedResources[0];
+        final RepositoryMapping mapping =
RepositoryMapping.getMapping(resource.getProject());
+        return mapping != null;
+    }
+
+}
\ No newline at end of file
-- 
1.6.0.4
