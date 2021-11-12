Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43973C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 289236108B
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbhKLWjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 17:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhKLWjD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 17:39:03 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44615C061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:36:12 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b15so43204975edd.7
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=6X88QKPvZup13/yQrRHYqiXju1lpDNDg55R4Pk+02ao=;
        b=HCXHvDlOX4jvy4YwwLnJMf5p0mBwKSk2rOZpnD3ClFi+Kyol8oTOiQIB0nEqXnido9
         5GL1B9XfIOofWBrq/qxXyEGgY3oesSNsXb/r9Q9wcTUk6f33Tm4UVAcVQ7NU33BM0axn
         cHV2TNjiekMV0gf1VY9GJEBSZ4v73/lfR90ziQj1gNnlm7JdTsekN3oBThb5bDZzWVkD
         hfUF8pTTkngesYFxjLwRrVhOdYV4KLTmwgcFa0cYblNlI1EcqDbJNKqxTSb64PKCL9b4
         49Yh08ArVmrmkCh3lEg8XXVFcbKfr0n5BY6mEX9H0MKheakc9zUh/gTQTq2v3vGtzZwm
         AwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=6X88QKPvZup13/yQrRHYqiXju1lpDNDg55R4Pk+02ao=;
        b=bjrCLTdwRuQOSZBSzyRvMbbUlqcbwO3FM3Z9BkA97ngv+nWw3b1fHTfJQth8Qb2LSc
         1diLOJgtXKQ4V0bVM3YI16uci7McG2gqfsTUzkwapa4jBUL6kwogrxzp2S0//xVeWsHY
         e/W0ZkyBszI4/dMqPPUG4/Hlhdj5ALkGPTcMs7ocw5EJitIS7od1azxxe1BV+AYtgtSt
         vdOQGGTjMjqpFtfSmy0TraiWl4bvLpY/cIRoxq63NNvhtnB31/X1luZp0lqTyCGnVXf2
         vxYLKVlvgVNZCxjvnxEjqvIn2/6lFloNbMOxl3qTqsXw7sf8Nh+T4gnKKePU5tgniSqV
         JDTQ==
X-Gm-Message-State: AOAM531dSfCi+4G3ie7PiCnFnA0VCfhHHhk2O81wc3tW/mveUFYI7nLp
        f+zoy0mt6IRUlb3q/UiFcu8oWmSL7gULGQ==
X-Google-Smtp-Source: ABdhPJyEcKAfR7SavuynLcS6mQulcJRm+ZD5Ku5g6hpNV8MerBG2JevAtv1/cqhKpatbP2F8u3gbpw==
X-Received: by 2002:a05:6402:2791:: with SMTP id b17mr25631753ede.28.1636756570796;
        Fri, 12 Nov 2021 14:36:10 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bm2sm3590150edb.39.2021.11.12.14.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:36:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mlf9V-000Y0y-79;
        Fri, 12 Nov 2021 23:36:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        git@jeffhostetler.com, Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] trace2: increment event format version
Date:   Fri, 12 Nov 2021 23:33:09 +0100
References: <ebc4d9a6960f0350772c14981ef211876f29d0fa.1636669891.git.steadmon@google.com>
 <xmqqh7cijnwx.fsf@gitster.g> <YY2h5lO90vo3Dy42@google.com>
 <xmqqczn6jlvu.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqczn6jlvu.fsf@gitster.g>
Message-ID: <211112.867ddduhly.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 11 2021, Junio C Hamano wrote:

> Josh Steadmon <steadmon@google.com> writes:
>
>> On 2021.11.11 15:03, Junio C Hamano wrote:
>>> Josh Steadmon <steadmon@google.com> writes:
>>> 
>>> > In 64bc752 (trace2: add trace2_child_ready() to report on background
>>> > children, 2021-09-20), we added a new "child_ready" event. In
>>> > Documentation/technical/api-trace2.txt, we promise that adding a new
>>> > event type will result in incrementing the trace2 event format version
>>> > number, but this was not done. Correct this in code & docs.
>>> >
>>> > Signed-off-by: Josh Steadmon <steadmon@google.com>
>>> > ---
>>> >  Documentation/technical/api-trace2.txt | 4 ++--
>>> >  trace2/tr2_tgt_event.c                 | 2 +-
>>> >  2 files changed, 3 insertions(+), 3 deletions(-)
>>> 
>>> Hmph, it seems to me that this is better done before the release,
>>> or am I mistaken?
>>
>> Ideally yes, although I am not sure if there is anyone using traces who
>> strongly depends on the accuracy of the evt field.
>
> Relieving us from having to keep track of the actual users is the
> point of documenting to making promises ;-)
>
>> For release-blocking
>> fixes (for lack of a better term), should I have sent this patch
>> differently?
>
> I do not think so.

Josh notes the "child_ready" event being new in this release, but the
same is true of the cmd_ancestry event added in 2f732bf15e6 (tr2: log
parent process name, 2021-07-21)

So yeah, with both of those it makes sense to have this for v2.34.0.

On the field itself I also wonder if it's useful at all. I'd think
anyone implementing a parser for the format would dispatch to a lookup
handling known keys, so having a version indicating "new keys here"
seems rather useless.
