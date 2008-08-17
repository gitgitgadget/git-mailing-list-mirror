From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 06/31] Make wildcard checking public in RefSpec
Date: Sun, 17 Aug 2008 22:43:47 +0200
Message-ID: <1219005852-21496-7-git-send-email-marek.zawirski@gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-2-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-3-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-4-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-5-git-send-email-marek.zawirski@gmail.com>
 <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sun Aug 17 22:46:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUp8M-0002uV-93
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 22:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbYHQUoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 16:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752167AbYHQUoj
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 16:44:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:31899 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbYHQUoh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 16:44:37 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1489141fgg.17
        for <git@vger.kernel.org>; Sun, 17 Aug 2008 13:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hu8SqPcwxHOWUL9hj0uRk5j2bDFi5UL9UMsrEQeroVg=;
        b=FUQE70xtdJ83zn1yvE9NrYOLqbHavh5s20QtH1ErVKs9tJh5ph3jSQgQur75xBMkr3
         AYvtuz/kOLHwu69jH80d8U+1gO/YZvR/eNzGWVVWLgYbS/sg4kL01crdhs6oxoCrbNlO
         j7C+eormLqUq8o1Aa7Pkky4d4VwYaOm3hSE7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=HLaf+bomzEuGlKAHq5JYriStex8xCHs1vK3amvqqZ/BwMqmVEhTrQlYV+y0Z/LRmqF
         SgjAHygiLQ8IR2y0Rr8sgntXMtaVspGZ5rVG6/FhOM6RSuJuyeOy/fFQYi73IAIwrgId
         CROpk63ggPlqQ9bNOrHFffYr17eLKemsF5+l4=
Received: by 10.102.218.6 with SMTP id q6mr3465136mug.127.1219005876957;
        Sun, 17 Aug 2008 13:44:36 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id s10sm721492mue.15.2008.08.17.13.44.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 17 Aug 2008 13:44:36 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1219005852-21496-6-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92639>

This constant and method can/should be reused in GUI.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/transport/RefSpec.java    |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
index e489233..9ec5847 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
@@ -47,9 +47,20 @@ import org.spearce.jgit.lib.Ref;
  * reference in one repository to another reference in another repository.
  */
 public class RefSpec {
-	private static final String WILDCARD_SUFFIX = "/*";
+	/**
+	 * Suffix for wildcard ref spec component, that indicate matching all refs
+	 * with specified prefix.
+	 */
+	public static final String WILDCARD_SUFFIX = "/*";
 
-	private static boolean isWildcard(final String s) {
+	/**
+	 * Check whether provided string is a wildcard ref spec component.
+	 * 
+	 * @param s
+	 *            ref spec component - string to test. Can be null.
+	 * @return true if provided string is a wildcard ref spec component.
+	 */
+	public static boolean isWildcard(final String s) {
 		return s != null && s.endsWith(WILDCARD_SUFFIX);
 	}
 
-- 
1.5.6.3
