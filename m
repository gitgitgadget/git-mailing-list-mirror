Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4F0C433F5
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 19:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A86761139
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 19:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbhJFTNP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 15:13:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:34386 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhJFTNO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 15:13:14 -0400
Received: (qmail 26788 invoked by uid 109); 6 Oct 2021 19:11:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Oct 2021 19:11:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32551 invoked by uid 111); 6 Oct 2021 19:11:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Oct 2021 15:11:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 6 Oct 2021 15:11:20 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] object-name: make ambiguous object output
 translatable
Message-ID: <YV302GvgjqYhid5v@coredump.intra.peff.net>
References: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com>
 <cover-v2-0.2-00000000000-20211004T142523Z-avarab@gmail.com>
 <patch-v2-2.2-c0e873543f5-20211004T142523Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-2.2-c0e873543f5-20211004T142523Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 04, 2021 at 04:27:02PM +0200, Ævar Arnfjörð Bjarmason wrote:

> +	abbrev = repo_find_unique_abbrev(ds->repo, oid, DEFAULT_ABBREV);
> +	if (type == OBJ_COMMIT) {
> +		/*
> +		 * TRANSLATORS: This is a line of ambiguous commit
> +		 * object output. E.g.:
> +		 *
> +		 *    "deadbeef commit 2021-01-01 - Some Commit Message"
> +		 *
> +		 * The second argument is the "commit" string from
> +		 * object.c, it should (hopefully) already be
> +		 * translated.
> +		 */
> +		strbuf_addf(&desc, _("%s %s %s - %s"), abbrev, ci_ad.buf,
> +			    _(type_name(type)), ci_s.buf);
> +	} else if (tag_desc) {
> [...]

OK, this all looks reasonable to me. I'd probably have ditched "desc"
altogether in favor of just calling advise(), to give translators even
more information about what we're trying to output, but I admit I don't
care that much either way.

I'm still not sure if translating the object types is a good idea or
not, per my other response.

> +	/*
> +	 * TRANSLATORS: This is line item of ambiguous object output,
> +	 * translated above.
> +	 */
> +	advise(_("  %s\n"), desc.buf);

The "\n" here isn't necessary (and wasn't present in the original, but
it doesn't hurt, as advise()'s algorithm gobbles any newlines as it
splits). I guess it helps making this otherwise un-notable string more
unique for translation, but just stuffing the indentation into the
earlier calls would do an even better job of that.

-Peff
