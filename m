Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF31FC433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiFUWVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiFUWVq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:21:46 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CAB3135A
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:21:44 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r20so401820wra.1
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YgNHJYdBHGccu7rdiMKrg7l/6Jlb2Hb3QM4nsWaRStI=;
        b=jX6DKdaKESKVk4IaPdqHNr+LNpTP2CVFaTUwDko072jSO97KS7UOWRN3IpHsiprmq8
         EyFDxpxLaWtDEJ165Mqd0lVK2hZHzYZX/pOPsO/1yatPxckfwQm/N1mddzXThaseh5WR
         zGOhVPXILl3iHB7KCuwUzoWA7H/CT8UQYQRbXoVxhTgr6Yc+jrQLvkAGRbDo6CIWIFQT
         eAPkd3krQdr0f85SXR4O5tLbME6eXFfZ6i3dX6Y5GsXP2pH12al8R3lewCZvvYCsQwSl
         Z38lkhbRhdcEat4zNzyCGlSUwI4Q0f7fb/1BCka0Xy7x2H5xp26s2U+nX4PhUderCgkp
         L/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YgNHJYdBHGccu7rdiMKrg7l/6Jlb2Hb3QM4nsWaRStI=;
        b=v93Y0D98lRAMMFa5qEXO7uJWy4Aj2ArLVL/lxKLTJ03qYDZnUVTUKVO9VeY9uN8ft9
         gBM3O+m8zboQSR8YbgIjrxaz/YH/OsbhkfMcHuUC68mZT5V/ltRRvaz190q9FVxSjn6k
         UnU0shcgJe7dOoOATzVDThxCSDwFH75FVYUAZcZibKAd4qcdKV6iICv9yhaj6HVGoZ7e
         MHJ0416IJV76zNIbq3OcUsjBfi/H/Ua1SIpC3so2guqozsDpmASHT0QynXzTJUVTTlLL
         zN4UzkShUwBsKv2LIvVCQyDJyNbcNdxriFZEl8mnvjVlpt7k/aSKPM2pbrNWPE0pkGTl
         CzHQ==
X-Gm-Message-State: AJIora+R7dRzr0w7ubpKM+b/w4cOu6ZGRc0KoQ49w0oxW7hqx/genpd0
        h7qL7lFYfDoM8tFxauinHTJMeUKmzNTBAA==
X-Google-Smtp-Source: AGRyM1uif5yn+RZfju2/55E2Gq78qXzb7ouNBgnzdHD0xCePgzC+rGqn5/nLgchwjkmKb054D/D8NQ==
X-Received: by 2002:a5d:6a01:0:b0:21a:338c:4862 with SMTP id m1-20020a5d6a01000000b0021a338c4862mr151331wru.631.1655850102737;
        Tue, 21 Jun 2022 15:21:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u2-20020a5d4342000000b0020fe61acd09sm17547431wrr.12.2022.06.21.15.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:21:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/3] tests: fix tests broken if a " " is in the checkout dir's path
Date:   Wed, 22 Jun 2022 00:21:37 +0200
Message-Id: <cover-0.3-00000000000-20220621T221928Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 1/3 here fixes regressions in v2.37.0-rc0, and with 2-3/3 the test
suite passes with the "git" directory named e.g. "git ~ @ checkout"
when running:

	make NO_PERL=Y test

The "NO_PERL=Y" being because several git-svn tests still fail, for
reasons I haven't looked into.

Ævar Arnfjörð Bjarmason (3):
  tests: add missing double quotes to included library paths
  test-lib.sh: fix prepend_var() quoting issue
  config tests: fix harmless but broken "rm -r" cleanup

 t/t1300-config.sh         | 2 +-
 t/t3700-add.sh            | 2 +-
 t/t3903-stash.sh          | 2 +-
 t/t7609-mergetool--lib.sh | 2 +-
 t/test-lib.sh             | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.36.1.1239.gfba91521d90

