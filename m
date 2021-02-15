Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57619C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 17:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CDC064E02
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 17:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhBORFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 12:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhBORC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 12:02:26 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C69C061756
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 09:01:35 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id jt13so12374297ejb.0
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 09:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uLY+Y8AoLGTsXYSwGCwwyMJ7olWnSx6E60Fm+deNB4U=;
        b=k4nFyPu8Z6/9gge/fAyEz2Gumr68tWr+lmhl/OGgNXewvupVk0fu0LsVbNV81V9zGq
         DnT/Jfe619oIadyQrUaSY/2jQb6E0PaBZxReD3OU5P4aNQVCDx7wrjgicLtWkb+lrnV1
         jGjyjHfZ9osEt5aO+2oYKGPKdTxs6DBDGrdvNarMvozjOhyZNyZ8nFDRuL0NMrNShce4
         FgD3f8GiZyNzq9wZxgFIVdFBtYrV4wLNMakcHCPRfXla7Q7BNY0ys6Fpmw1VjAAjxfcs
         qeSqVumXivFZIr2coq5IMW+aKiif5bI+jO+PAvLGk9M0fqW8EI24qXhD8NIQ2PSORySs
         UAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=uLY+Y8AoLGTsXYSwGCwwyMJ7olWnSx6E60Fm+deNB4U=;
        b=k2c7baYuhQgOm9+7oLbcdzm0nY0jpxL/RyDxb7dJYHqbfhy4wDIFlXqWRkR7L3zjIy
         Dl2XeXFOLHs38eOzQSe/QKW07V5xEShlMLdjSa5JygJIJ2RQaI6q2j5eZ2A3Z+aVgos8
         rquGmKhYs+a7znVjQZvivZF947qJQrd2lU0SGRtGB6eAuoSwc42okVciFXLH0t8c2QK5
         OpJ5ovf78Zk4KBaWzr/dBwHGutNtM9K9GY9J6tGtQBn8XdpB2d9ykcl1ozl6XuPZPD4n
         tX3AAEqUVH2BZFlJ0LUxsuNxVWkqhl8PNwg4j2JJfHfoI5TpC94RJqoPEJ7/BYWezqfK
         XR5w==
X-Gm-Message-State: AOAM532bKmuKm1W1b+nePm11JkOgUlxbE753oKB/sKxhfFAr5j0Bfvr6
        bpfs3Xh+P/gvAdiTHawVPbY=
X-Google-Smtp-Source: ABdhPJwMJJsFgcSEKnaUKcK3/k0uM4dZ03RhevaLETIu1ANUqME0MolkfdWM6t/paDaW7ZqrTTBmeg==
X-Received: by 2002:a17:906:8295:: with SMTP id h21mr14626164ejx.275.1613408494142;
        Mon, 15 Feb 2021 09:01:34 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id i10sm3400718ejy.64.2021.02.15.09.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 09:01:33 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH 2/9] midx: allow marking a pack as preferred
References: <cover.1612998106.git.me@ttaylorr.com>
 <4a358d57cf6e834cd1756e70bf713d4d104f321e.1612998106.git.me@ttaylorr.com>
 <20210211193314.GG1015009@szeder.dev> <YCqX7hxWWKzmvaUO@nand.local>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YCqX7hxWWKzmvaUO@nand.local>
Date:   Mon, 15 Feb 2021 18:01:32 +0100
Message-ID: <87r1lhb6z7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 15 2021, Taylor Blau wrote:

> On Thu, Feb 11, 2021 at 08:33:14PM +0100, SZEDER G=C3=A1bor wrote:
>> > +--preferred-pack=3D<pack>::
>> > +	When using the `write` subcommand, optionally specify the
>> > +	tie-breaking pack used when multiple packs contain the same
>> > +	object. Incompatible with other subcommands, including `repack`,
>>
>> I think this shouldn't be an option of the 'git multi-pack-index'
>> command but an option of its 'write' subcommand.
>
> :-/. I wrote a lengthy response on Friday, but Gmail must have eaten it.
>
> The gist of my response was that the intermingling of sub-commands with
> options from other sub-commands goes deeper than just the documentation,
> since command-line arguments are only parsed once in
> builtin/multi-pack-index.c.
>
> I explored whether or not it would be worth it to parse the common
> options first, and then have separate options for each of the
> sub-commands (as is done in the commit-graph builtin). But, this is
> tricky, since we accept common options on either side of the sub-command
> (i.e., we'd expect both 'git multi-pack-index --object-dir=3D... write' to
> behave the same as 'git multi-pack-index write --object-dir=3D...').
>
> So you could let the first call to parse_options() parse all of the
> arguments, but then specialized arguments (e.g., 'repack --batch-size')
> would cause the parse-options API to barf because the first call to
> parse_options() doesn't recognize '--batch-size'.
>
> I think the easiest way to do it would be to pass
> PARSE_OPT_STOP_AT_NON_OPTION, and then let the subsequent calls to
> parse_options() pass an array of option structs that also includes the
> common options so they can be parsed on either side of the sub-command.
>
> Obviously this leads to a lot of rather unfortunate duplication. So,
> I'm content to leave it all as-is, and let the multi-pack-index
> builtin check the disallowed combinations itself (e.g., if you passed
> '--preferred-pack' but aren't in 'write' mode, then we should complain).
>
> I can certainly move this piece of documentation into the 'write'
> section, though, which should alleviate your immediate concern.

I may be missing something, but...

It sounds to me like you're imagining this is more complex than it is
because you don't know about some/all of parse_options_concat() or
PARSE_OPT_KEEP_*.

See e.g. cmd_{switch,restore} in builti/checkout.c, or the entire family
of diff-like commands where we do parse_options() followed by
setup_revisions(). We've got a lot of commands that parse options in a
piecemeal manner.

At no point do you need to re-parse the options. You just have the
common command parse as far as it gets, and leave anything else in
argv/argc for sub-commands like "write".

I think the problem is you read the builtin/commit-graph.c code, it
could really benefit from using parse_options_concat(), now things like
"object-directory" are copy/pasted in that file. See 2087182272
(checkout: split options[] array in three pieces, 2019-03-29) for a
commit which simplified that sort of code.

In this case you'd share the "opts_multi_pack_index" struct between the
various commands, it would just have unused fields for "write" that
aren't used by "verify" or whatever.

The PARSE_OPT_STOP_AT_NON_OPTION flag isn't for what you're doing with
"write" here, since as your test shows you're doing:

    git multi-pack-index <ALL_OPTS> <SUBCOMMAND>

But PARSE_OPT_STOP_AT_NON_OPTION is for cases like "git-remote" that do:

    git multi-pack-index <COMMOT_OPTS> <SUBCOMMAND> <SUBCOMMAND_OPTS>

(Or maybe you really want the latter, and the test change isn't
representative).

So then we want to stop at the first non-option, i.e. the subcommand. I
think it's good practice not to emulate how "git remote" works for new
commands, which makes things a bit simpler to implement.

You say "since we accept common options on either side of the
sub-command" but without PARSE_OPT_STOP_AT_NON_OPTION this works, since
if you can parse everything you'll have "write" left, but if you truly
have unknown options you'll have more than that in argv.

All of the above shouldn't be taken as a "your patch should change"
comment, maybe it's fine as-is.

I just replied because it sounded like you didn't spot how to easily use
parse_options() to do this sort of thing. It's actually rather easy.
