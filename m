Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562CFC77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 02:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDNCDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 22:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNCDu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 22:03:50 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BBA91
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 19:03:49 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id p17so5831985pla.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 19:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681437829; x=1684029829;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpXH1dQsvAo6YG4HPv/2BMPrIxDrLeXBQ10bDwzDies=;
        b=dtcymB3pms02IjRJbLHCZIis9jRBkqkBdg6HMqWaw8LHVzy79QUG7CjvRkIsZsa7eX
         bl0vy8MhENMPTpnnJiaqo6dVz3dcBodVAHpOr9i6VfArFPMoNbNy/5rtm0ATBGLvL5QI
         MmKCHjNqFq2hgU3IOtg3H6piAREHTYG+uK2/ioAyFAqyRMAKdTRLL/2sVtL7JVwcLvW3
         R/kUg1pmDpWj8TLE1ouNVc3jOW08VLXmE10bjyUdc7FPHNq1DBZi3PqHmtxKfVwHGpa5
         Wpj2jKIO7VDLSiBUm34aEDEUMAnXmtS3AqEPhnDQyYRe8jvx1BOIGGOBExqmryFRCk2Q
         Zp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681437829; x=1684029829;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cpXH1dQsvAo6YG4HPv/2BMPrIxDrLeXBQ10bDwzDies=;
        b=kg6FHz0Vli8KnFPm1eo2jEP92oqiN0xxktf9WXEwhXjYK6QoAm0w4towHRUHg31u0W
         cF8ga7J8MRg9a/UiUhE0qonzNDYEC0LI6kpUxBWdBkIiPsLWkqWvLAfvRzV90GLnIt6c
         KSv7xOWhfqIdozuTnymkhgMqx+28vlPUBcbeNgMlGdJ+WshM0OE0rDPdcTywuXFGtFIC
         orwpjpkz7f2nA3KHdzt5Yd0dG2PlEnXO9ciWB0PzKO+lhvcjdy8z52FX87nU8u0JXmT3
         C1rYzFkATK+R/BZPZL99kL+G61/vXtWp6zPl+R+YXbmCM6z+FL1wufKE2pn9CIsQJ3Jz
         AEBQ==
X-Gm-Message-State: AAQBX9emWQ30d6xz+ww9hhBB5+etAWeuV86jL65RN0E6j8ZO9SOJYm93
        7Lx2ozT4NeHhrMBvrmP8ZKU=
X-Google-Smtp-Source: AKy350bVOrctK25m2nSwrXGzaTyqquLm8yJbOcNSU4ri67ODSx8wHrql0lqg2mSDFioBaeS241Dl6w==
X-Received: by 2002:a17:902:f94b:b0:1a2:9051:f09e with SMTP id kx11-20020a170902f94b00b001a29051f09emr918681plb.21.1681437829100;
        Thu, 13 Apr 2023 19:03:49 -0700 (PDT)
Received: from localhost (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id 3-20020a630a03000000b0050f7208b4bcsm1881781pgk.89.2023.04.13.19.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 19:03:48 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH v3 00/10] repack: fix geometric repacking with
 gitalternates
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
        <cover.1681384405.git.ps@pks.im>
Date:   Thu, 13 Apr 2023 19:03:48 -0700
In-Reply-To: <cover.1681384405.git.ps@pks.im> (Patrick Steinhardt's message of
        "Thu, 13 Apr 2023 13:16:02 +0200")
Message-ID: <xmqqv8hzusmz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Changes compared to v2:
>
>     - I've simplified patch 1 to reset the preferred pack index instead
>       of moving around some of the checks. This also causes us to print
>       the warning for missing preferred packfiles again.
>
>     - I've fixed the logic in patch 2 to find the preferred packfile to
>       not return a packfile that would be rolled up in a geometric
>       repack.
>
>     - I've added an additional patch to split out preexisting tests for
>       `--stdin-packs` into their own test file.
>
>     - I've changed the unportable test added for geometric repacking
>       with `-l` that used stat(1) to instead use our `test-tool chmtime`
>       helper.
>
>     - I've changed the logic that disables writing bitmaps in git-repack
>       to cover more cases. It now always kicks in when doing a repack
>       with `-l` that asks for bitmaps when connected to an alternate
>       object directory.
>
>     - In general, there's a bunch of small improvements left and right
>       for the tests I'm adding.
>
> Thanks for all the feedback so far.

Loss of "stat" is very much appreciated, as the ones added
in the previous round were the only hits from

    $ git grep '^[    ]*stat ' t/ ;# leading SP/HT plus "stat "

and I suspect among platforms that are not Windows, not Linux, and
not macOS, there may be ones that lack the tool.

With a few fix-ups to the test script I sent to the thread for the
review of [09/10] squashed in, this topic however seems to cause the
linux-TEST-vars job fail when queued at the tip of 'seen' (bbfd3bf)
[*1*].  When 'seen' is rewound by one merge to exclude this topic,
the CI runs OK (c35f3cd)[*2*].  I dug only far enough to identify
which topic among 40+ ones was causing the CI breakage.  Perhaps the
code is operating correctly but the expectation in the test needs
updating?  I dunno.

Thanks.


[References]
*1* https://github.com/git/git/actions/runs/4694670520/jobs/8323047888#step:5:313
*2* https://github.com/git/git/actions/runs/4694155668

