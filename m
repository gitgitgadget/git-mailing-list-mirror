Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE27C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiGMNKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbiGMNKo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:10:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3797AE087
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:10:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v16so15412085wrd.13
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bY91G1xok4c6j7fQ4xDNpoYsnXh/337AQSkUoeMK/xs=;
        b=DfMJ/+0q4sKorYTk43/muRsL8YTO5MvXBlAeKsqwWg+QhPpcGA44u476lHi8fZqHpF
         9/d9b4JbE+Ym+C1l+pl7J9GpAZI6xiYi0KhBK+i2GRTM6O0B/YyfGNrb4xZjf3Kct5RV
         vDKFaWsSkCHnuV3RkrFaxDLVNIhvWgBOuvmjoNwais63rlBAG6PT4VllwBsFCEfaXT7A
         OlrWzgF7PYx5rJNJ9w7U+1wGLlawIKF9PLp/3SlmpDJJeUsz4y08ONt8CWl8+0ypS4QZ
         1mHfrulbtupTPrVrefzyxqNxCUbSSi06YuAtOtcF5WLhNyAynZnmtprHSfb/ba6WzVUm
         aALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bY91G1xok4c6j7fQ4xDNpoYsnXh/337AQSkUoeMK/xs=;
        b=VWaYTzT4jxDkMJMt8VwmgiXhLv5MxTK+WwLwmFxGjAS11b5JkZumLPNnV63b/1acm1
         H9L90lVm1Z4ZYtj+hoS2jcDtRbfMYI/0k4Y8xgWN1h2RL4mRhEnnG7gEX8l+6v/52UaW
         Ums9SZPhM8kvOBQdYgI/AvE9DewSiOdm687vnQRNWRqPXZMCdDsDDTQStN0C+R85YkSp
         4VwdcSYsW5I1kVzE5XSu56yEqzLIm7GN9CMbaBbrpxy9dQvL9aN++LcZ33E/iLYocUQD
         wu93RgXgjUMrrAWY42wSGIDkLB296aLiHUzTZBtVjHjHk6lIWictithz6TUCZKeyePlT
         ziow==
X-Gm-Message-State: AJIora9y3xqszxAvzdUiPWJ7A2moJlB7vRuskm2SV4uADyLzn87a8KBd
        HtOirwAjpDHkdrJQhD1GYQ7bvkeQ2JgEpQ==
X-Google-Smtp-Source: AGRyM1s8P+/7YQzXHXuhHh9oxzxJSM+Tex/7bQ6vJhkxkYxi+xXZ34Jk9V8zheDk4Gr9/iP8eYNa6g==
X-Received: by 2002:a05:6000:1141:b0:21d:6ef3:e8c4 with SMTP id d1-20020a056000114100b0021d6ef3e8c4mr3365650wrx.573.1657717841462;
        Wed, 13 Jul 2022 06:10:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d15-20020a05600c34cf00b0039c4d022a44sm2183653wmq.1.2022.07.13.06.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:10:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/6] bisect.c: add missing "goto" for release_revisions()
Date:   Wed, 13 Jul 2022 15:10:30 +0200
Message-Id: <patch-1.6-9bea9591d17-20220713T130511Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
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
2.37.0.932.g7b7031e73bc

