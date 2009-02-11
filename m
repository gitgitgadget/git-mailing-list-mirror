From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH v2 04/12] Add new class ExceptionCollector for grouping exceptions
Date: Wed, 11 Feb 2009 19:40:06 +0100
Message-ID: <1234377614-23798-5-git-send-email-torarnv@gmail.com>
References: <1234377614-23798-1-git-send-email-torarnv@gmail.com>
 <1234377614-23798-2-git-send-email-torarnv@gmail.com>
 <1234377614-23798-3-git-send-email-torarnv@gmail.com>
 <1234377614-23798-4-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 19:42:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXK23-0005RI-4J
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013AbZBKSjx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2009 13:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755569AbZBKSjw
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:39:52 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:15206 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099AbZBKSjv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 13:39:51 -0500
Received: by fg-out-1718.google.com with SMTP id 16so108716fgg.17
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 10:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=q+P29jTM6bWVWsXBNADaRKAT/RNYgw9PcxjDyIhOWqw=;
        b=mu6WILDhNNtyizCMS99bmRtKbA0xKMKBX6rkEgoa2Sa13fX1YQkaK/AhNh3lIa65rI
         4LtOKUrcqvWftBRBZR+1Kib0MKefcsbEL5ZsgDd8dbqCwufccXEpGlTrOxBAAvQnroAh
         TUYdNj9rjewnmAU9UFlwsz/zlBPi3Iaqsfg98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=LlQ3rw/UEYLIV6qnZFYvcm8SFEmwJTPG2Uk3qm21AESb7sIOYTnxl3LdNTNXyM3y4X
         gH4lmJ2HAILfUmnZD4wxEwuzF/5lURSvwlw6kEKt3+1NuZH0r3wbgzpzTrWaa8OEoOHC
         AXpPiENYc+dd5hviDt/bT+I7yftAFrqARkR+M=
Received: by 10.86.31.18 with SMTP id e18mr147780fge.72.1234377590645;
        Wed, 11 Feb 2009 10:39:50 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id 12sm5100757fgg.13.2009.02.11.10.39.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Feb 2009 10:39:38 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id 5352C468005; Wed, 11 Feb 2009 19:40:14 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <1234377614-23798-4-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109491>

Copied from org.eclipse.team.internal.core

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 org.spearce.egit.core/META-INF/MANIFEST.MF         |    5 +-
 .../core/internal/util/ExceptionCollector.java     |  128 ++++++++++++=
++++++++
 2 files changed, 131 insertions(+), 2 deletions(-)
 create mode 100644 org.spearce.egit.core/src/org/spearce/egit/core/int=
ernal/util/ExceptionCollector.java

diff --git a/org.spearce.egit.core/META-INF/MANIFEST.MF b/org.spearce.e=
git.core/META-INF/MANIFEST.MF
index e13732b..20df15f 100644
--- a/org.spearce.egit.core/META-INF/MANIFEST.MF
+++ b/org.spearce.egit.core/META-INF/MANIFEST.MF
@@ -12,8 +12,9 @@ Require-Bundle: org.eclipse.core.runtime,
  org.spearce.jgit,
  org.eclipse.core.filesystem,
  org.eclipse.ui
