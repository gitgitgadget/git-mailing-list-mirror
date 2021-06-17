Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057D8C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB620613CA
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbhFQKzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhFQKzv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:55:51 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A1EC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:53:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d11so3870660wrm.0
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wy0sg63BiBj0I8RosM0N+8jrLIGQB46JTLfbqd6QYi8=;
        b=Tp2MrO2hCWuxdAijN0fBGCq9jyAp/PAK99oZ8+Xbh+b4f0jaDsDGe1xJiKg4aQFfZT
         WvnLBltOorqk60ckaWzgarVAyFPNBpcE1uzyJQs2njtdWKUWxxB+Omr1kxwbhC7V1hhK
         +l/dJq+v4qnb8VXBnjw7DIPQkOOFaiGsMGoovUvBzEBe66kWomVCjpVt8Jd4W5AIcGye
         3zNDeF1/Y7mE5083pZPIBglV8knueYYPt8tSl1lCbkl/dyPp2YG8XXVwewuuYsRuLdx2
         pLd1mvUsDqM70WWMey0geocebsgyZ2QGSVJWb+fkmcfVPq0IrVKuT2gckj1cw7t3sVon
         WMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wy0sg63BiBj0I8RosM0N+8jrLIGQB46JTLfbqd6QYi8=;
        b=GE74Z8Zn8E7dNHpjrbn6yB8vQX7UOOfYMG79zDnajfN9fMgfmOCtRAYUpGwMVltjnM
         df5FYfXwX5F51Qt7xVyYGj3wzcCcKwCSM7KFPQs+52aBU2Eoffe7vM5y75ASWVPWGTyK
         5YT/VakrnfpXULbogrbSNohp+sHswgZf3cR40gQyIDxqF0FHsyQ2RdmVCzFD0ex5Gppd
         t0ox2ZnC/P2yOVc2t4i4rO8vFYXDe1IVLDecCyvvtwm2Z6JBgpSN7mWYyCqRTT2ObcIb
         XyCzZ1ueLEI7M11GGRSkF/vW7zb+hMYbnDYCXvTVZ2nQkR6/5bXlQwX00QJZaTf/p1Z1
         ce2A==
X-Gm-Message-State: AOAM5301J1/RNqqvBUB2J2FNcREtAYQRCE4hU6X2eJJnWUQCGdibiAMC
        T4ZdU8hU1wTRROi0+w7iiRIWE9EBX8tmgQ==
X-Google-Smtp-Source: ABdhPJxZo1grgeE89Cpn82BOdeh8TGLD/EmHivM1tbTLX4lqbwki+JWdMVZzww6unmNU6HLOqDNCmQ==
X-Received: by 2002:adf:ea02:: with SMTP id q2mr4618133wrm.156.1623927220467;
        Thu, 17 Jun 2021 03:53:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 61sm5409586wrp.4.2021.06.17.03.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:53:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/4] show-branch: add missing tests, trivial color output change
Date:   Thu, 17 Jun 2021 12:53:34 +0200
Message-Id: <cover-0.4-0000000000-20210617T105245Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.571.gdba276db2c
In-Reply-To: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20210614T171626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This v2 doesn't change any of the code (see range-diff), but better
explains the change per Michael J Gruber's feedback in
https://lore.kernel.org/git/162374905722.40525.516266574605586007.git@grubix.eu/

There's also a trivial grammar fix, s/add/odd/g.

Ævar Arnfjörð Bjarmason (4):
  show-branch tests: rename the one "show-branch" test file
  show-branch tests: modernize test code
  show-branch: don't <COLOR></RESET> for space characters
  show-branch tests: add missing tests

 builtin/show-branch.c          |   9 +-
 t/t3202-show-branch-octopus.sh |  70 ----------------
 t/t3202-show-branch.sh         | 149 +++++++++++++++++++++++++++++++++
 3 files changed, 155 insertions(+), 73 deletions(-)
 delete mode 100755 t/t3202-show-branch-octopus.sh
 create mode 100755 t/t3202-show-branch.sh

Range-diff against v1:
1:  7b8ac43339 = 1:  7b8ac43339 show-branch tests: rename the one "show-branch" test file
2:  27f94abaed = 2:  27f94abaed show-branch tests: modernize test code
3:  8db7029086 ! 3:  937e728f7f show-branch: fix and test --color output
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    show-branch: fix and test --color output
    +    show-branch: don't <COLOR></RESET> for space characters
     
    -    Fix the "show-branch --color" output so it doesn't needlessly color
    -    and reset each time it emits a space character.
    +    Change the colored output introduced in ab07ba2a24 (show-branch: color
    +    the commit status signs, 2009-04-22) to not color and reset each
    +    individual space character we use for padding. The intent is to color
    +    just the "!", "+" etc. characters.
    +
    +    This makes the output easier to test, so let's do that now. The test
    +    would be much more verbose without a color/reset for each space
    +    character. Since the coloring cycles through colors we previously had
    +    a "rainbow of space characters".
    +
    +    In theory this breaks things for anyone who's relying on the exact
    +    colored output of show-branch, in practice I'd think anyone parsing it
    +    isn't actively turning on the colored output.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
4:  c54c6a7b20 ! 4:  dde0177235 show-branch tests: add missing tests
    @@ Commit message
         This fixes a few more blind spots, but there's still a lot of behavior
         that's not tested for.
     
    -    These new tests show the add (and possibly unintentional) behavior of
    +    These new tests show the odd (and possibly unintentional) behavior of
         --merge-base with one argument, and how its output is the same as "git
         merge-base" with N bases in this particular case. See the test added
         in f621a8454d1 (git-merge-base/git-show-branch --merge-base:
-- 
2.32.0.571.gdba276db2c

