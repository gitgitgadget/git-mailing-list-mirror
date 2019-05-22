Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA8981F462
	for <e@80x24.org>; Wed, 22 May 2019 05:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfEVFIm (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 01:08:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:35764 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725801AbfEVFIl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 01:08:41 -0400
Received: (qmail 15776 invoked by uid 109); 22 May 2019 05:08:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 May 2019 05:08:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20176 invoked by uid 111); 22 May 2019 05:09:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 May 2019 01:09:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 May 2019 01:08:39 -0400
Date:   Wed, 22 May 2019 01:08:39 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Adam Roben <aroben@apple.com>,
        Bryan Larsen <bryan.larsen@gmail.com>,
        Matthias Urlichs <smurf@smurf.noris.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] hash-object doc: elaborate on -w and --literally
 promises
Message-ID: <20190522050839.GB29933@sigill.intra.peff.net>
References: <20190520215312.10363-1-avarab@gmail.com>
 <20190520215312.10363-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190520215312.10363-3-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 20, 2019 at 11:53:11PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Clarify the hash-object docs to explicitly note that the --literally
> option guarantees that a loose object will be written, but that a
> normal -w ("write") invocation doesn't.

I had to double-check here: you mean that _when_ we are writing an
object, "--literally" would always write loose, right?

> At first I thought talking about "loose object" in the docs was a
> mistake in 83115ac4a8 ("git-hash-object.txt: document --literally
> option", 2015-05-04), but as is clear from 5ba9a93b39 ("hash-object:
> add --literally option", 2014-09-11) this was intended all along.

Hmm. After reading both of those, I do think it's mostly an
implementation detail. I would not be at all surprised to find that the
test suite relies on this (e.g., cleaning up with rm
.git/objects/ab/cd1234). But I suspect we also rely on that for the
non-literal case, too. ;)

So I am on the fence. In some sense it doesn't hurt to document the
behavior, but I'm not sure I would want to lock us in to any particular
behavior, even for --literally. The intent of the option (as I recall)
really is just "let us write whatever trash we want as an object,
ignoring all quality checks".

>  --literally::
> -	Allow `--stdin` to hash any garbage into a loose object which might not
> +	Allow for hashing arbitrary data which might not
>  	otherwise pass standard object parsing or git-fsck checks. Useful for
>  	stress-testing Git itself or reproducing characteristics of corrupt or
> -	bogus objects encountered in the wild.
> +	bogus objects encountered in the wild. When writing objects guarantees
> +	that the written object will be a loose object, for ease of debugging.

I had to read this last sentence a few times to parse it. Maybe a comma
before guarantees would help? Or even:

  When writing objects, this option guarantees that the written object
  will be a loose object, for ease of debugging.

-Peff
