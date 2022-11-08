Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C4FC43219
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiKHSZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKHSZp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:25:45 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBFA50F16
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:25:44 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id o13so7889432ilc.7
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxFeEqJFfTxlNrVuVABELPq5kfuZNLTUoLha1v2z4gk=;
        b=eprbd4Yg2wlk1z/DuEm2TBtN7HOSxVA05qYUzXaSBbae+PX/PV/DPbfEFg+5Q+klZK
         d7lJyLZsRGbYpFQZ1WC35WIM5ftqvMzyTp0qPcN2kWwT4mwdTZQs+3r4qijfjpsjvgce
         YBToVxiKohEr4wXVpnMMo2uuqhMtgOsnhRlolQGAMnSurewraNOvrDlGj3crCaxJwwDb
         qP78ZabMdjWcvVI0MTQjdUAv2Hj5kqy7ASrUj6iIh6vrc0zddbtyM4xaqMP5V8AD1PoJ
         MPagSjgcMXt6JmwHUQCTqFeIG7+mXEaGNPWlX32LOT+rioP8qrNoIUdacFaHuM2SukOv
         RJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxFeEqJFfTxlNrVuVABELPq5kfuZNLTUoLha1v2z4gk=;
        b=s17qNXpVU9mDM3RCVpFAlrycpTf970iLURddU6y7xhWo0GL9/8SUO06TVlpAVEISNm
         1SlC6Pl0PdsziVusobslTSObjDMqtE2rkVs7ePc+5YuuuAFcy5GomH+PT3vHzwDwi7ab
         tA7ShAQCXoahsmJmyrOBZ6YtWlcBvD9YhlfOjvJSC8/onzckZsRoSpNtK4bZ4Tsxatar
         t9foYDbji+E9HnBU7ougvtcFDhpmoPTxTrxfQwql0e0QRxx3SLpBf3RYQcXcqI2DcH6x
         j2/idJX+RWrLsCBm8CCutw5Ga+l83Zv9Ixu6ziSb7IdjqkEwGwVV3YL+NFY3t7VQHrR3
         5rLg==
X-Gm-Message-State: ACrzQf1vAoCH17CoLcInFtP4xsylv+TW+vwnpec0fyJZDQuFLSn5P3YX
        xwLCSHDTGt+UCcf0RHL0IwCpgSAiIFN+jw==
X-Google-Smtp-Source: AMsMyM7j9W2kHwOShQr2MKsyvOeiBZuxUdnf1YLj6Kxsd5pEkywuY7FtnJlBIoMB1sU0CipS9bE+Ww==
X-Received: by 2002:a92:ca88:0:b0:300:329a:3f52 with SMTP id t8-20020a92ca88000000b00300329a3f52mr954540ilo.36.1667931943980;
        Tue, 08 Nov 2022 10:25:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x1-20020a029481000000b00374fe4f0bc3sm3952418jah.158.2022.11.08.10.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:25:43 -0800 (PST)
Date:   Tue, 8 Nov 2022 13:25:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org, git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/1] ci: avoid unnecessary builds, with ci-config
Message-ID: <cover.1667931937.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an alternative approach to Johannes's patch in [1], which
cancels running GitHub Actions workflows when newer ones appear via the
'concurrency' controls.

Though the original patch was promising, it does not satisfy all
workflows. A couple examples:

  - ÆVar points out in [2] that he pushes a topic branch multiple times
    while working on it to see where CI breaks along a stream of
    commits.

  - Junio points out in [3] that he will often push various combinations
    of topics merged into 'seen' to try and "bisect" the culprit when
    debugging CI failures.

On the other hand, being able to cancel previously initiated runs of a
workflow on a given branch name is useful when the branch has been
updated locally and the results of the in-progress CI run are no longer
interesting.

This patch takes an alternative approach to the original patch in [1] by
using the same ci-config mechanism to cancel in-progress jobs when newer
ones appear only when configured to do so.

The original patch I posted with this approach in [4] had syntax issues.
This approach works as expected.

Thanks in advance for your review.

[1]: https://lore.kernel.org/git/pull.1404.git.1667482458622.gitgitgadget@gmail.com/
[2]: https://lore.kernel.org/git/221104.86bkpnzdqi.gmgdl@evledraar.gmail.com/
[3]: https://lore.kernel.org/git/xmqqk046cmmv.fsf@gitster.g/
[4]: https://lore.kernel.org/git/Y2R3vJf1A2KOZwA7@nand.local/

Taylor Blau (1):
  ci: avoid unnecessary builds

 .github/workflows/check-whitespace.yml |  6 ++++
 .github/workflows/l10n.yml             |  6 ++++
 .github/workflows/main.yml             | 40 ++++++++++++++++++++++++--
 3 files changed, 50 insertions(+), 2 deletions(-)

-- 
2.38.0.16.g393fd4c6db
