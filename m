Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB81C433F5
	for <git@archiver.kernel.org>; Sat, 18 Dec 2021 09:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhLRJ5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Dec 2021 04:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhLRJ5g (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Dec 2021 04:57:36 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7F3C061574
        for <git@vger.kernel.org>; Sat, 18 Dec 2021 01:57:35 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y22so17311445edq.2
        for <git@vger.kernel.org>; Sat, 18 Dec 2021 01:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=NDT8E/jD8KHtne4fzS0JeBHxS1Bjs99fRJKP4ia1doE=;
        b=iwZggAlC5iLIBE6M+wa0A/fHGr9QgwXPDd/CPVslQwqDjDf1Hh3LLqD1PSQrGqO5nf
         wksqtd+HlpKiQk8clbAVFeHSwXeosKWJcHjf/cc1qEAvfmaeqzVUOebWnwFiI138Td/S
         LdI+IBLi2iQiBDR7DpJQ9lpGDS1/mm/JiggCoTbb+lXaSbbLwED3LQx4qWG5EspsbeK1
         1od4RDt34eufyFSFL2s0iVd6bM3scUa10gFYtOpTo9QSeHx3KnevVLlnRDKeiLld50XN
         779Nhr8bI/zB0Nyf83lBRj90iXVomWTLAPgcW9ZRPPQAqAtg6fTDeSDWSljzAWzWKgOy
         s+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=NDT8E/jD8KHtne4fzS0JeBHxS1Bjs99fRJKP4ia1doE=;
        b=reguffhuKnphn15PyRkO/mKLDSnr8B/WIK89yNVbXHzEXbLfV6FSAFcoi9TTI56+aK
         YfiuZnwZ032lc21jwoEQmHdfCTa4zfh6UPpeJ9OBmKcwkB5Z7/YYZ6WjNXaYZOHXM7LP
         cV74ZJkXhoVpo87mgu3OoObbyr5hUFZUkW6sXs4Lt5N4TisTYl4v/hHj0wyQKew58rSM
         5clgAUHHwn+5XJx6BjfHwvBmWs6gfJmWJXmtimGnqUadZrRVRYZaExi+PnuJeaKajgs6
         f6mDE8kMv0yXGoWQh6d8Mq4P6wzIQvObpU7IaVyoBKxiWI0pMAbq2K6n3MDNqNaFZenE
         v0Yw==
X-Gm-Message-State: AOAM530m37HtEu8io00jGNI4rDtDd4uefh5cc2RLb3usA0iQcKBOdJpF
        eAnifewnd6KOAPN99v2WYjg=
X-Google-Smtp-Source: ABdhPJxh/1E8tsl51LxZO9sUEBVWkOQ5/khBOAm1Tr6A6DClSpF2Oi4vW0h/bgtVQgNlX6oVW+Eckg==
X-Received: by 2002:aa7:da8a:: with SMTP id q10mr3007173eds.302.1639821454002;
        Sat, 18 Dec 2021 01:57:34 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a3sm3611725ejd.16.2021.12.18.01.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 01:57:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1myWT7-000GpU-1Z;
        Sat, 18 Dec 2021 10:57:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/2] repack: make '--quiet' disable progress
Date:   Sat, 18 Dec 2021 10:55:33 +0100
References: <pull.1098.git.1639758526.gitgitgadget@gmail.com>
 <3eff83d9ae14023f3527dfeb419cf8259f6d053d.1639758526.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <3eff83d9ae14023f3527dfeb419cf8259f6d053d.1639758526.git.gitgitgadget@gmail.com>
Message-ID: <211218.861r2axmk3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 17 2021, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> While testing some ideas in 'git repack', I ran it with '--quiet' and
> discovered that some progress output was still shown. Specifically, the
> output for writing the multi-pack-index showed the progress.
>
> The 'show_progress' variable in cmd_repack() is initialized with
> isatty(2) and is not modified at all by the '--quiet' flag. The
> '--quiet' flag modifies the po_args.quiet option which is translated
> into a '--quiet' flag for the 'git pack-objects' child process. However,
> 'show_progress' is used to directly send progress information to the
> multi-pack-index writing logic which does not use a child process.
>
> The fix here is to modify 'show_progress' to be false if po_opts.quiet
> is true, and isatty(2) otherwise. This new expectation simplifies a
> later condition that checks both.
>
> This is difficult to test because the isatty(2) already prevents the
> progess indicators from appearing when we redirect stderr to a file.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/repack.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 1f128b7c90b..c393a5db774 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -612,7 +612,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	struct tempfile *refs_snapshot = NULL;
>  	int i, ext, ret;
>  	FILE *out;
> -	int show_progress = isatty(2);
> +	int show_progress;
>  
>  	/* variables to be filled by option parsing */
>  	int pack_everything = 0;
> @@ -725,6 +725,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  
>  	prepare_pack_objects(&cmd, &po_args);
>  
> +	show_progress = !po_args.quiet && isatty(2);
> +
>  	strvec_push(&cmd.args, "--keep-true-parents");
>  	if (!pack_kept_objects)
>  		strvec_push(&cmd.args, "--honor-pack-keep");
> @@ -926,7 +928,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  			}
>  			strbuf_release(&buf);
>  		}
> -		if (!po_args.quiet && show_progress)
> +		if (show_progress)
>  			opts |= PRUNE_PACKED_VERBOSE;
>  		prune_packed_objects(opts);

This seems like a good change, but the documentation could really use an
update (also before this change). It just says about -q:

    Pass the -q option to git pack-objects. See git-pack-objects(1).

But do various things in "git-repack" itself differently if it's
supplied.
