Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ADEC433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 15:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbiJZPgu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 11:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbiJZPgm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 11:36:42 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787C266851
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id i5-20020a1c3b05000000b003cf47dcd316so1813969wma.4
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56jtj266cXjpOowOwFVePvzRhJJnqtzHc0RD46ZRiTs=;
        b=eixtWnVQVIq4K4r2GDHGRNrM+TIZ9May+IwYo0coReEqwCNzz7uavdPBdpncleh8Vu
         Rj0emh7zgi6MkwEnM+SKlI/lQu6e8avV9YJ2hx6DP+ExKdHvambJknk27AV8l3zR2bTu
         0XcRf1Cp7MO1JvXFpM7tFEfiw2I5xKeRG8G8LW18PsIDovj4PpmRGnxBiO3djRRYYVmm
         z3y1xCedlMfdapcZxG9m3WvF+p2o1+cBs8UB7MoG6NIW3NLC9UDAJthqWryq8O/YBzLv
         kAXqNHrv5RoOETQFlV6kl5vBTsCTzr2fCvyi8BmO6Zz8V3y5P53rt88f93vNkx5pYkIO
         2b0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56jtj266cXjpOowOwFVePvzRhJJnqtzHc0RD46ZRiTs=;
        b=Jk588skfkgbGncxVmbrCd37ioeYUyzMMwOckFC7I6y+InYINmvbzaZHUElgPfdI582
         7tqmqEWL2sEfW/TVJQsx4j1bQ+BkZRle2N+4SEl3xGt0N7TLT06JT6w5xtsIZzy8bc9y
         ULwf/2L50u1alBllSSx3ct5GwCyvmZnrDubU1eIIiQaLOwQv449C7CSjClz5+qIqgyUc
         iL8pIwEFdmfJ+4GRa5pH7mF5153mtnqJKnaPvIshR1mghiJmgR3q4LL7FvJcAGAVEvIl
         q2SbWRDWz7noPHQot2rmOz/SiX4DqBda33M/MUfqx4ziBywRzDgUe4BPE/6CnhcqIvQ9
         U13g==
X-Gm-Message-State: ACrzQf3Y/iQF/5wbsh4U5zNjGASoyWFtCKY322UhcUe8CfaOiUOjkhYY
        YHMrs5w0kg1CEudr2LXItgHiRs0N97Xjtw==
X-Google-Smtp-Source: AMsMyM6MLQiw3F0QG4E9WfIcqVAiNwQDTEt7zNut5fJdRhBxf8NFccrPz/lHsqaMt40l2UoVNQRw4w==
X-Received: by 2002:a05:600c:4113:b0:3c6:f5d7:aa8d with SMTP id j19-20020a05600c411300b003c6f5d7aa8dmr2968825wmi.167.1666798599643;
        Wed, 26 Oct 2022 08:36:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1-20020a0560001b8100b002366f300e57sm5581884wru.23.2022.10.26.08.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:36:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/10] string-list API: mark "struct_string_list" to "for_each_string_list" const
Date:   Wed, 26 Oct 2022 17:35:17 +0200
Message-Id: <patch-04.10-40b3cc9b8d4-20221026T151328Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "const" to the "struct string_list *" passed to
for_each_string_list().

This is arguably abuse of the type system, as the
"string_list_each_func_t fn" take a "struct string_list_item *",
i.e. not one with a "const", and those functions *can* modify those
items.

But as we'll see in a subsequent commit we have other such iteration
functions that could benefit from a "const", i.e. to declare that
we're not altering the list itself, even though we might be calling
functions that alter its values.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 string-list.c | 2 +-
 string-list.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/string-list.c b/string-list.c
index 549fc416d68..d8957466d25 100644
--- a/string-list.c
+++ b/string-list.c
@@ -129,7 +129,7 @@ void string_list_remove_duplicates(struct string_list *list, int free_util)
 	}
 }
 
-int for_each_string_list(struct string_list *list,
+int for_each_string_list(const struct string_list *list,
 			 string_list_each_func_t fn, void *cb_data)
 {
 	int i, ret = 0;
diff --git a/string-list.h b/string-list.h
index c7b0d5d0008..7153cb79154 100644
--- a/string-list.h
+++ b/string-list.h
@@ -138,7 +138,7 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
  * Apply `func` to each item. If `func` returns nonzero, the
  * iteration aborts and the return value is propagated.
  */
-int for_each_string_list(struct string_list *list,
+int for_each_string_list(const struct string_list *list,
 			 string_list_each_func_t func, void *cb_data);
 
 /**
-- 
2.38.0.1251.g3eefdfb5e7a

