Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97863C25B06
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 06:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiHNGyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 02:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiHNGyO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 02:54:14 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83DB4333F
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 23:54:13 -0700 (PDT)
Received: (qmail 18620 invoked by uid 109); 14 Aug 2022 06:54:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 14 Aug 2022 06:54:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31643 invoked by uid 111); 14 Aug 2022 06:54:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 14 Aug 2022 02:54:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 14 Aug 2022 02:54:12 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] [RFC] list-objects-filter: introduce new filter
 sparse:buffer=<spec>
Message-ID: <YvicFCS45cPp9khe@coredump.intra.peff.net>
References: <pull.1316.git.1659958159193.gitgitgadget@gmail.com>
 <xmqqczdau2yd.fsf@gitster.g>
 <46ca40a9-2d9a-3c7c-3272-938003f4967a@github.com>
 <YvQf/xW7oohAsJct@coredump.intra.peff.net>
 <CAOLTT8QfmVXHDVfWZf0U73PXOQ--ZUmm3N=a60fv_Wo_5UnqmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8QfmVXHDVfWZf0U73PXOQ--ZUmm3N=a60fv_Wo_5UnqmA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 12, 2022 at 11:49:06PM +0800, ZheNing Hu wrote:

> > ...I agree with this. It is nice to put more power in the hands of the
> > clients, but we have to balance that with other issues like server
> > resource use. The approach so far has been to implement the simplest and
> > most efficient operations at the client-server level, and then have the
> > client build local features on top of that. So in this case, probably
> > requesting that _no_ trees are sent in the initial clone, and then
> > faulting them in as the client explores the tree using its own local
> > sparse definition. And I think that mostly works now.
> 
> Agree. But we have to fetch these blobs one by one after partial clone,
> why not reduce some extra network overhead If we can get those blobs
> that are *most* needed in the first partial clone, right?

Ideally we wouldn't be getting them one-by-one, but rather batching
them. I'm not sure of the current state of the code. But we should at
least be able to batch by tree depth.

You're right that we'll never be able to be as efficient as a server to
whom we can say "I care about these paths", though.

-Peff
