Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED85C1B0D9
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 17:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0988723AA8
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 17:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbgLIR14 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 12:27:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:55742 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732774AbgLIR14 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 12:27:56 -0500
Received: (qmail 18753 invoked by uid 109); 9 Dec 2020 17:27:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Dec 2020 17:27:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17031 invoked by uid 111); 9 Dec 2020 17:27:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Dec 2020 12:27:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Dec 2020 12:27:13 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 1/2] Add project-wide .vimrc configuration
Message-ID: <X9EI8c9yeX136ewm@coredump.intra.peff.net>
References: <20201209065537.48802-1-felipe.contreras@gmail.com>
 <20201209065537.48802-2-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201209065537.48802-2-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 09, 2020 at 12:55:36AM -0600, Felipe Contreras wrote:

> +augroup git
> +	au BufRead,BufNewFile */Documentation/*.txt set filetype=asciidoc
> +
> +	au FileType c setl noexpandtab tabstop=8 shiftwidth=0 cino=(s,:0,l1,t0

I had to read up on a few of these settings, and I'm still slightly
puzzled:

  - I generally leave shiftwidth=8, but reading the documentation says
    that 0 is equivalent to "1 tabstop". So that should be equivalent.

  - I've been using "(0" for years for my git work (which indents to
    align new lines with the unclosed parenthesis). I'm not quite sure
    what "(s" means. The documentation says "1s" would be "one
    shiftwidth". Is just "s" the same?

  - I also have ":0", which doesn't indent case labels. Matches our
    style.

  - I didn't have "l" set myself. I never noticed because it only
    matters if you open a case with an extra brace, which is relatively
    rare. For non-vim folks, it is preferring:

	switch (foo) {
	case 0: {
		break;
	}

    to:

	switch (foo) {
	case 0: {
			break;
		}

    which seems consistent with our style. So I think that is worth
    doing.

  - t0 is specifying not to indent function return types when they
    appear on a separate line. But our style is not to put those return
    types on a separate line, anyway. Do we need this?

-Peff
