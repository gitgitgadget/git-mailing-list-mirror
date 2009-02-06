From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] New PersonIdent of a repository is the default committer
Date: Fri, 06 Feb 2009 17:04:18 +0100
Message-ID: <498C5F82.2040205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 06 17:06:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVTDH-0002s7-L5
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 17:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759553AbZBFQEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 11:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753713AbZBFQEX
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 11:04:23 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:62380 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759551AbZBFQEW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 11:04:22 -0500
Received: by fg-out-1718.google.com with SMTP id 16so547060fgg.17
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 08:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=q4IDERMV+/yEawFewk9ZV45eiFG5xPtK1WBQJ4z6Nis=;
        b=R9cLiRS55nNGoVv1sT9RqsKh6kVRvW+I40abHvOvtSEWL8uQZhtNCva3eCnAsI+a7q
         V2IAv1AfO1xauscqO5ZN7zMcVtlEq09tfiXH7kc/bsXZL1ZXD49LaewzJ175prh1i0QD
         oFx6csdaoVEEITqBGl6UXcAvmzCi90sUedojM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=Af8kagIpDupcwuQHYQwQB8bDqgvUKEHrX3sq7VWQuJagZOhm8I9Ot8z9/vDxcaSd6z
         7ezGsQVLSkluxKrUfcCkd3vyDmkKRVfBrtr3hqAK2T833+hbaszd5jtrTVgNXOqwXM7R
         FDaV1ckr6VXLyKLdTAKmTMZisw+X8fgW6tdto=
Received: by 10.86.57.9 with SMTP id f9mr1054517fga.38.1233936260112;
        Fri, 06 Feb 2009 08:04:20 -0800 (PST)
Received: from ?10.11.2.21? (port-87-193-216-74.static.qsc.de [87.193.216.74])
        by mx.google.com with ESMTPS id 3sm524801fge.42.2009.02.06.08.04.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Feb 2009 08:04:19 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The constructor PersonIdent(Repository) uses the default values
from the configuration of the repository.

The new instance gets the name and the email of the default committer.

Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
 .../src/org/spearce/jgit/lib/PersonIdent.java      |   26 ++++----------------
 1 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
index bc5479a..fb4ab20 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PersonIdent.java
@@ -57,33 +57,17 @@
 
 	private final int tzOffset;
 
-	private static String getHostName() {
-		try {
-			java.net.InetAddress addr = java.net.InetAddress.getLocalHost();
-			String hostname = addr.getCanonicalHostName();
-			return hostname;
-		} catch (java.net.UnknownHostException e) {
-			return "localhost";
-		}
-	}
-
 	/**
-	 * Creates new PersonIdent from config info in repository, with current time
+	 * Creates new PersonIdent from config info in repository, with current time.
+	 * This new PersonIdent gets the info from the default committer as available
+	 * from the configuration.
 	 * 
 	 * @param repo
 	 */
 	public PersonIdent(final Repository repo) {
 		RepositoryConfig config = repo.getConfig();
-		String username = config.getString("user", null, "name");
-		if (username == null)
-			username = System.getProperty("user.name");
-
-		String email = config.getString("user", null, "email");
-		if (email == null)
-			email = System.getProperty("user.name") + "@" + getHostName();
-
-		name = username;
-		emailAddress = email;
+		name = config.getCommitterName();
+		emailAddress = config.getCommitterEmail();
 		when = System.currentTimeMillis();
 		tzOffset = TimeZone.getDefault().getOffset(when) / (60 * 1000);
 	}
-- 
1.6.0.4
