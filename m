Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6BEC433E0
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 22:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 330432070B
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 22:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgG0W55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:57:57 -0400
Received: from 0x63.nu ([109.74.10.199]:48882 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0W55 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 18:57:57 -0400
Received: from ip6-localhost ([::1] helo=moveme2)
        by 0x63.nu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1k0C47-0008H6-Gh; Tue, 28 Jul 2020 00:57:51 +0200
References: <87blk0rjob.fsf@0x63.nu> <xmqqr1swg9lc.fsf@gitster.c.googlers.com> <CAP8UFD1XV_jN10yOc2o4=5PtPcvT-RbxhY1H3swZz2r4g-Uzkw@mail.gmail.com> <20200727194036.GA795313@coredump.intra.peff.net>
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Questions about trailer configuration semantics
Message-ID: <875za8r2fu.fsf@0x63.nu>
In-reply-to: <20200727194036.GA795313@coredump.intra.peff.net>
Date:   Tue, 28 Jul 2020 00:57:51 +0200
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Jeff King writes:

> On Mon, Jul 27, 2020 at 08:37:26PM +0200, Christian Couder wrote:
>
>> > > I noticed some undocumented and (at least to me) surprising behavior in
>> > > trailers.c.
>> > >
>> > > When configuring a value in trailer.<token>.key it causes the trailer to
>> > > be normalized to that in "git interpret-trailers --parse".
>> > > E.g:
>> > >  $ printf '\naCKed: Zz\n' | \
>> > >    git -c 'trailer.Acked.key=Acked' interpret-trailers --parse
>> > >  will emit: "Acked: Zz"
>>
>> Yeah, I think that's nice, as it can make sure that the key appears in
>> the same way. It's true that it would be better if it would be
>> documented.
>
> I'd note that this also happens without --parse.

Right, and it also happens with "--only-input" (part of "--parse")

"--only-input" is documented as follows:

   Output only trailers that exist in the input; do not add any from the
   command-line or by following configured trailer.* rules.


[]

> I don't recall being aware of this prefix matching until this thread, so
> I doubt that the current behavior of --parse was something I tried for
> intentionally. It's mostly just using the existing code, plus a few
> extra options (listed in the docs). I'm not opposed to adding an option
> to do strict matching and/or avoid rewriting, and then possibly adding
> that into --parse by default.

Would that option also be set for the parsing done by "%(trailers)"
pretty format specifier?

> I don't have much of an opinion on which behavior would be preferred.
> I've never actually had a use case for configuring trailer.*.key, as I
> usually am only looking at reading existing trailers to collect stats,
> etc.

I'm also mainly using in reading trailers (mostly with pretty format
"%(trailers:key=x)") and then these convenience shortcuts doesn't really
seem helpful, they rather add a small risk of mangling my data. Not that
this has caused any problems for me in practice.

