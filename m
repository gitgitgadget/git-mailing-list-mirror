Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89028C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67245221E2
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bazBWcTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgHNMWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNMWG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 08:22:06 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCFBC061384
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:22:06 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id j22so4721928lfm.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 05:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tfmhAfPmIVuMWkZ16DBb8rYS5b1h4XnU3c5h04A27X0=;
        b=bazBWcTZXU/pz1eClRxYjZ+Q3Bj+vv2kvZnlfl2/LowIcjJm4WvaUDl1iQEgvAVgRh
         wd+9t9Q3IKBuq+Iucna0ECcn8yVkrY2GpFlQGv9qcmw7Z4PIhr2tKJNwrXi5Fd6DoZs3
         iQPWwlEp1IXbVKmBK4AisR+vQ1pbdUUKbCuARptPfH742mWdlHw+9IrcGBQSI4ww0Mwo
         8wNNWskUt7HykNtZQ3zj5BsqrxYqnZMU2fMRy2gPZ4iR9n1YFuaTg7T6Wt+lxC972Tvl
         OQ73R9/Ymdj94EOTYj2Z6Hgr30CvJ1KPNxYCpTixls3NS0ZK7Ss4htfl4ZhtTVyu+/o8
         W8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tfmhAfPmIVuMWkZ16DBb8rYS5b1h4XnU3c5h04A27X0=;
        b=Qf154ODQQqRTBRaY2AZaajPkUdD2EbO2uHD6RkSX3+mH2z3I0Pi6N1kuh4ovDBqaUh
         SgdXoesF4u8EC3+iZP+0ewHjh+c7DndxQgR0Po/7oepRJ08WC8S/gwge7dBRv8FEFHRo
         KYPvR/rX8xOJsokGPN36xwnGw/v4+CSotOCH8z+2O0tO6AABTzQUw+COFhX+gvFzhiXM
         DpxeNUeCozyYSkypUaD7GWYEHfEg4nvDzh+lQnLvR9mH2VAU8mzjV6FYS4fcO1d3iLNG
         VqVAUirL+YFrQNi59JLED5VB9979qzN0aElSdiIH4cO2ixu4/QCREXD7Sm0CBGk9OtBN
         VoSw==
X-Gm-Message-State: AOAM531Rho67p0q3gKYVfu7kMCJSrh2d4dpSfQlIPKIk6UOJPM9dkme7
        PnOeDe/pdO+PNXEFySEj2JoZ12rbig0=
X-Google-Smtp-Source: ABdhPJx7HEhSu5qS0rjraKh350loiiH7gGDQfgCHJSHDHIQnfXF6JzRbqvQ+gPRRbn9mbCvnT4nPOQ==
X-Received: by 2002:a19:c6c6:: with SMTP id w189mr1130025lff.75.1597407724529;
        Fri, 14 Aug 2020 05:22:04 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id o2sm1847407lfi.50.2020.08.14.05.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 05:22:04 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] index-format.txt: document SHA-256 index format
Date:   Fri, 14 Aug 2020 14:21:43 +0200
Message-Id: <e811455d55cdb222a85d880f3cf3d5e28a8d4c91.1597406877.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <cover.1597406877.git.martin.agren@gmail.com>
References: <20200813224901.2652387-1-sandals@crustytoothpaste.net> <cover.1597406877.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to a recent commit, document that in SHA-1 repositories, we use
SHA-1 and in SHA-256 repositories, we use SHA-256, then replace all
other uses of "SHA-1" with something more neutral.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/technical/index-format.txt | 27 +++++++++++++-----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index faa25c5c52..827ece2ed1 100644
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
 
@@ -32,7 +35,7 @@ Git index format
 
      Extension data
 
-   - 160-bit SHA-1 over the content of the index file before this
+   - 160-bit hash checksum over the content of the index file before this
      checksum.
 
 == Index entry
@@ -80,7 +83,7 @@ Git index format
   32-bit file size
     This is the on-disk size from stat(2), truncated to 32-bit.
 
-  160-bit SHA-1 for the represented object
+  160-bit object name for the represented object
 
   A 16-bit 'flags' field split into (high to low bits)
 
@@ -211,8 +214,8 @@ Git index format
 
   The extension consists of:
 
-  - 160-bit SHA-1 of the shared index file. The shared index file path
-    is $GIT_DIR/sharedindex.<SHA-1>. If all 160 bits are zero, the
+  - Hash of the shared index file. The shared index file path
+    is $GIT_DIR/sharedindex.<hash>. If all bits are zero, the
     index does not require a shared index file.
 
   - An ewah-encoded delete bitmap, each bit represents an entry in the
@@ -253,10 +256,10 @@ Git index format
 
   - 32-bit dir_flags (see struct dir_struct)
 
-  - 160-bit SHA-1 of $GIT_DIR/info/exclude. Null SHA-1 means the file
+  - Hash of $GIT_DIR/info/exclude. A null hash means the file
     does not exist.
 
-  - 160-bit SHA-1 of core.excludesfile. Null SHA-1 means the file does
+  - Hash of core.excludesfile. A null hash means the file does
     not exist.
 
   - NUL-terminated string of per-dir exclude file name. This usually
@@ -285,13 +288,13 @@ The remaining data of each directory block is grouped by type:
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
@@ -330,12 +333,12 @@ The remaining data of each directory block is grouped by type:
 
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
2.28.0.277.g9b3c35fffd

