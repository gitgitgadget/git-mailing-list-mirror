Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CA3C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 00:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiLBAHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiLBAHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 19:07:25 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7646C5135
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 16:07:23 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gu23so7982626ejb.10
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 16:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bx+NdMOZotI1X8QlHYADdQkhlr/v61I9v5jxO6U4Ad0=;
        b=l7TjXJUD7r2IcO9FWXn0gS34GyU6N3dLNmnLooYdqasq9p5NyA/aPm55rzzvofeTfw
         +2Bhjn+YgotMVDcy+Hzgso8PS9bOuCt5cZ3MSoJolemLhv6Bdu8wQDELetE+Mf0yLNFy
         qoTou1vnf69gkPuD9F5Wkb3v6qI13FmyCef8j6st9QfpJX6E1Nq6WsH/sO5xB93vDjCp
         49bbPi517LwwqcRQILctg08+WL+46oPMICmNJphkeA9ivF2ARHKQjYcgjCPoi53fplrf
         hx+jwhCbnzOM5ePBD5DHofCiuWZRkP90AJtBeQCto7dqCaI6/2SbvqpjbhyJnYupgPea
         Y8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bx+NdMOZotI1X8QlHYADdQkhlr/v61I9v5jxO6U4Ad0=;
        b=H7gPruY1Agwx83N0laHPuQHpDPQ0Sdqxjehzumw/dxp2c1YzmAUt6DBsFdvWVxFNQq
         nYls4XyOLNbUMaZGn4bwfiH+nFu9wlOgh/IE0wH43mZf0WXsw145SVEd07xMN+c3lodU
         qumM3fk5nZOsbpQVe3m1TIgUk/SGF877ae+lsRmIewqMcr60MGj4klepbNkCiHKlrP59
         r3NZrI3lvEGVvZM+h/9ayqMysZMZowNAE1rhuqTe3U9cm5evF+MZRNWjFFV+JDhDw3CF
         hOXtSSKqntRV7+bJeqcHk98nldjiHxJRYO7p70WFMiq8OtgXcnCeT1BRv623Nsfxf3t8
         ODzA==
X-Gm-Message-State: ANoB5pkBvnTmCmluJkDKd9sPCQxW2MzJYEA2hwZug//kx9ER5Pxb+dFF
        XBEtZ1poC1BLLM2s3M5gvKxu+gyOT8B0uA==
X-Google-Smtp-Source: AA0mqf6L0uqRvzeG45vs82s/SXeIWSb+h49R5fIaECx7YnNxYTS8Ng0oHOr5Gfo61DX+RXC7DcrX4Q==
X-Received: by 2002:a17:906:1e8a:b0:7b2:b992:694d with SMTP id e10-20020a1709061e8a00b007b2b992694dmr52578235ejj.651.1669939643070;
        Thu, 01 Dec 2022 16:07:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ex19-20020a170907955300b007be4d8a50d8sm2351576ejc.70.2022.12.01.16.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:07:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/8] t/lib-patch-mode.sh: fix ignored "git" exit codes
Date:   Fri,  2 Dec 2022 01:06:31 +0100
Message-Id: <patch-v2-5.8-f826a336c3d-20221202T000227Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.980.g92d3d4579ad
In-Reply-To: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix code added in b319ef70a94 (Add a small patch-mode testing library,
2009-08-13) to use &&-chaining and the newly added "test_cmp_cmd"
instead of interpolating "git" commands in a "test" statement.

This fixes cases where we'd have e.g. missed memory leaks under
SANITIZE=leak, this code doesn't leak now as far as I can tell, but I
discovered it while looking at leaks in related code.

The "cat _head >expect" here is redundant, we could simply give
"_head" to "test_cmp", but let's be consistent in using the "expect"
and "actual" names for clarity.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-patch-mode.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/lib-patch-mode.sh b/t/lib-patch-mode.sh
index cfd76bf987b..ae51f33a010 100644
--- a/t/lib-patch-mode.sh
+++ b/t/lib-patch-mode.sh
@@ -29,8 +29,11 @@ set_and_save_state () {
 
 # verify_state <path> <expected-worktree-content> <expected-index-content>
 verify_state () {
-	test "$(cat "$1")" = "$2" &&
-	test "$(git show :"$1")" = "$3"
+	echo "$2" >expect &&
+	cat "$1" >actual &&
+	test_cmp expect actual &&
+
+	test_cmp_cmd "$3" git show :"$1"
 }
 
 # verify_saved_state <path>
@@ -46,5 +49,5 @@ save_head () {
 }
 
 verify_saved_head () {
-	test "$(cat _head)" = "$(git rev-parse HEAD)"
+	test_cmp_cmd "$(cat _head)" git rev-parse HEAD
 }
-- 
2.39.0.rc1.980.g92d3d4579ad

