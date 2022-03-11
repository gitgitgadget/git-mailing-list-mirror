Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30CDC433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 00:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241475AbiCKAEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 19:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbiCKAEd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 19:04:33 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC341029D5
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 16:03:30 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u7so9955845ljk.13
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 16:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aMuRBBLsdbSrricRIGHNj6SPzt7W7cGCVvDWd8TSODg=;
        b=q6PzKOdDoTozq9OqvZHOLYGBUxIYLaDpXqWY6FW6iuzYPIo6D97LJisTPwGjC+yFUr
         7XFzH+Ojf9l2osf1PBmPoJuQvgCkoVrLqqwX48gJGGGSqSqZhNOTkrKFMhqeRrW3PPaz
         u2E9A4XvpUYIQaFfaKSygR3FPaoOvjoFnbqCnX9nQpjrK573zaXXq34mNVFRl4ZFvvDt
         j93MzqyVwAEQ/HhbQj79zZfXw8yG3fDrFDV0O0BTAoOk7mqh+4O56zps8ceohcgHnY+X
         rfdbKZlqc6NA92nTAdQtQeErwH5pmWeuwUbxlpuVF5znuzkrpPyYGr723wHlt6hEYjGk
         VE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMuRBBLsdbSrricRIGHNj6SPzt7W7cGCVvDWd8TSODg=;
        b=yTZQfqZ+pQHQFf6Ln7SpJKhDD/UXu9chsi3l8WBw4KT4czhL/PNmdvJBWhJzgqGygo
         6gu/Qu17KbIuYR+JiE2UheYcUl9Db/i0d/XdflQino99+Ho3uFMqpWKXhB9wK1bY/5JO
         8u11ectMLrS5LCX+DTXIF8jBc/lZO1md0DOf5S+jGKD2IvVSstbJD0SOH+GYcos+Swf6
         z7NO1QswWE68SQ6Rd7oIwx/D3G8dpQk4DMlHfF2oL+/biuWFpu5PDUdiPnQEcWYnCKo7
         P067noKlRMe1VYxA7Dhj4BjFLVZuO9m3C4RX5wt/f0eiTZuAnBzZ2uaDcsL/Byh12+sB
         +82g==
X-Gm-Message-State: AOAM53354f1kdxbYCOC5NQvVIdDxwUCOkOhOZwxYstgCAghChqJkBx1d
        5jVqI/6Jfdg6QsTlRTo/zMPI3IwV88bDNXqhb4Q=
X-Google-Smtp-Source: ABdhPJx2N5h9XLNcWhYVzq6aUFryX0xeXXcA3ctM+fUHQ5w14gUYij7+JbVYXuEDg3KEs5PlNT8ZNYtoMeMSVvDe5Iw=
X-Received: by 2002:a2e:bf05:0:b0:247:b233:cfba with SMTP id
 c5-20020a2ebf05000000b00247b233cfbamr4580369ljr.131.1646957009052; Thu, 10
 Mar 2022 16:03:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
 <pull.1093.v6.git.1646952204.gitgitgadget@gmail.com> <xmqqmthxbcv2.fsf@gitster.g>
In-Reply-To: <xmqqmthxbcv2.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Thu, 10 Mar 2022 16:03:18 -0800
Message-ID: <CANQDOdfX4tXSy_9r8mnXpYD=BoJtEcydAXBTff_ekf=6ryoebQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] A design for future-proofing fsync() configuration
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 10, 2022 at 3:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > After this change, new persistent data files added to the repo will need to
> > be added to the fsync_component enum and documented in the
> > Documentation/config/core.txt text.
> >
> > V6 changes:
> >
> >  * Move only the windows csprng includes into wrapper.c rather than all of
> >    them. This fixes the specific build issue due to broken Windows headers.
> >    [6]
> >  * Split the configuration parsing of core.fsync from the mechanism to focus
> >    the review.
> >  * Incorporate Patrick's patch at [7] into the core.fsync mechanism patch.
> >  * Pick the stricter one of core.fsyncObjectFiles and (fsync_components &
> >    FSYNC_COMPONENT_LOOSE_OBJECTS), to respect the older setting.
> >  * Issue a deprecation warning but keep parsing and honoring
> >    core.fsyncObjectFiles.
> >  * Change configuration parsing of core.fsync to always start with the
> >    platform default. none resets to the empty set. The comma separated list
> >    implies a set without regards to ordering now. This follows Junio's
> >    suggestion in [8].
> >  * Change the documentation of the core.fsync option to reflect the way the
> >    new parsing code works.
>
> Hmph, this seems to make one test fail.
>
> t5801-remote-helpers.sh (Wstat: 256 Tests: 31 Failed: 4)
>   Failed tests:  14-16, 31
>     Non-zero exit status: 1
> Files=1, Tests=31,  2 wallclock secs ( 0.04 usr  0.00 sys + 1.40 cusr  1.62 csys =  3.06 CPU)
> Result: FAIL

Thanks for reporting this.  I didn't see a failure in CI, nor when
running that specific test in mingw.  I also munged my config to
include core.fsyncObjectFiles and didn't see a failure.

Could you please share some more verbose output of the test, so I can
look a bit deeper?  In parallel, I'm trying again after merging my
changes onto seen.

Thanks,
Neeraj
