Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011EFC433ED
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D354E6128E
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbhDMJnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 05:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhDMJnn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 05:43:43 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A03C061574
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:43:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x7so15733880wrw.10
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B7Skdl598Kk/2UxDv634BhVpH08Ubu6bc8iCsqZpGbA=;
        b=r7CCrThUJH118VWK6y0ThTeZpwyn+eT27f7s/AtVazNc16q6ek7s5M61Z815558K15
         dA5KrQLbB6y6Fh4uoxAcyNOz8KPpyGC9EWGRnEDgXOhzA/syv11p/nEGIPu8DoBqK14s
         /uYxKxcborCL8Rfnv+713RRd//gtq3113bvQXABH6hJajFQ/mj+VcW+PE6UYhP+MFJyu
         o2xlQWfe3/mQxGnkBrq5qennbC4FZLxp5kUJpNwGOvy+h9xvHf46KaTriTBDLLFGAQlt
         D/cnrOR2tKe/pKQRUXiYd8ut135EGYXfT+D2vKnYgLfeyZQQPH9UlhPKhijq9qjQ/LLJ
         7SSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B7Skdl598Kk/2UxDv634BhVpH08Ubu6bc8iCsqZpGbA=;
        b=Mobk53qI/z1sVBapz0Ba0xQj3K3hMxEuL1GqAGtknJptTJbXM48jR0H/MVKK/HWCS5
         WzYeDzVq2YqW3HbZA8ALmhwqhQef8K+lBVMzx3qA6orJIajq94FY8pz+6obzrL3JAaRh
         ypjQl8ZrcreVqleu2Ol3GBMT6aNm7SXcyzETShuVcB0Jp4kaumZt8ngqvdFy4PtRvLeh
         MyOMEIrs1taa33vcZ7T+V9uTxeBDf/caQGql1gAriybiy4R9yyPEM2FVUqeSMM/wT4vb
         lWgcgyjrxDodTp1whAAlRpScn44zomAdz+NRfzsxHM306dM5oM6rURmkY9sRXV3yhq7K
         x4Yg==
X-Gm-Message-State: AOAM530v4LeIpy6QFVkL5s/+ooDy/6iZZ7pbLdNYHgC3liwfWhA3Obw0
        mmpvCU9alhPNlMPR42+QbpuTfvWMAEZYZg==
X-Google-Smtp-Source: ABdhPJyaHunalm6etTHAeD8uVQwHDifmzF3Ko4EtyK6AExJKSKIyzvHUWsmFnzDAnGogqfpMYkTioA==
X-Received: by 2002:a05:6000:181b:: with SMTP id m27mr12874240wrh.11.1618307001332;
        Tue, 13 Apr 2021 02:43:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p14sm4622877wrn.49.2021.04.13.02.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:43:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] fsck: better "invalid object" error reporting
Date:   Tue, 13 Apr 2021 11:43:03 +0200
Message-Id: <cover-0.6-00000000000-20210413T093734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.645.g989d83ea6a6
In-Reply-To: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of improved error reporting for fsck-ing bad loose
objects. See [1] for v1.

This is no longer based on the series to add a bug() function, since
as noted in the re-roll of that[2] that function is gone. This version
uses a plain BUG() for that condition.

Other than that the only change is improved commit messages, and I
added a trivial patch to move read_loose_object() around in
object-store.h so I wouldn't need a forward declaration, and updated
the comment for that function.

1. https://lore.kernel.org/git/cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-0.3-00000000000-20210413T090603Z-avarab@gmail.com


