Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D0CC38159
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 00:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjASAKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 19:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjASAK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 19:10:29 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A7D48A12
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 16:10:28 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id z10-20020a170902ccca00b001898329db72so352498ple.21
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 16:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=it18O9wG4VJx2OmRPvxF8sUD8VvzR8ZAXjyWfPSAqtM=;
        b=ZP6t8b85y2bTjpwY4g+kSxDrbFcLleOqkzVm3G5El/u4HUkx1E5GiwLuRNxscxdzHg
         XnW69yROeC9Qy4ympQYxhp/y455m9gnxVDKqCHorcBRjVknVOVpiLo8PNopE/NnHGGaP
         jlbK6rIjZt+5HDGCdzT5yahGynTjkfvD2i/3PrdYx7rbsxZVRLsJZyYbfG7A/jTKBLm7
         VkQUJHTh8IA86TuaR6j3seDqQo7qiLyon7fsdsj5pa3A6LSGNiFEat9zaQKo3uJDzHvQ
         Irnx0dnuJ6qPNmySMHWSUzGN51A5jXBpmGt4DNCqUk2yvZc14v7pvNYJdMinT+D0hU6R
         iZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=it18O9wG4VJx2OmRPvxF8sUD8VvzR8ZAXjyWfPSAqtM=;
        b=CMEeiexpceZyATqYWeet5hJ6bLqBRUpySaRT6FzsH6ZqF+N7T/jDASa0ppLofA2CsD
         5y6+hHrNzYh09r+lC8LHXHXuKGpmNx6i6/vvDNm91dgFqK6ejWjSzvvzXpRLu3+ceBE3
         wZP7yBf8v373V4OWCbO6ijUTZKbyMyLNfIsh8/lCp6Qpp1bobmSC5tvaoXZe2k5QQQr4
         4vq3pFHUzXg8mv8e2okoKiwmHd7xiqgDyJjioPrgSGSlXBkGIlRYFGjoL+AE2LtvOe0l
         s05Fb/4v5Uip8htbt3LXXqLGhljEcen/p5Yk99GBl2H3N7+ttYIf+7OzTiN2dHqMDZ6t
         X+cg==
X-Gm-Message-State: AFqh2kopEr4HDVDMJNGCebH5+CHsOPFRMjz4wVtG6UrB6WGkGIssQVb/
        22kfsk3VCLUmuF1MFAfnLoNrKcRZiUiz4w==
X-Google-Smtp-Source: AMrXdXtEupKJp80ZsH5R9rmOsCWN3Jd4zXNzE8bk9mvxEXA7lQww3omV6GjvcwswHT8BbZRFCtVR3azZZHfcaw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:2a4a:b0:220:1f03:129b with SMTP
 id d10-20020a17090a2a4a00b002201f03129bmr451287pjg.0.1674087027524; Wed, 18
 Jan 2023 16:10:27 -0800 (PST)
Date:   Wed, 18 Jan 2023 16:10:19 -0800
In-Reply-To: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
Message-ID: <kl6llelzo044.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 0/9] config API: make "multi" safe, fix numerous segfaults
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "SZEDER =?utf-8?Q?G=C3=A1bor?=" <szeder.dev@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We covered this at Review Club this week (thanks for coming, =C3=86var!). Y=
ou
can find the notes at:

  https://docs.google.com/document/d/14L8BAumGTpsXpjDY8VzZ4rRtpAjuGrFSRqn3s=
tCuS_w/edit

The overall sentiment from the meeting was that this is a positive
direction for the config API to go in. My personal opinion is that this
series is close to mergeable and I had mostly minor comments.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason         <avarab@gmail.com> writes:

> This series fixes numerous segfaults in config API users, because they
> didn't expect *_get_multi() to hand them a string_list with a NULL in
> it given config like "[a] key" (note, no "=3D"'s).

As you mentioned in Review Club, this series also fixes a wart in
config.h where *_get_value_multi() returned a "struct string_list"
instead of an error code like all other getters. So this series is
technically doing two sort-of-different things...

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (9):
>   for-each-repo tests: test bad --config keys
>   config tests: cover blind spots in git_die_config() tests
>   config tests: add "NULL" tests for *_get_value_multi()
>   versioncmp.c: refactor config reading next commit
>   config API: have *_multi() return an "int" and take a "dest"
>   for-each-repo: error on bad --config

Fix the wart..

>   config API users: test for *_get_value_multi() segfaults
>   config API: add "string" version of *_value_multi(), fix segfaults
>   for-each-repo: with bad config, don't conflate <path> and <cmd>

and introduce the better API that won't segfault, but I think it's okay
to have the series do both since they're closely related enough and the
latter is quite small anyway.
