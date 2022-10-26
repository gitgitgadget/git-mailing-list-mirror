Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B73DC433FE
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 14:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbiJZOVH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 10:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiJZOU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 10:20:58 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B30F88CD
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:20:58 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y14so21664061ejd.9
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 07:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xo9k/61/MxTyZ8l58tMG1c5o6lYM9hJ9CRky7qiFLck=;
        b=alE1kPe0zumqAImqR7cLcfS80zaTgMyRAeHtzDQ49kq1eLK9a74Z81OcWQoKs/iHCo
         ImCkOJ5cESX9LYlYcqbwZGtppNf7aPLTDKvgqmymen7VayHFLNzVSQeRVOVB15qoeKcR
         4YQf+lAL9L2GNbmFWhyBrhKdH+cx1sg3mHWOjCE0fJlcXWjKYzkBY+F/c5KB7p3jFR/K
         b4ZmYT+JqC9Tut5aXfdRnEyZeUTWpCLeHxNGoljqdnbZ06P0s4GiJzCWjyIsyKCPn+sU
         OYrHA5bSoVs+gFAcnMzLzEiNEXk2UkCAhhvwwOi841R2a4seum0sa0Ep2ip/g+IXVBKZ
         BboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xo9k/61/MxTyZ8l58tMG1c5o6lYM9hJ9CRky7qiFLck=;
        b=QysQfMUMMKjhW5nr4Ku3tra1D6OqD9P/DqLspHI2u04P2aWRyh3nm5qAOAHLxMbSp3
         MH9x7zBvLbUw2NlQT/FFlhTnWj1f7RmeKyjhDkeLoWGijNE2BXoXR/CHCE9ykTNCDRKK
         1hN8lsgdM6iRL4Dg/DXtQucGuSmDkkKrARW9vRVHav9Ta6yN3Eg+S1NdoSE0rHyNi/ar
         v/FAOdeU2MgGmk1n2Evr3KnekwboDwd1EGaMq53oeyLGmyI9gLc0zEnUPGYuX2osX3Q1
         CV/hAVzPzxIA9bZB8hAfFDLyE0428q5mBxmaKtil8N9ecWEpYhJfdQHZ2Va4dmGzgT6R
         pHfw==
X-Gm-Message-State: ACrzQf0nb/beHmzlZE+15siZwmHes9MpZqcJabWidMZ/m9iL4qEmQCRE
        H/v1KTySHzXZyehU00kAJQt3zcIu+FU=
X-Google-Smtp-Source: AMsMyM6FuYmQpaB4e6YFP87VuldAGgIsC/Hx6F6o7Sjs5yuHxZkDbmer1ZhJCJjslcwRBhJlKVp7VA==
X-Received: by 2002:a17:906:c151:b0:78d:cdbc:9fb7 with SMTP id dp17-20020a170906c15100b0078dcdbc9fb7mr36402827ejc.688.1666794056054;
        Wed, 26 Oct 2022 07:20:56 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11-20020a50ea8b000000b004619f024864sm3605565edo.81.2022.10.26.07.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 07:20:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 02/12] cocci rules: remove unused "F" metavariable from pending rule
Date:   Wed, 26 Oct 2022 16:20:29 +0200
Message-Id: <patch-v4-02.12-14e757cc020-20221026T141005Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
References: <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20221026T141005Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an issue with a rule added in 9b45f499818 (object-store: prepare
has_{sha1, object}_file to handle any repo, 2018-11-13). We've been
spewing out this warning into our $@.log since that rule was added:

	warning: rule starting on line 21: metavariable F not used in the - or context code

We should do a better job of scouring our coccinelle log files for
such issues, but for now let's fix this as a one-off.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/coccinelle/the_repository.pending.cocci | 1 -
 1 file changed, 1 deletion(-)

diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index 072ea0d9228..747d382ff5f 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -20,7 +20,6 @@ expression E;
 
 @@
 expression E;
-expression F;
 @@
 - has_object_file_with_flags(
 + repo_has_object_file_with_flags(the_repository,
-- 
2.38.0.1251.g3eefdfb5e7a

