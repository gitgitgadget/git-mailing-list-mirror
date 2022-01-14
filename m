Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A47EC433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 19:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244131AbiANThq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 14:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbiANThp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 14:37:45 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDD4C061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 11:37:45 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id o6so37727065edc.4
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 11:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jlZ7MFKlmml7LjsgIUAeFLJBbqnNNwPZG95droy+iSY=;
        b=AUf5lFL7Maj6FlcCyOnNSwj7PiFflrhouS3dMo10JwhH+9mertssD3b30I7QV6xUtS
         0SH2ldWHE5RV4EKda0Uw58RCaTNLnBpPEfQO8yHJWHElj2kdx0kaVz14Jccc2yU7ej43
         0A2BvCFZu3TMGwy843+HnvrW15sejpmvJZQwDUHS2hztbmPqClj16qnXb5Lewae66BZ6
         d/lZH2YtOyBFMwg5TkzdGusI8zgXigVT4gApUfSHy6fPtY15MMmZTbr4vAfB57zdXNCo
         QJ9Yu8+jtWgitb9Q42h/1RRMKHI05/o5arY9ne28gerREMdCxXn5Mdk3bS3IX8WQRCQh
         PxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jlZ7MFKlmml7LjsgIUAeFLJBbqnNNwPZG95droy+iSY=;
        b=Xe0ViWxcknaqkRlXxlEnaa7uXc5UOJkGX0/whwrhyLQ2wj4hb9kBPbORi+NKzwfNeR
         L80ikJrFTUz7k4XJEpOIYnxz8COU7DxB6sR2z5OhecEMkMzw+7Ral/t/gJQPRlxRuhm6
         N14Qi2jchGdL1iHXcEdjyIC0HL/+EMyVIAjqk8MiwYzs7TT3svQpmN9YQERyzXIeFhJy
         ZacEZUqrEdl9bXMI5Wyx/IJXh3XVzpbNGeTG3djLtq3dWRhx0iG626DLiQwZ3OjQlm5J
         JDdegcuhD7EqSujlRFTEKKV/28giLjop4R8jM/X1HIR8z1m+w+vE3eqsS6/ANGqnq1L7
         Ed0Q==
X-Gm-Message-State: AOAM532LWfpqMWGqSbJXBgkIpYmDXkcbBq1+DRPRndK1B36ayIfUOfmO
        AQPne1SIDqjGnVjGiSzVTLsLoOUDYff1EA==
X-Google-Smtp-Source: ABdhPJxy8ipL0EzZqcq4BGKRiOko926Qn6rX0YUovCxXv6Bo2ve6Sg8O692S9CdJ7f/MUSdzEWqhXQ==
X-Received: by 2002:a17:906:724a:: with SMTP id n10mr3898268ejk.659.1642189063789;
        Fri, 14 Jan 2022 11:37:43 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id p25sm2651280edw.75.2022.01.14.11.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 11:37:42 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n8SOM-001CpV-7L;
        Fri, 14 Jan 2022 20:37:42 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v7 4/6] object-name: show date for ambiguous tag objects
Date:   Fri, 14 Jan 2022 20:35:00 +0100
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
 <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
 <patch-v7-4.6-2e5511c9fa5-20220111T130811Z-avarab@gmail.com>
 <xmqq1r1bgso2.fsf@gitster.g> <220114.865yqmtt9z.gmgdl@evledraar.gmail.com>
 <xmqq4k66cf50.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq4k66cf50.fsf@gitster.g>
Message-ID: <220114.86bl0ertvd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 14 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I still think the trade-off of not doing that discussed in the commit
>> message is better, i.e. (to quote upthread):
>>=20=20=20=20=20
>>     We could detect that and emit a "%s [bad tag object]" message (to go
>>     with the existing generic "%s [bad object]"), but I don't think it's
>>     worth the effort. Users are unlikely to ever run into cases where
>>     they've got a broken object that's also ambiguous, and in case they =
do
>>     output that's a bit nonsensical beats wasting translator time on this
>>     obscure edge case.
>
> Writing the above (and quoting it again to make me respond to it)
> have already wasted a lot more time than a better solution that does
> not lead to a misleading output, especially given that it was given
> for free to you already.

I don't mind changing it, but the reason I re-quoted it is because your
reply seemed to suggest that you had skimmed past that part before
making your original comment, not to merely repeat myself.

I.e. it's basically suggesting "how about?..." without addressing the "I
intentionally didn't do this, because..." argument in the commit
message.

But sure, I'll add a translatable message for this edge case in a
re-roll.
