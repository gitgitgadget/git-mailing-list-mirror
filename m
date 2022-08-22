Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7326C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 21:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbiHVVeU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 17:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbiHVVeT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 17:34:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A129126575
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 14:34:17 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ce26so8085934ejb.11
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 14:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=3rHDUoqNdsukTl8eb49pApsP/0DUVYF2wJotlX+PFlk=;
        b=ap6E7+hgnOxCM3viN3Dzff8/UzJxZA6o2UrSjNy8VbF8q9IAZBOE2+lUHrZbAXP6US
         Dm52VbWOLiiLBaA6gxO8oqicVI+rsrXJSiH//0ie97BVwJjKOwAI3h22klirxrG0HdBB
         uSrVUlA7HYgSgC0jTj1bB+fn4EjP3159F1Ep3vw35lppOOC+P7wk8jh4ZsT1tov69V5+
         s+RLUmoIrDzlvJ2luBFi/BOmRtYWuUGLmjQIuCS65U8pq70vOHR14n5f056M84O7mubm
         PKlv68/YF7rIPtHA3MEawff8IPsSkVK2TVdE5egQQoW2gZW2KLBU3ntU07OH6aDjxVUe
         cBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=3rHDUoqNdsukTl8eb49pApsP/0DUVYF2wJotlX+PFlk=;
        b=SUQWRbxZyX9y3WcGdpjWbp1LDXoxp3FY11qtopWbTpky4Opz6ojmTE8Db6CAjRkR9c
         6WB0Jbild6qKme295hqd5GRVQN0HZHSjqUgn/gszvwjZFJr7qHsq5+Y9gKx3AzsZ254W
         iyCtbaWuk0Lhm3VZaMZ6QXLuhwyANoC4o0mxtoVs4crSeZ9aD/eY9R8DkW85dCiw0+Pl
         +HGQ/YU6hKkabxddHmRHgm/kFuVTHlbNL8ohuO5Xw7dqBUfrgnjmT52nHYv3CsyGufrX
         IGC4l/LIgAbzpicVqosj5bzPuXHLdz87mXMz+L/pSkJFOqP3TF4K0bOcgnNcdxgVAzQW
         5okw==
X-Gm-Message-State: ACgBeo1Mi3k8XXMToGZtwiChWWxFlLiaHGMMEwemVk1OljPNYXz27HuE
        yiyvOyVDsNeMGvWqYBWonPTiWW14PDQ=
X-Google-Smtp-Source: AA6agR5fMvovN1bySLcBynHqXCJ1o5/qXVIo1ESBfaDuF1I9rvpHP7pDkEuhhpl94ygh8LI2k4bDxA==
X-Received: by 2002:a17:907:3f21:b0:73d:87da:dc6a with SMTP id hq33-20020a1709073f2100b0073d87dadc6amr3244867ejc.658.1661204056088;
        Mon, 22 Aug 2022 14:34:16 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id u3-20020a50eac3000000b0043e581c30eesm325353edp.31.2022.08.22.14.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:34:15 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] promisor-remote: fix xcalloc() argument order
Date:   Mon, 22 Aug 2022 23:34:08 +0200
Message-Id: <20220822213408.662482-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.2.880.g3b8fb2ce68
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the number of elements first and their size second, as expected
by xcalloc().

Patch generated with 'contrib/coccinelle/xcalloc.cocci' and Coccinelle
v1.0.7 or later (previous Coccinelle versions don't notice this).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 promisor-remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/promisor-remote.c b/promisor-remote.c
index 5b33f88bca..68f46f5ec7 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -146,7 +146,7 @@ static void promisor_remote_init(struct repository *r)
 	if (r->promisor_remote_config)
 		return;
 	config = r->promisor_remote_config =
-		xcalloc(sizeof(*r->promisor_remote_config), 1);
+		xcalloc(1, sizeof(*r->promisor_remote_config));
 	config->promisors_tail = &config->promisors;
 
 	repo_config(r, promisor_remote_config, config);
-- 
2.37.2.880.g3b8fb2ce68

