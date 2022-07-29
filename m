Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0D5C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 08:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbiG2IbQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiG2IbP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 04:31:15 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BD86053F
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:31:14 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r83-20020a1c4456000000b003a3a22178beso269847wma.3
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=czFMdwmgQ4dlSTdKbe/dXHv0nYjh9yNHFCttVWiDRpc=;
        b=lb7zeCtHkZHP/lbIbXqgydIrw4ujlEx4w+3ROA27LRO7d0JWUVMjXrPPTbE3xBSr6r
         BQDUPbCs0GdwHni/kmVvAhH1d4Sk3dHIdyjdhd8T/spG95S1T8xYSz7Gxm2O0yYV/tN8
         wzJdukUJedYo+/4Dyipjn5YUP4I7c326zXf+NLhOAFcrSLukGdZ3RMLIAviQ6N22b/Ud
         Bm6LtlY/hn4FmMf4zol8KjpHaBfiKy2LDDutQHLRkZWqDbs6UcQ+Z5Te31wIAOsFdIvU
         BzUt8XLrL64FBkBJ0Yg2FZbveIfLVbPMMdPsqu1WPnspKscKIQ9XcFqdQ8vk8CUPz3GV
         ps7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=czFMdwmgQ4dlSTdKbe/dXHv0nYjh9yNHFCttVWiDRpc=;
        b=P9cRbOflPpJZDCo0/JwWYt2suz8vjCki8ew9fz4iJmaB0wbz8rDFWPCeVWG9hSr+/l
         8bUF696a2d4HS9eXon5lmogb8idOSTh8UG//TOY6+XdTV54p2FRLhZEi1zSuKDj0GdS4
         Rl/HXxJibpssdy7JVCo03iNGF6TRma1lURbhwDKZTdaXskhDbgZwBqwUnIFbc4FKi22G
         A15G4mWdIDdVJ9Fj6ZGsqMIVFseAsArwc5/8+PTXKh1FcGutii74aGqVhBK9cg0wEG+S
         qsZo/kBiJP95K3jlUqV7WtJrJ2Tqahwf2eJyMlCFB6Bdt98tpAVET84T8iZbfnFShcWO
         Srmw==
X-Gm-Message-State: AJIora/nPLvfQvsln2bLKcGvm7TsiIXJnRXRGeiTu7StPJp/MzO88VXU
        B7qeI2FNQriV4mYSQ4uTEjPoXKzndpevNg==
X-Google-Smtp-Source: AGRyM1t7P6yesKblMt0eRpmnPWtRjP9Yo7ACTpa95VcKhcyIQqx3buF0y608J4q7XTYr99QnL3JuTg==
X-Received: by 2002:a7b:c3d4:0:b0:3a3:ce7:7894 with SMTP id t20-20020a7bc3d4000000b003a30ce77894mr1720785wmj.134.1659083473042;
        Fri, 29 Jul 2022 01:31:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f13-20020adfe90d000000b0021f0c0c62d1sm2325467wrm.13.2022.07.29.01.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:31:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] bisect.c: add missing "goto" for release_revisions()
Date:   Fri, 29 Jul 2022 10:31:03 +0200
Message-Id: <patch-v2-1.6-12a4a20c59f-20220729T082919Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1196.g8af3636bc64
In-Reply-To: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a missing "goto cleanup", this fixes a bug in
f196c1e908d (revisions API users: use release_revisions() needing
REV_INFO_INIT, 2022-04-13).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bisect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index b63669cc9d7..421470bfa59 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1054,7 +1054,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 		 */
 		res = error_if_skipped_commits(tried, NULL);
 		if (res < 0)
-			return res;
+			goto cleanup;
 		printf(_("%s was both %s and %s\n"),
 		       oid_to_hex(current_bad_oid),
 		       term_good,
-- 
2.37.1.1196.g8af3636bc64

