Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C416C1F453
	for <e@80x24.org>; Wed,  1 May 2019 21:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfEAVD4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 17:03:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:46338 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726115AbfEAVD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 17:03:56 -0400
Received: (qmail 24958 invoked by uid 109); 1 May 2019 21:03:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 May 2019 21:03:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22722 invoked by uid 111); 1 May 2019 21:04:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 01 May 2019 17:04:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2019 17:03:54 -0400
Date:   Wed, 1 May 2019 17:03:54 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] gitsubmodules: align html and nroff lists
Message-ID: <20190501210354.GC13372@sigill.intra.peff.net>
References: <20190501203216.141398-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190501203216.141398-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 01, 2019 at 01:32:17PM -0700, Emily Shaffer wrote:

> There appears to be a bug in the toolchain generating manpages from
> lettered lists. When a list is enumerated with letters, the resulting
> nroff shows numbers instead. Mostly this is harmless, but in the case of
> gitsubmodules, the paragraph following the list refers back to each
> bullet by letter. As a result, reading this documentation via `man
> gitsubmodules` is hard to parse - readers must infer that a bug exists
> and a refers to 1, b refers to 2, and c refers to 3 in the list above.

Yikes, I see this, too.

> The problem specifically was introduced in ad47194; previously rather
> than generating numerated lists the bulleted area was entirely
> monospaced in HTML and shown in plaintext in nroff.

I wondered briefly if ad47194 was doing the wrong thing to convert this
section, but I think its _intent_ was right. Its author just didn't
anticipate this bug. :)

> The bug seems to exist in docbook-xml - I've reported it on May 1 via
> the docbook-apps mail list - but for now it may make more sense to just
> work around the issue.

Yeah. Specifically, the HTML generated directly from asciidoc doesn't
have this bug. Likewise, using asciidoctor has no impact (though in
theory if we eventually move to generating roff directly from
asciidoctor, the problem might go away).

I agree with you that it's worth working around in the meantime.

The patch itself looks good to me. A few observations:

>  A submodule is considered active,
>  
> -  a. if `submodule.<name>.active` is set to `true`
> +  1. if `submodule.<name>.active` is set to `true`

I'd sometimes use letters when there is already a nearby list using
numbers (and I need to be able to refer to either list distinctly). But
I checked the surrounding context and don't think that's the case here.

> -Note that (c) is a historical artefact and will be ignored if the

Not introduced by your patch, but it may be worth swapping this out for
"artifact". The spelling with the "e" is apparently a British-ism (today
I learned!), but I think we usually favor (favour!?) American spellings
in our documentation.

Obviously not super important, and definitely should be addressed in a
separate patch (if at all).

-Peff
