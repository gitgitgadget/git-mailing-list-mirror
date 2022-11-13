Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFC6C4332F
	for <git@archiver.kernel.org>; Sun, 13 Nov 2022 17:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbiKMRbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Nov 2022 12:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiKMRbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2022 12:31:25 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2972F1117E
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 09:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1668360670; bh=u/DiLIXgQbSy9CUETba6Lh1+zP4hpS6lZRsglnGSt6s=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=B6JWxSRb0h6LC8GOpRcCOs34T2j25/pUcxOftTzHvaIEJhWlh7f+em7TuhEB7Zy0g
         EoPffdOk0qzwkNThItJXjD0O9cdQMRMQBVW8UMcNBcLVL5NVT6TQiNjzbEUfWboQBt
         oKXAB1/JZD4rVulsJH7FWDZoF091rOQZUaOGLzbUOmgYV82YoEvmyZMsPnlpngjyKp
         qrPHNvkmIbWrFq5MmG8B+apbstmqbaNs6B1faGFv9iaAjktotpcUQx2YZrc7oTC7g9
         NG6zZ74yKRjS5d1lbyEPm/Eje0IZUGynQ+FfUdrcPpmc2rHGYGATZJWE1x3kNeNer9
         L19nigxFqEZAQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7xeb-1oz8Ob1k15-014dwm; Sun, 13
 Nov 2022 18:31:10 +0100
Message-ID: <6a6a9410-f854-2288-6d54-0aca115c0bb6@web.de>
Date:   Sun, 13 Nov 2022 18:31:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] pack-objects: fix handling of multiple --filter
 options
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Tan <jonathantanmy@google.com>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <53bffbf4-8308-0dd7-bca5-7c85b8334e05@web.de>
 <Y2/QxOnM/7UI4R8c@coredump.intra.peff.net> <Y3B6PxNaZvmm5OD2@nand.local>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Y3B6PxNaZvmm5OD2@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aMhRSXMZItCTRLDOqaWz6kn3sEcDYJRAiZ3a7LGZxS5Baj9U3OL
 Oy30QI4qhW/60wWthhnXCfR7gw9gbwAas1LT6kTbR6SLvVSMUHkzonCcqp+GKwMMbGN3JTw
 90tl1pWpWjY7sekl8LUMfGGjVUuZrJJtagfNeugSszsxLhERMBeMrgkn2ems4tTHn+Xvg/B
 gRzOBMHPwFUfKpj1GJ37g==
UI-OutboundReport: notjunk:1;M01:P0:3Rt5/qnAC+g=;f+BYRqePPtv5f1FJbGAj3mJfy1h
 w/J3EAKMb8uegmJ5MFLjz/nEKIkX0wgOx0/HOzIaudmqEfZOl1qLgF2URh/AzI1en+bs4HoCX
 VSIiYqnlNK5HjMiFHglkj7bRgqQv9ZrjBcr8zvTjJXf7gkO44FMRxYl8Qpwn+dbXmDir12VYu
 EcNi/Cbkrgt3A6l0CbvevzcM6uXHPIjeZ77LDFPPPBKGEFg7U32cgl5LuExwdpUvnc/feTi0v
 SrJKOCEe2PyuWank9H16D2oTEvJ9uGQIgvjYOXvko/nq0gVly1dbOTjTb8WgWuR6v02l40mZl
 mYiUr/CG+KoLfruERlMK+F8nQhiEt3aiJI7lanq9COsyMc1P5W+HMhT1d8sfFlDPJAj5TfQ6f
 d6QXasYJczIkCDLcZAEc+JsFvWsvXZxtqYVbNgFB15+enavWHAD8+UyrXTy/7/jkL37jskzGo
 fLQC684vRaNZfKalkK2gmnAZNLyvQ3hqD6Q4ydgFJQRZ5SgoPOHcIYjwkh9bdRtSNO+ZvodM4
 MJIL0wJqxWv1XHdwaVSTVAkjAKTuB71n2xtu1nwKB3c0OjhJd1LWmWljPcCPtG73Ey2sJuKIA
 A2shZcVBVXGxbCfPDYmbQ/spLW7+wywd4UcT1t0ofV+qlzaZSZhYlV/cReX9/VXH7mngWeqx6
 1F0RsPkpc2ZmIh1xCZiqKiqa2M9YUw2QbJuFV00uudkYDC684cvbOI6/cLk1FX40m3u3/ma0N
 qyYn7rbmI+UcHT1ibl6eI0xL8bHoVuQ7AJEI3nCMbVl5bhFMyrNL6rc5rXeGGMnpunet3OZBz
 Bb4sGZlPXg5gUV3Vf1uWo8h23BEo3GplS7bHwn5HB7oTAfBi1outd7antqjnSbTgONX922P7H
 kTKZLRYUMXtnoec/2AvnEvUy3K3yEPMGob5g9zu+5j48fLI5R7c5CC7HO5O995Iz7N74nynpk
 ZFSpxQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.11.22 um 06:01 schrieb Taylor Blau:
> On Sat, Nov 12, 2022 at 11:58:44AM -0500, Jeff King wrote:
>> On Sat, Nov 12, 2022 at 11:44:00AM +0100, Ren=C3=A9 Scharfe wrote:
>>
>>> Since 5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't
>>> leak, 2022-03-28) --filter options given to git pack-objects overrule
>>> earlier ones, letting only the leftmost win and leaking the memory
>>> allocated for earlier ones.  Fix that by only initializing the rev_inf=
o
>>> struct once.
>>
>> Yikes. I wondered how we managed to miss this in the tests. Surely we
>> have some examples that use multiple filters?
>>
>> I think the answer is that we do in t5616, but in practice they didn't
>> hit this bug because of the way filter-specs are treated server-sid3.
>> Even if we say "clone --filter=3Dfoo --filter=3Dbar" on the client, the
>> server upload-pack coalesces that into a single "combine:foo+bar"
>> string, and that's what its pack-objects sees.
>
> ...Or in other words, clients aren't broken here because we always send
> "combine" filters when multiple `--filter` arguments are passed to `git
> clone`, `git fetch`, etc.
>
> Is that always the case? I *think* so, but it would be nice to know if
> there was a way that clients would not send the `combine` filter with >1
> filter.

Searching for pack-objects invocations like this should at least find
all internal cases, right?

   $ git grep -e '"pack-objects"' -e --filter --all-match --name-only
   builtin/pack-objects.c
   bundle.c
   upload-pack.c

git pack-objects handles --filter and doesn't pass it on.  bundle.c and
upload-pack.c only add at most a single --filter option to a strvec.
bundle.c uses list_objects_filter_spec() to get the filter
specification, upload-pack.c uses expand_list_objects_filter_spec().

Ren=C3=A9
