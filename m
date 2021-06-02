Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952AEC47092
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 10:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79AA2613B4
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 10:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhFBKdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbhFBKdB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 06:33:01 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B4FC061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 03:31:16 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m18so1773015wrv.2
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 03:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=N8J+LbDFOVU1JsBtfp/PLDd9uV6TUgqCPNNokEhovRc=;
        b=Grvl+x3wenwRnML6co8xCrX9TfyjQNdX3LhkoMoLIfcejedwyzmlBpfuqmKGfYS5aJ
         aRZaqXNfTJ5lbz2Vj1+aUZmJvUlfRLmDmTEPesG9UJ6fKB5sdg0c2IGhHDoY0/WuTB29
         CG69kV4RHK9kokkTqK9Z11DWtqscZFLyLB91UEd+YsxOXRyfoVi52X5e4Rda95J+kTxw
         TvQjEJMygEybT7pPmkvS1eUthbjywG+UMS+aq8H8QYpS/9vrO58cr74i3SKQqNvPxXdP
         2CQVNRNXDsMKlDmiGMUBpvrI8qmQiTydp/yKdRVKeZRCu8Lc8HI8dDVb3mnGXByFBsPb
         cgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=N8J+LbDFOVU1JsBtfp/PLDd9uV6TUgqCPNNokEhovRc=;
        b=Tq7djy1HX9SBcA9yLahsdGnJS3h7cY9J1CAW2zZYRTGz5M1ZH++5Kj537wdq0yMoJ8
         ++4rBSsCO/GTmeAiXpI99Lnz7A+A7MXKIcmDc1O/Bb+nxqPajuxCoJsmkUqRhTZdO2Fh
         3CR0QfYn4h93/thctSJMkQupmqejD8ynZqD/PMV1ZBFF6i5yb1r4gFL76OQ/b9h6bFN2
         JNSM8tRWuHDWmu0K2n/gLV7bvFt2p5ygVOSGyXG4FMFTBf+zC+qCgf+Qjz2xDIV10j3z
         fNWiV4rVL5Mf54Zlja2Fg7CQLwPq1NQvMUbkhmOQPu6m4H9JBurkwho5NwZvxlmieBII
         X0KQ==
X-Gm-Message-State: AOAM531tgyA5ncetOuzXtFkl5MGJBw1C5q7PnRHPZCBKZcc/mnNWp4sX
        0U2aZ9VwPXFrGznCDaORS4r+E7/FP72hJw==
X-Google-Smtp-Source: ABdhPJxjqTzwBF1VJr5wqgHX/iPu9Rq/iQsRQhj7lPXmw3yJyAIfkFYEkrysmLL3xOunXzrKPiV66w==
X-Received: by 2002:a5d:504d:: with SMTP id h13mr26414595wrt.133.1622629875269;
        Wed, 02 Jun 2021 03:31:15 -0700 (PDT)
Received: from ?IPv6:2a02:587:4411:d162:d4e9:1224:9013:f2e3? ([2a02:587:4411:d162:d4e9:1224:9013:f2e3])
        by smtp.gmail.com with ESMTPSA id p20sm2205042wmq.10.2021.06.02.03.31.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 03:31:14 -0700 (PDT)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Ilias Apostolou <ilias.apostolou.zero@gmail.com>
Subject: =?UTF-8?Q?Request_feature=3a_=e2=80=93no-submodule?=
Message-ID: <c5709df6-c357-56b4-f0e0-673bc8b4e668@gmail.com>
Date:   Wed, 2 Jun 2021 13:31:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git community.

As you already know, git ls-files command lists all of the tracked 
files, but submodule names are included.

My team would like a –no-submodule switch to exclude those.

Best rewards,
Ilias Apostolou

Github: https://github.com/LiakosC
