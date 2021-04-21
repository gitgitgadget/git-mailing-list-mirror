Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED4CC43461
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2E6761453
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243724AbhDUO7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 10:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243748AbhDUO7R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 10:59:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551B9C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:58:42 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n127so10576947wmb.5
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aHMg2DL2kdOsSphE/43cOW3gdGyqZEsDm2jlr14qa9g=;
        b=tGzvvwzYesqohfRZDM8CVOjFME9A+gBBi32JBiP3J02GfFG/BFf2qeagSY9ipV87zs
         Uyn/ew7ToP9T9EV5tmHpQA0CzZ136ltonlZuHv8AWyTJkIYzGeLaCi0jrh+0oqNCBRhw
         U8u1TJK+wPGvVKqK1RbqZ1MgaElRycEV3P64ZmpehGMTorgXttwqTCJVhkyCDSX0dhRZ
         WyVxiZviwMryGGp6CAhPP0JxmlAUeYgO5MbRBRXQWKkpJBsy2V25RuTep9dx0YjRPkd4
         YMr2Ns8tVYjlsNczJZKJ+Dii+HbHXgITisysINNrahKaUGILKejCpqHFlu+a+1fndjQj
         9tIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aHMg2DL2kdOsSphE/43cOW3gdGyqZEsDm2jlr14qa9g=;
        b=jV9sT2gcc96/o3DYfRbWglGlZo4zBtG0J5F4V7wAHszb9BW5+mgAWMdyonRpTbuK/w
         0XdgY8D1EqTzO3O2MqtBT0TCw/MepxMK0XB9IyoF11TpAt7bNYlCQnGE8ov8BAPS5fLv
         JZX0PSuTxnMMhhB+uJV8d2EyVExosi9r15tkccfB1cxGk+vn81B+f/zgaUKYgnZ8QFc8
         Tuk0Nm4pVhxA9tCXV0YbkGdNObrypn59fgMqoyLaIK035kBWqAN3rZdY5VGbjW+GYkNn
         CWBNFJj5hdnQ1Rcyk9CLkPiu0eycO666ay5+XezJzRUwgseKl6ZK64pvSEIxtk4q8aoz
         bmWw==
X-Gm-Message-State: AOAM531eWl8R2AoJBF0LQ+Z78C28xEjaW5/6muPkWDf/FWlD+L7QC7hq
        2UbDJjp07xhEG7DkWGN8LVujSkVYe6HtnQ==
X-Google-Smtp-Source: ABdhPJyDdAiwspCjyiSotQUAMrxtfQ9dfsVtTtzOd0IgJo/CZV/NITACCOi9pAhZh3yZklGXmWM4lg==
X-Received: by 2002:a1c:a182:: with SMTP id k124mr10466424wme.132.1619017120774;
        Wed, 21 Apr 2021 07:58:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g1sm3394316wrd.69.2021.04.21.07.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 07:58:40 -0700 (PDT)
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
Subject: [PATCH v2 0/5] test-lib-functions.sh: trickery to make -x less verbose
Date:   Wed, 21 Apr 2021 16:58:33 +0200
Message-Id: <cover-0.5-00000000000-20210421T144921Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.g9a7f2f961d4
In-Reply-To: <cover-0.3-0000000000-20210420T122706Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210420T122706Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes the "-x" output less verbose for our various helper
functions, mainly using the trickery of feeding "$@" to "test" to rely
on it to die when given too many arguments.

Since v2[1] I ejected the patch to make the "test_line_count" function
unsafer per Junio's feedback.

The test_file_size has lost its "BUG" invocation, but is now safe as
we do that check in the test helper, as shown in 5/5 we fixed one
previous mild regression while doing that.

The 3-4/5 patches are just trivial "while we're at it" work.

1. http://lore.kernel.org/git/cover-0.3-0000000000-20210420T122706Z-avarab@gmail.com

Ævar Arnfjörð Bjarmason (5):
  test-lib-functions: normalize test_path_is_missing() debugging
  Revert and amend "test-lib-functions: assert correct parameter count"
  test helpers: remove unused test-tool path-utils slice-tests
  test-helpers: rename "path-utils is_valid_path" to "is-valid-paths"
  test-helpers: split "file-size" into "file-size(s)"

 t/helper/test-path-utils.c  | 44 ++++++------------------
 t/t0060-path-utils.sh       |  2 +-
 t/t1050-large.sh            |  2 +-
 t/t5319-multi-pack-index.sh |  6 ++--
 t/test-lib-functions.sh     | 67 ++++++++++++++++---------------------
 5 files changed, 45 insertions(+), 76 deletions(-)

Range-diff against v1:
1:  fd33f6d71f0 = 1:  ba9d6251ad5 test-lib-functions: normalize test_path_is_missing() debugging
2:  67ddd821dfa = 2:  5f8e5ad27f5 Revert and amend "test-lib-functions: assert correct parameter count"
3:  8fd51861b59 < -:  ----------- test-lib-functions: remove last two parameter count assertions
-:  ----------- > 3:  44948c6ace9 test helpers: remove unused test-tool path-utils slice-tests
-:  ----------- > 4:  ae5dc5d03b3 test-helpers: rename "path-utils is_valid_path" to "is-valid-paths"
-:  ----------- > 5:  947791d9535 test-helpers: split "file-size" into "file-size(s)"
-- 
2.31.1.721.gbeb6a21927

