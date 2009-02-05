From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH 03/11] Add a specialized team exception for Git
Date: Thu,  5 Feb 2009 02:00:10 +0100
Message-ID: <1233795618-20249-4-git-send-email-torarnv@gmail.com>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com>
 <1233795618-20249-2-git-send-email-torarnv@gmail.com>
 <1233795618-20249-3-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 02:01:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUscL-0000fv-Vh
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 02:01:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119AbZBEA7y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2009 19:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756050AbZBEA7x
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 19:59:53 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:5805 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbZBEA7w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 19:59:52 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1578fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 16:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=e4LOdpuL6ioo8Zr+gzIKbjYOrkJIG6i/w0Pg/PnGp+M=;
        b=pr9wXs/Ng9rUJOWHQmrPG8n+qtROptH1s8hSe0+j1mWmDxlyJr3Ptmp+vnhp1fqWev
         tTd7lYSkvgiX9XgOfn2mTazdpm2u0HnmJ7Gza/98x2Ij0ElUdnxP8Y6p0WMEU8yfwZfD
         hVjxYYD2hHdn8NIH6LQfbxe3K9QVxno8uGnfU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=pY+q7b/Tu+S8N9jGmEZshqlaAhG7CtGXU1jOJ6iWMmpJUbA5qMEP0UlSaxO6kjo9jL
         G+Gly0o5ycoDN91ExjeaQQbJU74p7a66LelsKXXTCeCDPfInNjejyaicpMTEnj/C94qQ
         11Fci5rLU6Ah2CpLfiAo6d6EE09qCepoDwU64=
Received: by 10.86.95.20 with SMTP id s20mr520483fgb.43.1233795590396;
        Wed, 04 Feb 2009 16:59:50 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id d4sm12512fga.38.2009.02.04.16.59.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 16:59:49 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id 8A567468002; Thu,  5 Feb 2009 02:00:19 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <1233795618-20249-3-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108478>

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
