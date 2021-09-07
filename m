Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD86C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C1560E76
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 19:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346093AbhIGTwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 15:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243859AbhIGTwX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 15:52:23 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE463C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 12:51:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r7so15509997edd.6
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 12:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3Fh3mYAXJjNgP3lyoHUQr4oSSKuEib8dyhAc4e8ZmSo=;
        b=ouARXr9WYJ3Hjz47KqiuILXAeA3I+PIjDvdQQjwQBMeDkk3AptU/x8Y197vLXK8SF7
         yc9uWk/iO6VHYKbq8eC8+//bOsDDRrL3xVuIXKL0tXB0ajd1l1Tnada3Rm9Gdgzv2vMp
         zg+lc2A7hgl5Sgs7e+Pe0zPSFHJScN2kw5M4MRLneTF5J3kjB5lq/KY80z20JOgYt6BH
         qbR7OzBkjZvtvryh/2MnsnW15u0P6C5QPjvXE525S7+Ft4Xrc62HDgKOJd8knJ6wbu7e
         lvo4QoOcH2xHo4fFJWTEh9at4rSG2x0UkzwyrYIcI4kFi9eFuH7xTCxN43IWmuzHuZgw
         b3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3Fh3mYAXJjNgP3lyoHUQr4oSSKuEib8dyhAc4e8ZmSo=;
        b=c4fh6XIZpjpaxB4nsCgfTcD5T+ReTa0SevXHeTSVDKe0gdk8PuK91MiQa7Kk401qTI
         y0N31vnDAUwp0FCxmDqrQtmkxQbjm+pGMRymq8XjRzbF1R6+ab5/CjtZ/GmIzeS6CxLb
         iBbuhL0TgmlmJ7idGbA82DHor/K3TsTVXLL3Ci2/uMCrwFd3vc2HD/FmaMYgBMdbubIO
         pryEm1EYGmULsSMJ6R5PWjAbg9PAguNyLc9zkm/gJa1AyBw0/Oud9KcGNq7TuzhvfyRU
         XWTdtwNNA2Tv8W6HylLf+9fIiiNzjxa/q8uvQAJ/SWIBqQuEtWyrvyMAIHVux8AwhBaO
         GBxg==
X-Gm-Message-State: AOAM5328RBI93K5jJNbQR5j83avYnP2694x6renq9DILyuxRHF8gS+dk
        Xl19BBcOcxis7dDXv3XFnqZwsyvwliqW7g==
X-Google-Smtp-Source: ABdhPJwO6xcu4lYaWjAWIsWAjWNhZ7AzVBbsziC+Ta/CTy3w+ybv/Mr8yUUbkvPrrtm3F+dK8okPzQ==
X-Received: by 2002:a05:6402:1bdd:: with SMTP id ch29mr940367edb.310.1631044275211;
        Tue, 07 Sep 2021 12:51:15 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j14sm30586edk.7.2021.09.07.12.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:51:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     "Neeraj K. Singh via GitGitGadget" <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 0/6] Implement a batched fsync option for
 core.fsyncObjectFiles
Date:   Tue, 07 Sep 2021 21:50:48 +0200
References: <pull.1076.git.git.1629856292.gitgitgadget@gmail.com>
 <pull.1076.v2.git.git.1630108177.gitgitgadget@gmail.com>
 <CANQDOdeEic1ktyGU=dLEPi=FkU84Oqv9hDUEkfAXcS0WTwRJtQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <CANQDOdeEic1ktyGU=dLEPi=FkU84Oqv9hDUEkfAXcS0WTwRJtQ@mail.gmail.com>
Message-ID: <8735qgkvv1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Neeraj Singh wrote:

