From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 1/2] Use Boolean.valueOf instead of new Boolean
Date: Wed, 6 Feb 2008 21:14:15 +0100
Message-ID: <200802062114.16756.robin.rosenberg@dewire.com>
References: <1202170534-15788-1-git-send-email-robin.rosenberg@dewire.com> <1202170534-15788-3-git-send-email-robin.rosenberg@dewire.com> <20080206070631.GM24004@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org,
	"Roger C. Soares" <rogersoares@intelinet.com.br>,
	Dave Watson <dwatson@mimvista.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:15:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMqg9-0004uz-0O
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 21:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758918AbYBFUOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 15:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756110AbYBFUOg
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 15:14:36 -0500
Received: from [83.140.172.130] ([83.140.172.130]:10437 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1758822AbYBFUOe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2008 15:14:34 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C6A31800690;
	Wed,  6 Feb 2008 21:14:27 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gb-SF3JM+Wmt; Wed,  6 Feb 2008 21:14:26 +0100 (CET)
Received: from [10.9.0.6] (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id 89413800680;
	Wed,  6 Feb 2008 21:14:21 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <20080206070631.GM24004@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72840>

onsdagen den 6 februari 2008 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > These operation are relatively expensive in general so it is good to make them
> > visible, but when they are needed a lot we just want to do without explicit conversion
> > so we ignore the warning there.
> > @@ -207,7 +207,7 @@ public class GitResourceDecorator extends LabelProvider implements
> >  					return Boolean.FALSE;
> >  				}
> >  
> > -				return mapped.isResourceChanged(rsrc);
> > +				return new Boolean(mapped.isResourceChanged(rsrc));
> >  			}
> >  			return null; // not mapped
> >  		} catch (CoreException e) {
> 
> Oooooooow.  That hurts.
Sorry :/

I reuse Date and String, and Integer object elsewhere all the time, but the obvious
solution is too simple :)

Thanks Shawn.

-- robin

>From 4fbd3de89c53956abfbc1a4bb08113c6a9f83ab3 Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Wed, 6 Feb 2008 18:40:25 +0100
Subject: [EGIT PATCH 1/2] Use Boolean.valueOf instead of new Boolean

This use two singleton Booleans instead of allocating new
objects.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../internal/decorators/GitResourceDecorator.java  |    4 ++--
 .../src/org/spearce/jgit/lib/GitIndex.java         |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java 
b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
index 7eb008b..9592817 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/decorators/GitResourceDecorator.java
@@ -207,7 +207,7 @@ public class GitResourceDecorator extends LabelProvider implements
 					return Boolean.FALSE;
 				}
 
-				return new Boolean(mapped.isResourceChanged(rsrc));
+				return Boolean.valueOf(mapped.isResourceChanged(rsrc));
 			}
 			return null; // not mapped
 		} catch (CoreException e) {
@@ -245,7 +245,7 @@ public class GitResourceDecorator extends LabelProvider implements
 							Integer df = (Integer) rsrc
 									.getSessionProperty(GITFOLDERDIRTYSTATEPROPERTY);
 							Boolean f = df == null ? isDirty(rsrc)
-									: new Boolean(df.intValue() == CHANGED);
+									: Boolean.valueOf(df.intValue() == CHANGED);
 							if (f != null) {
 								if (f.booleanValue()) {
 									decoration.addPrefix(">"); // Have not
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
index 69ed270..3cd9de9 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
@@ -290,7 +290,7 @@ public class GitIndex {
 		if (setExecute != null) {
 			try {
 				return ((Boolean) setExecute.invoke(f,
-						new Object[] { new Boolean(value) })).booleanValue();
+						new Object[] { Boolean.valueOf(value) })).booleanValue();
 			} catch (IllegalArgumentException e) {
 				throw new Error(e);
 			} catch (IllegalAccessException e) {
-- 
1.5.4.rc4.25.g81cc
