Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E41C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 11:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiKJLZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 06:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiKJLZP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 06:25:15 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D232E4AF36
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 03:25:13 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id 13so4212914ejn.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 03:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tVBG+Pxd9oPgqdQJ5EK0T7CRjo/XjHceJWlbURiwsSU=;
        b=PVukjgzhnm7Z6C4dDqc7knEGoQ+ubea6cvqbsMnOurxcrW5ybWe4MPtl69YQPUNgnv
         j3zvdKpxlB+dVG9hhuwuPD8LGf3spBz5uIBGNZ2r2g9oFzE9TvbHT488igppi9GALDKR
         j1SuhIGZlpARPkf57QYInZthx5jsZXceI+J9vaxCrEpxXTwgdiMtqFC+gY1g3+sOqoso
         NtHS1PQyBzfShi8jRoxLno5ekxmXF3J9428DCSVoAWbhRgqcIGdaGTpEmIit+rmKTUeJ
         hre0TxwwgyG/5fFBLqdLNgaxc7qysSyhEMbNRYNpCenSpWpF8KsdFHY9/rKSGsAnBjek
         kzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tVBG+Pxd9oPgqdQJ5EK0T7CRjo/XjHceJWlbURiwsSU=;
        b=FNdpTAR72Cy3bnDwdJMyO4z4eHqafbq8lUWiCrHiUn/qSGWVzOzIzRNi0fFn8EWRJ9
         Ytekt11NHsJR1CXWY5QRD4SE62v/68XbbIlAgMG03fHChMEbEUrd4b0cdWEJJ3JgKzi8
         ibPeh8G76QAQuyrDd72v4DFr4RS98Ft1aMUFkrp/XEf5XDfoOI60fCxyfB3VVA+J9niX
         PCnApBwpbN8vHc3CbNI1IIzfpq4YKF0lsIIZQv5KVDG0Ui5Lq+JNiI749ymcioOma+I7
         U9ES6+si+Hpr8d6iJ0bgGUnXTPvDmJCOijgG4T42sXtIOrdVuyRfCEossFiZgUtpQH9O
         jZfA==
X-Gm-Message-State: ACrzQf2E1bbuF/QhBGAbdto5xHB4hLX5DshhsRV5gUZX8s5Yac0HlBWI
        fKVdTIWelu5sPXGeCZ5xDrRtTsA7NwgMkg==
X-Google-Smtp-Source: AMsMyM7fhL4pQ7e2aWqc1nrpGxcWvoi8p11V40lvTh/P60VYr21oOBZ0Cxi/wWJOyxUrKnwLcluidg==
X-Received: by 2002:a17:907:8b18:b0:7ad:d1f5:2f80 with SMTP id sz24-20020a1709078b1800b007add1f52f80mr52458150ejc.661.1668079512043;
        Thu, 10 Nov 2022 03:25:12 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id gu14-20020a170906f28e00b0072f112a6ad2sm7150272ejb.97.2022.11.10.03.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 03:25:11 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ot5gE-001Uhj-34;
        Thu, 10 Nov 2022 12:25:10 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] Get rid of "git --super-prefix"
Date:   Thu, 10 Nov 2022 11:51:07 +0100
References: <20221109004708.97668-1-chooglen@google.com>
 <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <kl6ltu373ae5.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <kl6ltu373ae5.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <221110.86zgcznjah.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 09 2022, Glen Choo wrote:

> Thanks for the series! I haven't fully figured out where I stand on
> this, but I can share some initial thoughts and comparisons to my RFC.
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> An RFC alternative to Glen's [1], and what I *thought* he might be be
>> going for in the earlier discussion[2].
>>
>> The difference is that in Glen's there's no "git --super-prefix", but
>> rather each set of commands still using it ("submodule--helper",
>> "read-tree" etc.) geit their own command-level option.
>
> Yes, and a secondary intent was to give exact definitions and a shared
> implementation to the command-level options instead of having each new
> command figure out what to do every time a similar use case pops up.

... (more below)...

>>
>> But it still works substantially the same, in that we're juggling a
>> global variable that we set, and read out later somewhere down the
>> stack.
>
> Yes, intentionally so. I was under the assumption that the various
> prefixes would still be used, and that adding them to commands will be a
> necessary evil, so it was better to have them share a single
> implementation.

I'm not sure I understand what you mean here exactly, but as an example
that might clarify things: In my "foreach" patch:
https://lore.kernel.org/git/RFC-patch-3.8-4858e2ad0ed-20221109T192315Z-avar=
ab@gmail.com/

