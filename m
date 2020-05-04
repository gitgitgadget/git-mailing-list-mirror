Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20FAC4724C
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6523206B8
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qftBskmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgEDTD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 15:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726796AbgEDTD5 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 15:03:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A98C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 12:03:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k1so351342wro.12
        for <git@vger.kernel.org>; Mon, 04 May 2020 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bMqfVV0Jthx0FbzkxthTP1FYgECiPP01IK56yDoGvRw=;
        b=qftBskmpQdJ2dtpmo+99Shib0FBG0ArLS2v6EwD+7YaBYEeLT6BczicpQl6cee2883
         dEK5A3kQu0w9Zkm97tbr+tGtyGiEudpQ2v7AWtMIDYjNsUdGuCEOLVPU0ils9+zZdC/J
         Ysc3mShw1kjt0KclrDsmmxBPeO2KZXPJlYJIixvTR0aBF686rIftCXksMoQ8XPXxwH76
         cmgd84mNflZgGXgoDUo+VYfLFK13R562aYxCf1e6zhILsb4TBCODr6Alt0ZouazFTwtW
         H92Lsjbx41lHqalHXmcRDcsVefesBV9MS23K6htPVD67hp9AaGS0n0ql7udm2Jx7VnwM
         0fTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bMqfVV0Jthx0FbzkxthTP1FYgECiPP01IK56yDoGvRw=;
        b=WGwnlqr4wUabRc3xozCioGwXVRS+ZVTpdb6kf2nuCF7JA7RSlNUgnPyWpCcE6fbyt5
         OAO32ZQynGRsdjj7U0yPIgtm1zQ7t8pALrGLik2ZmMBw2b57EPfl0Jz62HSJz3Jwb760
         hhfpR+XvRfSLOU8mVyyok1Syg5p3ldDiZ1irkTluS3dlPGJUcZVDtPCXDtaiRM1ZYWFp
         6JF6x1CH4IAbvxGC0rcDOVTFUXaKfV2TwWt7RrvrY/nzbvn9q6J0teHdupYref9EzCxu
         cE6iDRk9oqE4jmCP+wK01gbWfRdY3J2voXMEMlARlBNVehjLpSw9j7Qw/Mfx/eIlEmeu
         txgw==
X-Gm-Message-State: AGi0PuYOhavEzDzbsNAjodIpYefZrw0/JGJQyFzk1Vx4AyE6DlZAz45p
        YFtPeNVfGiK9uDNg9ykP5Fny9PCv
X-Google-Smtp-Source: APiQypI/L49P/15zcBQNfoyRtY+symao+5Fn4+NyqkbZbL1+5jbn5i0XQnIjtpw867y7q9Pru4WnCA==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr543940wrq.171.1588619035702;
        Mon, 04 May 2020 12:03:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l19sm606604wmj.14.2020.05.04.12.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:03:55 -0700 (PDT)
Message-Id: <093fa74a3d0e7721093cceb338e8efc9c0c95b1c.1588619028.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
References: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
        <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 19:03:42 +0000
Subject: [PATCH v11 06/12] reftable: define version 2 of the spec to
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

