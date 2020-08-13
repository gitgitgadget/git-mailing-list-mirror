Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E94DC433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 22:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CB34207DA
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 22:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="0MSw8Jo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgHMWtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 18:49:42 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41492 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726576AbgHMWtm (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 Aug 2020 18:49:42 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E1204607A2;
        Thu, 13 Aug 2020 22:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1597358951;
        bh=NakwnmNVGLdxMwzUueifo9xvgmqSzI0buqb8gs+VWR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=0MSw8Jo+8di+S8Fd1BqEvfz+KfxXzLjeo83OS01/qIPW/XXk2rU9H7q60JNzJSqLA
         m9BeT9a0vJ2EPeMeRmq58pje6elxHHEgB4Os94nHZE7Nn2T2e/nb93lHKAtnd/ejBa
         8cWwbkBSjQZ8ivRcMDVsx2J53FaKHhVFGscBMKnc83WjRyzdSXsBbl/iWlTbf3wbUR
         I66dg20p0IjGNy4Fwnz3Xx/rg9CC9WEdDAIqOOmz6FdAjgPkLSF9ocnSMm3c8MyG5V
         UvneRERH0Uq3caf2ObCJ/gw4M3GABHK8ZSOw33hPwqaYDsEN1IEgCC+nPML54L9TRw
         YaL6zkgaM4LxgC7pIeh1K5CQDLRf4ubYjVytI7bUp4+oMGPKJKfmrn9GgAMM3M/6Eu
         csD+xSaGxHmp/jLJimsGCUyF4LSNtjsRKJ6d41/xp3mpDZlfam2HQKJAAuTataGcjJ
         02/vkY4WoevhKTtkgwW+9vq08Ci49Nv/q5CE2++Eq3SoveIvAM6
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH 1/2] docs: document SHA-256 pack and indices
Date:   Thu, 13 Aug 2020 22:49:00 +0000
Message-Id: <20200813224901.2652387-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.220.ged08abb693
In-Reply-To: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we have SHA-256 support for packs and indices, let's document
that in SHA-256 repositories, we use SHA-256 instead of SHA-1 for object
names and checksums.  Instead of duplicating this information throughout
the document, let's just document that in SHA-1 repositories, we use
SHA-1 for these purposes, and in SHA-256 repositories, we use SHA-256.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/technical/pack-format.txt | 36 ++++++++++++++-----------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index d3a142c652..f4c8d94f73 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -1,6 +1,12 @@
 Git pack format
 ===============
 
+== Checksums and object IDs
+
+In a repository using the traditional SHA-1, pack checksums, index checksums,
+and object IDs (object names) mentioned below are all computed using SHA-1.
+Similarly, in SHA-256 repositories, these values are computed using SHA-256.
+
 == pack-*.pack files have the following format:
 
    - A header appears at the beginning and consists of the following:
@@ -26,7 +32,7 @@ Git pack format
 
      (deltified representation)
      n-byte type and length (3-bit type, (n-1)*7+4-bit length)
-     20-byte base object name if OBJ_REF_DELTA or a negative relative
+     base object name if OBJ_REF_DELTA or a negative relative
 	 offset from the delta object's position in the pack if this
 	 is an OBJ_OFS_DELTA object
      compressed delta data
@@ -34,7 +40,7 @@ Git pack format
      Observation: length of each object is encoded in a variable
      length format and is not constrained to 32-bit or anything.
 
-  - The trailer records 20-byte SHA-1 checksum of all of the above.
+  - The trailer records a pack checksum of all of the above.
 
 === Object types
 
@@ -58,8 +64,8 @@ ofs-delta and ref-delta, which is only valid in a pack file.
 
 Both ofs-delta and ref-delta store the "delta" to be applied to
 another object (called 'base object') to reconstruct the object. The
-difference between them is, ref-delta directly encodes 20-byte base
-object name. If the base object is in the same pack, ofs-delta encodes
+difference between them is, ref-delta directly encodes base object
+name. If the base object is in the same pack, ofs-delta encodes
 the offset of the base object in the pack instead.
 
 The base object could also be deltified if it's in the same pack.
@@ -143,14 +149,14 @@ This is the instruction reserved for future expansion.
     object is stored in the packfile as the offset from the
     beginning.
 
-    20-byte object name.
+    one object name of the appropriate size.
 
   - The file is concluded with a trailer:
 
-    A copy of the 20-byte SHA-1 checksum at the end of
-    corresponding packfile.
+    A copy of the pack checksum at the end of the corresponding
+    packfile.
 
-    20-byte SHA-1-checksum of all of the above.
+    Index checksum of all of the above.
 
 Pack Idx file:
 
@@ -198,7 +204,7 @@ Pack file entry: <+
         If it is not DELTA, then deflated bytes (the size above
 		is the size before compression).
 	If it is REF_DELTA, then
-	  20-byte base object name SHA-1 (the size above is the
+	  base object name (the size above is the
 		size of the delta data that follows).
           delta data, deflated.
 	If it is OFS_DELTA, then
@@ -227,9 +233,9 @@ Pack file entry: <+
 
   - A 256-entry fan-out table just like v1.
 
-  - A table of sorted 20-byte SHA-1 object names.  These are
-    packed together without offset values to reduce the cache
-    footprint of the binary search for a specific object name.
+  - A table of sorted object names.  These are packed together
+    without offset values to reduce the cache footprint of the
+    binary search for a specific object name.
 
   - A table of 4-byte CRC32 values of the packed object data.
     This is new in v2 so compressed data can be copied directly
@@ -248,10 +254,10 @@ Pack file entry: <+
 
   - The same trailer as a v1 pack file:
 
-    A copy of the 20-byte SHA-1 checksum at the end of
+    A copy of the pack checksum at the end of
     corresponding packfile.
 
-    20-byte SHA-1-checksum of all of the above.
+    Index checksum of all of the above.
 
 == multi-pack-index (MIDX) files have the following format:
 
@@ -329,4 +335,4 @@ CHUNK DATA:
 
 TRAILER:
 
-	20-byte SHA1-checksum of the above contents.
+	Index checksum of the above contents.
