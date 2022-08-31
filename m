Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10058ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbiHaXTQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbiHaXSe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:34 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8D0B028D
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:33 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id s7so5225655wro.2
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=YSVm/6e2Dh1Q2xXRbpUD16ZKnROrQLonB5spxrJi1EU=;
        b=MaYwk6Gieht9GQNaPtXeb4x2yHJ7hH+5bD5WyEGE28slru1geChoNm9vHmWKaPyX9n
         LaokrmYMl+8BUs8x4gq1OB+OY+wzR//co+8DAn+fej7rjeUmWsnxHYZRn9yH8bLuPxUV
         P0rFuhBWcjLaruG/ZBowhwXdKAvyJTafzmq4vxZ5wTc2r2gzzpJRRdU8cPgKfVs2nIno
         nFg3AenyiZ016B5a7enSJrB/EBWKE6PdKe0D42Oa75f8+X3L+Rf/OS3aZf8xlWOd0f94
         e8HZsYCTMnzqacTcIkwIEySzMYH6wCmMVnS9nIWtnqwobUHGHHUSUFXr2Tto/i8D2lU9
         KKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YSVm/6e2Dh1Q2xXRbpUD16ZKnROrQLonB5spxrJi1EU=;
        b=naGuIsQ8P46q2IHwavn//dGi8o4URoQwS0h+qsETlXmsxHDCATm/VMrOiZlX36cAaU
         QXSBcMEDK03Fz+3E0teEyhha3THUtJ+HqhhLhn/w4goeH07UTtzrXt/44PJ2XaiFEOvE
         CTXzy0PnW5NQPaMIkUb6wtqrGGOFEwUtq4kG67dBeF6D8DY4hGq24ZJeji3jVB2DYhwN
         wzY9M3NrhSJ1qRVlRZSmEupNKDa5Tqv1GOBCRli/y7n0QFvOxMxlRBAr6LCEj2Ts6v5X
         LMJ+WGFzIMX9/a1fnWNi+nz/82LFgeHX/P7qghvF8xlk7IewuB+tawMLJNWpUdTzLJ4J
         w0Rw==
X-Gm-Message-State: ACgBeo1fPQ3UUvuzpSZ8CWCnDryrdThBlfnINMsmXRsXocaIHbMlICut
        kyjK/6vuURU0c+kNWWS6/qqrSc4dP8QFBw==
X-Google-Smtp-Source: AA6agR7CUK0BQE9tb6uHDtrk6KdthYDSHQ/W9nvkG2bekk9lg7QJHjz4nGLiC+RGSZuc7d19gYZHRA==
X-Received: by 2002:a05:6000:1ac8:b0:220:6af3:935d with SMTP id i8-20020a0560001ac800b002206af3935dmr13003180wry.549.1661987912325;
        Wed, 31 Aug 2022 16:18:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 15/33] submodule--helper: add "const" to copy of "update_data"
Date:   Thu,  1 Sep 2022 01:17:57 +0200
Message-Id: <patch-v4-15.33-30be00d5cf7-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Add a "const" to the copy of "struct update_data" that's tracked by
the "struct submodule_update_clone", as it neither owns nor modifies
it.

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d243c3ddfd3..829a57ce8a9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1780,7 +1780,7 @@ struct submodule_update_clone {
 	int current;
 
 	/* configuration parameters which are passed on to the children */
-	struct update_data *update_data;
+	const struct update_data *update_data;
 
 	/* to be consumed by update_submodule() */
 	struct update_clone_data *update_clone;
@@ -1865,7 +1865,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	const char *update_string;
 	enum submodule_update_type update_type;
 	char *key;
-	struct update_data *ud = suc->update_data;
+	const struct update_data *ud = suc->update_data;
 	char *displaypath = get_submodule_displaypath(ce->name, ud->prefix);
 	struct strbuf sb = STRBUF_INIT;
 	int needs_cloning = 0;
-- 
2.37.3.1420.g76f8a3d556c

