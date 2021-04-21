Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D54C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5E16144B
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243733AbhDUO7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 10:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243727AbhDUO7R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 10:59:17 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31925C06138A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:58:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id q123-20020a1c43810000b029012c7d852459so2777784wma.0
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=okHkhyBoLVzo0EidXSeP/EVHyRLow2pvIsyTn5/kb5k=;
        b=lZPtXCpqTRaBnQvZlXzB+BwKkY83w/FV9SlzIJxDU0nbSmnZj/7yiSxPEnnPB9qva3
         /c059O4ZSnoU2wvO5oIZcRnQBT7TkbFOE6tpZKwx3nGIcWKQRU6MCpSO2Kd4F3ey46/Q
         UjXxjiZxUt6X8/bu9rRA/KqAS0hNtQqaIA9PMFJBqS9h43iYRuPTSfoHcIpxubs0wonO
         yMbKCtcV3yr8zg+esrMmsOJ9/fBK2p9lNiViRpc99uxdBcGA+mZ4im0FStaERPQDxPvO
         miBqTvabKxW+BUsGXrzLBKGYpYaah5gREly6j1L/7vWeZXsyvB3XNTwzPp0FTYdeF3eo
         AGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=okHkhyBoLVzo0EidXSeP/EVHyRLow2pvIsyTn5/kb5k=;
        b=Kiue1Rcln84lD4k58ddPCVRFI2OqpFH8qyIRKCo/mQCGaKc14cGMejjdrfuD8qRznS
         6bN0N3Diim00rz3RYZKXvBnCZjYBBR+oORWKFiL6IaJLwzZOtwOuIzs8Q8NcGz6m1WIs
         LApyH7kKbtPKMAeH4nPXbpzJ22bxrqUD6whOYohvb3jDEV8SO/ooGFTp/dLdh/9bgTDa
         djH70VfcUS9BxiaUwI3qW801GxazhD6B044hAW31qxdQIwNLy+1k0KukLu5sX686XRPD
         C5LRALtdZaKdX33Dgy8iUoP1oXP6BgfoHckkoboUJZeGq0hm8oILXL74TKnTtpyoynQT
         dGfQ==
X-Gm-Message-State: AOAM5308il/SHxg3lWU6gLIWT1STPGpgO3TKPL9iC+gvV9DupKLsFvFh
        daqHdZCXKNTQt8nAs9oZMxQOmnn8CPs6RQ==
X-Google-Smtp-Source: ABdhPJwQIugKOMZ9ay+nqwx6Lu0owLHgpyNZYoi6NlMlOYOaSUsTuO+s1RMRNqmmbmm/Pjnu1X0pNw==
X-Received: by 2002:a1c:e20a:: with SMTP id z10mr9964994wmg.158.1619017121649;
        Wed, 21 Apr 2021 07:58:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g1sm3394316wrd.69.2021.04.21.07.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 07:58:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] test-lib-functions: normalize test_path_is_missing() debugging
Date:   Wed, 21 Apr 2021 16:58:34 +0200
Message-Id: <patch-1.5-ba9d6251ad5-20210421T144921Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.g9a7f2f961d4
In-Reply-To: <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210420T122706Z-avarab@gmail.com> <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the test_path_is_missing() to be consistent with related
functions. Since 2caf20c52b7 (test-lib: user-friendly alternatives to
test [-d|-f|-e], 2010-08-10) we've been ls -ld-ing the bad path and
echo-ing $* if it exists. Let's just say that it exists instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index bd64a15c731..0232cc9f46d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -810,12 +810,7 @@ test_path_is_missing () {
 	test "$#" -ne 1 && BUG "1 param"
 	if test -e "$1"
 	then
-		echo "Path exists:"
-		ls -ld "$1"
-		if test $# -ge 1
-		then
-			echo "$*"
-		fi
+		echo "Path $1 exists!"
 		false
 	fi
 }
-- 
2.31.1.721.gbeb6a21927

