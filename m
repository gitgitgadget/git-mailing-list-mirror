Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED537C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 15:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245459AbhK3PGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 10:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245300AbhK3PDI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 10:03:08 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C36C06179E
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 06:58:04 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id o20so87448315eds.10
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 06:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=i2GsHLpCnhVTO9mm82dlgb/BY4+TLo9yvmB2d/fh468=;
        b=Psa8TRK//QcXZsrswLhf4MHyXLGzDtpmCb0YrQLx9vR0R0h+pwLDe62bSqYYMufmEW
         k7Br1hK7KDkBtq/XUHl49A3H/vYKgKjXjx+ABw3sm+5vrOarYly97qgS8cA9Y/k9Itz5
         AX/32Zgqf0I8xknlu5X/hLcLUjSr3O+XX3G6BO3u+uIV2cI2QQywIvNXIYaSFsUh/Mwn
         dQ70UOH8kgs277mmysHqS10z2eBw/bXCDCDTN5EMH2FBvLHsYtI64WIleDLSDqaNNMZV
         4y+K0mZVEFkdbrIBmtoFSDfwkyPfchSrWBDp52dmazji/iCZ2wjSOnbQEW1NwI/kQKUx
         KMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=i2GsHLpCnhVTO9mm82dlgb/BY4+TLo9yvmB2d/fh468=;
        b=B/F+2xMx842rkgAYCjOeVx9iWnL2EY77ZRPYr8pIzezDifU/O2gFTiszY7Fxq/0jSU
         EKCSOBcmnBBA30m+N98gZxewvReK1BkChDh1HzdX3wfIqJCqVfXBEHUJ9Kw2CzXS/D1H
         Op1xszG9mxBcfJDeZzc2y6bTpYiH/Vi5Kc4uVkbt7/RZuHGzcRcIoqX3Qrej7RxdRC/l
         PyPhlLtGbdxBfbZJ0lFKuWZE/JMevYKM7GWp/rymwLyl/aOBL10Q33qIQLmKN2rxeNaE
         lYsWdHFS2lnCpDkDT61bSy9s4d7pF3HxBsfnCe4Z3+5+E1bwR2kjq2JFPMNYRiMW2ssn
         6t7g==
X-Gm-Message-State: AOAM531Qq1OmCJajrWu2a0dA6uZcKaKf2mn6lYIT+r0DOO/M7ty1th4V
        hH7VC+TeRo7cJemkQKfnd/fT5SXSimaDlQ==
X-Google-Smtp-Source: ABdhPJyu9UhkZalGX4hXy56JoubsNk/iAxpJVC+GK3bfvnX46JTUH8gIfl2vCD4ylgoLDfPOFP5tSQ==
X-Received: by 2002:a17:907:2bd1:: with SMTP id gv17mr67019194ejc.231.1638284279822;
        Tue, 30 Nov 2021 06:57:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gs15sm9150033ejc.42.2021.11.30.06.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 06:57:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ms4Zy-0012DG-Q7;
        Tue, 30 Nov 2021 15:57:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 00/17] Upstreaming the Scalar command
Date:   Tue, 30 Nov 2021 15:50:08 +0100
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
 <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
 <211130.86mtlleqhm.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2111301450030.63@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <nycvar.QRO.7.76.6.2111301450030.63@tvgsbejvaqbjf.bet>
Message-ID: <211130.861r2xelmx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 30 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Tue, 30 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Tue, Nov 30 2021, Johannes Schindelin via GitGitGadget wrote:
>>
>> > [...]
>
> Unfortunately, you clipped the most important part, the part that I put in
> there mostly for your benefit. So let me repeat it once again:
>
> This patch series' focus is entirely on Scalar, on choosing sensible
> defaults and offering a delightful user experience around working with
> monorepos, and not about changing any existing paradigms for contrib/.
>
> I do see that you want to drag the conversation back to discussing the
> build process, and the CI integration. And on changing the way things are
> done in `contrib/`. You've made that point abundantly clear. I just don't
> see how that could possibly improve Scalar. I mean, if it failed during
> the past 4 months, why expect any different outcome in the future.

The seemingly unintentional behavior change in CI jobs that aren't
scalar jobs you're introducing started in v7 of this series, submitted
on November 17th:

    https://lore.kernel.org/git/1b0328fa236a35c2427b82f53c32944e513580d3.16=
37158762.git.gitgitgadget@gmail.com/

So as far as any CI testing is concerned we're talking about just under
2 weeks.

I really don't see how that and other unintentional behavior changes in
the CI on top of "master" have anything to do with "the build process"
in the sense that we've discussed as part of the greater scalar
integration topic in the past.

I only linked to those thread(s) because some of that behavior changing
(i.e. now running tests in a previously compile-only job) is apparent
when either running with my patch-on-top of this series, or it was
discussed in some threads related to that & the merger with
ab/ci-updates.

Is it intentional that the previously compile-only "pedantic" job is now
running the scalar tests?
