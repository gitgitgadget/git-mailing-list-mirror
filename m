Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961B1C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 07:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6278421D1A
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 07:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2W1VX9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgIHHRV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgIHHRU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 03:17:20 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD294C061573
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 00:17:19 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u126so15942884iod.12
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 00:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0wazG+NJwlr2fO+GwIMecHIBJzo2iECKwIzItceIdDA=;
        b=S2W1VX9Arjc7C25TiqBFLVgwEb5VFp4Wt2Sr19P4VMLaJLM30Td6/Yt2ZJLy8u01VE
         zj4zBvG0KrnnBJjNV2GSri8rRAo0q+e5+qh2FbmevkRN5Qlcc+YFTQWhNmcMqqjZkhnt
         iVJn0Sp18umWNYRl5sJX2T4iz2V3Dc4S4/0XH/ug1bvlEqP28H9MYm2KpVk3BlYAUTp7
         Q9Wx2toEX3wFu8rowyVtC7pSUyAQCqU+haackVEx8lM8ztagIhgRhjdpGLi5oEKAMntv
         Msy4jewtLILamxq7Nya466GszKwFpa/X73bslYC3JAZHU4S5dS58yDzGp6YykWH4yKzy
         tOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=0wazG+NJwlr2fO+GwIMecHIBJzo2iECKwIzItceIdDA=;
        b=CBTrGIYjBgjJjgsRjlSWl/OEphWvzEG5PUGsfDg6NfhoZFTlmOK7yLxtA4Lel+VjiQ
         0lcHLdU5RSPMIHaGPxv+xY/ukyixzHpGCOgdMblJBL36kkyeC0HAsQLUL5xOq3rYe6qw
         E0BBHzTu2yYgEyNXt432FTg2sBgbFcWsCfwgjx9OCrh/J/N5QOzzKd0C0ocyevlUqfre
         FkmDZgTsAipkUI29yAGXv2KVVH/etibC8GUzdhYxKX597BGdKEz7T6DceyMu7vSTvv0/
         fyQA3H+pFGhPxb6BmfewlboCwkma+rRmgqu0oqMnN/qCr9d+yP0oTjMmqPs5Gg8ZtP79
         4AcA==
X-Gm-Message-State: AOAM5323M4hSw++S8AO1IPD8hSMEj7hFqXTHx996MuKtiA8ammwkAJ9p
        0UXVziib1nuF13yYwLcfJN0LAhzA8tg=
X-Google-Smtp-Source: ABdhPJzzIB0kBRvJuinUUBAqk6a3nwEeilwsjyuNiHH/LgluAaIa3vQT9tgVT5kVI6Vn7x7UmSXBBQ==
X-Received: by 2002:a5d:824f:: with SMTP id n15mr19028179ioo.95.1599549438258;
        Tue, 08 Sep 2020 00:17:18 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id m18sm9587778iln.80.2020.09.08.00.17.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 00:17:17 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/3] format-patch: --interiff/--range-diff tweaks
Date:   Tue,  8 Sep 2020 03:16:07 -0400
Message-Id: <20200908071610.16714-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series addresses a few comments[2,3,4,5] which cropped up during
review of the series which added --interdiff and --range-diff options to
git-format-patch[1]. That series made it into 'next' before I could address
the comments, so these patches (based upon 'master') make minor tweaks
"incrementally" (over 2 years late).

[1]: https://lore.kernel.org/git/20180722095717.17912-1-sunshine@sunshineco.com/
[2]: https://lore.kernel.org/git/CACsJy8C8RK6HkfoEYJGZg=sgtJS0WksHD3=7Souw3jYebRo=Sg@mail.gmail.com/
[3]: https://lore.kernel.org/git/xmqqh8kp4otz.fsf@gitster-ct.c.googlers.com/
[4]: https://lore.kernel.org/git/CAPig+cSuYUYSPTuKx08wcmQM-G12_-W2T4BS07fA=6grM1b8Gw@mail.gmail.com/
[5]: https://lore.kernel.org/git/xmqqva93t4u7.fsf@gitster-ct.c.googlers.com/

Eric Sunshine (3):
  diff: move show_interdiff() from its own file to diff-lib
  diff-lib: tighten show_interdiff()'s interface
  format-patch: use 'origin' as start of current-series-range when known

 Makefile      |  1 -
 builtin/log.c | 22 +++++++++++++---------
 diff-lib.c    | 25 +++++++++++++++++++++++++
 diff.h        |  7 +++++++
 interdiff.c   | 28 ----------------------------
 interdiff.h   |  8 --------
 log-tree.c    |  4 ++--
 7 files changed, 47 insertions(+), 48 deletions(-)
 delete mode 100644 interdiff.c
 delete mode 100644 interdiff.h

-- 
2.28.0.618.gf4bc123cb7

