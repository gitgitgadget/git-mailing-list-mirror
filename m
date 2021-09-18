Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3CAC433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 01:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2B6E60F6B
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 01:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhIRBTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 21:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhIRBTC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 21:19:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E2FC061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 18:17:39 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g8so36450043edt.7
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 18:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=HYlG1JxED0v2O5F3k/WSeb0XiWbG+8iTGH3QktfeRh4=;
        b=nFYLNKTj91b86ov/wxme8Jdg7PEzgk8fE6zS1+aHBfQerGZqf/PkQ5EEshoFNo1TQM
         HwJYN3OJsz6qgJKDHWufvMgf2RDQ89LC4i3M4J+7WAYXyG0oHOSIlSE4jD/6aLDeI6iP
         GeYVZiSMVIihMNPB6HBACq3d5WrvAJA7pHzF1kmdc4HWRKD7W7If0zfuBhG48nm3Ue2j
         t114Gckd6IIuaCAZhiLX5/PKkhnJ2MEtGBmHhxYvKGGhKhuUDxeCMUC3M8dFIX/USN4n
         m6w8Lf5Skdn9N2Lg9ga0sE6Mf5/NP6iQZ6j5LQgiqT8uf0OOEV8pvF6JbCWxq4BI2Kmi
         kCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=HYlG1JxED0v2O5F3k/WSeb0XiWbG+8iTGH3QktfeRh4=;
        b=wwEPkQEEstZQyNJRsX8jYVjdJL//5ifAG4udMxe+vB7GQ7ASwwTOLp5yhoXKwO4RRR
         TjXBgDctUZXN0IZDevvupUstp780IcpdizqwPa6z85BHLkID8+97jaw058vmHPWrn4gz
         cnnWJl6GCSZupMk3IaZ6BZpBULF69SetviYm63WU6Z7NlxJl8pKRBIoLxFoHoqANohnm
         GcIg5BkHVj8E9/AsthebHdTMkSRsE77s8rap98pT0rl57Ambz6oYGwIdW0VUvXJ7NLdF
         9GNRjpnU/tUfvHz84O5GAVbP3paI2QVL+k/RzDCjbHD8uukHeQdIIlu9G1/m1zvIqSe4
         49Ug==
X-Gm-Message-State: AOAM531BPA/HXQwkOvRtiWBhRYl48Bno9+kEOa/xAvAY+IbqRpIjZ21l
        lUAkmmjyLq5m28+8GVG92ew=
X-Google-Smtp-Source: ABdhPJwzJgrZaR9l6RsVt6RzyxAeWBz19eJSrtERes+fECVljV3r3+MfAubibY4yhHkHFRWP/3L+Xg==
X-Received: by 2002:a17:906:e82:: with SMTP id p2mr15351135ejf.50.1631927857497;
        Fri, 17 Sep 2021 18:17:37 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bw25sm2983803ejb.20.2021.09.17.18.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 18:17:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        peff@peff.net
Subject: Re: [PATCH 3/5] commit-graph: use parse_options_concat()
Date:   Sat, 18 Sep 2021 02:58:27 +0200
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <20210215184118.11306-4-avarab@gmail.com> <YCrCt8sEFJSPE+28@nand.local>
 <87czx1awwg.fsf@evledraar.gmail.com> <20210917211337.GC2118053@szeder.dev>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20210917211337.GC2118053@szeder.dev>
Message-ID: <87zgsad6mn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 17 2021, SZEDER G=C3=A1bor wrote:

