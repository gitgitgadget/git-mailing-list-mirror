From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [EGIT PATCH 02/11 v2] Use Set instead of array to keep track of change listeners
Date: Thu,  5 Feb 2009 19:28:38 +0100
Message-ID: <1233858518-21563-1-git-send-email-torarnv@gmail.com>
References: <498B159B.4040001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 19:29:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV8yz-0005SL-GP
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 19:29:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbZBES2K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 13:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755372AbZBES2I
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 13:28:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:62971 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752698AbZBES2H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 13:28:07 -0500
Received: by ug-out-1314.google.com with SMTP id 39so180217ugf.37
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 10:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Wq4vBCEgnYedQyUh+/aaEC5MXtrCfUGOWacKsFmMc+c=;
        b=t7mbx0mAQKT2rYWMpDY9tq/ZFdbmx1SGkqAUhe7HLPlWUr8Ag0d6wWOd8Amlgcwcl7
         64FG9XtLM2QTNHFwp98wFpS2zqfKDJg9/kYPrKtnbMJQJMvJzlPhFnR8e3FmKeqfUcUR
         lkDzJf79BozyhgZ1nnoN04pKgF+bsafl1+ar0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Bsamy+e845sB2m9S99b+nVYVsVsOebE74kqG2LPphi9w9z9NjCNYNcOR3BmK5pmWI4
         3bswubPs2TEONYd7SmvI0jWkcdC3NBA7GrpslGf8ZhNKfK5TSRj0ixsKYpOp2Hj/VHZd
         Vy4DhJkYwH4kH7rawVuVv3kyzLg32rxqBjUak=
Received: by 10.103.6.18 with SMTP id j18mr336352mui.33.1233858484404;
        Thu, 05 Feb 2009 10:28:04 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id y2sm1081080mug.15.2009.02.05.10.28.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Feb 2009 10:28:03 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id 16D60468001; Thu,  5 Feb 2009 19:28:38 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
In-Reply-To: <498B159B.4040001@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108596>

Also, add method for removing listeners.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 .../spearce/egit/core/project/GitProjectData.java  |   40 ++++++++++++=
-------
 1 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/Gi=
tProjectData.java b/org.spearce.egit.core/src/org/spearce/egit/core/pro=
ject/GitProjectData.java
index db5f20b..b12a85f 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjec=
tData.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitProjec=
tData.java
@@ -52,7 +52,7 @@
=20
 	private static final Map<File, WeakReference> repositoryCache =3D new=
 HashMap<File, WeakReference>();
=20
-	private static RepositoryChangeListener[] repositoryChangeListeners =3D=
 {};
+	private static Set<RepositoryChangeListener> repositoryChangeListener=
s =3D new HashSet<RepositoryChangeListener>();
=20
 	@SuppressWarnings("synthetic-access")
 	private static final IResourceChangeListener rcl =3D new RCL();
@@ -112,16 +112,18 @@ public static synchronized void addRepositoryChan=
geListener(
 			final RepositoryChangeListener objectThatCares) {
 		if (objectThatCares =3D=3D null)
 			throw new NullPointerException();
-		for (int k =3D repositoryChangeListeners.length - 1; k >=3D 0; k--) =
{
-			if (repositoryChangeListeners[k] =3D=3D objectThatCares)
-				return;
-		}
-		final int p =3D repositoryChangeListeners.length;
-		final RepositoryChangeListener[] n;
-		n =3D new RepositoryChangeListener[p + 1];
-		System.arraycopy(repositoryChangeListeners, 0, n, 0, p);
-		n[p] =3D objectThatCares;
-		repositoryChangeListeners =3D n;
+		repositoryChangeListeners.add(objectThatCares);
+	}
+
+	/**
+	 * Remove a registered {@link RepositoryChangeListener}
+	 *=20
+	 * @param objectThatCares
+	 *            The listener to remove
+	 */
+	public static synchronized void removeRepositoryChangeListener(
+			final RepositoryChangeListener objectThatCares) {
+		repositoryChangeListeners.remove(objectThatCares);
 	}
=20
 	/**
@@ -131,13 +133,21 @@ public static synchronized void addRepositoryChan=
geListener(
 	 *            the repository which has had changes occur within it.
 	 */
 	static void fireRepositoryChanged(final RepositoryMapping which) {
-		final RepositoryChangeListener[] e =3D getRepositoryChangeListeners(=
);
-		for (int k =3D e.length - 1; k >=3D 0; k--)
-			e[k].repositoryChanged(which);
+		for (RepositoryChangeListener listener : getRepositoryChangeListener=
s())
+			listener.repositoryChanged(which);
 	}
=20
+	/**
+	 * Get a copy of the current set of repository change listeners
+	 * <p>
+	 * The array has no references, so is safe for iteration and modifica=
tion
+	 *=20
+	 * @return a copy of the current repository change listeners
+	 */
 	private static synchronized RepositoryChangeListener[] getRepositoryC=
hangeListeners() {
-		return repositoryChangeListeners;
+		return repositoryChangeListeners
+				.toArray(new RepositoryChangeListener[repositoryChangeListeners
+						.size()]);
 	}
=20
 	/**
--=20
1.6.1.2.309.g2ea3
