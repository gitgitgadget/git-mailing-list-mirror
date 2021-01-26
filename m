Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E53C4161F
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C2CB2067C
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbhAZWEj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:04:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:39738 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbhAZVIU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jan 2021 16:08:20 -0500
Received: (qmail 26675 invoked by uid 109); 26 Jan 2021 21:07:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 26 Jan 2021 21:07:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3689 invoked by uid 111); 26 Jan 2021 21:07:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 26 Jan 2021 16:07:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 26 Jan 2021 16:07:37 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jacob Vosmaer <jacob@gitlab.com>, gitster@pobox.com,
        git@vger.kernel.org, jeffhost@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v3 1/1] upload-pack.c: fix filter spec quoting bug
Message-ID: <YBCEmZHapifbVqRy@coredump.intra.peff.net>
References: <YA81LEon1RPzT0T9@coredump.intra.peff.net>
 <20210125230952.15468-1-jacob@gitlab.com>
 <20210125230952.15468-2-jacob@gitlab.com>
 <874kj46mwf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874kj46mwf.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 26, 2021 at 10:57:36AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > This fixes a bug that occurs when you combine partial clone and
> > uploadpack.packobjectshook. You can reproduce it as follows:
> 
> Let's: 
> 
>  * Refer to the commit we're fixing a bug in, i.e. Junio's mention of
>    10ac85c7 (upload-pack: add object filtering for partial clone,
>    2017-12-08) upthread.
> 
>  * See also "imperative-mood" in SubmittingPatches. I.e. say "Fix a bug
>    in ..." not "This fixes ... can be reproduced as"
> 
>  * uploadpack.packObjectsHook not uploadpack.packobjectshook except in C
>    code.

Generally good advice (the imperative stuff IMHO is less important
outside of the subject line, but a reasonable default way of writing).

> > The problem is an unnecessary and harmful layer of quoting. I tried
> > digging through the history of this function and I think this quoting
> > was there from the start.
> 
> 
> ...So looked at "git log" but didn't try to check out 10ac85c7 and see
> if it had the same issue? If we're going to leave a note about this at
> all probably better to help future source spelunkers by being able to
> say the issue was there from the start.

I don't think it could be tested easily at that point. It implemented
the server side, but not the client side. And later when the client side
was added, the non-hook code path was fixed. (More discussion earlier in
the thread).

-Peff
