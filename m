From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: [JGIT PATCH] Allow http_proxy values without protocol-part
Date: Thu, 9 Jul 2009 23:28:22 +0200
Message-ID: <20090709232822.00000164@unknown>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 23:28:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP1AN-0006yB-5d
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 23:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109AbZGIV21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 17:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755670AbZGIV20
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 17:28:26 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:65532 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755283AbZGIV20 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 17:28:26 -0400
Received: by bwz25 with SMTP id 25so471700bwz.37
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 14:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ef9EvOCCtlGLpI3n5PtThj7moghO0kfiBnDFRvEskwA=;
        b=XKdjH/AXZ3BAIrn+OCo7I0bIHgq2T8uIlYuwYPzlXnDAYFd2YPbtbtUm7vnAhld3h4
         7QhnF/6viSD0vHBGmXQJj9CoOeZnS9LFYYJRxZJVgLlvLNRBSqTnTKKm3qLe4u0JouaX
         OW13Zqjf1OU91XgKSZc9LL6K7IOlT9ysYkmgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Hkgp5Wd9SUYLsbIRzhQiHi/987Ch7JhqIJQIpROYuIqlez/C2CTY8XHvpbJv9stPcf
         ZUxs7v4j9lwqJy5zGisjs2eA3OcJmKdlAoxdsxjoPkgkhgb2OWctQkefFIcdH+v4mUo5
         Y/hW3Tn9xHpTLsbyhPwNSQiaos+11nMW7osUM=
Received: by 10.103.11.7 with SMTP id o7mr667719mui.95.1247174904264;
        Thu, 09 Jul 2009 14:28:24 -0700 (PDT)
Received: from unknown (g226215147.adsl.alicedsl.de [92.226.215.147])
        by mx.google.com with ESMTPS id 7sm1562675mup.54.2009.07.09.14.28.23
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 14:28:23 -0700 (PDT)
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.16.0; i586-pc-mingw32msvc)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123013>

From: Christian Halstrick <christian.halstrick@sap.com>

jgit reads the environment variable http_proxy to configure the proxy
for http traffic in the same way as applications using the libcurl
library. It would be nice if jgit would understand the same values as
libcurl, but for libcurl the protocol part is optional (e.g.
http_proxy=proxy:8080 is valid). I changed jgit to also support
http_proxy values without a protocol spec. When no protocol is
specified "http://" is assumed.

Signed-off-by: Christian Halstrick <christian.halstrick@sap.com>
---
 .../src/org/spearce/jgit/util/HttpSupport.java     |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/HttpSupport.java b/org.spearce.jgit/src/org/spearce/jgit/util/HttpSupport.java
index 33dfcee..5f21677 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/util/HttpSupport.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/util/HttpSupport.java
@@ -69,7 +69,7 @@ public static void configureHttpProxy() throws MalformedURLException {
 		if (s == null || s.equals(""))
 			return;
 
-		final URL u = new URL(s);
+		final URL u = new URL((s.indexOf("://")==-1) ? "http://"+s : s);
 		if (!"http".equals(u.getProtocol()))
 			throw new MalformedURLException("Invalid http_proxy: " + s
 					+ ": Only http supported.");
-- 
1.6.3.2.1299.gee46c
