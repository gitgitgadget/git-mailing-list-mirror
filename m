From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] INSTALL: Add instructions about configuring /etc/xml/catalog on Cygwin for documentation builds.
Date: Sun, 25 Jul 2010 13:57:35 +1000
Message-ID: <1280030255-4764-1-git-send-email-jon.seymour@gmail.com>
Cc: jon.seymour@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 05:58:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcsLg-00015M-S3
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 05:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678Ab0GYD5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 23:57:47 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59483 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab0GYD5q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 23:57:46 -0400
Received: by pvc7 with SMTP id 7so4062764pvc.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 20:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=2wd52jkFZYrxIcV8WHfM7IkdwuRVzOgVUof5ytH2fsI=;
        b=iqZYgWGxFdGDGqjaD+vLT/pOhAS1kkcJIMzyBFUEU+esgwxD0lr6dpQoXm9ubXfLcX
         PDre4voSml3c4pBL/XTy4xn2hK+Y/IyIk8d9gptxBBG79K2iYK9HULZsvgyVFJ07vZrv
         I9yF/0462fwkbcDBXstwJfCVHYV5IruXjen3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xtkZs+anSSbnO49qXOveXr6xISfHxoBOXgKsmtcOWY/W5+AZ3Bv3GJAV95l+Cj98L8
         3mo6j8Y0986SOwHzbgaekHHfZyzrS1DRzFxF0nxoYeANF9gjqwbT3X3cu/r7Z9VIeQT0
         PW13bidftJyO3EHqd2cWdhOqNB9yYfzuvckGc=
Received: by 10.114.61.3 with SMTP id j3mr8589216waa.60.1280030265530;
        Sat, 24 Jul 2010 20:57:45 -0700 (PDT)
Received: from localhost.localdomain (124-169-0-188.dyn.iinet.net.au [124.169.0.188])
        by mx.google.com with ESMTPS id c24sm3744652wam.7.2010.07.24.20.57.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 20:57:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4.6.ge3842
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151705>

Without additional configuration steps, the documentation build on Cygwin fails because the XML catalog is missing required rewrites for certain docbook resources.

This patch documents the required configuration.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 INSTALL |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/INSTALL b/INSTALL
index 61086ab..59200b7 100644
--- a/INSTALL
+++ b/INSTALL
@@ -157,3 +157,36 @@ Issues of note:
    It has been reported that docbook-xsl version 1.72 and 1.73 are
    buggy; 1.72 misformats manual pages for callouts, and 1.73 needs
    the patch in contrib/patches/docbook-xsl-manpages-charmap.patch
+
+   Users attempting to build the documentation on Cygwin may need to ensure
+   that the /etc/xml/catalog file looks something like this:
+
+   <?xml version="1.0"?>
+   <!DOCTYPE catalog PUBLIC
+      "-//OASIS//DTD Entity Resolution XML Catalog V1.0//EN"
+      "http://www.oasis-open.org/committees/entity/release/1.0/catalog.dtd"
+   >
+   <catalog xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog">
+     <rewriteURI
+       uriStartString = "http://docbook.sourceforge.net/release/xsl/current"
+       rewritePrefix = "/usr/share/sgml/docbook/xsl-stylesheets"
+     />
+     <rewriteURI
+       uriStartString="http://www.oasis-open.org/docbook/xml/4.5"
+       rewritePrefix="/usr/share/sgml/docbook/xml-dtd-4.5"
+     />
+  </catalog>
+
+  This can be achieved with the following two xmlcatalog commands:
+
+  xmlcatalog --noout \
+     --add rewriteURI \
+        http://docbook.sourceforge.net/release/xsl/current \
+        /usr/share/sgml/docbook/xsl-stylesheets \
+     /etc/xml/catalog
+
+  xmlcatalog --noout \
+     --add rewriteURI \
+         http://www.oasis-open.org/docbook/xml/4.5/xsl/current \
+         /usr/share/sgml/docbook/xml-dtd-4.5 \
+     /etc/xml/catalog
-- 
1.7.0.4.6.ge3842
