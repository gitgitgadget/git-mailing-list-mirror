Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB05C433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 11:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3FB52075D
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 11:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjEvDG72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgHKLuE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgHKLuE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 07:50:04 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4453FC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 04:50:04 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o5so6607273pgb.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 04:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vTCpDrGSqwFEZaAeWHHje+rhD9i998mF0in3s1ln42I=;
        b=BjEvDG72CLgmo4uYY3tmsTbxoARbX/4MdtFXZ4JMSUKTlkaAmIdxwCTtVdhfMjdmYq
         Ps9X0aiUWuC8qMWyW73A3vpEv7qTKFM/R1sADMRLn07tBHnzn2F0QLUm+GH7l4HBqTBe
         86oP5Aw2c5SlPrwJPma5nAkXhFTQx2c6owHw07UNBXAaeaXF1cijV5WPTzHc+LvEWjKs
         p2ETqJZAbnVjMlMrph9w55H3nzLtuM6EOJzv0SPb7lOLy8RPH9gO6DlUqSSH6pr4u+OQ
         H+A4M0JA968uDnm6ETAspcgBPn0ntaBOBiY/gK72nFpLJsQ7tUIx4ZJ/uK9ZuFoI5VG7
         9fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vTCpDrGSqwFEZaAeWHHje+rhD9i998mF0in3s1ln42I=;
        b=uB4WtuQy11EWYjSkxqAE7nDoEbSWkJEankDgzLCX1rygAi1eZB2Vf8JpTOqCIH591M
         NSJlt179zdZ3oaiqe/F5dC2+KCsTY+6vJ75BV0fMahzxQCM3aa8DOaYH8ukVhCwglGa6
         CKE2Jn3jkTUksd1NAE0IarRkLkp/SUZc3OjX221Y6RjLa85WaQ9msLPDyuiR18jG48mF
         mP5N+oQx02ixwJTgIVfpC1169uJIiLWrEjlJpI0Vubzt/7W7fnxEQb/uK+DVNwYyEdZm
         rMn0GiB3HQEwq15p4sGGrb/VAl4R1G8v37t2Wn3PKQHDXkBEoCC/RMLYNDNCKU6P99qc
         u5MA==
X-Gm-Message-State: AOAM532aemdya+2auAcU/+7UV60ZjaOSWAaLkVz2BLIpIywTMMRZxkTU
        SOf2NUoJfqBS08GrdvMGN9Wb03bE
X-Google-Smtp-Source: ABdhPJzCi0DWgQvYv1TzEfOxlMT/VG+vgdK/mhAKK8KcktDxAIPWMtcskBLwYRK20r71jCHntvJzkw==
X-Received: by 2002:a62:7853:: with SMTP id t80mr5887654pfc.47.1597146602856;
        Tue, 11 Aug 2020 04:50:02 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:ea17:7ad5:df16:a252:473b])
        by smtp.gmail.com with ESMTPSA id q73sm3019220pjc.11.2020.08.11.04.50.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2020 04:50:02 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 0/2] diff: index-line: respect --abbrev in object's name
Date:   Tue, 11 Aug 2020 18:49:55 +0700
Message-Id: <cover.1597146478.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.28.0.215.g32ffa52ee0
In-Reply-To: <cover.1596887883.git.congdanhqx@gmail.com>
References: <cover.1596887883.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For diff-family, Git supports 2 different options for 2 different
purposes, `--full-index' for showing diff-patch object's name in full,
and `--abbrev' to customize the length of object names in diff-raw and
diff-tree header lines, without any options to customise the length of
object names in diff-patch format. When working with diff-patch format,
we only have two options, either full index, or default abbrev length.

Although, that consistent is documented, it doesn't stop users from
trying to use `--abbrev' with the hope of customising diff-patch's
objects' name's abbreviation.

Let's resolve that inconsistency.

Đoàn Trần Công Danh (2):
  revision: differentiate if --no-abbrev asked explicitly
  diff: index-line: respect --abbrev in object's name

 Documentation/diff-options.txt                |  9 +++---
 diff.c                                        |  5 +++-
 revision.c                                    |  2 +-
 t/t4013-diff-various.sh                       |  3 ++
 ...ff.diff-tree_--root_-p_--abbrev=10_initial | 29 +++++++++++++++++++
 ...--root_-p_--full-index_--abbrev=10_initial | 29 +++++++++++++++++++
 ...f.diff-tree_--root_-p_--full-index_initial | 29 +++++++++++++++++++
 7 files changed, 100 insertions(+), 6 deletions(-)
 create mode 100644 t/t4013/diff.diff-tree_--root_-p_--abbrev=10_initial
 create mode 100644 t/t4013/diff.diff-tree_--root_-p_--full-index_--abbrev=10_initial
 create mode 100644 t/t4013/diff.diff-tree_--root_-p_--full-index_initial

Range-diff against v1:
1:  9daef7445c = 1:  9daef7445c revision: differentiate if --no-abbrev asked explicitly
2:  9146313893 ! 2:  12acf1fe5d diff: extend --abbrev support to diff-patch format
    @@ Metadata
     Author: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## Commit message ##
    -    diff: extend --abbrev support to diff-patch format
    +    diff: index-line: respect --abbrev in object's name
    +
    +    A handful of Git's commands respect `--abbrev' for customizing length
    +    of abbreviation of object names.
    +
    +    For diff-family, Git supports 2 different options for 2 different
    +    purposes, `--full-index' for showing diff-patch object's name in full,
    +    and `--abbrev' to customize the length of object names in diff-raw and
    +    diff-tree header lines, without any options to customise the length of
    +    object names in diff-patch format. When working with diff-patch format,
    +    we only have two options, either full index, or default abbrev length.
    +
    +    Although, that consistent is documented, it doesn't stop users from
    +    trying to use `--abbrev' with the hope of customising diff-patch's
    +    objects' name's abbreviation.
    +
    +    Let's resolve that inconsistency.
    +
    +    To preserve backward compatibility with old script that specify both
    +    `--full-index' and `--abbrev', always shows full object id
    +    if `--full-index' is specified.
     
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
-- 
2.28.0.215.g32ffa52ee0

