Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4116DC43219
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 19:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiKUTA4 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 21 Nov 2022 14:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiKUTAy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 14:00:54 -0500
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EB85CD22
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 11:00:54 -0800 (PST)
Received: by mail-pf1-f172.google.com with SMTP id k15so12190679pfg.2
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 11:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSdaayKvYHTIXTPCPlZiJStWf1VN1DqVlNcbNRYcjRg=;
        b=5E0v2uDdLPxbLKw3z/rX0OqZJPIUjqz+DbSxyXkq3cKsyQAZoqom8eEwxuPqI87ifr
         Z/u87yBrBx5+6ob4Xgz2vSlmFz13QN5e9wDs21WDHoNnLzMAUUShINro+Ur9aEyn6p5f
         kG+04bVW4tcOo+KfvFoe7/NiYNpVRe5+CEUHgN2D8E/KcUpKAcbVFuq4VU1Sl4ZEtdDD
         jjXbtzams5HpCy8fQvYXe5odLk2nTbyohXEAjYlJ9WERRBeD5eJMURE+nb753UlBxUKY
         aUkoO8AcHMsXQxgcTHDdZ34wQHANY59srFgKqypyq+nLZJdbT1R2r8YIeDEvI8afG4WY
         cjqA==
X-Gm-Message-State: ANoB5pkZg5tPiSMkW8A061Ch9G0uHEr7m/fRxI8WfXnGJcnnc2sDMT88
        xewVOcCu504kZQC8lLvk9gnMOE9pd8a429IyYxA=
X-Google-Smtp-Source: AA0mqf7pK7/wq0qf9s4Ec0TE7pv+5hmN+6Wcmcr4p11RtYs2Osgqac+889o7c/zI8cVkv0b0O6X2ynK+zvjeXxbSuvg=
X-Received: by 2002:a63:f048:0:b0:477:5e23:f9d1 with SMTP id
 s8-20020a63f048000000b004775e23f9d1mr27735pgj.268.1669057253614; Mon, 21 Nov
 2022 11:00:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <62fc652eb47a4df83d88a197e376f28dbbab3b52.1661992197.git.gitgitgadget@gmail.com>
 <20220906223537.M956576@dcvr> <CAPig+cSx661-HEr3JcAD5MuYfgHviGQ1cSAftkgw6gj2FgTQVg@mail.gmail.com>
 <YxfXQ0IJjq/FT2Uh@coredump.intra.peff.net> <CAPig+cTge7kp9bH+Xd8wpqmEZuuEFE0xQdgqaFP1WAQ-F+xyHA@mail.gmail.com>
 <Y3u9ul1cu+L5d5IZ@coredump.intra.peff.net> <CAPig+cQfkkY2Eh=QD47QoUGuAiCEpxSsX24x_8ts2GTKVnV1aw@mail.gmail.com>
 <Y3vI99ZiNdXddX8C@coredump.intra.peff.net>
In-Reply-To: <Y3vI99ZiNdXddX8C@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 21 Nov 2022 14:00:41 -0500
Message-ID: <CAPig+cQEdidB4YHm9OiyOUe8mbTPBajjX5t-_6ZJVwRykXkqmg@mail.gmail.com>
Subject: Re: [PATCH 06/18] chainlint.pl: validate test scripts in parallel
To:     Jeff King <peff@peff.net>
Cc:     Eric Wong <e@80x24.org>,
        Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 1:52 PM Jeff King <peff@peff.net> wrote:
> On Mon, Nov 21, 2022 at 01:47:42PM -0500, Eric Sunshine wrote:
> > I think Ævar's use-case for `make` parallelization was to speed up
> > git-bisect runs. But thinking about it now, the likelihood of "lint"
> > problems cropping up during a git-bisect run is effectively nil, in
> > which case setting GIT_TEST_CHAIN_LINT=1 should be a perfectly
> > appropriate way to take linting out of the equation when bisecting.
>
> Yes. It's also dumb to run a straight "make test" while bisecting in the
> first place, because you are going to run a zillion tests that aren't
> relevant to your bisection. Bisecting on "cd t && ./test-that-fails" is
> faster, at which point you're only running the one lint process (and if
> it really bothers you, you can disable chain lint as you suggest).

I think I misspoke. Dredging up old memories, I think Ævar's use-case
is that he now runs:

    git rebase -i --exec 'make test' ...

in order to ensure that the entire test suite passes for _every_ patch
in a series. (This is due to him having missed a runtime breakage by
only running "make test" after the final patch in a series was
applied, when the breakage was only temporary -- added by one patch,
but resolved by some other later patch.)

Even so, GIT_TEST_CHAIN_LINT=0 should be appropriate here too.
