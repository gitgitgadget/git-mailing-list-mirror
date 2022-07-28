Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F8BC19F2B
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiG1QSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbiG1QSf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:18:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15E173918
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:18:01 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d8so2851695wrp.6
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3ilOnEgCwjqjsIEfzeQVhRCUKPAWuAWm00oFTL1g4BU=;
        b=quEh+SbuV0qbgi/yMqDaramDdMzqNV7emkPMGAlg8toy5bp2/wWd787W4EvMOpQpTl
         H9jjCRehghihWbmfG2XmJ27DkXAUVVv9lAdun9LSBXwcne+/9IZUkJc1z8qA7CNK2vn1
         h51t7e2UEiIeKY+nQkrT7VQS0DeqQwpW2XL6WRg+SJ4ZrlnJWMSnA9TNV5+omv8nfV+e
         LP98kz16BBm8xSMMUZ0O+GLFX7djUChKu2XN+fKB5JhUFGgYQAB2ZWFmy/72MlaEzAYq
         m45+v547vKK4Z8rAjHDc1CinevrRTcQ90OKuyjPO0oFhsFtWZH1thb8O36LUNkI8mAAe
         YEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3ilOnEgCwjqjsIEfzeQVhRCUKPAWuAWm00oFTL1g4BU=;
        b=Dz1VsNXGmFQ0Z2DmGn6F3qGuguC07JABeJHUTUHqYIrF0MGDzjgCZOljwg3oKEXeEn
         KWGd7rjVaCXtuXMtvZM4wCci5KjnGV4s/MeUo85cVO2zOewjKSjnALRfsvOfpmPvk6Re
         1J0EzcWUEBKOeBUlgOTINw+Rki/VnetxsWYmmxWSMqrpaJYVIaNnXWoIBZzD8teDoPJb
         QzvztbnOds1UUeRzOcB6D6ffWX4bN0/rrsCUZPN/mRYNj3c9YUJU0YXnIclrwTbX8PIo
         z8U39IxnDYrXQxvyhUOLxd0z9BlnrYVmUpliou/G1UCT2wLRC7YBBN6EUU1XMgHaAsQa
         Fdwg==
X-Gm-Message-State: AJIora/ZlJ49t4I3bMO3BJVxSKHioBXJj+47rtVe/8w7j0IcisiYuZx2
        kxCmovxmEoABzNAndtjx6q4Qm8zLZ6nQtg==
X-Google-Smtp-Source: AGRyM1vft4qnE3ZrG0w0myxLQiRMBsNH4B9WI2HBhFm73R1mSgAlWZfp5t/CwR83UiFZxB1f4cnLvQ==
X-Received: by 2002:a5d:4577:0:b0:21e:f928:e911 with SMTP id a23-20020a5d4577000000b0021ef928e911mr2417648wrc.369.1659025080179;
        Thu, 28 Jul 2022 09:18:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w13-20020adfee4d000000b0021f0af83142sm1220117wro.91.2022.07.28.09.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:17:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 15/20] submodule--helper: add "const" to copy of "update_data"
Date:   Thu, 28 Jul 2022 18:17:00 +0200
Message-Id: <patch-15.20-e319f4edc54-20220728T161116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1167.g38fda70d8c4
In-Reply-To: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com>
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
index e235acce985..fe92c9858ce 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1777,7 +1777,7 @@ struct submodule_update_clone {
 	int current;
 
 	/* configuration parameters which are passed on to the children */
-	struct update_data *update_data;
+	const struct update_data *update_data;
 
 	/* to be consumed by update_submodule() */
 	struct update_clone_data *update_clone;
@@ -1862,7 +1862,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	const char *update_string;
 	enum submodule_update_type update_type;
 	char *key;
-	struct update_data *ud = suc->update_data;
+	const struct update_data *ud = suc->update_data;
 	char *displaypath = get_submodule_displaypath(ce->name, ud->prefix);
 	struct strbuf sb = STRBUF_INIT;
 	int needs_cloning = 0;
-- 
2.37.1.1167.g38fda70d8c4

