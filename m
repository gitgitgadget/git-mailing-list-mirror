Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B8BC433EF
	for <git@archiver.kernel.org>; Wed, 29 Jun 2022 02:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiF2CJD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 22:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiF2CJC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 22:09:02 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93F5248EB
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 19:09:00 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id l11so25341515ybu.13
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 19:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4iSiL8hQRkMNjhvKreFlAvOMY46KNi3SFzmBWGyY6SQ=;
        b=qfd84cx2sPC5d0o77Ib4eE3NONukfafIMaJp3mb6VqU4GxCCVV9y71x37dEJ94c0Si
         tRVPnW/jw2dwwpCXmPRG9Pg23PX4YfhuYLxJv5KLlHkyag6LT7s2aZgFJ17ALod2weCp
         XeTuoNbRkE3BE2YonrNDmluKevULF/eXJa8PtwBJaby2W4aMlBzehsPMFWBLbSHIliJe
         QBjMWUvsoOJwUnGR+lqH0MfmpzydvgEuER7SjNsWv8EsuQTIvHEbKKaY1eB/xFKmA5SV
         CAizGlQ73hqHV4nnfxmIxlUaphM/8PwOYa+vZqkZ1TatwIk0+or1lfleh/NeAi+RVhi6
         rNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4iSiL8hQRkMNjhvKreFlAvOMY46KNi3SFzmBWGyY6SQ=;
        b=GIj9M9xtfdiO0/iog6R5C/xZC4ZEE/ARO0BUNyDekMjHxL56LthOK4oAixD39zeNjs
         aoBJi1RUYZCfMdXLk2jlbQRK/lcyMc1D32Ueea2RoLE6SPyWFOf2vgh+gJOiUPr3XlQp
         +oG9MANMzLVeBD5061pqvMPs4qEWYDZtzEBmZjHuz44qrWuuvXzn7As9c5t2o+U6jzAl
         1CVxuGnFqKptpb7qYpcAo4soFTWRsPZoSHPgma934VWdHrCpGFwf92IysnK5u/F+Zhtw
         fPta3AtpDzAkuMOhllrsq0hlHkgQdSOBnWTH8+TLXU0hDyhLrD892P8tnAQFCHxAeDWZ
         Heqw==
X-Gm-Message-State: AJIora/d0YpHLpT4woQ45CytDlrrO8MY7dNGZKeERkbsLDLmvcCZd5xh
        wni9KxPP4j7/5IZdEUaWocCD5BbpKFc10kgiwnX9LQ==
X-Google-Smtp-Source: AGRyM1vZtxmYJBVmw+sti/FKQbY8jqbxjQKoey7+is1Z2vX37c8xOTfEHrb3Vr8TrOMD9mJvZzeyHpTQ7Eg4yBPVvik=
X-Received: by 2002:a05:6902:243:b0:66c:8e4a:4bbb with SMTP id
 k3-20020a056902024300b0066c8e4a4bbbmr911316ybs.22.1656468540014; Tue, 28 Jun
 2022 19:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656044659.git.hanxin.hx@bytedance.com> <cover.1656381667.git.hanxin.hx@bytedance.com>
 <3cdb1abd43779844b8e8dc094e2fd2da1adc461a.1656381667.git.hanxin.hx@bytedance.com>
 <220628.865yklgr6g.gmgdl@evledraar.gmail.com>
In-Reply-To: <220628.865yklgr6g.gmgdl@evledraar.gmail.com>
From:   Han Xin <hanxin.hx@bytedance.com>
Date:   Wed, 29 Jun 2022 10:08:49 +0800
Message-ID: <CAKgqsWXawRg6DgvORs709YSsQFqKgiQ=u2LN8Fx3LVXdfbJAag@mail.gmail.com>
Subject: Re: Re: [PATCH v3 2/2] commit-graph.c: no lazy fetch in lookup_commit_in_graph()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 28, 2022 at 3:53 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > +     test_i18ngrep ! "fatal: promisor-remote: unable to fork off fetch=
 subprocess" err &&
> > +     test $(grep "fetch origin" trace | wc -l) -eq 1
>
>
> Use "grep", not "test_i18ngrep", and this should use "test_line_count".
>
> But actually better yet: this whole thing looks like it could use
> "test_subcommand" instead, couldn't it?

When using test_subcommand() we should give all the args,
if we remove or add any args later, this test case will always
pass even without this fix. So, is this test case still strict?

    run_with_limited_processses env GIT_TRACE2_EVENT=3D"$(PWD)/trace.txt" \
        git -C with-commit-graph fetch origin $anycommit &&
    test_subcommand ! git -c fetch.negotiationAlgorithm=3Dnoop \
        fetch origin --no-tags --no-write-fetch-head \
        --recurse-submodules=3Dno --filter=3Dblob:none \
        --stdin <trace.txt
