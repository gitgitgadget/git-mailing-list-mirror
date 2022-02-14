Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8EAC433FE
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 10:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349573AbiBNKx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:53:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349299AbiBNKxO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 05:53:14 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E2D6D94F
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 02:17:49 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id z12-20020a17090a1fcc00b001b63e477f9fso10659707pjz.3
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 02:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6cus1VSLnAqqPVndZz/sgp0A+OrXLeo0yM2fV3K6Oa0=;
        b=eswK2JISJHoTLZ8Nl2y3by9sPwhJtFzte7Ho/NEptrcJyO0Y6eeZY9tFLsv/HP+vpS
         6v7uInG9HmaY41OtS/kQRWYbL+s9zJaJP7OCWrTUEtwe001egaUH5PyC4AbjaRVcTpo5
         rM9WIl9389S/WHIARLtphMdQCdlHumZs6/m1nloPxA3fD1B92rP6uMNiPeDYGzwpXN/U
         GHA78YU97wgF+wBhi/odq/4pWIzOBNaUf0R1QX7MdVVxnFGpi79aPzi/tvG7macZanSS
         3XVB7k+bJlaNWL7oLI6rl9Su8ti8fdWD7ItQaLWxTuaiY7n7FSmjyKsFsx/15010zV3Q
         29Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6cus1VSLnAqqPVndZz/sgp0A+OrXLeo0yM2fV3K6Oa0=;
        b=Gp23LVl968Y4nLzJ+ga/Kmpbv6l7KgKTy+G/6DU6EwIqAcfsiRM01ckze9HGTK/s7Y
         c6J4WQIoPwlF755c6SRceQIKD9So8GArLMX4htc+rls/8jQsYApgDwRANOqIpN/vQW0q
         +m5ObgeInIcogu2tXh86Kr42cvOM3NOUu8f+H1ym9gUKKHECd5nTHoYMnLUmgUG1QQ0M
         tHQ0tfS+lhfA7wiB1V/NJ1kzRsfxzR7M1undcLblS3h1u1K4XYop95WOVY3xyeYPx1yQ
         G3wKUspr4Xrw+Kg74eQq5kjVSwh3Z9woGmRWyUxgTgAOkrSlKU7rk8cC9jKdrcH1D26X
         nYXA==
X-Gm-Message-State: AOAM530yzJmUkl+hPzZxj2At1L5ZagvF6B+/pHsKoLucGBlmGk3ONvgm
        x0aT4w0WlJ07IGkVIQFZAe/FPfR5e8cfvtFYsufbZtZD+3nFdpEy4XYmjsEWDlQTvcvlLJ9BIAL
        zJPIGJhXeGFcA7QwP7ctg8XlQFqxkLFOGJynQe/Ra4EkAO52VQIXrjbw1ev3PNek=
X-Google-Smtp-Source: ABdhPJytoFEsf7ZnEBBI/p3SIzC24G0cGBIoF+EBfGx4bxz7M9YvCw6QuIzcElf3aTnmD9zq2yn7tLBRoz9U1A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:7486:: with SMTP id
 h6mr13733375pll.92.1644833868996; Mon, 14 Feb 2022 02:17:48 -0800 (PST)
Date:   Mon, 14 Feb 2022 18:17:32 +0800
In-Reply-To: <20220210044152.78352-8-chooglen@google.com>
Message-Id: <kl6lczjp7nwj.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com> <20220210044152.78352-8-chooglen@google.com>
Subject: Re: [PATCH 7/8] fetch: fetch unpopulated, changed submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Teach "git fetch" to fetch cloned, changed submodules regardless of
> whether they are populated (this is in addition to the current behavior
> of fetching populated submodules).

Reviewers (and myself) have rightfully asked why "git fetch" should
continue to bother looking for submodules in the index if it already
fetches all of the changed submodules. The reasons for this are twofold:

1. The primary reason is that --recurse-submodules, aka
--recurse-submodules=yes does an unconditional fetch in each of the
submodules regardless of whether they have been changed by a
superproject commit. This is the behavior of e.g. from
 t/t5526-fetch-submodules.sh:101:

  test_expect_success "fetch --recurse-submodules recurses into submodules" '
    # Creates commits in the submodules but NOT the superproject
    add_upstream_commit &&
    (
      cd downstream &&
      git fetch --recurse-submodules >../actual.out 2>../actual.err
    ) &&
    test_must_be_empty actual.out &&
    # Assert that the new submodule commits have been fetched and that
    # no superproject commit was fetched
    verify_fetch_result actual.err
  '

Thus, we continue to check the index to implement this unconditional
fetching behavior.

2. In the --recurse-submodule=on-demand case, it can be correct to
ignore the index because "on-demand" only requires us to fetch changed
submodules. But in the event that a submodule is both changed and
populated, we may prefer to read the index instead of the superproject
commit, because the contents of the index are more obvious and more
actionable to the user.

For example, we print the path of the submodule when attempting to fetch
a submodule for debugging purposes:

- For a populated submodule, we print "Fetching submodule <path>"
- For an unpopulated submodule, we print "Fetching submodule <path> at
  commit foo"

Presumably, the user would prefer to see the "populated submodule"
message because it's easier to work with, e.g. "git -C <path>
<fix-the-problem>" instead of "git checkout --recurse-submodules
<commit-with-submodule> && git <fix-the-problem>".

The latter is not a sufficient reason to read the index and then the
changed submodule list (because we could try to read the changed
submodule configuration from index), but since we need to support
--recurse-submodules=yes, this implementation is convenient for
achieving both goals.
