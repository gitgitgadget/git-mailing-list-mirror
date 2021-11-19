Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B03C433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD4361AD0
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 12:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbhKSMtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 07:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbhKSMti (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 07:49:38 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB6DC06173E
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:46:36 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id s13so18003357wrb.3
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 04:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ItZ4oK0ZnArLm3JvM6PldTfHNF21/G9rtklDqBfFvEU=;
        b=Qd/d2Xebn10Wyl787z1sMnOYEtAjM+tOXDtCF4CSvuRJJGITxCblElgwBc39SgnBOu
         0KSgVJhHRDMGxO7NmHub8fSA+z8/ErfeWDv6znHxdeIWHSqseEUBNmxuEsDKYdGUgJXW
         RKXmD8Z5pGXUIUH7b676WvWLWwXY7ipBAbo2pyCzi23f6D47A1Zv337mWcKzpeftFrWJ
         08xiO9upecG4gw3nsxoNg+zEW4xTbV8Tx2T1QwZVZJjh1fLu0P5IImOeGlvGeemT+yBB
         rOERNnsNK8PgtAfKF68dtUdgh0jc8juma0ubr66UCrDZ2jgKCNl/82OLjNED4gmTiRCu
         qKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ItZ4oK0ZnArLm3JvM6PldTfHNF21/G9rtklDqBfFvEU=;
        b=h6aNjnV+VkG0B8JsQ5ZXUjhSiJAwLbFIw2GImTUgxyHsr475VYvn/pHz1MW6LfJ5bN
         PiTtaQc09NaXwb0B4BLjEBJmwlZHttPNOqYQJV6Aofcuf3JBuIz/CyK16/wzGq4H1evI
         FEPkQB/AFUOWiDqZr/ORFe8sfjSHqNK96UuzdBxqfLoUS3oG5cBpODWAKs4JsXtvHQDx
         tztXmiIJoXQ32QEtWak1AK7zeHLdwV2L+eeGKwCzg3oZexw9M5xwL9B1bsKPtTcCSiVz
         aurERFLlKDB0ZJs8+kqPl17O4NuZDNl0K/+DCvgVpzcKMM1CoIeKMi6TRa1R3T+35X2E
         lCRw==
X-Gm-Message-State: AOAM531M0j/m5sorXx6Zy1cTRYaB9WV8tLqQZ87W1UVXOJ8ukS9HTrmI
        9yhqqadceuvMWaxIpmtzt/+MPT5AZC3SvA==
X-Google-Smtp-Source: ABdhPJy12B4Ke+A6o0WxSCx7uVWB7+zzbHnNjqW06BO7Q3F7noqr3Kr8SplhuNS85jVzWLp5pNHMHw==
X-Received: by 2002:a5d:648f:: with SMTP id o15mr6866761wri.381.1637325994557;
        Fri, 19 Nov 2021 04:46:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w7sm2857567wru.51.2021.11.19.04.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 04:46:34 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/6] object-store.h: remove unused has_sha1_file*()
Date:   Fri, 19 Nov 2021 13:46:23 +0100
Message-Id: <patch-3.6-62ed0ec6077-20211119T124420Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.817.gb03b3d32691
In-Reply-To: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
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
2.34.0.817.gb03b3d32691

