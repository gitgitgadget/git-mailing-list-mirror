From: Nigel Magnay <nigel.magnay@gmail.com>
Subject: [PATCH JGIT] Minor : Make ObjectId, RemoteConfig Serializable
Date: Fri, 6 Feb 2009 21:15:29 +0000
Message-ID: <320075ff0902061315g3f8b9c9bj92f528e700d59c50@mail.gmail.com>
References: <320075ff0902060702n7573aaecu9054626ee9a6991@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 06 22:17:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVY4k-0005j8-JB
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 22:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756346AbZBFVPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 16:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756338AbZBFVPd
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 16:15:33 -0500
Received: from mu-out-0910.google.com ([209.85.134.191]:51085 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756335AbZBFVPc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 16:15:32 -0500
Received: by mu-out-0910.google.com with SMTP id i10so684273mue.1
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 13:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=wyt6Y7AZxPzPo4UdwjAFtw5LFKymji1L+iArlp8EuAA=;
        b=xgbP1RK/zwjWPr/a4SY06MBRQc5BVuw2j4Talt2VAaxqGsxnD3nBPmTaHCuSayiz6h
         k/NjWastLHfTK5MRWp8w+S3yOakuQhWzxtVUfiqScThPQhVlIfcnCzuJWklUirPgmi6Q
         gz5Vda++o/M8m3iXNY2imP6MLPLb/J8rW4Mdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=UcGYWS92aN35/xbDlgkxpYjtu0jIJw+O3fCCO9oI2+yLr/4DKv1uVa3RPZ36BlCB02
         UDfJWV/Te/Em2uRSLx3ZqGtRF/0sctLjG0dg4k5WVBo8zxtLo8rqidwAEcPsjp1RG6oh
         tHfoKj4iJHOrbZMUSJh9NHsCEDYzXvXv5MIMU=
Received: by 10.103.92.8 with SMTP id u8mr952382mul.34.1233954929758; Fri, 06 
	Feb 2009 13:15:29 -0800 (PST)
In-Reply-To: <320075ff0902060702n7573aaecu9054626ee9a6991@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108789>

Make AnyObjectId and RemoteConfig Serializable.
When using jgit as a library in other tools, it's helpful to be able
to use the nice, tested bits of jgit rather than String, but need to
be able to serialize them.

Signed-off-by: Nigel Magnay <nigel.magnay@gmail.com>
---
 .../src/org/spearce/jgit/lib/AnyObjectId.java      |    3 ++-
 .../org/spearce/jgit/transport/RemoteConfig.java   |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
index e2f70ca..532174b 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/AnyObjectId.java
@@ -39,6 +39,7 @@

 import java.io.IOException;
 import java.io.OutputStream;
+import java.io.Serializable;
 import java.io.Writer;
 import java.nio.ByteBuffer;
 import java.util.Arrays;
@@ -52,7 +53,7 @@
  * with this instance can alter at any time, if this instance is modified to
  * represent a different object name.
  */
-public abstract class AnyObjectId implements Comparable {
+public abstract class AnyObjectId implements Comparable, Serializable {
     static final int RAW_LEN = Constants.OBJECT_ID_LENGTH;

     static final int STR_LEN = RAW_LEN * 2;
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
index 5bbf664..7949612 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
@@ -38,6 +38,7 @@

 package org.spearce.jgit.transport;

+import java.io.Serializable;
 import java.net.URISyntaxException;
 import java.util.ArrayList;
 import java.util.Collections;
@@ -53,7 +54,7 @@
  * describing how refs should be transferred between this repository and the
  * remote repository.
  */
-public class RemoteConfig {
+public class RemoteConfig implements Serializable {
     private static final String SECTION = "remote";

     private static final String KEY_URL = "url";
--
1.6.0.2
