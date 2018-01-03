Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D0491F428
	for <e@80x24.org>; Wed,  3 Jan 2018 00:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbeACAqa (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 19:46:30 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:34887 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbeACAq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 19:46:29 -0500
Received: by mail-it0-f66.google.com with SMTP id f143so103470itb.0
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 16:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wpFVWN4PWM8KAUSM+5Kxg47b0ztz2TS6l0eyBGvtRMw=;
        b=inLv6lk5TcEOfncn8DAdV87BQGrC+wxa8PiNewlaKTwzMZIvtIUuPjZMPx23lUR+Jt
         lYMGY/2mUFp7sLiVcb8dqI2//H6nvb/7HOcsc2yFWHX07pP0kZrUPTjQHJiHXGCBT+YG
         aBM8Whs4IGet1I1r8ziYzyovVCrTI6d/rH4BpI7nk2NEYa9QdANKkJaCC8gdTeF1xgIQ
         MmhY0jW0EbLMFQQlAcfi/PGJb8ulpcis1pJmb498EJlrXB570qJrNrJZeWptuTach0S9
         efvXxIxJZn2VN0AHIcZbQ3TNE6d3Lkt/HWgeMP04lUAKES8G08xBtZDWPuCRwCZSb/l9
         KGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wpFVWN4PWM8KAUSM+5Kxg47b0ztz2TS6l0eyBGvtRMw=;
        b=Q2VERVgs+/B396t0AZ+qWeDHoSb5/aohkHkBQNSYA7C8QIr/OC69IZ+ScGmTDBVNry
         oduPHbLYPvdt+y4qijnWEoinZQeGaiZpdoD7DGFGc4jd8sKW88mZjHgfF5fazC6qUG7F
         zTIWPXQ48v4Vn8xNWbWxXmVmgN23spLfzE2oikPsttCqQPKEWV6fwS9sIkFjtWF/WiU0
         wP/3Q+0tomBjVZeJpTEPm5D951ylNSRSEGMhsXKKHbZxC8MeBH0PLxxo8q4uIvfHT/aN
         tKtO6MGb8Cyrs7HHP5ugy3ySS9gHiZ0NZVfNOZF+38WBpEJuf/8OEaHOz0sL0HNZZthh
         Ixlw==
X-Gm-Message-State: AKGB3mLVOfIrfT8T1Opg5C+zZldq6viQIihlikvvMUk8ea7yEy33SeM2
        yd5EAQ93z3SSRNdcKjFHdudDn2t26+w=
X-Google-Smtp-Source: ACJfBotZ4BMGUTjrhVq+iQloxf6DCPORQwAFa0euEvoNglgViPGhiczDriFC2DExp+arVbi12lltsw==
X-Received: by 10.36.17.15 with SMTP id 15mr54297itf.53.1514940388827;
        Tue, 02 Jan 2018 16:46:28 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 191sm33089itx.16.2018.01.02.16.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jan 2018 16:46:28 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/5] pickaxe refactorings and a new mode to find blobs (WAS: diffcore: add a pickaxe option to find a specific blob)
Date:   Tue,  2 Jan 2018 16:46:19 -0800
Message-Id: <20180103004624.222528-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.620.gb9897f4670-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After some discussion [1], we're convinced that the original approach for
adding in just another pickaxe mode to find blobs was too hacky.

So I went the less hacky way and did some refactoring first (patches 1-3),
Then we'll have the new pickaxe mode to find blobs in patch 4. It grew
slightly larger as it had issues with the setup (we neither have a regex
nor a KWS to init) in this new world, so there are a few more lines in there.

The last patch is just the cherry on the cake, helping to keep users sane by
warning when they try to use different pickaxe modes at the same time.

Thanks,
Stefan


[1] https://public-inbox.org/git/CAGZ79kaB0G9zetF6QtC45+ZGLM3gOsYWV7e+gkCe2yKOhb0Ssg@mail.gmail.com/


Stefan Beller (5):
  diff.h: Make pickaxe_opts an unsigned bit field
  diff: migrate diff_flags.pickaxe_ignore_case to a pickaxe_opts bit
  diff: introduce DIFF_PICKAXE_KINDS_MASK
  diffcore: add a pickaxe option to find a specific blob
  diff: properly error out when combining multiple pickaxe options

 Documentation/diff-options.txt | 10 +++++++++
 builtin/log.c                  |  4 ++--
 combine-diff.c                 |  2 +-
 diff.c                         | 35 +++++++++++++++++++++++++++---
 diff.h                         | 13 ++++++++++--
 diffcore-pickaxe.c             | 48 ++++++++++++++++++++++++------------------
 revision.c                     |  7 ++++--
 7 files changed, 89 insertions(+), 30 deletions(-)

-- 
2.15.1.620.gb9897f4670-goog

