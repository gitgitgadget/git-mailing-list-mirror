Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B66DC433E3
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57D8A22D06
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 21:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTAm8EQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgHOVvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgHOVvg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:36 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A82C0A3BDE
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:06:34 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i19so6289181lfj.8
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sc2iWXxtSrkDE4h5N1PJMTikEIGT/lg3/YHIVDfPGV8=;
        b=VTAm8EQ5f6h+tcHuBLrH5vcPq28eONIEnmjMqB4WZhYrIZHhqvx/fVzFP7HVs3K9W6
         PcjDu/FFgIfbOtaNKvFCZv14BuSmfZIYbG/QQseOUgek8KLc0TdAU6IOnql40nqCMzpl
         3pc+tI1FwiXt3WWk6mTYFL05xssbQyMqemKL0KjqLo1nK/LlNNCwxrcMgfbbR4x5SePY
         3PVWFL4CWzeFjcKuKHkiwiUqcIPXh1odoR63UPXv3ofEpG6OH4LPwBMmOUQ5SXbeg5Wi
         yI0dsNm/LS0vzm/Iu5NXunkrhg3qlUChypsqnf4ZijQ2YFiLsmIV4Nfc3uZoFeS6GY2G
         pZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sc2iWXxtSrkDE4h5N1PJMTikEIGT/lg3/YHIVDfPGV8=;
        b=VcXIMg9aIzomehty+WPPf68fNBMq0WQf3yO+/8Ap6xPAewlcGPWVGtOcsIZM116It8
         pkhz1DmU3+o65mv18d9/d5CvSfpGu0K6hiflp2zZ1YbFu005kXl94f5xNdx6F32WSCgv
         vTbkdwidJxStgLZsfmY/ZkwP2GtYToXCEGlIZ7mZUVvMwcqEmLwsbce6MRnxhLnSsTv/
         6rFa3AOi1zfGlrCz7EPwkcTImqBq6WuDgeXV6+zPJFEcC/OklDthXFaetymn008+eMQ1
         d/KYgMXBGCdaN7SAPbGHQAs1lowoG3loVzT+IlLSkZTLfEvtnsFyvQuAJAhGhC119jhV
         vTyA==
X-Gm-Message-State: AOAM532hY4Gvcm0AcRkOINFqRePmVcpuoaaHI3T+kBIeHTjW4/GbpmQj
        J8xAjA88zmxj5vSsi2U9exRVA1Elwlo=
X-Google-Smtp-Source: ABdhPJxsBEsgws3L9Zr2BsNrn6WBJcUGCN06rUCo1TL8Z7siP24ahgvEzZhIUIs9leDZzHRT46esXw==
X-Received: by 2002:a19:c3d7:: with SMTP id t206mr3671242lff.177.1597507589099;
        Sat, 15 Aug 2020 09:06:29 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id a1sm2670493lfb.10.2020.08.15.09.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 09:06:28 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] index-format.txt: document SHA-256 index format
Date:   Sat, 15 Aug 2020 18:06:00 +0200
Message-Id: <14bd0d93620a917f5373ccef2867184ab7bb0811.1597506837.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <cover.1597506837.git.martin.agren@gmail.com>
References: <cover.1597406877.git.martin.agren@gmail.com> <cover.1597506837.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document that in SHA-1 repositories, we use SHA-1 and in SHA-256
repositories, we use SHA-256, then replace all other uses of "SHA-1"
with something more neutral. Avoid referring to "160-bit" hash values.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/technical/index-format.txt | 34 +++++++++++++-----------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index faa25c5c52..f9a3644711 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -3,8 +3,11 @@ Git index format
 
 == The Git index file has the following format
 
-  All binary numbers are in network byte order. Version 2 is described
-  here unless stated otherwise.
+  All binary numbers are in network byte order.
+  In a repository using the traditional SHA-1, checksums and object IDs
+  (object names) mentioned below are all computed using SHA-1.  Similarly,
+  in SHA-256 repositories, these values are computed using SHA-256.
+  Version 2 is described here unless stated otherwise.
 
    - A 12-byte header consisting of
 
