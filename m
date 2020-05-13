Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A3BCA90AF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 13:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F9B7204EC
	for <git@archiver.kernel.org>; Wed, 13 May 2020 13:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiO7T0Ca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgEMNYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 09:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgEMNYH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 09:24:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18589C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 06:24:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t40so10968454pjb.3
        for <git@vger.kernel.org>; Wed, 13 May 2020 06:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HVnhWciME3+W4HO6MvWffB/Ux2fEUv6UxySLoo7VNm0=;
        b=QiO7T0CaT+2n1I0geQVtle2x2CozwBKz7tczWxIqO7zsF2MinnReTmebc71v4ekDBr
         MlkUYTquaVV3OKLnZabL5tpZBqjNQ6CQsZ6b+X+C7F9YlxbGPwkXQiyPBKhGkE38Ba/I
         B97+7a17tGJeerNyyw04Mutx/iFddrdXwYVpwhMgzD6+yfX5Eb0fowvzV+1XYAySS5XU
         LuyXcqkF/bjTD2RXkskKAcnMjTXOo2BOUHWB2uJLCEfqEkNTaLCCD0p1JWWVmQj/5D2/
         I2cRjnjaLkkSXc0MdaXEcV6z4rQLlG9rIvk3O4/964PhzhtnB5qBuBT33yTBpEvXdsB3
         KfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HVnhWciME3+W4HO6MvWffB/Ux2fEUv6UxySLoo7VNm0=;
        b=dqmtysf5+/cEGurcDUqSXQ/NYGHccpEUjlWwm2nHQwvJzfYrjLjHF01sQeLbsSw9kn
         QnxV4Q7CYBkiM8IO3xWHO1MakEogJ3rGyAGerVJHYqomPVncOpfI5cnMchErMrM3G0Zt
         c+/PtFEzJksp9FDaL/uCPN5gNJGiQJdRtKIxFJaTk+noCzXG9/tTJ3tNwrrG9+iraECj
         dzEHVx5BaJOiOiSw9pUS8obDBnQ2Ioio4P2Nm4O5+AOnqmjm0dzNhzcL35KoP9OAaa/g
         3HL+4ylfRBgTHulB/8FNLRCisHC2Be30Tg3XzEX5HQXzxlyEtYc8gqnsZ63i5/GNS5Ux
         cp8Q==
X-Gm-Message-State: AOAM5312oASQikXj6w4tNfm3qJQ3I2vROgw83gVyBg0HYR5ldW7tn8F1
        dif8PefxTQZxV5qYtsEQskkKI1vZ
X-Google-Smtp-Source: ABdhPJzl+T7K2vfYJsJ6uLo3XIOLzJzitoddGkKWhNy8kmMOfwVgXbj5Ei/kJA0YlrszIpr49F9X3Q==
X-Received: by 2002:a17:90a:4149:: with SMTP id m9mr9137366pjg.200.1589376245698;
        Wed, 13 May 2020 06:24:05 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id g10sm14918530pfk.103.2020.05.13.06.24.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 06:24:05 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 0/2] CI: Enable t1509 on GitHub Actions and Travis
Date:   Wed, 13 May 2020 20:23:05 +0700
Message-Id: <cover.1589375923.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.2.672.g232c24e857
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's our long desire to enable t1509 in CI system [1]

This is here to enable it.

[1]: https://lore.kernel.org/git/1FEDCA48-FE77-44C3-8C4A-65B4C435E6B3@gmail.com/

Đoàn Trần Công Danh (2):
  t1509: correct i18n test
  CI: enable t1509 in Travis and GitHub Actions

 ci/lib.sh                 | 13 +++++++++++++
 ci/run-docker-build.sh    |  3 +++
 t/t1509-root-work-tree.sh |  4 ++--
 3 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.26.2.672.g232c24e857

