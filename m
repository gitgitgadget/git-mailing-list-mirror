Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BC4C433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 13:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiFXNYH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 09:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiFXNYG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 09:24:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110A7522FC
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 06:24:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id pk21so4733241ejb.2
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 06:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=hOHXUrz2iNXeXQLJvkBs4lC3IlXCuA60WghDpwS29iE=;
        b=CKGdTmLY9xpyuAt8qDsIWPCSiHAKyIWFzPa2qyvMV3vxsl7xn4Np82Z52MR5Nc4XBk
         qM7iH3uwd6y1ALbbqGFIxyvFu549dWc1es0gwbMltZcsqaLsMBUYWuEu5MPVvQ7VoGSK
         VEBZS9Ma4NPS2kLic5/5J9npcJuQjTOhrhMWDc9zvuTAK9T6IfgNkfY37Pcwt/YX1Qkl
         66lY7bmKV58L49XiqC8cvBUr7TdmGKlNENWfe5vF1Qfy2bm/YZInQQbTbwqTsOeAcfZz
         fTJiEhQSteIUeP5ndT3ZiigJrmgMhU4deYBoct3Rhn4vdogvJ7ubqM1LRjHpRUmnIdmY
         hp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=hOHXUrz2iNXeXQLJvkBs4lC3IlXCuA60WghDpwS29iE=;
        b=qe1mUVJSXB4jEMykj5ZRzYxoxZZtiwaA8bpSTaA55xxZy7FA6KeZYiT4VOVKXZ5reO
         DpZbHpu3zENWQ/fRlPh7gIU5zxZSrLtL8bN8ZPak0sAYIkxR/2dHRRTnbuOYtZ1fEUca
         X4IhT44SJzecZKWR7JGQJaZD4+MphGajkYGlWjtxfjAvmSgUxIpJmj3pdzeCgRqHU6Dp
         kUAUiOwkO3jGzpMZIF1mJI6YijY0ZzM5/Jy1i6yGF1Q552Bgun58n2l7alAfpedRKFUR
         o0rB/LJClo8khMsGXWtJjH8wuu/IJN/NlIvCHAZyXA7qpNwCIXsIzfjYFnkOFGkIvMO5
         vy9A==
X-Gm-Message-State: AJIora/YK1uZxkbGENgXw3jSlm3imTQijSP42Gm6Nn8q7Oxb9DxjmqWC
        YYR83P9hF1Q8zShpFUKoBE4=
X-Google-Smtp-Source: AGRyM1vflAR3JgaVBUzgmm49RC42ROauHtPqoKw1BqD3xUrky8RhN39ShxoyoN/GNWsQZTBgy+k8Eg==
X-Received: by 2002:a17:906:7493:b0:722:df76:319d with SMTP id e19-20020a170906749300b00722df76319dmr13299626ejl.588.1656077044629;
        Fri, 24 Jun 2022 06:24:04 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bu23-20020a170906a15700b006fec56c57f3sm1122191ejb.178.2022.06.24.06.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 06:24:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o4jI3-001JtA-Bm;
        Fri, 24 Jun 2022 15:24:03 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v3] ls-files: introduce "--format" option
Date:   Fri, 24 Jun 2022 15:20:31 +0200
References: <pull.1262.v2.git.1655629990185.gitgitgadget@gmail.com>
 <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
 <080f65b3-91f5-7b68-4235-4bfb956c8321@gmail.com>
 <xmqqv8sr1iex.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqv8sr1iex.fsf@gitster.g>
Message-ID: <220624.86pmiyi498.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 23 2022, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> Thanks for re-rolling, having taken a look a closer look at the tests
>> I'm concerned about the output format for some of the specifiers, see
>> below.
>
> Thanks for raising these issues.  I agree with you on many of them.
> In addition to what you covered ....
>
>>> +path::
>>> +	The pathname of the file which is in the index.
>> I think that for all these it might be clearer to say "recorded in the
>> index" rather than "of the file which is in the index"
>
> I think we would call this "name".  The name of the existing option
> that controls how they are shown is "--full-name", not "--full-path",
> for example.

To the extent that we got this wrong it was me in 455923e0a15 (ls-tree:
introduce "--format" option, 2022-03-23), but given that we have that I
think it makes sense to have this be consistent with ls-tree.

FWIW ls-tree also uses "name" options, but its docs talked about
"<path>", so I thought it was more helpful to pick that.

We also say that we will "show the full path names" in that
documentation.
