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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD72C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 08:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C23F861212
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 08:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237031AbhIOIMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbhIOILh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 04:11:37 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFE4C0613E1
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 01:10:03 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id g11so1393335qvd.2
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 01:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=psPg7z1M8gP1gcvGygw1a+BNhXOHkeIpz0HlEwvCHP8=;
        b=LlgUuZIBhrOngPtuBSpVBt1QO4eGR/FwMqFLACQj8J3qgh3EWFkGPhDnYEHaQ1I7h2
         6Y86tYNyaBOx48ybBkdKjayRX70g/KfBLvOSx7nmP2KSciPpkB2sAcqFAqSBdIKCxN64
         G2GGQr6YcZ6lGXYV6jebhOu1zvnJwvAIB1+i2U9zqCGvivTrAxGmReo2B4xBSlx4cWQj
         Z1AFaViHBouZvmESvKwAbduedhyRv6QAKFAReveYrrdUAlSlbesK9cXgwgK7wRtZZWj+
         mj9LITdA39PKyNLpDJHGuqrJzl7WbAJhCCGtbGjw4+G6kCfC32tArpjoz/A89AEjP9+R
         AJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=psPg7z1M8gP1gcvGygw1a+BNhXOHkeIpz0HlEwvCHP8=;
        b=GA4/CZn1Wjg9PoEP6kMmRN3wczj9K5/h2CvT3IrK/2j7/SEcV6vvNBZ06tiQ9vR5LZ
         l5k68c5A1Oily7NW5OVwC6BBXDYRh9P3Yqswe9fLcJ0P6dn4bmQDctHCUl9eiVHAqZLE
         g1p/H1J79rBfaTqUFlnfUcg3sd3BIYiNcpbOpG1Hsb7Q8aBeTLBZk7zX5hl6SueQZqZN
         3FQk1G6GGk11gHYzZ7XwkOChWZj8AlPW5WEft9sdrK1mqf5iVwCO1CEDu4nQPCLYqsaE
         v6BQe0ZzG/YpHTEaPaTnb4ykrwltGOcGiOiS8rBww6srr9cMdLDKgOyX/N6Bz+FQky1k
         mlgQ==
X-Gm-Message-State: AOAM532oCqe8toIP/fKc461uVqcqScCW9LKVXyJRdvAEIDzwLU8Z5wOJ
        sVz1BYNoBrtlekr69uG/TaBLeg++8sc=
X-Google-Smtp-Source: ABdhPJzy58kI6GP0taaczxA7LfacVsAc6RWMGdmTSeZ6s/PHjleZL1ci9r45Lo0DY2jHy7XP5WYiEw==
X-Received: by 2002:a0c:90c4:: with SMTP id p62mr9717611qvp.50.1631693401803;
        Wed, 15 Sep 2021 01:10:01 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id 20sm9661435qkn.31.2021.09.15.01.10.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Sep 2021 01:10:01 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     sam@vilain.net, avarab@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 0/3] cvsserver: correctly validate pserver passwords
Date:   Wed, 15 Sep 2021 01:09:45 -0700
Message-Id: <20210915080948.11891-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first patch should be applied by any user of git-cvsserver, and
hashes for all pserver accounts updated; because the code originally
was using the username instead of the password to validate accounts,
and it might had even worked if the first 2 characters of the password
where the same (ex: cvsuser/cvspassword).

The second one allows for successfully running t9400 in OpenBSD and
will protect the code further from the possible use of an undef
variable, and shows that support for better password hashes than DES
is possible.

Carlo Marcelo Arenas Belón (3):
  git-cvsserver: use crypt correctly to compare password hashes
  git-cvsserver: protect against NULL in crypt(3)
  Documentation: cleanup git-cvsserver

 Documentation/git-cvsserver.txt | 27 +++++++++++++--------------
 git-cvsserver.perl              |  7 ++++---
 t/t9400-git-cvsserver-server.sh |  9 ++++++++-
 3 files changed, 25 insertions(+), 18 deletions(-)

-- 
2.33.0.481.g26d3bed244

