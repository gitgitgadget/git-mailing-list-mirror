Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FA2C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 21:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbiLTVIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Dec 2022 16:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLTVIW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2022 16:08:22 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD071E706
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 13:08:19 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id u19so32223851ejm.8
        for <git@vger.kernel.org>; Tue, 20 Dec 2022 13:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BNW74pxi1ijPz77BoW1q/jUQyE1ZgUM7W3WJP3ZgkEM=;
        b=qpmYyDXQ5gywa65cHBaMiACjysNuJ4mcLjt+e9ezisv+sZ1E/6pBMdNJ+VlzCmABnU
         XKn1dSd1VYyd24KtBITxpzKUmujFxARfRhF/+BmFLQDALnKRQokYr8rImixoL0uaatXb
         /PcbT0wm1H7lkcTcSTW2jmJ+M0lDd9anS01MojPp2JPWQC6HvHG5YkBIbqxvDAaB8SDF
         xW8hokPaVWWjh3RbMGCXYLVpT3EVoGibbJKA2Ho+Ht+Wg11GIrOvVgkgWWxoRHo5dp1u
         duh5uEDB2yXkI+oKujx4QyxPtLNTV76F8ON8VT+XodkoP2xxH6EfwF5VkAh5Qvfgf4zk
         ZXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNW74pxi1ijPz77BoW1q/jUQyE1ZgUM7W3WJP3ZgkEM=;
        b=GvAS8GmlZg8S3AVkFARtbbbLjTStldrw613D0dz7l2corWIPVn2j6ahFjQnMuXH0X7
         DVpmupRzgDEkQYkgcp1NDta6GpeZjIRczIc0+zn2AxghfH8NYraxNOpuWHHTb+4I38lE
         HtKBf8tcW+D5PXsg/wLl6lXyNVw2g7dCACxHLTunDcSu+fU4WAEOGpcO7MiwuTIJTQ8q
         ecNU6BoKzZ2YM0Tjx1MoEdIYc5g4FEehSz9a8yH8Jz+DFT86iS+jYkzDWmMsM4cMLiJ7
         h8hsbOiTJUtX4KG7gapMC8BjgubAPYirz1DCwbAVrD9Ce+ZTvplSP1CdP07pWGOU/2m3
         1KIQ==
X-Gm-Message-State: ANoB5pmXL4G5qVc20sjWCK343opHwIxtE0iSLNWepS2AzuX1RrduNozc
        PPENL1w54ckCb1CxvNyYqHE=
X-Google-Smtp-Source: AA0mqf7ReF6505cgrXtCzWIccsBJsOV0sb/6QygvTJJpADV88e4AydgOULQyyddpqjpWSYh5qqQqmA==
X-Received: by 2002:a17:906:408e:b0:7c0:eba3:e2e with SMTP id u14-20020a170906408e00b007c0eba30e2emr36204072ejj.31.1671570497935;
        Tue, 20 Dec 2022 13:08:17 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id la26-20020a170907781a00b0078d9cd0d2d6sm6310904ejc.11.2022.12.20.13.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 13:08:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7jqS-007Xls-2n;
        Tue, 20 Dec 2022 22:08:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, vdye@github.com
Subject: Re: [PATCH 1/3] bundle-uri: drop unused 'uri' parameter
Date:   Tue, 20 Dec 2022 21:50:29 +0100
References: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
 <d17f08ed4b68d711b452b5cfb54a949845bdea81.1670866407.git.gitgitgadget@gmail.com>
 <221219.86tu1rzmbs.gmgdl@evledraar.gmail.com> <xmqq4jtq292e.fsf@gitster.g>
 <be44ef00-2d80-18d5-4dab-357faca20853@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <be44ef00-2d80-18d5-4dab-357faca20853@github.com>
Message-ID: <221220.86fsd9wzpb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 20 2022, Derrick Stolee wrote:

> On 12/19/22 7:49 PM, Junio C Hamano wrote:
>
>> I think these three patches were designed to be "oops, that was
>> wrong and here is a band-aid" follow-up fixes on top of what was
>> back then in 'next'.  Now the base topic has been kicked out of
>> 'next' together with these, we can afford to roll them into the base
>> series before merging it back to 'next', but due to things generally
>> being slow toward the end of the year, that hasn't happened yet.
>
> I wasn't expecting to re-roll the base topic, but I'll get
> started on that now.
>
> However, the comments in this review are barely actionable.

Skimming over my comments again the actionable bits are:

 * 1/3: Commit says it's removing an unused param, also has while-at-it
   typo fix, maybe split that up?
 * 1/3: Commit says <same>, has while-at-it removal of documenting what
   a function's return value means, maybe keep that?
 * 1/3: Commit says <same>, has seeming while-at-it discussion of what
   another parameter is expected to contain (you replied saying they
   were related)
 * 2/3: Question about whether reading "r" v.s. "the_repository" has an
   observable behavior change. If yes let's add a test, if no let's note
   "it's for good measure".
 * 3/3: A question about whether we really didn't need
   GIT_TEST_BUNDLE_URI. You managed to convince me that no, we don't
 * 3/3: Question about what the 2nd paragraph of the commit message is
   trying to convey (you didn't reply to this bit). The actionable thing
   would be to clarify it, or remove it.

> They provide very little value especially for how verbose they are.

I agree that this was all of relatively little value, these are all
rather trivial patches after all, and the bundle-uri feature is opt-in
and WIP at this point.

But even trivial patches can be helped along by review. I'm just trying
to help this topic land & show Junio that others have reviewed this
carefully.

I agree that my E-Mails are verbose, sorry. This isn't my native
language, it's a balancing act between trying to be unambiguously
understood, and verbosity. sorry.

> frustrated to see such a drive-by review so late in the process.

This I'm confused by. You submitted this ~1 week ago on the 12th, Junio
rewound the parent topic out of "next" on the 14th.

Isn't this the appropriate time to comment on both this topic & its
parent?
