Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8291C4CECD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D79A206E2
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uIruSD0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgD0UUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726426AbgD0UUc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 16:20:32 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9069C09B053
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:47 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f13so22016087wrm.13
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bMqfVV0Jthx0FbzkxthTP1FYgECiPP01IK56yDoGvRw=;
        b=uIruSD0F6WGfBspnfIXrcKd8i1BCl9oPkcRUyydC1i/pENLb7kkn/u4w/v93exq/6g
         klG5q9eHpKq1tSmNrO0y7Yy5hZBf5VOCQtRXkY+aJGGQTO6oegiV+V5Kq5gvzJt9htkv
         sx0BVH6llUz3nt+5c8oHf4e19o4iQMF5cjQ5jCIbFQ8wjo9cy5McHoXKySIicYG5/D2h
         bxvqw6rGLzTNKg5MQHbB76VQt6iGn/3yW4Zyh96+lQb0GBxvk6mJFjGulWYKrKObsEKF
         zfV3+CaxOmSAUpDH+OFPE22aBdWpnL5VyQZ0KIJD4CIcPBHW8bDFPVkoDSC1rFeBxKIH
         fzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bMqfVV0Jthx0FbzkxthTP1FYgECiPP01IK56yDoGvRw=;
        b=JIY3hVdPo4Qig/wQrN0+40W+60/zFy93mjI2+CW+okD4dOPCMsF7C1L3LQzgkziVdv
         AWLJe3wKxqhQyTr3mJ32alrTgJF30RDkyw+fqa4/9JhLWsIxaFw+01b4uA8lMTB5k2gd
         rGebCTdmvDDUwJ45KhdFenpcSAjYtmZrfYu09ufcVpeRerNyW8w0m00BQSYgH6g8RiDQ
         X7GHajRKjXDTm6Pv49owWbqA044CWT1ycYZ/3iniVAzwOgpttg+o63m8NuGobiDFus3K
         uzq+c8ncWAB3RjHy86qtSrAd7ylw2YknsW6o2hqmRxSvovK52cGOT3PYvXBx7P7verF2
         1xZQ==
X-Gm-Message-State: AGi0PuZ9/wL0YxVtuJQi2cC8nFj9ZSgFNgR/BdqH+/8s43RUnA6ven4S
        yo4y6FtQrp5f1xoyCfycmz23OELX
X-Google-Smtp-Source: APiQypKXGntCpdETls7HzXKrNL+CrU62GEBuwTI6rvRIIxyF+4mWnnSCURitOSQa+8iiRjjVZLs6OA==
X-Received: by 2002:adf:e702:: with SMTP id c2mr29700745wrm.252.1588018426466;
        Mon, 27 Apr 2020 13:13:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm307718wmi.27.2020.04.27.13.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:13:46 -0700 (PDT)
Message-Id: <5ebc272e23d36273e2ab74510f18395d7badd988.1588018418.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
        <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Apr 2020 20:13:33 +0000
Subject: [PATCH v10 07/12] reftable: define version 2 of the spec to
 accomodate SHA256
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Documentation/technical/reftable.txt | 50 ++++++++++++++++------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/Documentation/technical/reftable.txt b/Documentation/technical/reftable.txt
index 9fa4657d9ff..ee3f36ea851 100644
--- a/Documentation/technical/reftable.txt
+++ b/Documentation/technical/reftable.txt
@@ -193,8 +193,8 @@ and non-aligned files.
 Very small files (e.g. 1 only ref block) may omit `padding` and the ref
 index to reduce total file size.
 
-Header
-^^^^^^
+Header (version 1)
+^^^^^^^^^^^^^^^^^^
 
 A 24-byte header appears at the beginning of the file:
 
@@ -215,6 +215,24 @@ used in a stack for link:#Update-transactions[transactions], these
 fields can order the files such that the prior file’s
 `max_update_index + 1` is the next file’s `min_update_index`.
 
+Header (version 2)
+^^^^^^^^^^^^^^^^^^
+
+A 28-byte header appears at the beginning of the file:
+
+....
+'REFT'
+uint8( version_number = 1 )
+uint24( block_size )
+uint64( min_update_index )
+uint64( max_update_index )
+uint32( hash_id )
+....
+
+The header is identical to `version_number=1`, with the 4-byte hash ID
+("sha1" for SHA1 and "s256" for SHA-256) append to the header.
+
+
 First ref block
 ^^^^^^^^^^^^^^^
 
@@ -671,14 +689,8 @@ Footer
 After the last block of the file, a file footer is written. It begins
 like the file header, but is extended with additional data.
 
-A 68-byte footer appears at the end:
-
 ....
-    'REFT'
-    uint8( version_number = 1 )
-    uint24( block_size )
-    uint64( min_update_index )
-    uint64( max_update_index )
+    HEADER
 
     uint64( ref_index_position )
     uint64( (obj_position << 5) | obj_id_len )
@@ -701,12 +713,16 @@ obj blocks.
 * `obj_index_position`: byte position for the start of the obj index.
 * `log_index_position`: byte position for the start of the log index.
 
+The size of the footer is 68 bytes for version 1, and 72 bytes for
+version 2.
+
 Reading the footer
 ++++++++++++++++++
 
-Readers must seek to `file_length - 68` to access the footer. A trusted
-external source (such as `stat(2)`) is necessary to obtain
-`file_length`. When reading the footer, readers must verify:
+Readers must first read the file start to determine the version
+number. Then they seek to `file_length - FOOTER_LENGTH` to access the
+footer. A trusted external source (such as `stat(2)`) is necessary to
+obtain `file_length`. When reading the footer, readers must verify:
 
 * 4-byte magic is correct
 * 1-byte version number is recognized
@@ -1055,13 +1071,3 @@ impossible.
 
 A common format that can be supported by all major Git implementations
 (git-core, JGit, libgit2) is strongly preferred.
-
-Future
-~~~~~~
-
-Longer hashes
-^^^^^^^^^^^^^
-
-Version will bump (e.g. 2) to indicate `value` uses a different object
-id length other than 20. The length could be stored in an expanded file
-header, or hardcoded as part of the version.
-- 
gitgitgadget

