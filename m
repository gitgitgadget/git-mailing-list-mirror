Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75867C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55DA0611C7
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 14:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhIJOyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 10:54:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:43956 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbhIJOys (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 10:54:48 -0400
Received: (qmail 5935 invoked by uid 109); 10 Sep 2021 14:53:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Sep 2021 14:53:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25846 invoked by uid 111); 10 Sep 2021 14:53:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Sep 2021 10:53:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Sep 2021 10:53:36 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 1/8] INSTALL: don't mention the "curl" executable at
 all
Message-ID: <YTtxcBdF2VQdWp5C@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
 <patch-v2-1.8-ac11cf8cfd1-20210910T105523Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-1.8-ac11cf8cfd1-20210910T105523Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 10, 2021 at 01:04:26PM +0200, Ævar Arnfjörð Bjarmason wrote:

> In 1d53f90ed97 (The "curl" executable is no longer required,
> 2008-06-15) the wording for requiring curl(1) was changed to the
> current "you might also want...".
> 
> Mentioning the "curl" executable at all is just confusing, someone
> building git might want to use it to debug things, but they might also
> just use wget(1) or some other http client. The "curl" executable has
> the advantage that you might be able to e.g. reproduce a bug in git's
> usage of libcurl with it, but anyone going to those extents is
> unlikely to be aided by this note in INSTALL.

I think that's reasonable. Keeping the INSTALL document short and clear
is much more important than preemptively giving debugging hints of
questionable value.

> diff --git a/INSTALL b/INSTALL
> index 66389ce0591..5c6ecf03c27 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -139,11 +139,11 @@ Issues of note:
>  	  (PPC_SHA1).
>  
>  	- "libcurl" library is used by git-http-fetch, git-fetch, and, if
> -	  the curl version >= 7.34.0, for git-imap-send.  You might also
> -	  want the "curl" executable for debugging purposes. If you do not
> -	  use http:// or https:// repositories, and do not want to put
> -	  patches into an IMAP mailbox, you do not have to have them
> -	  (use NO_CURL).
> +	  the curl version >= 7.34.0, for git-imap-send.
> +
> +	  If you do not use http:// or https:// repositories, and do
> +	  not want to put patches into an IMAP mailbox, you do not
> +	  have to have them (use NO_CURL).

I was confused by "them" here, which you kept in the post-image. In the
original I thought it mean "libcurl and curl". And now that you are just
saying "libcurl", it ought to be "it".

But perhaps it means "git-http-fetch, git-fetch, etc". In which case
it's still correct.

But maybe it would be simpler to say:

  If you do not use ..., you do not need libcurl (use NO_CURL to build
  without it).

Sort of orthogonal, but maybe worth touching while we're here: that list
of commands is kind of outdated. Nobody even knows what git-http-fetch
is these days, and most people would not use it (it is only for dumb
fetching). And certainly git-push can use http.

So maybe something like:

  "libcurl" library is used for fetching and pushing repositories over
  http:// or https://, as well as by git-imap-send if the curl version
  is >= 7.34.0.

-Peff
