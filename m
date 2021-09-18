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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DD3C433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 07:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 305F461039
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 07:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237570AbhIRH2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 03:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhIRH2l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 03:28:41 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A00C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 00:27:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g8so38706545edt.7
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Q9I1I75xWbCyy2B65/uk1V1IbjNJ4SPZhOLDIv0dSq0=;
        b=fwgGhOkapxDAzc8j+g3ZIx+Mu54ZLoqo4nBi4sP6LcN9YJzvM67QernQd3IHZ9Zl7G
         gp2HQVbQXp5y8/Im/L/M1xof45y3Qw7M/13bwSUTbmLvzVmORcqB+izc9b4nj/k8W1o4
         ll6rLr6qvR8jODfFP9PtpYbjQOkDD3DIILytvl8tSe9KOZB6VSnHzffbbtDu0eTzjndL
         bn9VwfGa8jH2tA39rwXp0viBr/V1LiSc1RVVugwlA0K2VD9P0wA1KIHg1+BuwCXRefzt
         cIBnAzLlXxS3uFapdrPxeQRJ4wUzYOvIj7qI6kIZfEMfrADH9Drsm+agIApiSUEM6vDA
         hPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Q9I1I75xWbCyy2B65/uk1V1IbjNJ4SPZhOLDIv0dSq0=;
        b=jtgNaQBG4CvcZAW+T6O24sMEBVI5v+xObJWdOuifSdIufDSn9r1pRZYK2KBdA3+Ymd
         z3bimRH8cxzT3zkK2NkLyCnKWihPyPw+sL2jJzUNh2rGmxtd0DdhM+dWy0Nvd+yxcO/v
         HsGnJNCz2Q8hja636KULTWcfEdJax3jwyf4wS/n7SR8KbJJkF7xKoC8W5nJC2+g5DoZt
         61hJXshz5Y6OtvNYnuZgXyNjQI+bqK8uVPy2Gd6XHCAR0k9Vi/j1emOvRAWxbxp0EMTE
         5DyyuhkoEyFHbd9wEMSG98BusrpkdLW2aCcIq370AQMk9b1bgai956UwAhhl5ikCw2aw
         Ogjg==
X-Gm-Message-State: AOAM530DIK5MLbkkFc9pwl+VxHKQtzC1xaxZpVf5TkALpZ/SHQMAQNhk
        fnk+7th5Dp8olyVfJXFg5fY=
X-Google-Smtp-Source: ABdhPJwc5ukURxEq2u0a4dn/x8Cvfd6WT6ajPs0FlPzfwYJnJX3Xet2FSrcpoMC9LfpTa21rM4RLew==
X-Received: by 2002:a17:906:640f:: with SMTP id d15mr17414180ejm.419.1631950035910;
        Sat, 18 Sep 2021 00:27:15 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o15sm3260469ejj.10.2021.09.18.00.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 00:27:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        dstolee@microsoft.com
Subject: Re: [PATCH 3/5] commit-graph: use parse_options_concat()
Date:   Sat, 18 Sep 2021 09:20:38 +0200
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <20210215184118.11306-4-avarab@gmail.com> <YCrCt8sEFJSPE+28@nand.local>
 <87czx1awwg.fsf@evledraar.gmail.com> <20210917211337.GC2118053@szeder.dev>
 <YUUQzswYL5x74Tps@coredump.intra.peff.net> <YUVreesWdRmBYl1C@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUVreesWdRmBYl1C@nand.local>
Message-ID: <87v92ycpil.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 18 2021, Taylor Blau wrote:

> On Fri, Sep 17, 2021 at 06:03:58PM -0400, Jeff King wrote:
>> > I'm inclined to think that '--progress' should rather be removed from
>> > the common 'git commit-graph' options; luckily it's not too late,
>> > because it hasn't been released yet.
>>
>> I wasn't following this series closely, but having seen your fix below,
>> I'm inclined to agree with you. Just because we _can_ allow options
>> before or after sub-commands does not necessarily make it a good idea.
>>
> I agree. Suppose we had a "git commit-graph remove" sub-command that
> removed the commit-graph file (ignoring that there are probably better
> hypothetical examples than this ;)). It's not obvious what --progress
> means in the context of that mode.

