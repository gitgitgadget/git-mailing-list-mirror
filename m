Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B925C433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 23:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F17D520814
	for <git@archiver.kernel.org>; Thu, 21 May 2020 23:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3/HEmSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgEUXE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 19:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730626AbgEUXE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 19:04:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC75C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 16:04:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id z15so1619845pjb.0
        for <git@vger.kernel.org>; Thu, 21 May 2020 16:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lligo7vI0PcJuOsMovychw4/2LpFOJDtPp2uOcL9z5Q=;
        b=F3/HEmSY1VmSAN5JKlv5i5GDImayAYXyu0b4X8uowgNHHuO3NwgyvIgf8EKfGdvLcc
         oSE6RQd7nN9iNJ0QGKY4sYmDfJxt3RuMgt+zYK2FFyYI1j40VbMQMdB74WBH5ODIZwaT
         9wHLcGSscLzw3EUy0Fjvq6ibDKAECs/PnCyR79B6A5tx36lAjDxUsl3zBG12VFYceUBS
         aqMxhKLVevOiLa7lok7OAkaStKWEWdr8pSFfBSikqZxRL48vIO+qG3REykGcsBL/bOyc
         TpOve+E9YXEe+Xf3pI7sXNHPSkzPvyQ73EEqpfim7nU3o05nqPzvPM64R5ItaZAbnYSV
         p8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lligo7vI0PcJuOsMovychw4/2LpFOJDtPp2uOcL9z5Q=;
        b=G6bNbRU2jnUR/9jIO2OnqSuJHC6Du6J9jEPpYOIjfOuGfz1L8zPzcM5LQFZvipasU1
         IaTqB6lQ7w4+2Bru8DMa5Ku0RkasX5+dHj75eVK6goTkPQmgsk+EiLY5JsoQDliIEEMi
         CgQYz+z8inOXCmp173EfT3Vd0OcBteycJMVsKx1hxn1gVI9Orp8JzJxj189favWEoeGY
         C5U/r+q2eqo1aU2Zf3rGBWwLIo/RWmncRVBvDmJDjBGRdsXCv75RDZEiFXi27ZZgCL5L
         BAu9ykpfONhK64GIu2NoJUZBCHB8063cpIgnV2cITpCyr7j1SzyCV7bxnEslCk//NCVf
         EB1g==
X-Gm-Message-State: AOAM532rSFZ1v997HP4+zMNJIIVM/Slqbx865JO7eJKGbjGHwdM+zx75
        q+Zw3rNuG5uk65iytZU0bR8=
X-Google-Smtp-Source: ABdhPJxD99qOq4mu5roa+WUKqSfjsRwXlXSnB9WU09WC9QVFzBOEPQQU0DGZjd6TtULJ99vxFmRbCg==
X-Received: by 2002:a17:902:a713:: with SMTP id w19mr11021177plq.296.1590102295970;
        Thu, 21 May 2020 16:04:55 -0700 (PDT)
Received: from localhost ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id j7sm5206232pfh.154.2020.05.21.16.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 16:04:55 -0700 (PDT)
Date:   Fri, 22 May 2020 06:04:53 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com,
        gitster@pobox.com, sunshine@sunshineco.com,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3] submodule: port subcommand 'set-branch' from shell to
 C
Message-ID: <20200521230453.GB2042@danh.dev>
References: <20200521163819.12544-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521163819.12544-1-shouryashukla.oo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

On 2020-05-21 22:08:19+0530, Shourya Shukla <shouryashukla.oo@gmail.com> wrote:
> Thank you for the review Eric. I have changed the commit message,
> and the error prompts. Also, I have added a brief comment about
> the `quiet` option.
> 
> +	/*
> +	 * The `quiet` option is present for backward compatibility
> +	 * but is currently not used.
> +	 */
> +	int quiet = 0, opt_default = 0;
> +	const char *opt_branch = NULL;
> +	const char *path;
> +	char *config_name;
> +
> +	struct option options[] = {
> +		OPT__QUIET(&quiet,
> +			N_("suppress output for setting default tracking branch")),

IIUC, this option is provided to be backward compatible with old shell
version, and this option doesn't affect anything.

Would it make sense to hide quiet from default usage, via:

	OPT_NOOP_NOARG(0, "quiet")

I may missed some discussion related to the decision to keep it
OPT__QUIET.

> +		OPT_BOOL(0, "default", &opt_default,
> +			N_("set the default tracking branch to master")),
> +		OPT_STRING(0, "branch", &opt_branch, N_("branch"),
> +			N_("set the default tracking branch")),
> +		OPT_END()
> +	};
> +	const char *const usage[] = {
> +		N_("git submodule--helper set-branch [--quiet] (-d|--default) <path>"),
> +		N_("git submodule--helper set-branch [--quiet] (-b|--branch) <branch> <path>"),

And if above comment is applicable, remove `--quiet` from here.

> +	git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper set-branch ${GIT_QUIET:+--quiet} ${branch:+--branch $branch} ${default:+--default} -- "$@"

I think we need to quote `$branch`, no?

	${branch:+--branch "$branch"}

-- 
Danh
