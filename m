Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDB5C433EF
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF206610E9
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352076AbhIHPdS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 11:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhIHPdK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 11:33:10 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2652C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 08:32:02 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m2so2095175wmm.0
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cIaZYo3Wuz0b6VVnfrLb8xaJyKotouTF0IZzb0HJdSw=;
        b=ELELH8Sb3GPfDBESGV/UhHBKHKAHTNjmsTzxXvXJXO/+SKABKY7G7Nczk5nGn6XiCx
         OrZ+I+26ixJqRUv0E6O11W5CpzoxmptsPXT+1Mtm1Y3EdB9tdyxZmImn1tE3+dE1ctho
         NnGgp92lMqBzxu4LvWDDgMRhlpGL3yZ0yO3YRBhZSuavb+T+q7AFI1e92NQMd9k0Gj2Y
         3nl2w+IVlAUykFFDdklOe6uV93lYFdAmta7dZZifuDeFXA0M08iR7bDVhWJr8vOcgIoJ
         58HXa9BO0lDJT4/X5Djmfig0kcDANFM5QfCLpWETGowsDd6TwPcxmiVl8l+QVJjQ4/fL
         ytNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cIaZYo3Wuz0b6VVnfrLb8xaJyKotouTF0IZzb0HJdSw=;
        b=DgyMYtNxAvWeBf6gfuKC9N0Q+ojHSDJtSEfLvJdH4ho6aKdS9mpqt0+HPUnCXWwbjU
         DczStlv36wZtIVnjYyiy/Ysg//xjHH6P16Gvb1RNraAGQxly98C/lLIsw5Mu20uRteNV
         oov4V3Y2XS2Q0/zDLoGI+gMDt5IiU4tyQIg2Rahf63brDPqsWtcbyeOIB7VJ/BjR3Lg8
         Zmaprrz3JQ62bmKHvHXnDMaNKIZ6DvZ2ybyUhJ974EXTeqwqSXo/AnGAUhi/YH8XGThW
         WDpgFDkkKfMkWmUGCVjMSyqDwEJKP32IbDFsYkspCZVZkwZBJ6y1YgH4DKuyPIszpw8M
         5Cbw==
X-Gm-Message-State: AOAM533U9ufbGpWDB/p+jm9W2GqERvEYw8vQ2HiYjSkdcf25xeZFG+oo
        ie6HeT3ylYiTPGbkYQf1BJt/J5smZsXjgQ==
X-Google-Smtp-Source: ABdhPJw2rtoYZPuFTLb884/fm1tHsNQsq/FyQAtlDRYYm6ymnDKDsk0+Ho4XwV/0s+CLsqEcqFZ0Jw==
X-Received: by 2002:a05:600c:1550:: with SMTP id f16mr4046646wmg.111.1631115121248;
        Wed, 08 Sep 2021 08:32:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm2385580wrh.67.2021.09.08.08.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 08:32:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] post-v2.33 "drop support for ancient curl" follow-up
Date:   Wed,  8 Sep 2021 17:31:51 +0200
Message-Id: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.825.g2bf60429931
In-Reply-To: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
References: <cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up to the already-integrated topic for dropping
support for older curl versions submitted before the v2.33 release[1].

No verions become unsupported in this topic, this is a mere clean-up.

There were a couple of cases where we either already dropped support
for something, but got the curl version wrong in a macro comparison,
or just got the version wrong. That's now corrected.

But more importantly this introduces a git-curl-compat.h header which
centarlizes all our curl version dependencies, and any compatability
shims we've got to deal with those versions. This makes the code much
easier to read and maintain than inline LIBCURL_VERSION_NUM version
comparisons, and will make any future dropping of supported curl
versions in the future easier to perform & review.

1. https://lore.kernel.org/git/cover-v4-0.5-00000000000-20210730T175650Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (5):
  http: drop support for curl < 7.18.0 (again)
  http: correct curl version check for CURLOPT_PINNEDPUBLICKEY
  http: correct version check for CURL_HTTP_VERSION_2_0
  http: centralize the accounting of libcurl dependencies
  http: don't hardcode the value of CURL_SOCKOPT_OK

 git-curl-compat.h | 123 ++++++++++++++++++++++++++++++++++++++++++++++
 http.c            |  39 +++++++--------
 imap-send.c       |   2 +-
 3 files changed, 141 insertions(+), 23 deletions(-)
 create mode 100644 git-curl-compat.h

-- 
2.33.0.825.g2bf60429931

