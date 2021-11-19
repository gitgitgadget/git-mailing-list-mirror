Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B17C433FE
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7FE61AA2
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbhKSU3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 15:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbhKSU3e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 15:29:34 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F21C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:26:32 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id c4so20063834wrd.9
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L0QyslBvJy5fQX2Yb6x4EkVSsmx8yIk+5/XY2SyqadY=;
        b=QzcNWmrTCOVR0H+Q7DWZPxxhCWcjANqtfRPk4LUoiN5XraUtkjKetrYpKBAq3WHeGV
         nqo6QJIyJ0khRZBktlPPM2RnwgK7nn+bHmusTt8J2iIWDobkrFKxk1Ch0eexhqRI5TeD
         l+mEiKgvneCsm1M/YhZioJyY6ly4uB8QwPnO3xrpgewmZhk9RYJzOho2q64naJz/MeJI
         zkbuW/dl3JgToSMl+f7HHsIFnLI6JQgfKZtvUiYHd72XZ2R1OiGRpi0Aj6+CFTRCR/hy
         qHx9WMtveDipBBiAI9VFHqfeMtBXB0CiOx4m9d6BWTdTv4ObNWvTOCLTS+Q04v3i2v5G
         DmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L0QyslBvJy5fQX2Yb6x4EkVSsmx8yIk+5/XY2SyqadY=;
        b=8CcvRQ1x10HjgxrKb3cDnHer344zA5Ejsd05PobfoyxvCCiZgiRPqGnGkaxFQMQTCd
         CICAXf6xfBcmtOhpFfRNaxjg7349HHA7hnL7IMzTuy0WkS7F8yr+jTuY3CavczLmsa/Z
         ubw9GK9qbYCge560FZvzE1DZG/xKJ+fVorXPu/pbROcPsqrtzndnGPL+kf3NJtVGOSFb
         25afltgcXjDvgBpJiWsJ71TrHfZND8iXPCzj5GsiHWjs5RbW0RmqgoAZJHYoI6PeYJux
         zJs8i+fN1zw9GyVDWOaGPKFHdTU/QTdYdA4dNaHrnkjcBOlWFeOBfKqPv1/IBoW8x5R+
         2LLg==
X-Gm-Message-State: AOAM532XTNUmKMccVhm0UuSsdYzc6xNTWirmq9FKXudPFHF+mLBphpk1
        JakbzmHjrGLksmgjfYp+3hWSs3qQWAgh5Q==
X-Google-Smtp-Source: ABdhPJytKNXOUq9fsNK0PMndAkfevcEX37DwX7KvpDzg9fHq6EU1fVUVPEdtgyzBcQkCyqLUUOzUpg==
X-Received: by 2002:a5d:64af:: with SMTP id m15mr11042157wrp.267.1637353590144;
        Fri, 19 Nov 2021 12:26:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg14sm856202wmb.5.2021.11.19.12.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 12:26:29 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] object-store.h: remove unused has_sha1_file*()
Date:   Fri, 19 Nov 2021 21:26:23 +0100
Message-Id: <patch-v2-3.5-6d0ca249001-20211119T202455Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.823.gcc3243ae16c
In-Reply-To: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These macros were last used in 5d3679ee023 (sha1-file: drop
has_sha1_file(), 2019-01-07), so let's remove coccinelle migration
rules added 9b45f499818 (object-store: prepare has_{sha1, object}_file
to handle any repo, 2018-11-13), along with the compatibility macros
themselves.

The "These functions.." in the diff context and the general comment
about compatibility macros still applies to
"NO_THE_REPOSITORY_COMPATIBILITY_MACROS" use just a few lines below
this, so let's keep the comment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/coccinelle/the_repository.pending.cocci | 15 ---------------
 object-store.h                                  |  4 ----
 2 files changed, 19 deletions(-)

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 2ee702ecf7f..072ea0d9228 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -11,21 +11,6 @@ expression G;
 + repo_read_object_file(the_repository,
   E, F, G)
 
-@@
-expression E;
-@@
-- has_sha1_file(
-+ repo_has_sha1_file(the_repository,
-  E)
-
-@@
-expression E;
-expression F;
-@@
-- has_sha1_file_with_flags(
-+ repo_has_sha1_file_with_flags(the_repository,
-  E)
-
 @@
 expression E;
 @@
diff --git a/object-store.h b/object-store.h
index 952efb6a4be..1717f73eea3 100644
--- a/object-store.h
+++ b/object-store.h
@@ -286,10 +286,6 @@ int has_object(struct repository *r, const struct object_id *oid,
  * These functions can be removed once all callers have migrated to
  * has_object() and/or oid_object_info_extended().
  */
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
-#define has_sha1_file_with_flags(sha1, flags) repo_has_sha1_file_with_flags(the_repository, sha1, flags)
-#define has_sha1_file(sha1) repo_has_sha1_file(the_repository, sha1)
-#endif
 int repo_has_object_file(struct repository *r, const struct object_id *oid);
 int repo_has_object_file_with_flags(struct repository *r,
 				    const struct object_id *oid, int flags);
-- 
2.34.0.823.gcc3243ae16c

