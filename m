Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9011EC6FD1D
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 16:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjDGQRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 12:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjDGQRA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 12:17:00 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3B311D
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 09:16:59 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-504718a2265so952626a12.2
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 09:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680884218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Likmu3q1mtebWeMPlDh80BjAZDCXfa4mGVqrQNAF3Ls=;
        b=JmxJrlDcafJIjQeQFD4hm4+USF1hrWVsKFZFQQFNttKjLk/U6CuoG30M3Qi1LZsnPQ
         +N0s1obPVCvXbRIBiWw0NtL7fIO7UwPN815LBqSxpEj8NisrqkezAChUZm/IvV5wIp7a
         Mxdp4xMRBSqqsfdHDFLwNz7HP7LtGYxqfo4QamkqQ27JC9CwYdvQ0uEAm0cqHJzkSn0N
         B/OB5elRXdxSoVxRVm1xAcsZ/HTef0QL2q8nOQ6J8emMECa0DYsR/9WbPYYNY8OdX2oZ
         u8Ol85nvtrOEx1uicwsEhlSJYP5rknDoWiPx7CIL90ZjiAeKBarWPuo7j4H2BrHrjvIA
         44LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680884218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Likmu3q1mtebWeMPlDh80BjAZDCXfa4mGVqrQNAF3Ls=;
        b=abGVaHD4hdtfjfWoE1AdeCRijbH8wU7jd0s1CIeHyiOKv5YlnjA0QfevYU+3BV55OB
         sCD9MDB8nNVW16r7+GsFru7BHHWuTwP9M9NtxWpddytloj1OrFxt3t5h5Ln+vM2fsUBE
         7oAJ2+0ZvNGdy6renUuJmh753p6wBi2AAo0yO9PncuXF5w2QAfahDg1ugLNJGSsnnQN0
         MhJzJRZ+wDPbCnjjgl+xxlsJvh2GT4eDcgqdlAV76a0Y2bSMlf3HT1hWTg5bE0GOAWZ6
         i1TsoEBh3gLgGjQf9klsENMm44y8xrncmOQpUGVWgUCZ1VsXk5gwDGBVBuUfYrN7wjEs
         D4hw==
X-Gm-Message-State: AAQBX9c+pnPpjY2reco7hM2279Q7ijNPx4UUe1fkIa2QPExLWceW9z68
        /rOh2B7pripsvc3VjzeYstkchnLdOag=
X-Google-Smtp-Source: AKy350YVj9oaAjO7WNkv3gcQ2TrPmUs4s0f1Iu210JIBRJicJoDwmI0B56Jw+f7HPLPWnZvzzFmbzw==
X-Received: by 2002:a50:ee99:0:b0:4fa:ba31:6c66 with SMTP id f25-20020a50ee99000000b004faba316c66mr3282972edr.42.1680884218035;
        Fri, 07 Apr 2023 09:16:58 -0700 (PDT)
Received: from localhost (78-131-17-112.pool.digikabel.hu. [78.131.17.112])
        by smtp.gmail.com with ESMTPSA id j18-20020a50d012000000b004c4eed3fe20sm2045602edf.5.2023.04.07.09.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 09:16:57 -0700 (PDT)
Date:   Fri, 7 Apr 2023 18:16:55 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>,
        William Sprent <williams@unity3d.com>
Subject: Re: [PATCH v2 1/2] builtin/sparse-checkout: remove NEED_WORK_TREE
 flag
Message-ID: <20230407161655.GB3117@szeder.dev>
References: <pull.1488.git.1678283349.gitgitgadget@gmail.com>
 <pull.1488.v2.git.1679903703.gitgitgadget@gmail.com>
 <4b231e9beb43e4fac6457b9bf86e4c1db39c4238.1679903703.git.gitgitgadget@gmail.com>
 <xmqqr0taaxrr.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0taaxrr.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 27, 2023 at 10:51:04AM -0700, Junio C Hamano wrote:
> "William Sprent via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> > index c3738154918..5fdc3d9aab5 100644
> > --- a/builtin/sparse-checkout.c
> > +++ b/builtin/sparse-checkout.c
> > @@ -57,6 +57,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix)
> >  	char *sparse_filename;
> >  	int res;
> >  
> > +	setup_work_tree();
> >  	if (!core_apply_sparse_checkout)
> >  		die(_("this worktree is not sparse"));
> > ...
> > @@ -898,6 +903,7 @@ static int sparse_checkout_disable(int argc, const char **argv,
> >  	 * forcibly return to a dense checkout regardless of initial state.
> >  	 */
> >  
> > +	setup_work_tree();
> >  	argc = parse_options(argc, argv, prefix,
> >  			     builtin_sparse_checkout_disable_options,
> >  			     builtin_sparse_checkout_disable_usage, 0);
> 
> I am throwing this out not as "we must tackle this ugliness before
> this patch can proceed" but as "this is ugly, I wish somebody can
> figure it out in a cleaner way", so do not take this as a blocking
> comment or objection, but more as something to think about improving
> if possible as a bonus point.
> 
> It really is a shame that we have a nice "dispatch" table at the
> beginning of the single caller:
> 
>         int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>         {
>                 parse_opt_subcommand_fn *fn = NULL;
>                 struct option builtin_sparse_checkout_options[] = {
>                         OPT_SUBCOMMAND("list", &fn, sparse_checkout_list),
>                         OPT_SUBCOMMAND("init", &fn, sparse_checkout_init),
>                         OPT_SUBCOMMAND("set", &fn, sparse_checkout_set),
>                         OPT_SUBCOMMAND("add", &fn, sparse_checkout_add),
>                         OPT_SUBCOMMAND("reapply", &fn, sparse_checkout_reapply),
>                         OPT_SUBCOMMAND("disable", &fn, sparse_checkout_disable),
>                         OPT_END(),
>                 };
> 
> yet we have to sprinkle setup_work_tree() to all of these functions'
> implementation.  If we were able to describe which selected ones do
> not need the setup call, we could let the parse-options API to look
> up the function and then before calling "fn" we could make the setup
> call.  That would allow us to maintain the subcommands much nicely.

It's easy enough to do in this particular case: there is an
OPT_SUBCOMMAND_F() variant which takes an additional flags parameter,
so we could add a PARSE_OPT_SETUP_WORK_TREE flag, check it in e.g.
parse_subcommand(), and act accordingly if it's set.

However, this wouldn't work when the command has a default operation
mode and is invoked without any subcommands.  And I'm not sure about
doing this in parse-options, because it's about, well, parsing
options, not about doing fancy setup stuff.


