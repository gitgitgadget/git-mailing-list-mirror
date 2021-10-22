Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25A5C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA006120D
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 14:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhJVOZH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 10:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbhJVOZG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 10:25:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9853C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 07:22:48 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ec8so2402033edb.6
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=+AJXz0rGLXHYEhXXE+3pwl308U9zw3l5HIFzCmk2NNg=;
        b=cL6CvDgp+kclqfN1rRZpjLxFxw63zQEfVaLw8DirKjiUpT/f3XNNk0xUeMGXrCMUY/
         55GCEGRVCfqV0R3Gke7zZ0innX9ndPhSagNt7LZA2ZzkfGdqJzg3lAHV87EiYjKyuQAJ
         o/7kRlmN7Vp3KQd2rvDqoxcyGmQcihePnIjvXZSSqZZZ5d4SSBw0o786PL7Cf1WVR3s/
         knRFi9hVmwG2SuKu9Wf8Ymy0It5MSv+hYuz2Wor0s17MShmhAvDPIehmzbVfFM4d1Jos
         YvgNpjy2hr3KCvB7SNiFItA9CkxDAtSyEzGAE77WIO5+Og/BoLKTlmFlHgt/YNXjZhs0
         VWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+AJXz0rGLXHYEhXXE+3pwl308U9zw3l5HIFzCmk2NNg=;
        b=yJ2WzCmSTjjF6l2so8SYjMA8M8yM/392ALDuLV/3VRiYx9HYE2QWC6qhZ9nvfBq/6l
         gJ0YDJwp5rvwo51IRLhyz/VjF122wJNjxrxSJxwZsdlUtt3pd9oJPLort2b+80WY3pjn
         0qUN8mshQwhKhFT0R6eiq6sWWYAZJTVj0zxoKllDE9hF4IDV0FvEHkBnQhigewMJ8rGp
         bN8qUJGjWjKgs6syySp2GpB6OoH+3EUD2hDTmSE+HgLxGUxhx3WoL+iq4wymz4S92qwg
         vkqZlNVSy0x4mk+2cmwNOXfPj7OKm4WgOvp+vXJTGYrhG/qjTk9d1Wq1hGFTVl87LbXT
         ghTA==
X-Gm-Message-State: AOAM530WnjCPeLIQJSEGD+GucZK3tUyo1AVZUBu+DCwWAvVSBD/GZ3ud
        dRBkzTSXx3+O8FuIXCj6K+5erNwCW80ZGg==
X-Google-Smtp-Source: ABdhPJzW6mGMyJJYXFg78Bm5xTvA31YWJRq+Ly8O2nJqrL4u8+7CT4xbri2cdKOLX6yNyLcCY8DnRQ==
X-Received: by 2002:a17:906:9b08:: with SMTP id eo8mr285083ejc.50.1634912567260;
        Fri, 22 Oct 2021 07:22:47 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h10sm918456edb.20.2021.10.22.07.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:22:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdvRU-001EF7-Uc;
        Fri, 22 Oct 2021 16:22:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 00/10] progress: assert "global_progress" + test
 fixes / cleanup
Date:   Fri, 22 Oct 2021 16:21:29 +0200
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
 <YXIzitjDUpJcFOcS@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YXIzitjDUpJcFOcS@google.com>
Message-ID: <211022.86zgr1jg0b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 21 2021, Emily Shaffer wrote:

> On Thu, Oct 14, 2021 at 12:28:16AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> This series fixes various issues in and related to progress.c, and
>> adds a BUG() assertion for us not starting two progress bars at the
>> same time. Those changes are needed for subsequent changes that do
>> more interesting things with this new global progress bar.
>>=20
>> This v3 hopefully addresses all the feedback on the v2, thanks
>> all. Changes:
>>=20
>>  * Fix a memory leak in 1/10, and make the progress tests use the
>>    SANITIZE=3Dleak test mode.
>>=20
>>  * Simplified some of the test-progress.c code (no more "start"
>>    handling, the "total" count is mandatory now.
>>=20
>>  * Split out a formatting change into 2/10 to make 3/10 easier to
>>    read.
>>=20
>>  * A new 9/10 makes an ad-hoc test recipie in 10/10 easier to explain
>>    (in response to Emily's comment).
>>=20
>>  * The BUG() assertion in 10/10 now has a much better message, we dump
>>    the title of the two progress bars in play if we have a bug where
>>    we started two at the same time.
>
> One thing I noticed (and so did SZEDER) was the addition of string_list
> to the helper; I made a comment accordingly in the patch where it was
> added. It kind of seemed like an oversight - but I remember you were
> wanting to head in that direction (multiple progress bar support) so
> maybe it was paving the way for that?
>
> Anyways, with or without it the series looks OK to me in this round too.

Replied to in the thread with SZEDER at:
https://lore.kernel.org/git/211022.864k99kune.gmgdl@evledraar.gmail.com/

I.e. it's not for multi-progress-bar support, but because the API
doesn't xstrdup() the title. The loop handing it the title needs to keep
the string it gave to it alive.
