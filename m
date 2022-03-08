Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DFCC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 18:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349658AbiCHS0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 13:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349680AbiCHS0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 13:26:25 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEF95A084
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 10:24:09 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d07ae11467so167666087b3.12
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 10:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+6TnCVcKJcQEklrX7nsYWMIPUNqQwU7IFlaCyJqfjm8=;
        b=ltncjhDvUswBdX3B/IGWCy3Kk7CJJuaw1S4/TQ3ZYVtCzlvaScBinxOrKF8l0alxAy
         kbCL9/MqC6ip0BcVQG720LTRq03LC4RXjo6rmh+bA7uMjTj40aBtzLDaK+mOuYyWiMLu
         r3HZCSAzs7nHpW2uia1G+a/xxoAf0BiB1yM3BYjc56gUZsufT7IFSPb8jxXFliiPR3RV
         USmpWKbA3/de37fIhm/+UzRr7ElAW5PKItQb4jJh6uyT52U2YpW5w7Z+ac5iPjR91Rq7
         VJs5pEjrFWSiQclGSECOgjnc+xNgtGXQdyTaAu1qiTjXzUZ1KyjNT9gYWNciplxCGadE
         33cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+6TnCVcKJcQEklrX7nsYWMIPUNqQwU7IFlaCyJqfjm8=;
        b=IHzLAbKRQ0fiNKgJs8CkDGvdctO0k5aIyY73C4ITGnSqoQcnl6XldZa+8Kp9ZO2hi9
         Z55EDmTNaXN6ohskJk4F99TUm9Ub2F4vY7P+MTgkF5O7vjT0sJloIzIDiPUdBoGNoUwd
         dBVAE4bHqwJ9wlerWW8NB9ig1NndULB/PYS25K54RGbD9+fFcyHEtumDG/aWmzM/K2aQ
         rNnTB0ehaBLNECKsFrG5h6FM4vSSrpkBSAxmjn5xMuIcUKbsej7WrqXQkqfvVaobNaNn
         cfkilwwRGtbz+EwWW2uYIhPB2yqOUKVDC0glitB+ilIFIjt1gMcbDUpNM4rd1LnO0u25
         ZduQ==
X-Gm-Message-State: AOAM5319mCcvbZ4SrI86eSUfOVsf+A31880Tz0uRxypljHglI2CGdiGH
        7+VSfYOnjf7tWd6DueK9ujYXPlrtKjUslQ==
X-Google-Smtp-Source: ABdhPJwR+TvV6cftMxHj+6XtQ58sOH4/ayiAXfPOmCrnD5uANWpaueXUsejTQ4p2NRfJT2rwTV/I3NXCjhcoEA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a81:df04:0:b0:2dc:48db:dda3 with SMTP id
 c4-20020a81df04000000b002dc48dbdda3mr14130069ywn.224.1646763847650; Tue, 08
 Mar 2022 10:24:07 -0800 (PST)
Date:   Tue, 08 Mar 2022 10:24:04 -0800
In-Reply-To: <xmqqr17dp8s9.fsf@gitster.g>
Message-Id: <kl6lh7885mm3.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220304005757.70107-1-chooglen@google.com> <20220308001433.94995-1-chooglen@google.com>
 <xmqqr17dp8s9.fsf@gitster.g>
Subject: Re: [PATCH v5 00/10] fetch --recurse-submodules: fetch unpopulated submodules
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>>   It's true that we don't need <.super_oid, .path> in order to init the
>>   subrepo, but it turns out that recursive fetch reads some
>>   configuration values from .gitmodules (via submodule_from_path()), so
>>   we still need to store super_oid in order to read the correct
>>   .gitmodules file.
>
> OK, but then do we know which .gitmodules file is the "correct" one,
> when there are more than one .super_oid?  Or do we assume that
> .gitmodules does not change in the range of superproject commits we
> have fetched before deciding what commits need to be fetched in the
> submodules?

This uses a "first one wins approach", which obviously doesn't have
correctness guarantees. But in practice, I don't think this is likely to
cause problems:

- As far as I can tell, the only value we read from .gitmodules is
  'submodule.<name>.fetchRecurseSubmodules', and this value gets
  overridden by two other values: the CLI option, and the config
  variable with the same name in .git/config.

  During "git submodule init", we copy the config values from
  .gitmodules to .git/config. Since we can only fetch init-ed submodules
  anyway, it's quite unlikely that we will ever actually make use of the
  .gitmodules config.

- Even if we do use the .gitmodules config values, it's unlikely that
  the values in .gitmodules will change often, so it _probably_ won't
  matter which one we choose.

- This only matters when the submodule is not in the index. If the
  submodule _is_ in the index, we read .gitmodules from the filesystem
  i.e. these patches shouldn't change the behavior for submodules in the
  index.
