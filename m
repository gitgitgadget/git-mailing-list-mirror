Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B96C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 357226113A
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 10:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348618AbhIHKWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 06:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345299AbhIHKWx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 06:22:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E954C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 03:21:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id u19so2192099edb.3
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 03:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=9oPyvR0k2nVpDoPO/bipln9CjIrlTXHh4FJkgm2X2EQ=;
        b=cA3DDgC7rZ7wMfSY4aYlBdsznM7w0RvJXpGbsxaC/5zOHmyHgF1Lmrnmi5VhfpkGCM
         4y69dm7sjU4k4QhSPru0oDrsduOlljD55tHGgP31gekbG7F4UVASttC8JwNKtbB+zkp9
         JcQmm+2C+vAPnnZ5gytnJhPSRoU1ZlKijdB127fk7gUr/7naQyOOUfJ6n9ohPCgkxj5x
         lfAAx/K7ls7CYNOvMMgjHMtGptWM/ZEbZcQRK4v+3wtVH4Xe1pJjm8F8uJn2ytJxsxDe
         WD/KQnSITows7i3YbMDyTT8XAktXq1ffoxB+QHkP+FGwcmNr2UP6ji2CPZpCEabfR9Dn
         6L3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=9oPyvR0k2nVpDoPO/bipln9CjIrlTXHh4FJkgm2X2EQ=;
        b=fD2OKe9+E6Bk23u4EAljUGOZzuGUdb35Wk8dVdp9j7HiaJbF/ds3GvDdt2Ti7isTYX
         IoQPVOsFnE+2fy0xMrESNQjWYUl9xAFLUgy8VlrF5Eb6Sd4TsHHLxg4nK03jTA6QNWtn
         gyhxm60l9OTirM+WBZCkkNY/771j3h1lnsLgtrWb12A/6SCjR+rdgqgB8cKOYkpFcwf0
         X9yHidGS7ZlwFm6RT5TIZAzCVNdEvN1eZTNCfu+MDhciOPBAwkFLMhlzvJRQiB2zDmLy
         CoOdP4khpnFtmcRp4W3gdkemJ1FGDGY9/af/MX9uNOY0ah8wqH+cZ58/Ao009glB+JzV
         r5og==
X-Gm-Message-State: AOAM533xXAjzDUmnkJdS0tZahXwHPZftINXTdCzooGgOStVm2SEOGX9C
        iT69aH2iKE6Qt8FRh+BhOr8=
X-Google-Smtp-Source: ABdhPJzTO0hX7oKX92zNWIEvPQ4l3I+jrxp2HXv8yS5oCzGGrOF2roqAMm1wP5NVQNlga0tlgfd6gQ==
X-Received: by 2002:a05:6402:c84:: with SMTP id cm4mr2982112edb.381.1631096504584;
        Wed, 08 Sep 2021 03:21:44 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k20sm793351ejd.33.2021.09.08.03.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 03:21:43 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] pack-write: skip *.rev work when not writing *.rev
Date:   Wed, 08 Sep 2021 12:18:38 +0200
References: <9f40019eb3d3315cb03440e6237bced4feb6cf67.1617116623.git.me@ttaylorr.com>
 <patch-1.1-366ba928bd-20210908T010743Z-avarab@gmail.com>
 <YTglEreI7nFCII/b@nand.local> <YTgy85aiCL1bJjKE@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YTgy85aiCL1bJjKE@nand.local>
Message-ID: <87r1dziczs.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Taylor Blau wrote:

> On Tue, Sep 07, 2021 at 10:50:58PM -0400, Taylor Blau wrote:
>> Of the two, I think the former is more appealing (since no other
>> functions called by finish_tmp_packfile() are guarded like that; they
>> conditionally behave as noops depending on `flags`).
>
> Sorry; this is nonsensical. The only other function we call is
> write_idx_file() which merely changes its behavior based on flags, but
> it never behaves as a noop.
>
> That doesn't change my thinking about preferring the former of my two
> suggestions, but just wanted to correct my error.

I agree that this code is very confusing overall, but would prefer to
wait on refactoring further until the two topics in flight (this and the
other pack-write topic) settle.

As shown in
https://lore.kernel.org/git/87v93bidhn.fsf@evledraar.gmail.com/ I think
the best thing to do is neither of the narrow fixes you suggest, but to
more deeply untangle the whole mess around how we choose to write these
files & with what options. A lot of it is bit-twiddling back and forth
for no real reason.

Once we do that it becomes impossible to land in a mode where these
functions need to in principle deal with writing a "real" file and the
"verify" mode, which as noted in the linked E-Mail is the case now, we
just need/want these "is more than one set?" checks & assertions because
we've made the interface overly confusing/general.
