Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8176EB64DC
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 10:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjFUKzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 06:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjFUKym (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 06:54:42 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E291737
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 03:54:29 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-56ce61769b7so61582247b3.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 03:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687344868; x=1689936868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ta7vEMPiNFg4Br3MjhG7L+TtBWiDYoJCPiUgJXonQBg=;
        b=JS33RJt7eIt+dwbUjCO1z652vXdDf+byGjioKpU44oeAC3/Qm7yjfvaFIgeDoMwmWl
         IKUTGXE9Z9Epa+4ls9E8x/cw7qRfOk46D2+3LsHWwQr/SL1CglVtmgc7AnDtWQpa3ekp
         jMZAlY4UqWnddXuwTowItN81hh2UWHIPM/Xuhm5cDYIDZeC3cHNfvC0juHtkiyv1HkLp
         GZfUN37hYIyl41TC8lslKccPb0FsB1fl2wOAZAW1kIIWNGivO5+9oXyArsinvtZ5LJmx
         wISwiR1TfFC8NzHq19BLV6gfytee0b0Vjgfah5I/+5UiBUEhOAOYTQWOVWKmbml97M8A
         dXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687344868; x=1689936868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ta7vEMPiNFg4Br3MjhG7L+TtBWiDYoJCPiUgJXonQBg=;
        b=Y+YWnGQaW5zxFSz8t0Ni0oXbnpKVHm4HwRTtwBAwtpYZlSM0oOOOaMvkZLXtKNnZGl
         EqZEFL/7Wc03ObE8I9xe4fql5Yu5AbV8us38DRZ4bK4erP+VNPm7VNLYyZDPkqt7XNQQ
         qSqc0Xgpd2RaP3z61N5fUBgRsEyS+B1BN54m/EjxyKu01U2XX6XN2bB7bcBFSbMjrBra
         gF40JLjNHeI0ujk08H2cTNZYfz1F8HU4ouNKdu23DxfKAwtlyE36ZO7lffyjK2Lh54Hy
         ggxmZBZUTIiuvoGh1VMYjcMH3YK3/ZStamBOu8PlkvXE60VjvCP/rXua/OQtqGsIaP8D
         Zs/w==
X-Gm-Message-State: AC+VfDyJW3rkVal0nak3lahsO6afAAykfVrdTJpP7t9UtJreHu3BS9z9
        bLHt5yRE/Dy9NhXuXII1IOPXwA==
X-Google-Smtp-Source: ACHHUZ77eDPRPGBm0pJdA1ckr+V33m5qWDdwWKXVSFMv1EVXvKM76dNZtMqOSyjxLHHth8kcibzhZg==
X-Received: by 2002:a81:6554:0:b0:573:b24c:a527 with SMTP id z81-20020a816554000000b00573b24ca527mr419634ywb.41.1687344868742;
        Wed, 21 Jun 2023 03:54:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i187-20020a0dc6c4000000b00565d056a74bsm1039765ywd.139.2023.06.21.03.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:54:28 -0700 (PDT)
Date:   Wed, 21 Jun 2023 06:54:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/9] t/helper: add 'find-pack' test-tool
Message-ID: <ZJLW4TPDpxjkHS4h@nand.local>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-4-christian.couder@gmail.com>
 <xmqq1qicuwrw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1qicuwrw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2023 at 04:32:35PM -0700, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
> > In a following commit, we will make it possible to separate objects in
> > different packfiles depending on a filter.
> >
> > To make sure that the right objects are in the right packs, let's add a
> > new test-tool that can display which packfile(s) a given object is in.
>
> This tool would be serviceable if we only are interested in checking
> just a few objects, but if we were to check many objects, I have to
> wonder if it would be more efficient to use show-index to dump the
> list of objects per pack, which should be sorted by object name, so
> it should be trivial to run "comm" with the list of objects you want
> to check.

I was going to say the exact same thing. Even if we were checking many
objects, can't we dump the output of show-index to a file, and then grep
it repeatedly? Presumably these tests are working on repositories with
tens of objects, so I doubt it matters much either way.

If we do end up taking this approach to use the test-helper instead, the
implementation seems reasonable.

Thanks,
Taylor
