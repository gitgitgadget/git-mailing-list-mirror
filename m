Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDE2C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 09:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE63D20870
	for <git@archiver.kernel.org>; Thu,  7 May 2020 09:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQABtJ62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEGJ74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 05:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725900AbgEGJ7z (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 05:59:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C157DC061A41
        for <git@vger.kernel.org>; Thu,  7 May 2020 02:59:54 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e16so5602546wra.7
        for <git@vger.kernel.org>; Thu, 07 May 2020 02:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bMqfVV0Jthx0FbzkxthTP1FYgECiPP01IK56yDoGvRw=;
        b=CQABtJ62FKBy4I4kOXy49Yzq8Zq+j3n2yu4BU9C5ui7go2w6BRvY+F9FnuFiBUAql3
         b3KgXYdmeDPLtBO/AWHQcqWL924VuROxEhoc3loKyxwe6KYRrQbndXVU7CiGT9H0OUtH
         5bCXZlk4TAnhrJ1keolL0JceSn6RLK4ZStENfpQuEEocplB86T53sC1C6ku9luAt1yhj
         ocEtv3lOz8l/xiUcgnvAAAsuLwfXNubmRlMFOnL612+9YHVHy2p/3t+b7GuuKq4nVRYt
         KB1vdVJnI9KGWMyQOd1EFbRvjcmHSFrXU66qzXJRV+6+qBaI3UZBiWhzY5uXyK6KnSsg
         d3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bMqfVV0Jthx0FbzkxthTP1FYgECiPP01IK56yDoGvRw=;
        b=eeUcI/DYZXHKcyHqwO4cdqFHt0/4w0nchu5ov2w/KaMGjNlykajPrC8T8aC7FE3uKZ
         8eB0NK+uOGg3hB4qQai+9O3OY6Pt4e2GA1AGlXhO4dd4E/kf7JygBacjx6namwjSoEZq
         NDOTksCVxJ8x/qy2W87DPO/+gWFxFKsowb0cRtl9/Dn0Ea8MhGfy4UlSnCM7J/kzD4Gb
         iZexlVXFDd8hXlHcbL42TbSQlt0kKoHupBVDD0MXtMGF4g/FR5k9qCKp4YWVhRin76fh
         22d+prWLrgmMcq4glegEU97Bv6asvwZrpD6cUtjirsVsVsY9uXfw6AJgYRLAzRm2U0RF
         eJ3w==
X-Gm-Message-State: AGi0PubdAW3PLphZ93sKD5H2CpIBW10/gJznbGmxyFdiogNPbIvrA0Pg
        ZK2ePT+43pOEJfW9yI+TOx9og5ND
X-Google-Smtp-Source: APiQypLnWeEeBcKie3yXTk2j/4DEPazD6gHpxagBd6nFSaZgas/mbxR+HZKRGyZPhP88wLx/soXWPw==
X-Received: by 2002:a5d:4248:: with SMTP id s8mr14274186wrr.216.1588845593401;
        Thu, 07 May 2020 02:59:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t67sm7957295wmg.40.2020.05.07.02.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 02:59:52 -0700 (PDT)
Message-Id: <093fa74a3d0e7721093cceb338e8efc9c0c95b1c.1588845586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
References: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
        <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 09:59:39 +0000
Subject: [PATCH v12 06/12] reftable: define version 2 of the spec to
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

