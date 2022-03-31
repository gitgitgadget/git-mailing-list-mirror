Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2233CC433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352385AbiCaBsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352373AbiCaBsD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:48:03 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2027488BE
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:46:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n35so13336372wms.5
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jk6msYm2qImLeE02szi4xyW33dmsCJMyDvLjBL83UkQ=;
        b=LtBqNyl5I42vEJcbxQf/uZbSkZukQBRRUTd2k9KTLkbWV/aKY2aHb+xD/kT+xrou33
         Hjoc2OcPvcOtuz1ppo0ivgvj44ovWhkbATygN3sKuLYiir1Avs7L6Udu7fdhX/D5sEoi
         sGEqPlx0O224a7DLLc7616IRUfsnlZwFhdaZ19uNZM/m3Vu8DaoaruIcQzc7SCR7foBa
         eykH3O84SCHseSae4M5poZrM6gQJPeM6VZSlT9MCoI0ebA2yp0Ae3aTR/gzAn0df/dLz
         HmJBYbEhUJpPi/DXGy7h0zZU0v5ZlUW1MWvR1KWb/5RukA8/nQvHxwJZmNU7vHYGTlV4
         FTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jk6msYm2qImLeE02szi4xyW33dmsCJMyDvLjBL83UkQ=;
        b=YQw2Dt+2/WBZpmXDuLlndkngGZpDEt+xl7D+cMAFdTl2YyjJfIYrmn2YgOxFUbTLhK
         vdsdR1dfnrzDFq1Ijm1CrIKAa6xFgekIws5Rwsh1t6oBokHfXQAqu0NbizAbKHG6ai5M
         NxO9qmoHmyras6PHa/G+I2DFXOY06Of+lAmbumBkr6T4L+Wa9q8s4xnU6Xs3jzCutjQ9
         6axPLoPQP/mc2IV8bRkfQ0+l5A85qqeHbmIMfZ9mhY/2oH1298Q+0f1z/HLdufNNKS5z
         1FQpkRZsb3gN5PC9t8UeFHpTbcsztxDaf3VL0JSAGaLTJgm21qt1DI4DpePwF/DXjWFr
         rC1w==
X-Gm-Message-State: AOAM530hK7P9Amv4cXjVBgCP0UiSNVu3LMMKR4FTGgfXBuPaJrk5NNRM
        gCQojYCfLsacf8R2V8fDHWDrZ3dCLUvqbQ==
X-Google-Smtp-Source: ABdhPJyXZUQcgZtlnpA259tuLXZzz/jIrIarU1PbePrfqapNbRHqsOZL1btAbO05aetgxV4D3+CkFQ==
X-Received: by 2002:a05:600c:5021:b0:38c:70c0:80e9 with SMTP id n33-20020a05600c502100b0038c70c080e9mr2400544wmr.91.1648691174242;
        Wed, 30 Mar 2022 18:46:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020a05600018af00b002057c72d45fsm23603272wri.77.2022.03.30.18.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:46:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 5/6] object-store.h: remove unused has_sha1_file*()
Date:   Thu, 31 Mar 2022 03:45:54 +0200
Message-Id: <patch-v4-5.6-69d32330716-20220331T014349Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1561.ge8eddc63765
In-Reply-To: <cover-v4-0.6-00000000000-20220331T014349Z-avarab@gmail.com>
References: <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com> <cover-v4-0.6-00000000000-20220331T014349Z-avarab@gmail.com>
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
index bd2322ed8ce..53996018c11 100644
--- a/object-store.h
+++ b/object-store.h
@@ -312,10 +312,6 @@ int has_object(struct repository *r, const struct object_id *oid,
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
2.35.1.1561.ge8eddc63765

