Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E47C433E0
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 20:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3EFB64E07
	for <git@archiver.kernel.org>; Mon, 15 Feb 2021 20:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhBOUj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 15:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhBOUjz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 15:39:55 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE729C061574
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 12:39:14 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id f14so13324216ejc.8
        for <git@vger.kernel.org>; Mon, 15 Feb 2021 12:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=B5kpOPKG+SnMCExew6VZdkrL/212zsk8AVI2x12W6OM=;
        b=fhMkpnAThZZ7KS5AtlYJOwbXUheuVZedie42E497n/hfnztKraNjHrt3m5Z9my2lBc
         SdSl2NSjP12y1kqRIAddmbisouli5r7hyEWrqGE4ydutLmBSRUyBkdyynY6UuIVkj9xC
         dwzGZVWK2PfGjNQzCsc5N0Kd00ZOmEDmjTE5I1VmjJze1xicxEQmQLqht5VMRplzS8vv
         /+dUb36z6n6zv5BthR6mpelbwQZpUpCcDTgRybN9zZnDhk06HS0qi1edraqEr2ssq89P
         qtFvri2ZZWsKTmIp3WsnXs0xC/L0GdzoQkxrDexaNsxIGNg8aaqalGkJmXv4O1Cd3DrB
         Yojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=B5kpOPKG+SnMCExew6VZdkrL/212zsk8AVI2x12W6OM=;
        b=EemG15Q6SUu0NjlmeC3/H0SGmKTMbBxa1wHGscxSjf7iThPr42gM2woCCMAdKSJy8F
         mUQB5G9taJ61MIPIQuHHHjwo/g78f9cL3YYWTxoV/t/zoD8ASYc5WNwjoUZFMN1GcR5R
         y0nQVe93DoxKQ0geYBtTWJzlUUY8sCVLemqinqEpSqGOYb0dl+x9/iiB5GUgaGRJekQ9
         OjY5Zh4+VsF9TIKe5cL4YMhqGi4P9DxwUb2o2FS0mN04YjBrCREL4xp/BmRwiY0m1FLe
         U0IS5hnIIwxUZ0VCk5MclyGl4dpBi6XwBaCUaH9wxeRWzkGNHFlOw6cstTBXIJTJnvga
         v+8g==
X-Gm-Message-State: AOAM532nEXHFvCE9cK8gCy2dvjoURRP17dCplanV8acO69Ev4JkDvcgV
        Z6BcbVF5yDrf94VgRCq9AZ0=
X-Google-Smtp-Source: ABdhPJyawDlBay4oBfVYvBo8/iPWPWwVGnR4dWRmDcmttYhkXKH2EEdMeObwCvZVIsF+0ESIxhIrrg==
X-Received: by 2002:a17:906:ad9:: with SMTP id z25mr17611113ejf.513.1613421553241;
        Mon, 15 Feb 2021 12:39:13 -0800 (PST)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id v13sm3280685eds.43.2021.02.15.12.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 12:39:12 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        dstolee@microsoft.com,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        peff@peff.net
Subject: Re: [PATCH 3/5] commit-graph: use parse_options_concat()
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <20210215184118.11306-4-avarab@gmail.com> <YCrCt8sEFJSPE+28@nand.local>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YCrCt8sEFJSPE+28@nand.local>
Date:   Mon, 15 Feb 2021 21:39:11 +0100
Message-ID: <87czx1awwg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 15 2021, Taylor Blau wrote:

> On Mon, Feb 15, 2021 at 07:41:16PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Make use of the parse_options_concat() so we don't need to copy/paste
>> common options like --object-dir. This is inspired by a similar change
>> to "checkout" in 2087182272
>> (checkout: split options[] array in three pieces, 2019-03-29).
>>
>> A minor behavior change here is that now we're going to list both
>> --object-dir and --progress first, before we'd list --progress along
>> with other options.
>
> "Behavior change" referring only to the output of `git commit-graph -h`,
> no?
>
> Looking at the code (and understanding this whole situation a little bit
> better), I'd think that this wouldn't cause us to parse anything
> differently before or after this change, right?

Indeed, I just mean the "-h" or "--invalid-opt" output changed in the
order we show the options in.

