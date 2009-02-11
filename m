From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH v2 03/12] Add a specialized team exception for Git
Date: Wed, 11 Feb 2009 19:40:05 +0100
Message-ID: <1234377614-23798-4-git-send-email-torarnv@gmail.com>
References: <1234377614-23798-1-git-send-email-torarnv@gmail.com>
 <1234377614-23798-2-git-send-email-torarnv@gmail.com>
 <1234377614-23798-3-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:41:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXK1A-0004zp-OW
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:41:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756705AbZBKSjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2009 13:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756013AbZBKSji
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:39:38 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:15213 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754618AbZBKSjb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:39:31 -0500
Received: by fg-out-1718.google.com with SMTP id 16so108720fgg.17
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 10:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=e4LOdpuL6ioo8Zr+gzIKbjYOrkJIG6i/w0Pg/PnGp+M=;
        b=yE15/3RqTA37py0LrK+BK1w27tgL2zqpw92n8md/2peArzUDgQz8D2LWiCDJXnFz64
         /C1PEUWeNkX6O1SGb/6DU9zzYk2tpIxV0cHqcrQSDoa/Ww2LkASOKk8AaQXrGyfN5fsL
         HEAqmXpI4DGLGk2dL6edszOyCk8YTF/NrBEF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uicelH0xlUGskwqs7XmG+8UqP5v+/TZv4t3KdXXjH2+53nXJBnkfMlmjb8DNR6+JbU
         pUOc0WxBzricOnwj4wf2azyRk9k7YlMPxt9y8aC8brL54yohZiogxZ6FPM78e57Yz53i
         X3i8tYqIIjYVeX2T6Gs6iDuGLgkCVzv6oJJjs=
Received: by 10.86.66.19 with SMTP id o19mr880375fga.0.1234377569522;
        Wed, 11 Feb 2009 10:39:29 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id d6sm1902855fga.39.2009.02.11.10.38.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Feb 2009 10:38:54 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id 1A915468002; Wed, 11 Feb 2009 19:40:14 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <1234377614-23798-3-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109482>

Copied largly from org.eclipse.team.internal.ccvs.core (CVS) and
org.tigris.subversion.subclipse.core (SVN), and then cleaned up.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 .../src/org/spearce/egit/core/GitException.java    |  168 ++++++++++++=
++++++++
 1 files changed, 168 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/Git=
Exception.java

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/GitExcepti=
on.java b/org.spearce.egit.core/src/org/spearce/egit/core/GitException.=
java
new file mode 100644
index 0000000..7217fb7
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/GitException.java
@@ -0,0 +1,168 @@
+/*********************************************************************=
**********
+ * Copyright (c) 2000, 2007 IBM Corporation and others.
+ * Copyright (c) 2003, 2006 Subclipse project and others.
+ *
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1=
=2E0
+ * See LICENSE for the full license text, also available.
+ *********************************************************************=
**********/
+
+package org.spearce.egit.core;
+
+import java.io.IOException;
+import java.lang.reflect.InvocationTargetException;
+
+import org.eclipse.core.resources.IResource;
+import org.eclipse.core.runtime.*;
+import org.eclipse.team.core.TeamException;
+import org.eclipse.team.core.TeamStatus;
+
+/**
+ * A checked exception representing a failure in the Git plugin.
+ * <p>
+ * Git exceptions contain a status object describing the cause of the =
exception.
+ * </p>
+ *=20
+ * @see IStatus
+ */
+public class GitException extends TeamException {
+
+	private static final long serialVersionUID =3D 1L;
+
+	/**
+	 * Constructs a new Git exception
+	 *=20
+	 * @param severity
+	 * @param code
+	 * @param message
+	 * @param e
+	 */
+	public GitException(int severity, int code, String message, Throwable=
 e) {
+		super(new TeamStatus(severity, Activator.getPluginId(), code, messag=
e,
+				e, null));
+	}
+
+	/**
+	 * Constructs a new Git exception
+	 *=20
+	 * @param severity
+	 * @param code
+	 * @param message
+	 */
+	public GitException(int severity, int code, String message) {
+		this(severity, code, message, null);
+	}
+
+	/**
+	 * Constructs a new Git exception
+	 *=20
+	 * @param message
+	 * @param e
+	 */
+	public GitException(String message, Throwable e) {
+		this(IStatus.ERROR, UNABLE, message, e);
+	}
+
+	/**
+	 * Constructs a new Git exception
+	 *=20
+	 * @param message
+	 */
+	public GitException(String message) {
+		this(message, null);
+	}
+
+	/**
+	 * Constructs a new Git exception
+	 *=20
+	 * @param status
+	 */
+	public GitException(IStatus status) {
+		super(status);
+	}
+
+	/**
+	 * Transform this exception into a CoreException
+	 *=20
+	 * @return the new CoreException
+	 */
+	public CoreException toCoreException() {
+		IStatus status =3D getStatus();
+		return new CoreException(new Status(status.getSeverity(), status
+				.getPlugin(), 0, status.getMessage(), this));
+	}
+
+	/**
+	 * Static helper method for creating a Git exception
+	 *=20
+	 * @param resource
+	 * @param message
+	 * @param e
+	 * @return the created exception
+	 */
+	public static GitException wrapException(IResource resource,
+			String message, CoreException e) {
+		return new GitException(IStatus.ERROR, e.getStatus().getCode(),
+				message, e);
+	}
+
+	/**
+	 * Static helper method for creating a Git exception
+	 *=20
+	 * @param e
+	 * @return the created exception
+	 */
+	public static GitException wrapException(Exception e) {
+		Throwable t =3D e;
+		if (e instanceof InvocationTargetException) {
+			Throwable target =3D ((InvocationTargetException) e)
+					.getTargetException();
+			if (target instanceof GitException) {
+				return (GitException) target;
+			}
+			t =3D target;
+		}
+
+		return new GitException(IStatus.ERROR, UNABLE,
+				t.getMessage() !=3D null ? t.getMessage() : "", t); //$NON-NLS-1$
+	}
+
+	/**
+	 * Static helper method for creating a Git exception
+	 *=20
+	 * @param e
+	 * @return the created exception
+	 */
+	public static GitException wrapException(CoreException e) {
+		IStatus status =3D e.getStatus();
+		if (!status.isMultiStatus()) {
+			status =3D new TeamStatus(status.getSeverity(), Activator
+					.getPluginId(), status.getCode(), status.getMessage(), e,
+					null);
+		}
+		return new GitException(status);
+	}
+
+	/**
+	 * Static helper method for creating a Git exception
+	 *=20
+	 * @param e
+	 * @return the created exception
+	 */
+	public static GitException wrapException(IOException e) {
+		return new GitException(IStatus.ERROR, IO_FAILED, e.getMessage(), e)=
;
+	}
+
+	/**
+	 * Static helper method for creating a Git exception
+	 *=20
+	 * @param e
+	 * @return the created exception
+	 */
+	public static GitException wrapException(TeamException e) {
+		if (e instanceof GitException)
+			return (GitException) e;
+		else
+			return new GitException(e.getStatus());
+	}
+}
--=20
1.6.1.2.309.g2ea3
