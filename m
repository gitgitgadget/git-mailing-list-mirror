From: Shunichi Fuji <palglowr@gmail.com>
Subject: [EGIT PATCH] egit.core: Handling mapping unavaiable
Date: Tue, 12 Feb 2008 02:06:25 +0900
Message-ID: <20080212020625.d33eded5.palglowr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 18:08:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOc8b-0004FO-Ba
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 18:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757367AbYBKRGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 12:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753432AbYBKRGc
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 12:06:32 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:23092 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757255AbYBKRGb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 12:06:31 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2277633wah.23
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 09:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=vLe6eQX3Zg7qBy/Z8HDEi1lOCbvQEcj8XZFMftTN6h4=;
        b=cao4qRCnG8ioq0+5v567mCDp9yyG3RnZKWnVU3zZ46ceg/0J1eEps/KKTnrJRvJnyv7s0rk5b01Og+M70yrnnJDn1YbFYAHeN3HncmfZex3YJHjKfXOnTSdh3JqlrgBixJAeZB9/9xMekRAAicpVKu8ieg0LDydJWacdjrY49Sk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=rRTHfy3uMLiBwa2dBWT4M1BAbXC8R9dlcGsZWZsi3cmN3oaxD+jt4LSr8qqCZFjV0fNCQysPNhpSjHTGwGI4hDIDU1NUxhJdHb4iWeijdQPlddIGqUMJM+gxkYx3wY0tzEc3z/RcYqiGCigdXznTazHmMYYkh56GxgkaNusx+1w=
Received: by 10.114.174.2 with SMTP id w2mr253270wae.17.1202749589616;
        Mon, 11 Feb 2008 09:06:29 -0800 (PST)
Received: from linuxhost ( [203.135.245.193])
        by mx.google.com with ESMTPS id l28sm2798985waf.40.2008.02.11.09.06.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 09:06:28 -0800 (PST)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.7; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73554>


 Check whether IResource.getProject returned the workspace root.

Signed-off-by: Shunichi Fuji <palglowr@gmail.com>
---
 .../egit/core/project/RepositoryMapping.java       |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
index 754a172..383cb8b 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
@@ -267,13 +267,16 @@ public class RepositoryMapping {
 	}
 
 	/**
-	 * Get the repository mappping for a resource
+	 * Get the repository mapping for a resource
 	 *
 	 * @param resource
-	 * @return the RepositoryMapping for this resource
+	 * @return the RepositoryMapping for this resource,
+	 *         or null for non GitProvider.
 	 */
 	public static RepositoryMapping getMapping(IResource resource) {
 		IProject project = resource.getProject();
+		if (project == null)
+			return null;
 		RepositoryProvider provider = RepositoryProvider.getProvider(project);
 		if (!(provider instanceof GitProvider))
 			return null;
-- 
1.5.4