I'm making use of "OPT__SUPER_PREFIX()" to share the things that need to
be shared, and after that we ferry the "super_prefix" from
module_foreach() down through "struct foreach_cb" to
"runcommand_in_submodule_cb()", and that's all the places we need it.

With how OPT_SUBCOMMAND() works we'd need a file-level static variable
(or similar) if we took the "--super-prefix" in the
cmd_submodule__helper() instead, which we could do, and it would have
pretty much the same effect.

But I don't really see the advantage in any one individiual case. Isn't
it just trading that one repeated "OPT__SUPER_PREFIX()" line for more
clarity about who needs what?

>> Whereas here there's no renaming of the option, but:
>>
>>  * For "submodule--helper" only the sub-commands that need it take the
>>    option, it's not an option to "submodule--helper" itself.
>
> In writing [1], I ended up convincing myself that it isn't just that all
> of "submodule--helper" _does_ support "--super-prefix", but that all of
> it _should_ support "--super-prefix". I'll have to take another look.

I agree with your:

	"[...]"This is the only way the prefix is used in "git
	submodule--helper", and all of its subcommands already conform
	to this behavior (even the ones that weren't marked
	SUPPORT_SUPER_PREFIX) because they all use
	get_submodule_displaypath() when printing paths to
	submodules.[...]"

In that it's clear that e.g. if "add" were added to the list of
sub-commands that used "git --super-prefix" *and* we started calling
that recursively with the same method that "get_submodule_displaypath()"
makes it easier to construct such paths (which is also the case after my
series, just with the *_sp() variant).

But I don't see how that extends to an argument that we should be
blurring the lines about what does and doesn't need it *now*, which as I
pointed out in my "now we'll accept it" is what that commit is doing:
https://lore.kernel.org/git/221109.867d04rfnt.gmgdl@evledraar.gmail.com/

> At the very least, the subcommands that are just entrypoints for
> git-submodule.sh should support it, since they all need to print
> submodule paths in a semi-consistent way. I still think it would be nice
> for these to take a top level flag.

