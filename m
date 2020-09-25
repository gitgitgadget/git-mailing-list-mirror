Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2182FC4727F
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCFBF20936
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxnCL6sO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgIYRDR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgIYRDR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 13:03:17 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C03C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:17 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 7so3090539pgm.11
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=37FTFpMSJWGzj8QayRLc4KS0foY5xrhLJ4c8TzHZPNY=;
        b=LxnCL6sOyNsEIKcnyTJcArskn9jqryEGtiWrJQHtnhiN5ThrdJAnr50S0ZW6kH7s0F
         4ii2bhbgJt/usGI2w96BAz3nXJE48byzs9c08zfKlPiayEvT1xgzoaTfPKepm3fPMdmp
         E2Z/O75bT/kf3ePrGMtoelNckAWzPE4jhzce6VxH6Ga67f+PgprVET06TVVi129kBzTI
         z/WnjO3RV8+b/q/AoRUy2fm4xKYoO0HEyihSHr48cqo7CybPEs/sEV7rmopz33YOIWYM
         L571CDtknWa6gGkvXPv6w5UybZMq1Q74d6vCjWY3jNaiDXAlejHwr54cj/hilTV+XrDs
         d13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=37FTFpMSJWGzj8QayRLc4KS0foY5xrhLJ4c8TzHZPNY=;
        b=KkHABpUY9YhL349cmfxYlebFWwV/7Cc/OyEXdKYRFb5gepSH8JcJYlAJiQGIJT12KM
         MwG+NXljRTb+iLe28sUJW6Mi5gYCJL/04RTeH93rVELy+8kdxCur8noMUMMv54WIcH0l
         /8fLuw3GqWno5z8mFY/iyAkCiggtxdjK9Qg4yj0WkaIjETWuSHA5wnKdFC84Z4LoWVFD
         uNsJhfL2+tNk2YmxInsvQsTJvZz5IRuOnp1esd2Ad1+59Mee8pIJzMq+e8UUok57vkkT
         W0YIzP0xTfWhNhfpdm5kkf5o7w4MT/3vcWJ+1iQr8sE3NqelYKhyhVW+hkbnXjhRY947
         mgzA==
X-Gm-Message-State: AOAM5320zl38g58q8KFNK/Q0zS8lxrhvtNrute1wpAfIyi1WSd4sx5z9
        2zk/vz/HthL5I2u5te0C9UR/mgZmqKvJhw==
X-Google-Smtp-Source: ABdhPJz4r2GibFPrvZmfm4VKGjkJz58Az1wNEk92fFjm1yYQbUmkxwr0cPwq2UeJwRV0XEcgySsAGQ==
X-Received: by 2002:a65:63c5:: with SMTP id n5mr829491pgv.437.1601053392482;
        Fri, 25 Sep 2020 10:03:12 -0700 (PDT)
Received: from localhost.localdomain ([47.9.163.48])
        by smtp.gmail.com with ESMTPSA id k27sm2822467pgm.29.2020.09.25.10.03.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 10:03:11 -0700 (PDT)
From:   shubham verma <shubhunic@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 00/11] Modernizing the t7001 test script
Date:   Fri, 25 Sep 2020 22:32:45 +0530
Message-Id: <20200925170256.11490-1-shubhunic@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In this patch series modernize the t7001 test script by changing the
style of its tests from an old one to the modern one and by cleaning
up the test script.

Shubham Verma (11):
  t7001: convert tests from the old style to the current style
  t7001: use TAB instead of spaces
  t7001: remove unnecessary blank lines
  t7001: change the style for cd according to subshell
  t7001: remove whitespace after redirect operators
  t7001: change (cd <path> && git foo) to (git -C <path> foo)
  t7001: use ': >' rather than 'touch'
  t7001: put each command on a separate line
  t7001: use here-docs instead of echo
  t7001: use `test` rather than `[`
  t7001: move cleanup code from outside the tests into them

 t/t7001-mv.sh | 393 +++++++++++++++++++++++---------------------------
 1 file changed, 181 insertions(+), 212 deletions(-)

-- 
2.25.1

