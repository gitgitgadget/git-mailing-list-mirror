Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A08C0015E
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 13:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjGYNl4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGYNly (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 09:41:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E002E7
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 06:41:53 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991da766865so931081266b.0
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 06:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google; t=1690292511; x=1690897311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fiUp6IVzShen0mky+h9TkPkcKqqaMtqc32FlicgPffU=;
        b=NF7wwaBPdxQZwT2Uxz0euaSIs5nN/RDAuU22Ss20TtLE9SbYGMqJD4gi3JaJEPBVRH
         v4EgnnUq9F7bdOTg/yINcmCftXyXECeBmC4Mv8rYVg7k+CzIQKl5113FrGY7gi6mU6d+
         DqlkRl9loJjIMuBTX95xBDg3Y0kx8N6ILghZNyY9kXH8ffjJLTVInfa0BcUZPwKO5if0
         QXsfyBSW+ptjVnbDHBs4hlSgJx/ZgRoWyugF/dns4VgheSjigSqKaJqQs8B39iOX6qt4
         xUhPP7JJ7sES+FWHc85pplRaQ8c7bhztqq7Xh929gb9ZQjnuBoiarOuJWdh+tXU9TtwT
         yXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690292511; x=1690897311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiUp6IVzShen0mky+h9TkPkcKqqaMtqc32FlicgPffU=;
        b=QjEFoMvl5zcRK+3E0k6NTTmrSdtbLrM7gx7YKU7l5iNp8SCxXMd431JZGHGiZ4FNsr
         kt5yvUQOqJFRSXWVRU/D/RSlgPD/oqMIqhxc0qB9P2JwCnAYfk8BQRS32Ewp7ma19Dqo
         oUr9niIWmBZ/MoiZTkLgezLN79kOQEv0ttrJHKN9j9k+mwP95Knv/V2PrGg7AX7A599X
         bJPBTaXvMDdoFJOoIbYjmRPAn3uzYo9UzYGy17+g5HHzAgULy6iYoF4InAOH3j+U4TSJ
         eMdFVaL5tKscIg7I92aUFp99QZSWOQjS78Ecyz98zCHfLPB2g1dLINmqqX9gesNf4+7r
         M2Gg==
X-Gm-Message-State: ABy/qLYoBziLLhzrg8Ff9BCgEOsN7pWHIqxnBCWVkaygciWfDzbo9ng4
        wIvZv9sbJXYI7PLzFuRW1ixRffjM/OV6mVjzeRvBeg==
X-Google-Smtp-Source: APBJJlEktgaFUb8rsNQBHbg0FQe9sEncncIeX7np9D2ttmM+XPtKB8YWklyTmJYh6MKkGFCsz29wEMuQVJb6X8xFpZg=
X-Received: by 2002:a17:906:32cc:b0:982:c8d0:683f with SMTP id
 k12-20020a17090632cc00b00982c8d0683fmr14491904ejk.18.1690292511485; Tue, 25
 Jul 2023 06:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230705060812.2865188-1-christian.couder@gmail.com> <20230705060812.2865188-8-christian.couder@gmail.com>
 <xmqq5y6y1agl.fsf@gitster.g> <CAP8UFD1tqzp744j0KORw-zcgOn6Tufm4Kk3yct3vHGY29pbm-w@mail.gmail.com>
 <xmqqy1j5p40f.fsf@gitster.g>
In-Reply-To: <xmqqy1j5p40f.fsf@gitster.g>
From:   Robert Coup <robert.coup@koordinates.com>
Date:   Tue, 25 Jul 2023 14:41:35 +0100
Message-ID: <CAFLLRpL8yUb5eSBwCuEcHkgZEZcAdugua0robVUNGUE6Eik8Bw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] repack: implement `--filter-to` for storing
 filtered out objects
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 24 Jul 2023 at 19:18, Junio C Hamano <gitster@pobox.com> wrote:
> Come to think of it, we haven't seen much reviews from those other
> than Taylor.  Are folks content with the direction this series is
> going in general?

For what it's worth I have a medium-term plan similar to Gitlab's with
respect to moving chunks of repositories onto lower cost storage media
& to promisor remotes. Like others, I wasn't at all sure about the
original approach (and commented at the time). What Christian is
proposing here seems much cleaner, is usable without complex
gymnastics or safety equipment, and provides a better building block
for future work.

Rob :)
