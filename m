Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC05C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 18:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiKUSAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 13:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiKUSAg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 13:00:36 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F76140CF
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 09:59:57 -0800 (PST)
Received: (qmail 12246 invoked by uid 109); 21 Nov 2022 17:59:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Nov 2022 17:59:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25887 invoked by uid 111); 21 Nov 2022 17:59:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Nov 2022 12:59:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Nov 2022 12:59:55 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Teng Long <dyroneteng@gmail.com>
Subject: Re: [PATCH] docs: de-indent first paragraph of gitformat-* to flow
 the text
Message-ID: <Y3u8mzT6UN9DoOB7@coredump.intra.peff.net>
References: <221109.86bkpgriso.gmgdl@evledraar.gmail.com>
 <patch-1.1-1c1434bba31-20221121T141411Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-1c1434bba31-20221121T141411Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 03:15:50PM +0100, Ævar Arnfjörð Bjarmason wrote:

> But the end result of having some paragraphs use "<p>" in the HTML
> output, and to have others wrapped in "<pre><code>" doesn't look
> nice. The most minimal way to fix this is to de-indent the opening
> line of paragraphs that don't start with another formatting
> element (e.g. "*" or "-" would already format them as text). Let's do
> that.

Is there any reason to just touch the opening line of the paragraphs,
and not change the indent of the whole thing? I understand that doing
the first line is sufficient to convince asciidoc to do what we want,
and the diff is technically fewer lines, but the result is rather
confusing for people who will work on the source in the future.

> There's a lot more to fix in these gitformat-* docs (as their
> formatting was funny before), but this is a minimal change to fix the
> most major issues.

I briefly looked at doc-diff output here. Most of them looked obviously
correct (though since there isn't a lot of context in the doc-diff, it's
sometimes hard to tell), but a few were questionable:

> @@ -103,7 +103,7 @@ Git index format
>  
>    Object name for the represented object
>  
> -  A 16-bit 'flags' field split into (high to low bits)
> +A 16-bit 'flags' field split into (high to low bits)
>  
>      1-bit assume-valid flag

This puts "A 16-bit flags field" at a different indent than the
paragraph before, but I think it is part of a list. It is less indented
than the follow-on paragraph ("1-bit assume-valid flag"), but I think
that is correct, as it is a sub-list of the 16-bit flags.

I know you said that formatting problems remain, and certainly this was
not right before your patch either. But I think your patch makes it
worse, because it pulls the touched line out of the list (and all of the
adjacent parts are still rendered as code blocks, making the structure
even less clear).

> @@ -114,7 +114,7 @@ Git index format
>      12-bit name length if the length is less than 0xFFF; otherwise 0xFFF
>      is stored in this field.
>  
> -  (Version 3 or later) A 16-bit field, only applicable if the
> +(Version 3 or later) A 16-bit field, only applicable if the
>    "extended flag" above is 1, split into (high to low bits).
>  
>      1-bit reserved for future

This is the same (it's the same list).

> @@ -125,16 +125,16 @@ Git index format
>  
>      13-bit unused, must be zero
>  
> -  Entry path name (variable length) relative to top level directory
> +Entry path name (variable length) relative to top level directory
>      (without leading slash). '/' is used as path separator. The special
>      path components ".", ".." and ".git" (without quotes) are disallowed.
>      Trailing slash is also disallowed.

And I think this is supposed to be part of that same list, too, but now
is de-dented.

> -    The exact encoding is undefined, but the '.' and '/' characters
> +The exact encoding is undefined, but the '.' and '/' characters
>      are encoded in 7-bit ASCII and the encoding cannot contain a NUL
>      byte (iow, this is a UNIX pathname).

This is supposed to be a continuation of the earlier "Entry path name"
item, but now is at the same top-level. Which is not right, but arguably
is not worse than before your patch.

>  
> -  (Version 4) In version 4, the entry path name is prefix-compressed
> +(Version 4) In version 4, the entry path name is prefix-compressed
>      relative to the path name for the previous entry (the very first
>      entry is encoded as if the path name for the previous entry is an
>      empty string).  At the beginning of an entry, an integer N in the

And this one is another top-level part of the list.

> --- a/Documentation/gitformat-pack.txt
> +++ b/Documentation/gitformat-pack.txt
> @@ -294,10 +294,10 @@ Pack file entry: <+
>  
>    - The same trailer as a v1 pack file:
>  
> -    A copy of the pack checksum at the end of
> +A copy of the pack checksum at the end of
>      corresponding packfile.
>  
> -    Index checksum of all of the above.
> +Index checksum of all of the above.

These are supposed to be list items of "The same trailer as..." above.
Now they're de-dented, which I think is worse than the state before your
patch.

I don't want to say "we must fix all format problems at once", but I
think in the cases I pointed out that trying to fix the code-block
problem is a losing battle, because the list-like nature is being made
worse. And they probably should remain untouched until somebody is
willing to turn them into actual list elements and continuation markers.

-Peff