> On Fri, Aug 27, 2021 at 4:49 PM Neeraj K. Singh via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> Thanks to everyone for review so far! I've responded to the previous
>> feedback and changed the patch series a bit.
>>
>> Changes since v1:
>>
>>  * Switch from futimes(2) to futimens(2), which is in POSIX.1-2008. Contrary
>>    to dscho's suggestion, I'm still implementing the Windows version in the
>>    same patch and I'm not doing autoconf detection since this is a POSIX
>>    function.
>>
>>  * Introduce a separate preparatory patch to the bulk-checkin infrastructure
>>    to separate the 'plugged' variable and rename the 'state' variable, as
>>    suggested by dscho.
>>
>>  * Add performance numbers to the commit message of the main bulk fsync
>>    patch, as suggested by dscho.
>>
>>  * Add a comment about the non-thread-safety of the bulk-checkin
>>    infrastructure, as suggested by avarab.
>>
>>  * Rename the experimental mode to core.fsyncobjectfiles=batch, as suggested
>>    by dscho and avarab and others.
>>
>>  * Add more details to Documentation/config/core.txt about the various
>>    settings and their intended effects, as suggested by avarab.
>>
>>  * Switch to the string-list API to hold the rename state, as suggested by
>>    avarab.
>>
>>  * Create a separate update-index patch to use bulk-checkin as suggested by
>>    dscho.
>>
>>  * Add Windows support in the upstream git. This is done in a way that
>>    should not conflict with git-for-windows.
>>
>>  * Add new performance tests that shows the delta based on fsync mode.
>>
>> NOTE: Based on Christoph Hellwig's comments, the 'batch' mode is not correct
>> on Linux, since sync_file_range does not provide data integrity guarantees.
>> There is currently no kernel interface suitable to achieve disk flush
>> batching as is, but he suggested that he might implement a 'syncfs' variant
>> on top of this patchset. This code is still useful on macOS and Windows, and
>> the config documentation makes that clear.
>>
>> Neeraj Singh (6):
>>   object-file: use futimens rather than utime
>>   bulk-checkin: rename 'state' variable and separate 'plugged' boolean
>>   core.fsyncobjectfiles: batched disk flushes
>>   core.fsyncobjectfiles: add windows support for batch mode
>>   update-index: use the bulk-checkin infrastructure
>>   core.fsyncobjectfiles: performance tests for add and stash
>>
>>  Documentation/config/core.txt       | 26 ++++++--
>>  Makefile                            |  6 ++
>>  builtin/add.c                       |  3 +-
>>  builtin/update-index.c              |  3 +
>>  bulk-checkin.c                      | 92 +++++++++++++++++++++++++----
>>  bulk-checkin.h                      |  4 +-
>>  cache.h                             |  8 ++-
>>  compat/mingw.c                      | 53 +++++++++++------
>>  compat/mingw.h                      |  5 ++
>>  compat/win32/flush.c                | 29 +++++++++
>>  config.c                            |  8 ++-
>>  config.mak.uname                    |  4 ++
>>  configure.ac                        |  8 +++
>>  contrib/buildsystems/CMakeLists.txt |  3 +-
>>  environment.c                       |  2 +-
>>  git-compat-util.h                   |  7 +++
>>  object-file.c                       | 23 ++------
>>  t/perf/lib-unique-files.sh          | 32 ++++++++++
>>  t/perf/p3700-add.sh                 | 43 ++++++++++++++
>>  t/perf/p3900-stash.sh               | 46 +++++++++++++++
>>  wrapper.c                           | 40 +++++++++++++
>>  write-or-die.c                      |  2 +-
>>  22 files changed, 389 insertions(+), 58 deletions(-)
>>  create mode 100644 compat/win32/flush.c
>>  create mode 100644 t/perf/lib-unique-files.sh
>>  create mode 100755 t/perf/p3700-add.sh
>>  create mode 100755 t/perf/p3900-stash.sh
>>
>>
>> base-commit: 225bc32a989d7a22fa6addafd4ce7dcd04675dbf
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1076%2Fneerajsi-msft%2Fneerajsi%2Fbulk-fsync-object-files-v2
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1076/neerajsi-msft/neerajsi/bulk-fsync-object-files-v2
>> Pull-Request: https://github.com/git/git/pull/1076
>
> Hello everyone,
> I'd like to bump this review up in people's inboxes since Patch V2
> hasn't gotten any traction in over a week.
>
> Thanks in advance for taking a look,
> - Neeraj Singh
> Windows Core Filesystems Team

Thanks, I've been meaning to take a look at this, and also as a
note-to-self: check how this interacts with the fsync()-impacted race I
noted in my just-sent:
https://lore.kernel.org/git/cover-0.3-00000000000-20210907T193600Z-avarab@gmail.com/