>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  builtin/commit-graph.c | 43 ++++++++++++++++++++++++------------------
>>  1 file changed, 25 insertions(+), 18 deletions(-)
>>
>> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
>> index baead04a03..a7718b2025 100644
>> --- a/builtin/commit-graph.c
>> +++ b/builtin/commit-graph.c
>> @@ -44,6 +44,21 @@ static struct opts_commit_graph {
>>  	int enable_changed_paths;
>>  } opts;
>>
>> +static struct option *add_common_options(struct option *prevopts)
>> +{
>> +	struct option options[] =3D {
>> +		OPT_STRING(0, "object-dir", &opts.obj_dir,
>> +			   N_("dir"),
>> +			   N_("the object directory to store the graph")),
>> +		OPT_BOOL(0, "progress", &opts.progress,
>> +			 N_("force progress reporting")),
>> +		OPT_END()
>> +	};
>
> I'm nitpicking, but I wouldn't be sad to see this called "common"
> instead".
>
> Can't this also be declared statically?

It happens to work now to do that, but try it in builtin/checkout.c and
you'll see it blows up with a wall of "initializer element is not
constant".

Probably better to be consistent in parse_options() usage than make it
safe for that sort of use...

>> +	struct option *newopts =3D parse_options_concat(options, prevopts);
>> +	free(prevopts);
>> +	return newopts;
>> +}
>> +
>>  static struct object_directory *find_odb(struct repository *r,
>>  					 const char *obj_dir)
>>  {
>> @@ -75,22 +90,20 @@ static int graph_verify(int argc, const char **argv)
>>  	int fd;
>>  	struct stat st;
>>  	int flags =3D 0;
>> -
>> +	struct option *options =3D NULL;
>>  	static struct option builtin_commit_graph_verify_options[] =3D {
>> -		OPT_STRING(0, "object-dir", &opts.obj_dir,
>> -			   N_("dir"),
>> -			   N_("the object directory to store the graph")),
>>  		OPT_BOOL(0, "shallow", &opts.shallow,
>>  			 N_("if the commit-graph is split, only verify the tip file")),
>> -		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting"=
)),
>>  		OPT_END(),
>>  	};
>> +	options =3D parse_options_dup(builtin_commit_graph_verify_options);
>
> Another nitpick, but I'd rather see the initialization of "options" and
> its declaration be on the same line, after declaring
> builtin_commit_graph_verify_options.

As you noted in your own reply "the NULL initialization is important",
or more specifically: We're doing this dance here (and in other existing
code, e.g. checkout.c) to trampoline from the stack ot the heap.

>> +	options =3D add_common_options(options);
>>
>>  	trace2_cmd_mode("verify");
>>
>>  	opts.progress =3D isatty(2);
>>  	argc =3D parse_options(argc, argv, NULL,
>> -			     builtin_commit_graph_verify_options,
>> +			     options,
>>  			     builtin_commit_graph_verify_usage, 0);
>>
>>  	if (!opts.obj_dir)
>> @@ -205,11 +218,8 @@ static int graph_write(int argc, const char **argv)
>>  	int result =3D 0;
>>  	enum commit_graph_write_flags flags =3D 0;
>>  	struct progress *progress =3D NULL;
>> -
>> +	struct option *options =3D NULL;
>>  	static struct option builtin_commit_graph_write_options[] =3D {
>> -		OPT_STRING(0, "object-dir", &opts.obj_dir,
>> -			N_("dir"),
>> -			N_("the object directory to store the graph")),
>>  		OPT_BOOL(0, "reachable", &opts.reachable,
>>  			N_("start walk at all refs")),
>>  		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
>> @@ -220,7 +230,6 @@ static int graph_write(int argc, const char **argv)
>>  			N_("include all commits already in the commit-graph file")),
>>  		OPT_BOOL(0, "changed-paths", &opts.enable_changed_paths,
>>  			N_("enable computation for changed paths")),
>> -		OPT_BOOL(0, "progress", &opts.progress, N_("force progress reporting"=
)),
>>  		OPT_CALLBACK_F(0, "split", &write_opts.split_flags, NULL,
>>  			N_("allow writing an incremental commit-graph file"),
>>  			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
>> @@ -236,6 +245,8 @@ static int graph_write(int argc, const char **argv)
>>  			0, write_option_max_new_filters),
>>  		OPT_END(),
>>  	};
>> +	options =3D parse_options_dup(builtin_commit_graph_write_options);
>> +	options =3D add_common_options(options);
>>
>>  	opts.progress =3D isatty(2);
>>  	opts.enable_changed_paths =3D -1;
>> @@ -249,7 +260,7 @@ static int graph_write(int argc, const char **argv)
>>  	git_config(git_commit_graph_write_config, &opts);
>>
>>  	argc =3D parse_options(argc, argv, NULL,
>> -			     builtin_commit_graph_write_options,
>> +			     options,
>>  			     builtin_commit_graph_write_usage, 0);
>>
>>  	if (opts.reachable + opts.stdin_packs + opts.stdin_commits > 1)
>> @@ -312,12 +323,8 @@ static int graph_write(int argc, const char **argv)
>>
>>  int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>>  {
>> -	static struct option builtin_commit_graph_options[] =3D {
>> -		OPT_STRING(0, "object-dir", &opts.obj_dir,
>> -			N_("dir"),
>> -			N_("the object directory to store the graph")),
>> -		OPT_END(),
>> -	};
>> +	struct option *no_options =3D parse_options_dup(NULL);
>
> Hmm. Why bother calling add_common_options at all here?

I assume you mean in this line just below what you quoted:

    struct option *builtin_commit_graph_options =3D add_common_options(no_o=
ptions);

Do you mean why not do the whole thing in graph_{verify,write}() and
only show the usage if we fail here?

Yeah arguably that makes more sense, but I wanted to just focus on
refactoring existing behavior & get rid of the copy/pasted options
rather than start a bigger rewrite of "maybe we shouldn't show this
rather useless help info if we die here....".
