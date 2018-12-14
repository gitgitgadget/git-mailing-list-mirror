Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6222720A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 02:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbeLNCyD (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 21:54:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43918 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeLNCyD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 21:54:03 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so3967636wrs.10
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 18:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GL6h9p3/mcbs6kCYwRrEHL3Dt8s8r8U0RCSWTNrPs+U=;
        b=I1/zdvByB+M1bEyhigXVGab1JjiDpcvcEw/nAbYbFrwE6aNavkX8aH0YDHRNgm0Lnk
         BJ2Rc1ROa+8Hi434c16TZi7uup0o0dV/fg3PkAjhqlqkbF98JOv4Ow3y2RdcLV6BI/cR
         I8DI3VNVYr2j5vC7Dl0a6/UjdxDMrFxOoSdKhMdOdgBbhICc/bQBCBcouIRbNZiZqgHJ
         nwKTtsW//c4LCu92wbZNqR4iaawIJEOdrlQWlz3xKxWqP3KMv3whm8FI8YhtxxWa3iVm
         ktFxCK0J3UEjiIiFgBQdwpz0cA8WXVeTyiAqPDLr0hHBtgxG50Brr6U1RvKqKwt43X3s
         68YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GL6h9p3/mcbs6kCYwRrEHL3Dt8s8r8U0RCSWTNrPs+U=;
        b=O/JjTsXGR0z03xmoo6S7moltuEzwQKFGZ3whj06ZjtjnABhCI7YXNJN4G32susDZee
         xl94nZrJu6H80p6mH+g2B5GlBNrrDzvWkZkrOyqrTCwkHLK3J/D72CI9PmItJJBPoT6v
         zJr9Pmn57wSAOM8P/TRAsETDxq2/UnAeoaoFkm1F8H6EZDyejuD6g8Kw0ok16fKfbzDz
         r8Vdjpb9KUAKevaANNNCG4bfOUN2yP+ClLKHCH9rNjWDwFYGtLye+9AAvSPYZM0Gj1Hj
         0Ev+mNuDJbAf17IjK+C4q6+9qk9VsZcd8bX+GzVro7E+JuHTP3wbA0cKtAvtxOb6qHHG
         jzsw==
X-Gm-Message-State: AA+aEWb0OX1ZpRJ71Ac6L3UylxuG64hp7KntIgD6ZItmQ04vuxpgWFlb
        lnbz3xwsXtZReaSmQ7mr6vc=
X-Google-Smtp-Source: AFSGD/WKOVHljQzlbzulfh+q3yj9hKNzu+suIDN0WTd3qMzDB9skuss7wX/iiqsVQNUsm+04IFLJGQ==
X-Received: by 2002:adf:e9d1:: with SMTP id l17mr939803wrn.73.1544756040668;
        Thu, 13 Dec 2018 18:54:00 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e16sm4208640wrn.72.2018.12.13.18.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 18:53:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sjon@parse.nl
Subject: Re: [PATCH] submodule update: run at most one fetch job unless otherwise set
References: <CAGZ79kYsk8YEUUhMVF9fBC++fop3CPyobXTgHTuF2Lgikf9CJA@mail.gmail.com>
        <20181213190248.247083-1-sbeller@google.com>
Date:   Fri, 14 Dec 2018 11:53:59 +0900
In-Reply-To: <20181213190248.247083-1-sbeller@google.com> (Stefan Beller's
        message of "Thu, 13 Dec 2018 11:02:48 -0800")
Message-ID: <xmqqwoocddiw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> In a028a1930c (fetching submodules: respect `submodule.fetchJobs`
> config option, 2016-02-29), we made sure to keep the default behavior
> of a fetching at most one submodule at once when not setting the
> newly introduced `submodule.fetchJobs` config.
>
> This regressed in 90efe595c5 (builtin/submodule--helper: factor
> out submodule updating, 2018-08-03). Fix it.
>
> Reported-by: Sjon Hortensius <sjon@parse.nl>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Thanks for tying the loose ends.

We may want to convert the _INIT macro to use the designated
initializers; I had to count the fields twice to make sure I was
tweaking the right one.  

It did not help that I saw, before looking at the current code, that
90efe595c5 added one field at the end to the struct but did not
touch _INIT macro at all.  That made me guess that max_jobs=0 was
due to _missing_ initialization value, leading me to an incorrect
fix to append an extra 1 at the end, but that was bogus.  The
missing initialization left by 90efe595 ("builtin/submodule--helper:
factor out submodule updating", 2018-08-03) was silently fixed by
f1d15713 ("builtin/submodule--helper: store update_clone information
in a struct", 2018-08-03), I think, so replacing the 0 at the end is
1 happens to be the right fix, but with designated initializers, all
these confusions are more easily avoided.


>  builtin/submodule--helper.c | 2 +-
>  t/t5526-fetch-submodules.sh | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index d38113a31a..1f8a4a9d52 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1551,7 +1551,7 @@ struct submodule_update_clone {
>  #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
>  	SUBMODULE_UPDATE_STRATEGY_INIT, 0, 0, -1, STRING_LIST_INIT_DUP, 0, \
>  	NULL, NULL, NULL, \
> -	NULL, 0, 0, 0, NULL, 0, 0, 0}
> +	NULL, 0, 0, 0, NULL, 0, 0, 1}
>  
>  
>  static void next_submodule_warn_missing(struct submodule_update_clone *suc,
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 6c2f9b2ba2..a0317556c6 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -524,6 +524,8 @@ test_expect_success 'fetching submodules respects parallel settings' '
>  	git config fetch.recurseSubmodules true &&
>  	(
>  		cd downstream &&
> +		GIT_TRACE=$(pwd)/trace.out git fetch &&
> +		grep "1 tasks" trace.out &&
>  		GIT_TRACE=$(pwd)/trace.out git fetch --jobs 7 &&
>  		grep "7 tasks" trace.out &&
>  		git config submodule.fetchJobs 8 &&
