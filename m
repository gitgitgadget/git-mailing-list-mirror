Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6EDC433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 13:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243800AbhLAOCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 09:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243293AbhLAOCb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 09:02:31 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE1CC061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 05:59:10 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x6so101727902edr.5
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 05:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=4V3NcZf0Yc+EGjLyMTtJFtBvb9nQ6lfH5056fOD0u0Y=;
        b=FPZ4TmHdt9FQv4YgTc7FPZNYMxzii3stui5ztgSBEwjbeNvVJsYbngbJGNugz4Shkg
         TfMfYJVRT4QvKPBi33eaCRGtWmeVNDGBcyQvNNC7egwbzBA0IVNw6NWPtCGmlmablD0Y
         oya+zK3d2urLGF+swaEKZ1zAb+OtVjajHWXGU8YXXlMeGQstNWkUwFGyv20HRpCpZxDn
         bz4eVeqGIlXnbY1R1fiFogi9TYT66TBIXo15MX15jHHgecPCqc+ZRdiE8d8M7sHhrZbR
         78Xg2bo/BV6YQxO+0iM5H7wsyFnJzbbUKlo8yH4DkYEMmoqTIdiJYD4KjZD9T8kn80wv
         1r7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=4V3NcZf0Yc+EGjLyMTtJFtBvb9nQ6lfH5056fOD0u0Y=;
        b=mCmMwx5suKkKNDHbRT7qv3cIoQx56h+2nhbKt3Nxuaf6uNyKfCdcivwT1Ht0OWZ5ZL
         EnGfW1aL/AYjho+OBnirhuYRRTdQHBjeIWhVyGe+85F2kRZjgdfoaqGddFksttxQNabw
         qujfNKDlyFjYT9rU8gzO1CzbxYCZwhurxzmWdhx5cgQuMFNF41zwIJQrKIOdpj9PCO73
         HlBo7Iz11KicB4GrazDzEKRKoxD8YAEK6DEESrOGquaBv+lTl4v7U2hV3efHEL9zJOOC
         sa5GK5hgn7KBzEd4aUhZBU4OVgil4Uj8ioJupr6iyf6iwtcqoz7KGppJjr2EosdWfzzi
         Jr1A==
X-Gm-Message-State: AOAM530NIE98QUVWaLZOyMkvaQYMWR9RTnowAJYAnOKKRmAytgr7oTOd
        xuAPVtA6/pfHOG1BF3lbRev2oWIYnEI1YA==
X-Google-Smtp-Source: ABdhPJzR2ZC8A6WMCu1Vi7M2k1WC5BcrlFYa8Yi9pLswUb0a4QRmI/OUDgxV+HK7J1rsiWUzMg2m+Q==
X-Received: by 2002:a05:6402:1d52:: with SMTP id dz18mr8678430edb.285.1638367147838;
        Wed, 01 Dec 2021 05:59:07 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id t5sm15218589edd.68.2021.12.01.05.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 05:59:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1msQ8Y-001Fwl-9V;
        Wed, 01 Dec 2021 14:59:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: "breaking" command output message parsing (was: [RFC PATCH]
 vreportf: ensure sensible ordering of normal and error output)
Date:   Wed, 01 Dec 2021 14:51:11 +0100
References: <20211130043946.19987-1-sunshine@sunshineco.com>
 <YaXQ/HinYZH1wL7E@coredump.intra.peff.net>
 <CAPig+cRQqm8Ce29PnkndT47NNxM3UhJv12RZGZZJD-AyGVC7Zw@mail.gmail.com>
 <CAPig+cS1ozLSJQgEJemDb+==NdB0ru5p4xknN11dkp6GJJM9iA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CAPig+cS1ozLSJQgEJemDb+==NdB0ru5p4xknN11dkp6GJJM9iA@mail.gmail.com>
Message-ID: <211201.86h7bsbf4l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 30 2021, Eric Sunshine wrote:

> On Tue, Nov 30, 2021 at 9:05 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>> (2) With git-worktree being four or five years old, for
>> backward-compatibility concerns, I worry that "that ship has sailed",
>> where 'that' is the freedom to relocate those status-like messages
>> from stdout to stderr. I don't want to break tooling which exists
>> around git-worktree.
>>
>> I'd be happy to be wrong on the second point -- indeed, git-worktree
>> is still marked "experimental" in the man-page, but that may not mean
>> anything this late in the game -- and submit a patch which places
>> git-worktree's status-like messages on stderr instead of stdout.
>> Thoughts?
>
> If that ship has indeed sailed, then perhaps the best and safest thing
> to do is admit that git-worktree is an outlier in terms of sending
> status-like messages to stdout, and just sprinkle the necessary
> fflush(stdout) around in builtin/worktree.c and live with that
> localized ugliness. Thoughts?

I really don't think that ship has sailed at all. We're at full liberty
to change these error messages, and have even done so for some plumbing
in the past (being sensitive to what sort of messages, sometimes they
are important).

See e.g. my 9144ba4cf52 (remote: add meaningful exit code on
missing/existing, 2020-10-27), that was a case where we knew about a
in-the-wild parser of the output, and git-remote is in the (I suppose
"pseudo-plumbing?") "Ancillary Commands" category.

I think the one grey area here is as in 9144ba4cf52 where we'd expect
people to reasonably script around these commands, and parsing the
output was the only way to accomplish something reasonable. E.g. in that
case automation around adding remotes & the handling of failure
scenarios. The case of [1] for "git pull" is another potential recent
one. I.e. someone grepping "Everything up-to-date".

From some brief skimming of the worktree.c code that doesn't seem to
apply, i.e. it's just chattyness.

I doubt anyone cares if it's blathering about "preparing a worktree" or
whatever, it just matters if "git worktree add" and the like fail with
non-zero, but perhaps there's cases of conflated states, as in that case
of "git remote" and "git pull".

1. https://lore.kernel.org/git/211130.86a6hleo84.gmgdl@evledraar.gmail.com/