@@ -32,8 +35,7 @@ Git index format
 
      Extension data
 
-   - 160-bit SHA-1 over the content of the index file before this
-     checksum.
+   - Hash checksum over the content of the index file before this checksum.
 
 == Index entry
 
@@ -80,7 +82,7 @@ Git index format
   32-bit file size
     This is the on-disk size from stat(2), truncated to 32-bit.
 
-  160-bit SHA-1 for the represented object
+  Object name for the represented object
 
   A 16-bit 'flags' field split into (high to low bits)
 
@@ -160,8 +162,8 @@ Git index format
 
   - A newline (ASCII 10); and
 
-  - 160-bit object name for the object that would result from writing
-    this span of index as a tree.
+  - Object name for the object that would result from writing this span
+    of index as a tree.
 
   An entry can be in an invalidated state and is represented by having
   a negative number in the entry_count field. In this case, there is no
@@ -198,7 +200,7 @@ Git index format
     stage 1 to 3 (a missing stage is represented by "0" in this field);
     and
 
-  - At most three 160-bit object names of the entry in stages from 1 to 3
+  - At most three object names of the entry in stages from 1 to 3
     (nothing is written for a missing stage).
 
 === Split index
@@ -211,8 +213,8 @@ Git index format
 
   The extension consists of:
 
-  - 160-bit SHA-1 of the shared index file. The shared index file path
-    is $GIT_DIR/sharedindex.<SHA-1>. If all 160 bits are zero, the
+  - Hash of the shared index file. The shared index file path
+    is $GIT_DIR/sharedindex.<hash>. If all bits are zero, the
     index does not require a shared index file.
 
   - An ewah-encoded delete bitmap, each bit represents an entry in the
@@ -253,10 +255,10 @@ Git index format
 
   - 32-bit dir_flags (see struct dir_struct)
 
-  - 160-bit SHA-1 of $GIT_DIR/info/exclude. Null SHA-1 means the file
+  - Hash of $GIT_DIR/info/exclude. A null hash means the file
     does not exist.
 
-  - 160-bit SHA-1 of core.excludesfile. Null SHA-1 means the file does
+  - Hash of core.excludesfile. A null hash means the file does
     not exist.
 
   - NUL-terminated string of per-dir exclude file name. This usually
@@ -285,13 +287,13 @@ The remaining data of each directory block is grouped by type:
   - An ewah bitmap, the n-th bit records "check-only" bit of
     read_directory_recursive() for the n-th directory.
 
-  - An ewah bitmap, the n-th bit indicates whether SHA-1 and stat data
+  - An ewah bitmap, the n-th bit indicates whether hash and stat data
     is valid for the n-th directory and exists in the next data.
 
   - An array of stat data. The n-th data corresponds with the n-th
     "one" bit in the previous ewah bitmap.
 
-  - An array of SHA-1. The n-th SHA-1 corresponds with the n-th "one" bit
+  - An array of hashes. The n-th hash corresponds with the n-th "one" bit
     in the previous ewah bitmap.
 
   - One NUL.
@@ -330,12 +332,12 @@ The remaining data of each directory block is grouped by type:
 
   - 32-bit offset to the end of the index entries
 
-  - 160-bit SHA-1 over the extension types and their sizes (but not
+  - Hash over the extension types and their sizes (but not
 	their contents).  E.g. if we have "TREE" extension that is N-bytes
 	long, "REUC" extension that is M-bytes long, followed by "EOIE",
 	then the hash would be:
 
-	SHA-1("TREE" + <binary representation of N> +
+	Hash("TREE" + <binary representation of N> +
 		"REUC" + <binary representation of M>)
 
 == Index Entry Offset Table
-- 
2.28.0.297.g1956fa8f8d

