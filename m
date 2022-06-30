Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86361C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 08:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbiF3IeS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 04:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiF3IeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 04:34:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA14F1B7A0
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 01:34:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ay16so37542306ejb.6
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 01:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jpElAa22wTJMkGIYE41JF3VDSuuHlRDlJxC0Tml97dw=;
        b=hL4wH2hDHbuTSdxBy7/jlYyzma8x43HkxUW2K2aBk2Cj8KrafrzI11f6IJ8YOr7fUN
         lAv72KvgyW0+eY5x2k/b1kmUygUR90dKm9/DA5keOiWZL+Eqa6JjuWRXWSdRp7fOXvGD
         b8vO+VfpJfbR1KbDLA0GVgxmUKoWTQxEpRuPMGeNCmA0s3unp5FVWTE8Mb8aWwVISSSy
         UeQMP3wwgajJvLWVi9LD+hFxjrVh/a//1uCTVw6Pa+4A4ANNgRGOmwfDjwfpM8+HGPZi
         fkm+ubAVS/wbfDMeFaMaYoL8JR/NuS/OuXKGjxxMm66FHThC8vCS9gCb7VsqB3JzrKcr
         I2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jpElAa22wTJMkGIYE41JF3VDSuuHlRDlJxC0Tml97dw=;
        b=fTDNk4BsiTvkmgIDroYjGtQJQ3MOYbsuXf1RsWHUO+Yt/uczKgWTAyFqjvtXX5ljBC
         mDo0fdwjHWUNMdKLGQYfMfLGWAAdTFXdwG7D+iaS8RPCLRr9WYhZLNQga9Z8sdL/EYIf
         hZnE8LP4EohF3bBEv9MBNM+IGFwugSEHbGyFefGtoMQjnSHWJ71EPsZs6rxn8/uMuYrf
         GFzTSHCGcSBW7QrObc0y1GzzzhNeJAI7ScgBXzHYWkUw8FhK0MGSIXNL/zyZCHIh466b
         knEfc8LLPv2tiQ+agucBM3dYg3UKl14gp6GtQjxZZR37LkDk2llNBTRiYaP5/VnfmPx2
         J6ng==
X-Gm-Message-State: AJIora9brJKtRvpV3vRryQJQpnF7HP6FL64C4bYXyam6tKFhp0/LHqbh
        Q2qC5GABYxr1qDRGKEtfPLI=
X-Google-Smtp-Source: AGRyM1slv2jtIc+MyqrbmsCTUXuJI4GkYNkUmq/9VGyO7QD7E9X3u7bXGhzYbTetO2rAhaQT7aIePw==
X-Received: by 2002:a17:907:3f1d:b0:726:c927:769b with SMTP id hq29-20020a1709073f1d00b00726c927769bmr7590309ejc.754.1656578053289;
        Thu, 30 Jun 2022 01:34:13 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id h6-20020aa7cdc6000000b00435720b7a1csm12862186edw.20.2022.06.30.01.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 01:34:12 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o6pcq-002B8A-0v;
        Thu, 30 Jun 2022 10:34:12 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        jonathantanmy@google.com, gitster@pobox.com,
        Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 0/4] move pruned objects to a separate repository
Date:   Thu, 30 Jun 2022 10:00:27 +0200
References: <cover.1656528343.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <cover.1656528343.git.me@ttaylorr.com>
Message-ID: <220630.86y1xeeeik.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 29 2022, Taylor Blau wrote:

> Now that cruft packs are available in v2.37.0, here is an interesting
> application of that new feature to enable a two-phase object pruning
> approach.
>
> This came out of a discussion within GitHub about ways we could support
> storing a set of pruned objects in "limbo" so that they were not
> accessible from the repository which pruned them, but instead stored in
> a cruft pack in a separate repository which lists the original one as an
> alternate.
>
> This makes it possible to take the collection of all pruned objects and
> store them in a cruft pack in a separate repository. This repository
> (which I have been referring to as the "expired.git") can then be used
> as a donor repository for any missing objects (like the ones described
> by the race in [1]).
> [...]
> [1]: https://lore.kernel.org/git/YryF+vkosJOXf+mQ@nand.local/

I think the best description of that race on-list is this by Jeff King,
if so I think it would be nice to work it into a commit message (for
4/4):

	https://public-inbox.org/git/20190319001829.GL29661@sigill.intra.peff.net/

Downthread of that, starting at:

	https://public-inbox.org/git/878svjj4t5.fsf@evledraar.gmail.com/

I describe a proposed mechanism to address the race condition, which
seems to me be functionally the same as parts of what you're proposing
here. I.e. the "limbo" here being the same as the proposed "gc
quarantine".

The main difference being one that this RFC leaves on the table, which
is how you'd get these objects back into the non-cruft repository once
they're erroneously/racily expired. I imagined that we'd add it as a
special alternate, read it last, and make the object reading code aware
that any object needed from such an alternate is one that we'd need to
COR over to our primary repository:

	https://public-inbox.org/git/8736lnxlig.fsf@evledraar.gmail.com/

Whereas it seems like you're imagining just having the "cruft pack"
repository around so that a support engineer can manually recover from
corruption, or have some other out-of-tree mechanism not part of this
RFC to (semi-?)automate that step.

If you haven't it would be nice if you could read that thread & see if
what I'm describing there is essentially a superset of what you have
here, and if any of the concerns Jeff King brought up there are ones you
think apply here.

Particularly as there was a reference to an off-list (presumably at
GitHub) discussion with Michael Haggerty about these sorts of races. I
don't know if either Jeff or Michael were involved in the discussions
you had.

I think that the mechanism I proposed there was subtly different from
what Jeff was concerned about being racy, but that thread was left
hanging as the last reply is from me trying to clarify that point.

So maybe I'm wrong, but I think if that was the case you'd also be wrong
about this approach being viable, so it would be nice to clear that up
:)

I'd also be very interested to know if you have anything like my
proposed auto-healing via a special alternate planned.  I think that
would allow aggressive pruning of live repositories not by fixing our
underlying race conditions, but by "leaning into" them as it were.

I.e. we'd race even more, but as we could always auto-heal by "no, I'll
actually need that" COR-ing the relevant object(s) back from the "gc
quarantine" (or your "cruft repository") that would be OK.