> On Mon, Feb 15, 2021 at 09:39:11PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> On Mon, Feb 15 2021, Taylor Blau wrote:
>>=20
>> > On Mon, Feb 15, 2021 at 07:41:16PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >> Make use of the parse_options_concat() so we don't need to copy/paste
>> >> common options like --object-dir. This is inspired by a similar change
>> >> to "checkout" in 2087182272
>> >> (checkout: split options[] array in three pieces, 2019-03-29).
>> >>
>> >> A minor behavior change here is that now we're going to list both
>> >> --object-dir and --progress first, before we'd list --progress along
>> >> with other options.
>
> The final version of this patch that was picked up is at=20
>
>   https://public-inbox.org/git/patch-v4-3.7-32cc0d1c7bc-20210823T122854Z-=
avarab@gmail.com/
>
> I reply to this old version because of the following pieces of the
> discussion:
>
>> > "Behavior change" referring only to the output of `git commit-graph -h=
`,
>> > no?
>> >
>> > Looking at the code (and understanding this whole situation a little b=
it
>> > better), I'd think that this wouldn't cause us to parse anything
>> > differently before or after this change, right?
>>=20
>> Indeed, I just mean the "-h" or "--invalid-opt" output changed in the
>> order we show the options in.
>
> [...]
>
>> but I wanted to just focus on
>> refactoring existing behavior & get rid of the copy/pasted options
>
> No, there is more behavior change: since 84e4484f12 (commit-graph: use
> parse_options_concat(), 2021-08-23) the 'git commit-graph' command
> does accept the '--[no-]progress' options as well, but before that
> only its subcommands did, and 'git commit-graph --progress ...'
> errored out with "unknown option".
>
> Worse, sometimes 'git commit-graph --progress ...' doesn't work as
> it's supposed to.  The patch below descibes the problem and fixes it,
> but on second thought I don't think that it is the right approach.
>
> In general, even when all subcommands of a git command understand a
> particular --option, that does not mean that it's a good idea to teach
> that option to that git command.  E.g. what if we later add another
> subcommand for which that --option doesn't make any sense?  And from
> the quoted discussion above it seems that teaching 'git commit-graph'
> the '--progress' option was not intentional at all.
>
> I'm inclined to think that '--progress' should rather be removed from
> the common 'git commit-graph' options; luckily it's not too late,
> because it hasn't been released yet.
>
>
>   ---  >8  ---
>
> Subject: [PATCH] commit-graph: fix 'git commit-graph --[no-]progress ...'
>
> Until recenly 'git commit-graph' didn't have a '--progress' option,
> only its subcommands did, but this changed with 84e4484f12
> (commit-graph: use parse_options_concat(), 2021-08-23), and now the
> 'git commit-graph' command accepts the '--[no-]progress' options as
> well.  Alas, they don't always works as they are supposed to, because
> the isatty(2) check is only performed in the subcommands, i.e. after
> the "main" 'git commit-graph' command has parsed its options, and it
> unconditionally overwrites whatever '--[no-]progress' option might
> have been given:
>
>   $ GIT_PROGRESS_DELAY=3D0 git commit-graph --no-progress write --reachab=
le
>   Collecting referenced commits: 1617, done.
>   Loading known commits in commit graph: 100% (1617/1617), done.
>   [...]
>   $ GIT_PROGRESS_DELAY=3D0 git commit-graph --progress write 2>out
>   $ wc -c out
>   0 out
>
> Move the isatty(2) check to cmd_commit_graph(), before it calls
> parse_options(), so 'git commit-graph --[no-]progress' will be able to
> override it as well.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  builtin/commit-graph.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 21fc6e934b..3a873ceaf6 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -101,7 +101,6 @@ static int graph_verify(int argc, const char **argv)
>=20=20
>  	trace2_cmd_mode("verify");
>=20=20
> -	opts.progress =3D isatty(2);
>  	argc =3D parse_options(argc, argv, NULL,
>  			     options,
>  			     builtin_commit_graph_verify_usage, 0);
> @@ -250,7 +249,6 @@ static int graph_write(int argc, const char **argv)
>  	};
>  	struct option *options =3D add_common_options(builtin_commit_graph_writ=
e_options);
>=20=20
> -	opts.progress =3D isatty(2);
>  	opts.enable_changed_paths =3D -1;
>  	write_opts.size_multiple =3D 2;
>  	write_opts.max_commits =3D 0;
> @@ -331,6 +329,7 @@ int cmd_commit_graph(int argc, const char **argv, con=
st char *prefix)
>  	struct option *builtin_commit_graph_options =3D common_opts;
>=20=20
>  	git_config(git_default_config, NULL);
> +	opts.progress =3D isatty(2);
>  	argc =3D parse_options(argc, argv, prefix,
>  			     builtin_commit_graph_options,
>  			     builtin_commit_graph_usage,

Yes, this was unintentional on my part, sorry, and thanks for cleaning
up my mess.

However, I have wondered how we should be dealing with these
sub-commands in general.

In the case of commit-graph we've always documented it at the top-level
as OPTIONS, so even though the usage shows:

    git commit-graph write <options>

We've always accepted "--object-dir" after "git commit-graph", and all
the other options are documented in their per-subcommand sections.

So just from reading the documentation you might think that this (with
your fix here) is intentional behavior, and we should just fix the
synopsis.

Then we have the more recent multi-pack-index which *is* documented as:

    'git multi-pack-index' [--object-dir=3D<dir>] [--[no-]progress]
            [--preferred-pack=3D<pack>] <subcommand>

So actually, the reason this crept in is probably because I was copying
the pattern we've had there since 60ca94769ce
(builtin/multi-pack-index.c: split sub-commands, 2021-03-30), my commit
message says as much.

Given that and multi-pack-index's documented behavior I think that it
probably makes sense to keep and document this, and as a follow-up
(which I or Taylor could do) change the synopsis accordingly.

Aside from whatever bugs have crept or existing behavior, I think it
makes sense as UI to do things like:

    git commit-graph --object-dir=3D<dir> write --reachable
    git commit-graph --progress write
    git commit-graph --progress verify

etc., as --progress is a not-subcommand-specific option, not really. We
might have a subcommand that doesn't have progress output, but I still
think it makes sense to have it in that position, maybe we'll end up
adding it later.

Brian and I also had a discussion back in April[1] about
--object-format, i.e. should we be making every single command support:

    git hash-object --object-format=3Dsha256

Or (as I suggested) doesn't it make more sense to do:

    git --object-format=3Dsha256 hash-object

Like the --progress option it does mean that you'll end up with commands
for whom that'll just be ignored:

    git --object-format=3Dsha256 version

But that's conceptually similar to repo settings, and I don't think it's
confusing, the same can be said about e.g.:

    git -c this.doesNotUse=3DthisConfig version

Having said that for --progress it probably makes sense to eventually
have:

    git --progress commit-graph write

I.e. maybe we'd want a top-level option for it, given how many commands
have that option and us needing to pass a "do_progress" flag all over
the place.

Of course we'd need to (silently or not) support it also as:

    git commit-graph --progress write
    git commit-graph write --progress

Which is the case here.

1. https://lore.kernel.org/git/8735vq2l8a.fsf@evledraar.gmail.com/