Well, you might have as many as tens of commit-graph files, and could be
running this on AIX where I/O is apparently implemented in terms of
carrier pigeon messaging judging by how slow it is :)

But as argued in
https://lore.kernel.org/git/87zgsad6mn.fsf@evledraar.gmail.com/ I don't
see how it's going to be any more confusing to user than "git -c foo=3Dbar
version" (the -c does nothing there)>

> Here's a patch that does what you and G=C3=A1bor are suggesting as an
> alternative. Unfortunately, we can't do the same for the
> multi-pack-index command, since the analogous change there is 60ca94769c
> (builtin/multi-pack-index.c: split sub-commands, 2021-03-30), which was
> released in 2.32.

If we came up with some call about what we want subcommands in general
to look like I'd think it would be fine to convert multi-pack-index to
it, perhaps with some deprecation period where it would issue a
warning() while it understood both forms.

> Anyway, as promised:
>
> --- 8< ---
>
> Subject: [PATCH] builtin/commit-graph.c: don't accept common --[no-]progr=
ess
>
> In 84e4484f12 (commit-graph: use parse_options_concat(), 2021-08-23) we
> unified common options of commit-graph's subcommands into a single
> "common_opts" array.
>
> But 84e4484f12 introduced a behavior change which is to accept the
> "--[no-]progress" option before any sub-commands, e.g.,
>
>     git commit-graph --progress write ...
>
> Prior to that commit, the above would error out with "unknown option".
>
> There are two issues with this behavior change. First is that the
> top-level --[no-]progress is not always respected. This is because
> isatty(2) is performed in the sub-commands, which unconditionally
> overwrites any --[no-]progress that was given at the top-level.
>
> But the second issue is that the existing sub-commands of commit-graph
> only happen to both have a sensible interpretation of what `--progress`
> or `--no-progress` means. If we ever added a sub-command which didn't
> have a notion of progress, we would be forced to ignore the top-level
> `--[no-]progress` altogether.
>
> Since we haven't released a version of Git that supports --[no-]progress
> as a top-level option for `git commit-graph`, let's remove it.
>
> Suggested-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/commit-graph.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 21fc6e934b..067587a0fd 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -50,8 +50,6 @@ static struct option common_opts[] =3D {
>  	OPT_STRING(0, "object-dir", &opts.obj_dir,
>  		   N_("dir"),
>  		   N_("the object directory to store the graph")),
> -	OPT_BOOL(0, "progress", &opts.progress,
> -		 N_("force progress reporting")),
>  	OPT_END()
>  };
>
> @@ -95,6 +93,8 @@ static int graph_verify(int argc, const char **argv)
>  	static struct option builtin_commit_graph_verify_options[] =3D {
>  		OPT_BOOL(0, "shallow", &opts.shallow,
>  			 N_("if the commit-graph is split, only verify the tip file")),
> +		OPT_BOOL(0, "progress", &opts.progress,
> +			 N_("force progress reporting")),
>  		OPT_END(),
>  	};
>  	struct option *options =3D add_common_options(builtin_commit_graph_veri=
fy_options);
> @@ -246,6 +246,8 @@ static int graph_write(int argc, const char **argv)
>  		OPT_CALLBACK_F(0, "max-new-filters", &write_opts.max_new_filters,
>  			NULL, N_("maximum number of changed-path Bloom filters to compute"),
>  			0, write_option_max_new_filters),
> +		OPT_BOOL(0, "progress", &opts.progress,
> +			 N_("force progress reporting")),
>  		OPT_END(),
>  	};
>  	struct option *options =3D add_common_options(builtin_commit_graph_writ=
e_options);

This is a good change, but if you're up for bonus points leaves the docs
in an odd where we (as noted in [1]) document the --object-dir and
--progress options under OPTIONS, but now only take the former before
the sub-command.

1. https://lore.kernel.org/git/87zgsad6mn.fsf@evledraar.gmail.com/
