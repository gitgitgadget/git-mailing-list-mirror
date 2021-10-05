Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F04C433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 15:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB44D61165
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 15:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhJEPqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 11:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbhJEPqm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 11:46:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A7CC061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 08:44:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id l7so548545edq.3
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 08:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=aNHjs6mJHcNjLa08/ZQltLOMwXbmxZxUeIcXgGOOYN8=;
        b=KjQ+t8bT6j3DYu3JjL3iYMwJM3Pz1bTOL7Sq569n+esxu8kspJ4gWywb/L1R4yrOxF
         bMPlmGCWtH4lZiX/goTv2tvGpy4Xp66UCIyCy7NJsVAsxlcL93uybckj4rdvC7MFqgtF
         /zGD+c5qFqBvkSmmyCHJjWOQtVZQb0a8VUTM6tIpX6gPBDS1raVQUD2LuHSckqhwdKnp
         mL9tYccnkK/yEZn0VG37lPVrwqe9XzzKIRGRuIzPqGDpTprWCIDPZ8OreXr++KTNnmvc
         ik/RoyaUlnELN70K5DwWxWZn3W9V2m2yEq/VzldjSm0bvFJqB5dqzaojwuvsF8hXVw3/
         nHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=aNHjs6mJHcNjLa08/ZQltLOMwXbmxZxUeIcXgGOOYN8=;
        b=1Nr8byrq3+8IH/QaGFOOXg9glgtiMpExRoG7fu3BUr6KvHzHJwSQJ2Ldk9BGIQn5VJ
         Cu6VALBhYaMK7F9PB/BMybIlYYVr620cUN6u22jRBS/Z79ry5rSpFgq8Woe+44xH4SoB
         3GpCCIpZuocEtctQPi/bCraaGWBl7m30QfHtjdkeQQ+W99JPapq5J0Zo6W0NxiXCvIk5
         6omzxGMOd9bX5kPylw8dU1WbPbfq3psTbvX70Y0Qhe2s3k3QEvYpsU6f5W0D1EMwSwGm
         3NFa9xa+8VtTDHr9Mjbae/AWUsxyQiLQQ5LSgmxNMqdkv8DtSFWF11NGb7TJ2y47PBLS
         /LeA==
X-Gm-Message-State: AOAM531x2JpvwBGq0dM80mZc+5msFXlxhvv4W8T9na/RfmLKjp2h6hTD
        H3jTjOEOsQDYY1ES0cdYN190dE24aCc=
X-Google-Smtp-Source: ABdhPJxMU3bEHcLcwpsjxNI4DXfxiefhWmka/KMZuilhseFgEeS9mqluJJrWucczQdDiA2Q8+ml6vA==
X-Received: by 2002:a17:907:1b15:: with SMTP id mp21mr17065863ejc.442.1633448690383;
        Tue, 05 Oct 2021 08:44:50 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r3sm1915923ejr.79.2021.10.05.08.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 08:44:49 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        newren@gmail.com, Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 0/7] Sparse Index: integrate with reset
Date:   Tue, 05 Oct 2021 17:34:48 +0200
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
Message-ID: <878rz7lbm6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 05 2021, Victoria Dye via GitGitGadget wrote:

> The p2000 tests demonstrate an overall ~70% execution time reduction across
> all tested usages of git reset using a sparse index:

[...]

> Test                                               before   after       
> ------------------------------------------------------------------------
> 2000.22: git reset (full-v3)                       0.48     0.51 +6.3% 
> 2000.23: git reset (full-v4)                       0.47     0.50 +6.4% 
> 2000.24: git reset (sparse-v3)                     0.93     0.30 -67.7%
> 2000.25: git reset (sparse-v4)                     0.94     0.29 -69.1%
> 2000.26: git reset --hard (full-v3)                0.69     0.68 -1.4% 
> 2000.27: git reset --hard (full-v4)                0.75     0.68 -9.3% 
> 2000.28: git reset --hard (sparse-v3)              1.29     0.34 -73.6%
> 2000.29: git reset --hard (sparse-v4)              1.31     0.34 -74.0%
> 2000.30: git reset -- does-not-exist (full-v3)     0.54     0.51 -5.6% 
> 2000.31: git reset -- does-not-exist (full-v4)     0.54     0.52 -3.7% 
> 2000.32: git reset -- does-not-exist (sparse-v3)   1.02     0.31 -69.6%
> 2000.33: git reset -- does-not-exist (sparse-v4)   1.07     0.30 -72.0%

This series looks like it really improves some cases, but at the cost of
that -70% improvement we've got a ~5% regression in 7/7 for the full-v3
--does-not-exist cases. As noted in your 7/7 (which improves all other
cases):

    (full-v3)     0.79(0.38+0.30)   0.91(0.43+0.34) +15.2%
    (full-v4)     0.80(0.38+0.29)   0.85(0.40+0.35) +6.2%

Which b.t.w. I had to read a couple of times before realizig that its
quoted:
    
    Test          before            after
    ------------------------------------------------------
    (full-v3)     0.79(0.38+0.30)   0.91(0.43+0.34) +15.2%
    (full-v4)     0.80(0.38+0.29)   0.85(0.40+0.35) +6.2%
    (sparse-v3)   0.76(0.43+0.69)   0.44(0.08+0.67) -42.1%
    (sparse-v4)   0.71(0.40+0.65)   0.41(0.09+0.65) -42.3%

Is just the does-not-exist part of this bigger table, are the other
cases all ~0% changed, or ...?
    
Anyway, until 7/7 the v3 had been sped up, but a ~10% increase landed us
at ~+6%, and full-v4 had been ~0% but got ~6% worse?

Is there a way we can get those improvements in performance without
regressing on the full-* cases?

Also, these tests only check sparse performance, but isn't some of the
code being modified here general enough to not be used exclusively by
the sparse mode, full checkout cone or not?

It looks fairly easy to extend p2000-sparse-operations.sh to run the
same tests but just pretend that it's running in a "full" mode without
actually setting up anyting sparse-specific (the meat of those tests
just runs "git status" etc. How does that look with this series?

Since only the CL and 7/7 quote numbers from p2000, and 7/7 is at least
a partial regression, it would be nice to have perf numbers on each
commit (if only as a one-off for ML consumption). Are there any more
improvements followed by regressions followed by improvements as we go
along? Would be useful to know...
