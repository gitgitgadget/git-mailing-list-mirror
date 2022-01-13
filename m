Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3164CC433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 09:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiAMJfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 04:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiAMJfp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 04:35:45 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A876BC06173F
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 01:35:44 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 30so20905250edv.3
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 01:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=QFC2E/peMoFOzQhjxgjiQYjG5ld/etSWe2QjqIOej6U=;
        b=h+RtUjTL/RQkUeiTAXkMGk/h5mvS+7P6bZA2k2q7Wq3Xh3ztm4+SUhOxOtFZXBUWFS
         JjppT4IDcyC5SFyLvb7SKFNyDXLWFDo1yxq4e2tfC/MaN5A9/84TGLrj2gtmh8UXzHOe
         3TTCu3viA3lR4CgHn8ookpvrEAuysnytdg5DAQJpTvVf1jrakZgTDo6zA4SrUcTCl0Sb
         iMWIpA5kLX6vREIoKOgTZ4cj8ptephiLcwl531HYpz4LEsHKY3BGvQmEh5hap+qyfhdT
         Np0GxTCTCFWHzMqwLpkk9iwENKugKTSTnWXcIxge/Vcj8ke4Jdl1MmXX71lIDm4/Tm7x
         touQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=QFC2E/peMoFOzQhjxgjiQYjG5ld/etSWe2QjqIOej6U=;
        b=ChtO9x1SXGkSibfKwetEMiVvlA+R56KTqGT+qDXEsj8lkLckkbsJk+6IMDPE+J/3FJ
         OO7v80NE/7oc0V37/t+FzfYwGuHAASVyPf3xx05qRXH/t8ZoCfaVK9YoBfT1gadfpqkr
         GpKcuUgMSBdvm/U5yLHLCP24/5htezbq/IjSWq/G7AHESx/sJBEa58RiBa4xKjk+zFpC
         Z2q1ltrDzRh1B6NVdaOf4w7/9KAOd3LWa3DU5bFQkdnE6j0iNTiIR6ByLgkJ/myWgm6j
         5dkHEHIAziUoaZC6EENSp7q7wjpXni1cBMoUMy0Mnnfy1aYFqjARmj1MTz1Ld+5qRadQ
         sg9Q==
X-Gm-Message-State: AOAM532xY7l79cTkivMHJj/xn45uibnVDRyjnUk0iOiq2+pKd6aKFib5
        ZLyRo7P2vj2KcpF6ban9tiLUgDYd9zve9A==
X-Google-Smtp-Source: ABdhPJw3jenwC2aNjRmBYwvs4zLU3gc8LaKd4vfND0TDwrzCA9zGEtOJZxXK7ggAWzm5P+mj2d5F4A==
X-Received: by 2002:a05:6402:1e93:: with SMTP id f19mr3328866edf.199.1642066543162;
        Thu, 13 Jan 2022 01:35:43 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o25sm902997edr.20.2022.01.13.01.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 01:35:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7wWE-000qBF-78;
        Thu, 13 Jan 2022 10:35:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 0/2] Introduce new merge-tree-ort command
Date:   Thu, 13 Jan 2022 10:26:57 +0100
References: <20220105163324.73369-1-chriscool@tuxfamily.org>
 <CABPp-BFh7UnQtPM=tO8rfp5bPK4-7esouv5KCx1sUSESwEA=Rw@mail.gmail.com>
 <CAP8UFD0wKnAg5oyMWchXysPTg3K9Vb4M1tRcPzPE81QM903pYg@mail.gmail.com>
 <CABPp-BHpuLjCYycBwweMW_NdQrS_r3ECmvLb8XjNW-_Rau5NTw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2201101427440.339@tvgsbejvaqbjf.bet>
 <xmqq8rvn1nkw.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2201111439190.1081@tvgsbejvaqbjf.bet>
 <220111.86mtk2xb1y.gmgdl@evledraar.gmail.com>
 <CABPp-BFei07srZBgyKs6HCm+G+hmPR-3_EkKjRK8WwGL1Uf2oA@mail.gmail.com>
 <xmqqk0f4x20a.fsf@gitster.g>
 <CABPp-BHQdkhAEmTrtc+XMgj5A5ASBVRw0_bXH10NSrMsyRK+oA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BHQdkhAEmTrtc+XMgj5A5ASBVRw0_bXH10NSrMsyRK+oA@mail.gmail.com>
Message-ID: <220113.86k0f4vuz5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 12 2022, Elijah Newren wrote:

> On Wed, Jan 12, 2022 at 10:06 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
> ...
>> I however suspect that =C3=86var didn't mean by "legacy merge plumbing
>> built-in" the strategy backends.  IOW, I had an impression that what
>> is on the chopping block is merge-tree and not merge-recursive.
>>
>> But since you brought up deprecation of recursive, let's spend a few
>> minutes on the topic.
>
> Not sure it matters, but for reference, =C3=86var explicitly brought up
> merge-recursive.c.  The fuller quote was:
>
>> >> I.e. is it really costing us
>> >> to just leave these "legacy merge" plumbing built-ins and
>> >> merge-recursive.c etc. in place?
>
> Because he brought it up, I decided to address it.  It was unclear to
> me whether he meant builtin/merge-recursive.c or the toplevel
> merge-recursive.c, so I just addressed both.

FWIW what I meant (but clearly didn't make clear enough) is whether we'd
deprecate the git-merge-tree(1) command, not whatever powers it under
the hood.

I.e. I took the greater discussion here to mean (but may have
misunderstood it) that we were talking about the needs for a
libgit2-replacing merge plumbing.

The existing git-merge-tree command probably gets us 5% towards that,
and I can see how being bug-for-bug compatible with it might be
inconvenient in some future on-top-of-ort rewrite and extension of it.

So we probably SHOULD keep it, but I don't think it's a MUST. I.e. if
you/someone wrote some more powerful version of it, and keeping it
became hard to support I think it would be OK to transition/deprecate
it, as presumably its existing users wouldn't be too inconvenienced, or
would be happier with the more powerful plumbing tool.
