Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898AEC55182
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 21:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C1B20782
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 21:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jv3UqcX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgDTVPH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbgDTVPE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 17:15:04 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FD2C061A0C
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 14:15:04 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id k22so4250227eds.6
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 14:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bMqfVV0Jthx0FbzkxthTP1FYgECiPP01IK56yDoGvRw=;
        b=jv3UqcX3Xd3vVkKb4RHEGqgP7kPrbS20bAPcCkYhFfMU3ca5VBrHzEHnN35P9J2JAO
         p/O6mgZmDmKEqhJhwPfXISzh+Acype5qYDjzlKxG6glRfRKPHnPYEIJsSuzAFov9OtDZ
         1Mu2q64kHjEooBClufzP+/9Dw98FA/oQKA1KvV/plNo1VXBiHBi/1TLqZoXYIP2geP5n
         Ls6dtwyeSbIJvwWuuvv3en/qEnTqmUY9RBZWxLSojqOLmbePiECCueQcKJlKDYpo/OhI
         RVfI138gw8hWkmkpdgHqfuzvin0q4sOZh07ckSlg1D0C+Ufqo/GcNUlX00BNSdgRjaS+
         K3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bMqfVV0Jthx0FbzkxthTP1FYgECiPP01IK56yDoGvRw=;
        b=oOsao7z3oxvOVWvPWLenscb2b/aLxz5O92pSDBN82kOo/2qTaVbmW5/s7o0OQn1Bdf
         GQeUl6nBhk7XesbEUNJZqlviUCNTLR+t5U9PM7hoN11gFF9MC/lvk6347F0o2giwiNmr
         o+TweUdf2EIu5LJz7TeM+9ZmJo16m9arXgw39FbJgjtd8s1AsgHLPtaNj4wcnicoAhpW
         LIj92CQCpChsaXOrqw2DrEU2IQZZnaxRzusexyVtFvuMXu5ZmIcZ/L7VqY9U4EXRBpYy
         6M+XzS4UM3+U7NsownJl3CaI2bvTWJaeD36RgslRbSjNjBMsDxcr9+C/8NFzJi9hfef2
         vCgA==
X-Gm-Message-State: AGi0PubJ8O2ivGJP02kH4BekyeAxTDSc2Ngmmgv/yw6JA75iwILo6ji4
        P8slN1myuyhj7NQUYV9Nh2zAhz6l
X-Google-Smtp-Source: APiQypLfqO9a0KRmmywXyDF3oqzboobAZbmgWyF6gcUm3oIBU+SlzpQpHaFHGNChh6KzXMYiLw9D3g==
X-Received: by 2002:a05:6402:684:: with SMTP id f4mr16543330edy.240.1587417302623;
        Mon, 20 Apr 2020 14:15:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n10sm58738edf.3.2020.04.20.14.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:15:02 -0700 (PDT)
Message-Id: <3e418d27f678ffcad639274bbb3c6118d79e05e5.1587417295.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
References: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
        <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Apr 2020 21:14:52 +0000
Subject: [PATCH v9 07/10] reftable: define version 2 of the spec to accomodate
 SHA256
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

