Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E219EC433EF
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 17:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbiCZRQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 13:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiCZRQN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 13:16:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCF035865
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 10:14:36 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso6089178wmr.1
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 10:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EKzKA0n9K+9vEEnaNJzC9u78kulRkCT0O8HR4A9ie9Y=;
        b=mL1+L4ZL5wmY3pHewmxidA3VtGsI6rrhnhnjPSRbi/dhTQQghYQrXfCbMzQW3cvF5N
         zbGfL5lAYJc88SspW2QeOAWsbycYYm48QnOgx6FlaK2HNZx3XIA4OblI+9XEWe5tktVh
         4tLgangds42w1LFM8ll7w74sFuSInhJxNG1eFqtmj0bxJ+FUYwPoGAsAK9LI3AVYvAwl
         RjreG7dG4f4jA83LsGNLR19dBLDVIUtWAu4QT7cBa/6m7hVMvxQ+rM/zumIJ33Kk6Ahc
         dvKaVbNpdrf8WHih9fVdswpSFMSjqnlIulpVO42yq2AyZQvpgUDQKYMG9n8JpeiDOZpJ
         RrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EKzKA0n9K+9vEEnaNJzC9u78kulRkCT0O8HR4A9ie9Y=;
        b=fooEEZGy11p51xrb5V5MdnUHu/32hG1aJ3Kh4UWNvSNTOjQaw9WA8EToA4BFBK1u+0
         t1ZzE4cpr6kO9O6qx171rgPN9ChhlEGPtl4/L56JU0AUxG/T2nMwlBposCtjRhKs4Qci
         wa1YRxbmUXlTbo7f/BCUT+By4fzSZwVpkftvBtGC15kVlmq4rjGlWKZbLgpMlxJ6SYyZ
         WQCIMj5VJdk7JvNiAegwRjg5lxc+Gd3m+ywwA4fVoaTDFel2nOkyJU4/oGGu6E4jczdm
         QseFVowiED7wu7H8wztazzeFx4sk4hACuCzU8yL8lO11pco9uPOw7W3r0JtcAIUFXB4E
         RUFQ==
X-Gm-Message-State: AOAM530XJ7vBMiaN9+SvKZkkoyzo69p1Bdfay2zrbNx6XzM5zFVXwwae
        r0yHfWPTUfHZNMa9IZe+lNKKg5ALQ1oWow==
X-Google-Smtp-Source: ABdhPJygnnvjpGpr2mgKhc481IkEetWnvw9i/16acLVrKJdK7XigOSLDHTURuaiOMpXSIWf6F3YNUw==
X-Received: by 2002:a05:600c:3ca8:b0:38c:6dc6:6de0 with SMTP id bg40-20020a05600c3ca800b0038c6dc66de0mr25473134wmb.159.1648314874475;
        Sat, 26 Mar 2022 10:14:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0038cb924c3d7sm7805913wmq.45.2022.03.26.10.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 10:14:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/7] object-store.h: remove unused has_sha1_file*()
Date:   Sat, 26 Mar 2022 18:14:17 +0100
Message-Id: <patch-v3-5.7-cf7969f8f67-20220326T171200Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1535.gf8d72b9da1e
In-Reply-To: <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
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
2.35.1.1535.gf8d72b9da1e

