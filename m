Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF406C43618
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5722613F7
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbhELX0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:26:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:52926 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240646AbhELXMy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 19:12:54 -0400
Received: (qmail 30555 invoked by uid 109); 12 May 2021 23:11:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 May 2021 23:11:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10646 invoked by uid 111); 12 May 2021 23:11:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 May 2021 19:11:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 May 2021 19:11:36 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH 5/9] send-email: use function syntax instead of barewords
Message-ID: <YJxgqA+AajRh2Q0J@coredump.intra.peff.net>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <patch-5.9-8846d40fc0-20210512T132955Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-5.9-8846d40fc0-20210512T132955Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 03:48:21PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Change calls like "__ 'foo'" to "__('foo')" so the Perl compiler
> doesn't have to guess that "__" is a function. This makes the code
> more readable.

I think this is a good change. And while you do qualify it as "more"
readable, I think the main issue with readability here:

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 9ff315f775..da46925aa0 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -678,7 +678,7 @@ sub is_format_patch_arg {
>  		if (defined($format_patch)) {
>  			return $format_patch;
>  		}
> -		die sprintf(__ <<EOF, $f, $f);
> +		die sprintf(__(<<EOF), $f, $f);
>  File '%s' exists but it could also be the range of commits
>  to produce patches for.  Please disambiguate by...

is how far the "EOF" marker is from the actual here-doc, syntactically
(plus the ugly indentation). I suspect this and other places might be
nicer to assign from the here-doc into a well-named variable.

But I think it's fine to leave for now (and I worry a bit that it may
turn into a rabbit hole, so we might be better to just leave it alone
anyway).

-Peff
