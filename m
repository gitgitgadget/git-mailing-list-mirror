Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF793C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D6B364FD3
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 00:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhCKAPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 19:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhCKAPT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 19:15:19 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4878DC061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:15:18 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v15so25323515wrx.4
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 16:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9e+X6xTMQHMEzxHq4A1gO/hHWnp+3bKax4gAO440Hj4=;
        b=mbiX3yVwpR6htRV9rMoS/lDbyizjTLPoPnrxxftmD3UbHFY8UUKHQW2EvTjrrUiNbp
         PVGGrisnafZAt98x0KyIju4yjrKiokaZ8GN7Bq8MoCkB3xPXrNWDoNtVko8rgrK82us/
         5bSEQz4TPO8z3Hym9QfzZ51AelYmerQwtYvKplNvP+5zKNp2STDk1H1XRWGEBotEKH5A
         P+NUgrcManQKu8yPIDc9IRfBHv6cpRjwWf1Eq54VwqI0H4//hIksr3WS0ZDvSpcK6XAY
         r7adxfk/TuDuFTdn08f6w8oOnSV68b+iRnK175Xl++dA+YouRriJTi1QyTthM9oRNdR6
         lF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9e+X6xTMQHMEzxHq4A1gO/hHWnp+3bKax4gAO440Hj4=;
        b=mBq29i70tfvyAazGinXU13/6/LEa9og4k0D2NupAC6YD6fRg2/GKinS13a/Y0gOa2q
         4kbnR5kx85SRRqND5CikWLgavQxkqidzY5K0AhcPL+YWx3moDPkFpY0NXXUQILQnYgKe
         l3d//sm4wlHYwV4FsWKOmNC/5IMj90e2jWazSHoeHN5WAa/mOYA1I6UWfW9noFhp+fl1
         elh3/63rsKveYAObty2m8uYDzJj/kIbcZ90KnY1Apt+tEAuzS8TGoyzXp/D89rBLkknX
         lCSl6oZxD/QfDdnsY8Uvgs22tr7bE7/CWeRmw+TNOD/apaAwv4k3DCR95NqxIKKAl3jc
         f1sQ==
X-Gm-Message-State: AOAM533NL5zmljPS/5oY6sjVKLo2l+UpD+Q7CosVQ8t3hNvXKBw10TlY
        Uiw025VHKNnLtvYV8ij/igfH83DBSX0=
X-Google-Smtp-Source: ABdhPJwkB3tgpBBi5UXbvFeuVpvGShDfBKoRqNIjYrqG7ne0qJpRK8YU+YxeKqMNsY2YHH5EyhT13g==
X-Received: by 2002:adf:f711:: with SMTP id r17mr5920812wrp.358.1615421716768;
        Wed, 10 Mar 2021 16:15:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s84sm1026447wme.11.2021.03.10.16.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:15:16 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] bisect + tests: remove old $_x05, $_x35 and $_x40 variables
Date:   Thu, 11 Mar 2021 01:14:43 +0100
Message-Id: <20210311001447.28254-1-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc1.213.gbfdb770ff55
In-Reply-To: <YEj82fOf+F4xJC8S@coredump.intra.peff.net>
References: <YEj82fOf+F4xJC8S@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A cleanup in the spirit of Jeff King's just-sent series:
https://lore.kernel.org/git/YEj82fOf+F4xJC8S@coredump.intra.peff.net/

Applies independently of that series though.

Ævar Arnfjörð Bjarmason (4):
  git-bisect: remove unused SHA-1 $x40 shell variable
  test-lib: remove unused $_x40 and $_z40 variables
  shortlog tests: rewrite to get rid of --abbrev=35 hardcoding
  tests: get rid of $_x05 from the test suite

 git-bisect.sh                       |  2 -
 t/t3101-ls-tree-dirname.sh          |  2 +-
 t/t3508-cherry-pick-many-commits.sh |  4 +-
 t/t4201-shortlog.sh                 | 92 ++++++++++++++++-------------
 t/t6006-rev-list-format.sh          | 12 ++--
 t/t7600-merge.sh                    |  4 +-
 t/test-lib.sh                       |  9 +--
 7 files changed, 65 insertions(+), 60 deletions(-)

-- 
2.31.0.rc1.213.gbfdb770ff55

