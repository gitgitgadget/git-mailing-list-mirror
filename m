Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE06C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 14:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244700AbiCWOUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 10:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244697AbiCWOUU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 10:20:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3936D7CDC0
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:18:51 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m30so2377166wrb.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HIwBEui+mBuahqG4gyWGQKaoY0BcWnAnpQS93bYyQrA=;
        b=NALxmF1I9XcTIbiTUvUzBilyD9Hjncpn7CJs6qsapc9nhzXLdk71BqsxbyQ7wml5pM
         FyflGjp/6jWGAghA9DwHdQHs50fLKfkyVXwauy+Pnc1pUMmfWXQyi0kKIlv5EV0tfc0X
         kGu0GJsnpf7wcfqVGlKuVpQfUaiZCY6tyESr6C4IRrVe3DG4ftoFUMKj96kbtINFn7QI
         de1/W+VRgZQC7FyoZxj78v+L6/5/ZZYM6OXuSs73ByO6BJiXyi/QL1UMqFkbNoEmANfI
         zF/nj/cEOBnyZ+Dhe+U/kPPMS1MRzOoIKVG177VZ0ihaAaLsxVI4C+j3DvUA1aBrYI+l
         QAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HIwBEui+mBuahqG4gyWGQKaoY0BcWnAnpQS93bYyQrA=;
        b=P64aYmDb2YE5fQEDlankMuCZ9RAebfelGkv/VREmJq19IgC6qEWO/Deqj6ApEt9Zau
         fFNLVvPifvdQA2kSqwB9Qfy/KCfjKyxmqWtjck0pPEMWu3xN81Mbn+dWmEbJAbQVYxY5
         Yaz8LIof4Dni0LBAXw4laU59FSkU1oD6W09D+Q0S+fFDdKGOsyPIRL5aLU7MiPLva9K6
         6MOhd2KMleNTZ9qw+vhJVnp22SpJIM+Rs8GoqDay/zoEZ6ycoMJB+HUdLxRY0JOi2c//
         JeUf+2g8bInW8iEOo/srpApLch5o3Magd2ubX2KN9lYzG+AYelotf6RA2av9f7p2tS/J
         KtDA==
X-Gm-Message-State: AOAM531Qknw5zsq9w/3UxXlVh+NcW6+bWai0dR+HeLO/o7MGI0HVDWNb
        fzfdiZypuSRvPqzWR5hSAi5TCjPZbCBJgQ==
X-Google-Smtp-Source: ABdhPJwyBIeRupjT71R+CEr5khJgmvFBGfmuGllL/pP3EcgfHnLLThckxHHKrULrSVjR6CvlD8MbuQ==
X-Received: by 2002:adf:fa87:0:b0:203:f28e:76c3 with SMTP id h7-20020adffa87000000b00203f28e76c3mr23283665wrr.579.1648045129543;
        Wed, 23 Mar 2022 07:18:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm30592wmq.46.2022.03.23.07.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 07:18:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Neeraj Singh <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 6/7] fsync docs: update for new syncing semantics
Date:   Wed, 23 Mar 2022 15:18:30 +0100
Message-Id: <RFC-patch-v2-6.7-c20301d7967-20220323T140753Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1428.g1c1a0152d61
In-Reply-To: <RFC-cover-v2-0.7-00000000000-20220323T140753Z-avarab@gmail.com>
References: <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com> <RFC-cover-v2-0.7-00000000000-20220323T140753Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/core.txt | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index cf0e9b8b088..f598925b597 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -596,12 +596,23 @@ core.fsyncMethod::
   filesystem and storage hardware, data added to the repository may not be
   durable in the event of a system crash. This is the default mode on macOS.
 * `batch` enables a mode that uses writeout-only flushes to stage multiple
-  updates in the disk writeback cache and then does a single full fsync of
-  a dummy file to trigger the disk cache flush at the end of the operation.
-  Currently `batch` mode only applies to loose-object files. Other repository
-  data is made durable as if `fsync` was specified. This mode is expected to
-  be as safe as `fsync` on macOS for repos stored on HFS+ or APFS filesystems
-  and on Windows for repos stored on NTFS or ReFS filesystems.
+  updates in the disk writeback cache and, before doing a full fsync() of
+  on the "last" file that to trigger the disk cache flush at the end of the
+  operation.
++
+Other repository data is made durable as if `fsync` was
+specified. This mode is expected to be as safe as `fsync` on macOS for
+repos stored on HFS+ or APFS filesystems and on Windows for repos
+stored on NTFS or ReFS filesystems.
++
+The `batch` is currently only applies to loose-object files and will
+kick in when using the linkgit:git-unpack-objects[1] and
+linkgit:update-index[1] commands. Note that the "last" file to be
+synced may be the last object, as in the case of
+linkgit:git-unpack-objects[1], or relevant "index" (or in the future,
+"ref") update, as in the case of linkgit:git-update-index[1]. I.e. the
+batch syncing of the loose objects may be deferred until a subsequent
+fsync() to a file that makes them "active".
 
 core.fsyncObjectFiles::
 	This boolean will enable 'fsync()' when writing object files.
-- 
2.35.1.1428.g1c1a0152d61