-Export-Package: org.spearce.egit.core.internal.storage;x-friends:=3D"o=
rg.spearce.egit.ui",
- org.spearce.egit.core,
+Export-Package: org.spearce.egit.core,
+ org.spearce.egit.core.internal.storage;x-friends:=3D"org.spearce.egit=
=2Eui",
+ org.spearce.egit.core.internal.util;x-friends:=3D"org.spearce.egit.ui=
",
  org.spearce.egit.core.op,
  org.spearce.egit.core.project
 Bundle-ActivationPolicy: lazy
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/u=
til/ExceptionCollector.java b/org.spearce.egit.core/src/org/spearce/egi=
t/core/internal/util/ExceptionCollector.java
new file mode 100644
index 0000000..d99d651
--- /dev/null
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/util/Exc=
eptionCollector.java
@@ -0,0 +1,128 @@
+/*********************************************************************=
**********
+ * Copyright (c) 2000, 2006 IBM Corporation and others.
+ * All rights reserved. This program and the accompanying materials
+ * are made available under the terms of the Eclipse Public License v1=
=2E0
+ * which accompanies this distribution, and is available at
+ * http://www.eclipse.org/legal/epl-v10.html
+ *
+ * Contributors:
+ *     IBM Corporation - initial API and implementation
+ *********************************************************************=
**********/
+package org.spearce.egit.core.internal.util;
+
+import java.util.ArrayList;
+import java.util.Iterator;
+import java.util.List;
+
+import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.ILog;
+import org.eclipse.core.runtime.IStatus;
+import org.eclipse.core.runtime.MultiStatus;
+import org.eclipse.core.runtime.Status;
+
+/**
+ * Collects exceptions and can be configured to ignore duplicates exce=
ptions.
+ * Exceptions can be logged and a MultiStatus containing all collected
+ * exceptions can be returned.
+ *=20
+ * @see org.eclipse.core.runtime.MultiStatus
+ * @see org.eclipse.core.runtime.IStatus
+ *=20
+ * @since 3.0
+ */
+public class ExceptionCollector {
+
+	private final List<IStatus> statuses =3D new ArrayList<IStatus>();
+
+	private final String message;
+
+	private final String pluginId;
+
+	private final int severity;
+
+	private final ILog log;
+
+	/**
+	 * Creates a collector and initializes the parameters for the top-lev=
el
+	 * exception that would be returned from <code>getStatus</code> is
+	 * exceptions are collected.
+	 *=20
+	 * @param message
+	 *            a human-readable message, localized to the current loca=
le
+	 * @param pluginId
+	 *            the unique identifier of the relevant plug-in
+	 * @param severity
+	 *            the severity; one of <code>OK</code>, <code>ERROR</code=
>,
+	 *            <code>INFO</code>, or <code>WARNING</code>
+	 * @param log
+	 *            the log to output the exceptions to, or <code>null</cod=
e> if
+	 *            exceptions should not be logged.
+	 */
+	public ExceptionCollector(String message, String pluginId, int severi=
ty,
+			ILog log) {
+		this.message =3D message;
+		this.pluginId =3D pluginId;
+		this.severity =3D severity;
+		this.log =3D log;
+	}
+
+	/**
+	 * Clears the exceptions collected.
+	 */
+	public void clear() {
+		statuses.clear();
+	}
+
+	/**
+	 * Returns a status that represents the exceptions collected. If the
+	 * collector is empty <code>IStatus.OK</code> is returned. Otherwise =
a
+	 * MultiStatus containing all collected exceptions is returned.
+	 *=20
+	 * @return a multistatus containing the exceptions collected or IStat=
us.OK
+	 *         if the collector is empty.
+	 */
+	public IStatus getStatus() {
+		if (statuses.isEmpty()) {
+			return Status.OK_STATUS;
+		} else {
+			final MultiStatus multiStatus =3D new MultiStatus(pluginId, severit=
y,
+					message, null);
+			final Iterator it =3D statuses.iterator();
+			while (it.hasNext()) {
+				final IStatus status =3D (IStatus) it.next();
+				multiStatus.merge(status);
+			}
+			return multiStatus;
+		}
+	}
+
+	/**
+	 * Add this exception to the collector. If a log was specified in the
+	 * constructor then the exception will be output to the log. You can
+	 * retreive exceptions using <code>getStatus</code>.
+	 *=20
+	 * @param exception
+	 *            the exception to collect
+	 */
+	public void handleException(CoreException exception) {
+		if (log !=3D null) {
+			log.log(new Status(severity, pluginId, 0, message, exception));
+		}
+
+		// Record each status individually to flatten the resulting multi-st=
atus
+		final IStatus exceptionStatus =3D exception.getStatus();
+
+		// Wrap the exception so the stack trace is not lost.
+		final IStatus status =3D new Status(exceptionStatus.getSeverity(),
+				exceptionStatus.getPlugin(), exceptionStatus.getCode(),
+				exceptionStatus.getMessage(), exception);
+
+		recordStatus(status);
+		for (IStatus childStatus : status.getChildren())
+			recordStatus(childStatus);
+	}
+
+	private void recordStatus(IStatus status) {
+		statuses.add(status);
+	}
+}
--=20
1.6.1.2.309.g2ea3