But they don't need it, and some of them will never need it. E.g. I
don't see how it would make sense for "set-url" and "get-url" ever to
get a "--recursive" option, those are inherently non-recursive (if
they're going to make any sense, you *could* set all your submodule URLs
to the same thing, but what's the use in that?).

But also re my:
https://lore.kernel.org/git/221110.86cz9vpvqk.gmgdl@evledraar.gmail.com/;
I think that *if* we add new recursion we're just as likely to not use
any "--submodule-prefix"-like functionality, but to instead just walk
the tree, constructing repo objects along the way. As my 8/8 summarizes
that's what we're doing in "grep", "ls-files" etc.

Still, if it was easier etc. to just provide this for the entire
command, even if all subcommands wouldn't need it I wouldn't mind
it. But as noted above it's trivial to add it on demand with
"OPT__SUPER_PREFIX()", you don't need to reason about globals etc. So I
just don't see the benefit...

> There are other subcommands that are implementation details of other
> commands that need to run in a submodule because of assumptions
> the_repository, e.g. create-branch, push-check. Maybe these don't need
> "--super-prefix", I'll take another look.

I you don't need to take much of a look, because on "master" they don't
have a "SUPPORT_SUPER_PREFIX" next to their listing at the bottom of
submodule--helper.c, ditto for the "if" chain I have in
"next". I.e. none of the ones listed in the "struct option options" as
OPT_SUBCOMMAND() use "git --super-prefix", except if they're listed in
the "if" chain below.

> I'm not sure if there are others.

We can be sure it's just clone/update/foreach/status/sync/absorbgitdirs,
because if the others are invoked with the --super-prefix they'll die().

Which aside from the specific approaches in either of our topics is, I
think, a really nice thing to have. I.e. it makes reasoning about the
code easier if we can confidently say "this is a feature with global
effect, but it only has an impact on this subset of stuff".

Which is an aspect of your proposed RFC that I don't like in
isolation. I.e. if/when we're going to do the eventual refactoring that
I've done in my RFC we'd need to reason that we need to change "foreach"
and not "create-branch" or whatever, which the current whitelisting
really helps us with.

> (As an aside, when you remove git-submodule.sh, I wonder if we should
> split up submodule--helper along this dual-use line? e.g. the ones that
> are entrypoints could be moved to "builtin/submodule.c", and the
> implementation details can stay in "builtin/submodule--helper.c". Or
> maybe you're already one step ahead of me here :))

Yes, I'm ahead of you there.

The ones that are purely internal, such as "push-check" etc. are still
going to be invoked as "submodule--helper push-check".

Before my RFC topic here I was planning on having both a "foreach" and
"submodule--helper-foreach", as seen in:
https://lore.kernel.org/git/221104.86wn8bzeus.gmgdl@evledraar.gmail.com/

That was because I:

 1. Didn't want to make "foreach"'s "--super-prefix" interface "public",
    which it isn't now, as it's a purely internal thing we're trying to
    eventually get rid of.
 2. Didn't want to list all of "submodule--helper" as accepting it, as
    some of it doesn't need it (e.g. "push-check").

So having a "git submodule foreach" *not* accept it and it then
recursing to an internal "git submodule--helper-foreach" which did
accept it seemed like the least sucky thing to do.

But if I rebase those patches on my RFC topic here we can invoke both as
just "git submodule foreach".

Pedantically, that's also exposing a "private" interface to the
public. But:

 * I'm listing it as OPT_HIDDEN, so we're not showing it outside fo
   --help-all.

 * More importantly, you need to provide that specific flag, it's not
   accepting it "at a distance" via an env variable, which was the main
   thing I was being paranod about.

   Or rather. Even if *I knew* that "read-tree" or whatever wasn't
   invoking a hook, which then invoked "submodule foreach" down the
   line, and that "foreach" was slurping up the env var, I wanted to
   leave it in a state where the next maintainer of this code didn't
   have to worry about that.

> As you noted (somewhere) in the series, only commands called recursively
> need "--super-prefix", because otherwise "submodule--helper" is called
> from the root of the superproject and the 'prefix' is already
> well-known. I didn't make this argument because it was hard to word, so
> I'm glad you mentioned it.

Right, and just to add to that: This is the super_prefix=3D=3DNULL case in
get_submodule_displaypath() on "master" (i.e. aside from either of our
topics here).

> [1] https://lore.kernel.org/git/20221109004708.97668-2-chooglen@google.co=
m/
>
>>  * There's no passing of the "super_prefix" as a global, instead we
>>    pass it all the way along until we recurse to ourselves. For
>>    "submodule--helper" this is quite straightforward.
>>
>>  * Then in 8/8 we're left with just "read-tree" needing the remaining
>>    "--super-prefix", and we likewise don't pass it as a global, but
>>    instead add it to the "struct unpack_trees_options", which will
>>    pass it all the way down into unpack-trees.c and entry.c, until
>>    we're going to recursively invoke another "read-tree".
>
> I worry a little about two "necessary evils":
>
> - (As stated earlier) we may have to add "--super-prefix" or similar to
>   more commands
> - We may need to read "--super-prefix" from many parts of the code,
>   since many parts might print paths.
>
> Having globals makes both of these cases easier, and is quite a bit
> closer to the original implementation of "--super-prefix" (so your
> characterization of only getting to a halfway point is accurate). This
> was mostly to stave off opposition that it would tedious to add new
> per-command "--super-prefix"-es, but if nobody else cares, maybe it's ok
> to get of the globals.
>
> If we do want to pass a context object around, we probably have to be
> more principled about it (e.g. in 8/8 I notice that checkout_stage()
> doesn't receive the context object and we resort to passing NULL
> instead), but we'd want that anyway if we want Git to move towards being
> more library-like.

Quick aside: Yes, that unlink_entry(ce) in builtin/checkout.c is now
unlink_entry(ce, NULL).

The API had only 3 users, and two potentially cared about the
super_prefix. So I just amended the existing function, we could also add
a unlink_entry_sp() or whatever.

> It's quite likely that if any new "--super-prefix"-es are added, they
> would be added by a Googler (even the original ones were ;)), so I can
> probably go through the roadmap and figure out how costly these extra
> "--super-prefix"-es might be.

I don't really see that happening, but let me just grant that point for
the sake of argument:=20

Next month we're going to add a new "--super-prefix"-like use, and we're
going to want some combinatino of a global, setenv()/getenv() etc. back,
because it's the "sparse" code or whatever, and it'll be daunting to
pass the state through 30 levels of callstack, we'll want to bypass it.

I still don't see how it follows that we'd want to keep any of structure
for this, which I think my series shows none of the current code needs.

We can easily add such functionality back, adding a global variable
isn't hard, and I think if anything such a future future would benefit
from having to explain why it needs global state to do this sort of
thing, when these other commands and sub-commands don't.
