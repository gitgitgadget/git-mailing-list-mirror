Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EE8C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 10:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiCaKdk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 06:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiCaKdj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 06:33:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D751788E0
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 03:31:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bg10so47140833ejb.4
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 03:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=eXvmLfOqwrkE5mcnLzZXZRbSMund38cCVWt1yi3StB0=;
        b=S836jl+2xAzWSrWHLkaB9rsUhclldnJBQUd3wGl+HK/mqo9cMguaC2aTisskvnBb/C
         zDXVPk69+DR95+rnX4JnhoHyD/oUMKfKQKIiAL9gfw8nNRKMuk2AGEEY/XqUo+sJMECC
         63ZgA6yu5ILNzchn/piTa1KZLDxBbrWfQ08V+kSFFcA1ukh0nABqN9dzzvXHRHZQsgDx
         YJGgjJOhBZcl5Qq3zuG0fyQq69Q2TJ8jchPa6h30sDp45IVO+9EJoS5d39NbORYoZjlv
         DBIWRPy+U+m/hCp6l/kl3Ic7qbHgzIw+S3In3BnvC1q9QAO3UghcR371K2O80kwJZCWB
         53Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=eXvmLfOqwrkE5mcnLzZXZRbSMund38cCVWt1yi3StB0=;
        b=TLh56QNex7QwuX3tzpVzHVTNQALT8WWsv+bC9+27RlU6WNOCl7eM3ytyBsjsEVJrVn
         LGIMT1wqkeZ23FwCq0EhsmrfmvQIYM2+AG+uKInvB5FUc259ElY8/fJURKjbV/GNTK2g
         o3hLEjnQijk/WB4d02R4au3MT/dMJgK6XWz1ho2RFUa7xow2aUIQ1zypfpZcXgttgtIA
         GuvoEsvGGxoqnuumJ0WLewIyQ2krOkSWbgtNpLqpegtUymHdOj891HU7Wq4Czu0oC3fJ
         tJAIZq7ivQsvXDT7fG36JOEj3TinFxjYQZrW6yaPqZEKONsmvRTQ9AjsJjl+lK5K5RWM
         JN0w==
X-Gm-Message-State: AOAM532FEGci8aCUrn1xfShH56aq2JB2Ra+eXD7VDFAS7GBZNwBGE5j5
        E3eMuSEBPrRPwD6KC/TZXyvUC5EUMZxpKw==
X-Google-Smtp-Source: ABdhPJyb+Cw7VcN3ZEItjCZ6bTRO8RRPLY06Z11J+h8ZCsHIdAxcSLRHeVQ1oVbw4n4TfY2zchxoiQ==
X-Received: by 2002:a17:907:3e12:b0:6da:f8d9:efeb with SMTP id hp18-20020a1709073e1200b006daf8d9efebmr4370780ejc.634.1648722710445;
        Thu, 31 Mar 2022 03:31:50 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k3-20020a05640212c300b0041605b2d9c1sm11097336edx.58.2022.03.31.03.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 03:31:50 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nZs5l-000MMo-Fm;
        Thu, 31 Mar 2022 12:31:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com,
        gitster@pobox.com, Tao Klerks <tao@klerks.biz>
Subject: Re: [WIP v1 3/4] mv: add advise_to_reapply hint for moving file
 into cone
Date:   Thu, 31 Mar 2022 12:30:25 +0200
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220331091755.385961-4-shaoxuan.yuan02@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220331091755.385961-4-shaoxuan.yuan02@gmail.com>
Message-ID: <220331.86ilruqup6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 31 2022, Shaoxuan Yuan wrote:

> Originally, the SKIP_WORKTREE bit is not removed when moving an out-of-cone
> file into sparse cone, thus the moved file does not show up in the working tree.
> Hint the user to use "git sparse-checkout reapply" to reapply the sparsity rules
> to the working tree, by which the SKIP_WORKTREE bit is removed.
>
> Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
> ---
> I offered this solution becasue I'm not sure how to turn a cache_entry's 
> ce_flags back to a non-sparse state. I tried directly set it to 0 like this:
>
> 	ce->ce_flags = 0;
>
> But the behavior after this seems undefined. The file still won't show up
> in the working tree.
>
> And I found that "git sparse-checkout reapply" seems to be a nice fit for the
> job. But I guess if there is a way (there must be but I don't know) to do it
> direcly in the code, that could also be nice.
>
>  builtin/mv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 9da9205e01..5f511fb8da 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -138,6 +138,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  {
>  	int i, flags, gitmodules_modified = 0;
>  	int verbose = 0, show_only = 0, force = 0, ignore_errors = 0, ignore_sparse = 0;
> +	int advise_to_reapply = 0;
>  	struct option builtin_mv_options[] = {
>  		OPT__VERBOSE(&verbose, N_("be verbose")),
>  		OPT__DRY_RUN(&show_only, N_("dry run")),
> @@ -383,6 +384,11 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  		pos = cache_name_pos(src, strlen(src));
>  		assert(pos >= 0);
>  		rename_cache_entry_at(pos, dst);
> +		if (!advise_to_reapply &&
> +			!path_in_sparse_checkout(src, &the_index) &&
> +			path_in_sparse_checkout(dst, &the_index)) {
> +				advise_to_reapply = 1;
> +			}

More odd indentation, and the braces aren't needed.

>  	}
>  
>  	if (gitmodules_modified)
> @@ -392,6 +398,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
>  		die(_("Unable to write new index file"));
>  
> +	if (advise_to_reapply)
> +		printf(_("Please use \"git sparse-checkout reapply\" to reapply the sparsity.\n"));
> +

Please see 93026558512 (tracking branches: add advice to ambiguous
refspec error, 2022-03-28) (the OID may change after I send this, as
it's in "seen") for how to add new advise, i.e. we use advise(), add an
enum field, config var etc.