Ævar Arnfjörð Bjarmason (6):
  cache.h: move object functions to object-store.h
  fsck tests: refactor one test to use a sub-repo
  fsck: don't hard die on invalid object types
  object-store.h: move read_loose_object() below 'struct object_info'
  fsck: report invalid types recorded in objects
  fsck: report invalid object type-path combinations

 builtin/cat-file.c    |  7 +++--
 builtin/fast-export.c |  2 +-
 builtin/fsck.c        | 28 +++++++++++++++---
 builtin/index-pack.c  |  2 +-
 builtin/mktag.c       |  3 +-
 cache.h               | 10 -------
 object-file.c         | 66 +++++++++++++++++++++----------------------
 object-store.h        | 39 ++++++++++++++++---------
 object.c              |  4 +--
 pack-check.c          |  3 +-
 streaming.c           |  5 +++-
 t/t1450-fsck.sh       | 64 ++++++++++++++++++++++++++++++-----------
 12 files changed, 146 insertions(+), 87 deletions(-)

Range-diff against v1:
1:  f8f00db8d31 = 1:  37c323a2410 cache.h: move object functions to object-store.h
2:  3e547289408 = 2:  5a2cd6cca9c fsck tests: refactor one test to use a sub-repo
3:  74654a01ba3 = 3:  d0d9cb33315 fsck: don't hard die on invalid object types
-:  ----------- > 4:  81fffefcf99 object-store.h: move read_loose_object() below 'struct object_info'
4:  d23fb5cd039 ! 5:  5fb6ac4faee fsck: improve the error on invalid object types
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    fsck: improve the error on invalid object types
    +    fsck: report invalid types recorded in objects
     
         Continue the work in the preceding commit and improve the error on:
     
    @@ object-file.c: int read_loose_object(const char *path,
      			free(*contents);
     
      ## object-store.h ##
    -@@ object-store.h: int force_object_loose(const struct object_id *oid, time_t mtime);
    +@@ object-store.h: int oid_object_info_extended(struct repository *r,
    + 
    + /*
    +  * Open the loose object at path, check its hash, and return the contents,
    ++ * use the "oi" argument to assert things about the object, or e.g. populate its
    +  * type, and size. If the object is a blob, then "contents" may return NULL,
    +  * to allow streaming of large blobs.
       *
    -  * Returns 0 on success, negative on error (details may be written to stderr).
    +@@ object-store.h: int oid_object_info_extended(struct repository *r,
       */
    -+struct object_info;
      int read_loose_object(const char *path,
      		      const struct object_id *expected_oid,
     -		      enum object_type *type,
    @@ object-store.h: int force_object_loose(const struct object_id *oid, time_t mtime
     +		      struct object_info *oi,
      		      unsigned int oi_flags);
      
    - /* Retry packed storage after checking packed and loose storage */
    + /*
     
      ## t/t1450-fsck.sh ##
     @@ t/t1450-fsck.sh: test_expect_success 'object with hash mismatch' '
5:  bcec536b0f6 ! 6:  226d2031bcf fsck: improve error on loose object hash mismatch
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    +    fsck: report invalid object type-path combinations
    +
         fsck: improve error on loose object hash mismatch
     
         Improve the error that's emitted in cases where we find a loose object
    @@ object-file.c: int read_loose_object(const char *path,
     -			      oid_to_hex(expected_oid));
     +					   *contents, *size, oi->type_name->buf, real_oid)) {
     +			if (oideq(real_oid, &null_oid))
    -+				/*
    -+				 * Not a plain BUG() because if it
    -+				 * does happen we're in the middle of
    -+				 * an fsck we'd like to see to the
    -+				 * end.
    -+				 */
    -+				bug("BUG trying to compute hash for object at %s (expected %s)",
    -+				    path, oid_to_hex(expected_oid));
    ++				BUG("should only get OID mismatch errors with mapped contents");
      			free(*contents);
      			goto out;
      		}
     
      ## object-store.h ##
    -@@ object-store.h: int force_object_loose(const struct object_id *oid, time_t mtime);
    - struct object_info;
    +@@ object-store.h: int oid_object_info_extended(struct repository *r,
    +  */
      int read_loose_object(const char *path,
      		      const struct object_id *expected_oid,
     +		      struct object_id *real_oid,
-- 
2.31.1.645.g989d83ea6a6

