Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36918207D2
	for <e@80x24.org>; Fri, 23 Jun 2017 22:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754118AbdFWW0l (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 18:26:41 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36123 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbdFWW0k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 18:26:40 -0400
Received: by mail-pf0-f196.google.com with SMTP id z6so468637pfk.3
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0gKcz26H9kPebk9GSMPsBTxqAs3XYXfpFmHGeOdWuZI=;
        b=Cm4qKkbLyaJ5y73b/yDsG9o0iLiDlAOk2jatPYlFh+gP3Z4qwfVAMUhvCdUzrlAgmB
         abczA/m9OuNJ+5QZOJdpjzyhR+PRXDTcS+PlKvUwGp+HJBkZ2tZd9C4a84tU15B8CO64
         478ciX0pHkdJ5gsS8HhMzbECwPOI/DhtnFK+PHGyHEOAcNiWA7fSSipTHfj/kPXjJbwh
         Mlx+od0al7t+Ta+WSLnCU3bJISJGSOKkY0OJOyHUuw9eakEgMjcjyhwSe1Unor4hpanT
         dUXISxgMVp21YeGWw52unoAMgPaEsoL8ABggAG7dhmAGcvaOds/qJMwvAfBYF/VK6Gzp
         5p7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0gKcz26H9kPebk9GSMPsBTxqAs3XYXfpFmHGeOdWuZI=;
        b=jvpx1IzA2N4xxceeMYCNfEOuvGHapyoMYrSJz2oex7FdGb/ys1qus7QVtvRX5J80Hk
         d9DVkUl6oZ4A4r4SUvS2nnBuWgK42ZRXz9q8xcXMfRxIsCS5p6Bxp2zvwkR6w9/TuKwW
         z+dxdlX4vvQM2G2DDNA1JYgaIazMqH0Ta2g9agXxi/L7TgsYb4V7tlIhyY/SNIYiyIry
         kv2M0Lv2osxvVt9XIG8fp/hJisLPCVfXRVgFJH78FLH38rpIGJHNfW8FUpiRbYI+pQ3I
         89DNTyKa30yvAKQK6OZyz3AWlxffAz2FITZkDiNN+fMIja2iSui/EpD5nzSTVzr8xN2t
         YgyA==
X-Gm-Message-State: AKS2vOx7JOxz2JEgBL4EMSvvpkiy4RafXDGr5szkA4f19D30whVcTW1R
        qnC78he7ULCo5Q==
X-Received: by 10.84.194.226 with SMTP id h89mr11011824pld.58.1498256799548;
        Fri, 23 Jun 2017 15:26:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id n123sm10760215pga.35.2017.06.23.15.26.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 15:26:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        philipoakley@iee.org
Subject: Re: [PATCH 1/3] builtin/fetch: factor submodule recurse parsing out to submodule config
References: <20170623191302.16053-1-sbeller@google.com>
        <20170623191302.16053-2-sbeller@google.com>
Date:   Fri, 23 Jun 2017 15:26:38 -0700
In-Reply-To: <20170623191302.16053-2-sbeller@google.com> (Stefan Beller's
        message of "Fri, 23 Jun 2017 12:13:00 -0700")
Message-ID: <xmqqshiqbash.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Later we want to access this parsing in builtin/pull as well.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/fetch.c    | 18 ++----------------
>  submodule-config.c | 22 ++++++++++++++++++++++
>  submodule-config.h |  3 +++
>  3 files changed, 27 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 100248c5af..9d58dc0a8a 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -53,20 +53,6 @@ static int shown_url = 0;
>  static int refmap_alloc, refmap_nr;
>  static const char **refmap_array;
>  
> -static int option_parse_recurse_submodules(const struct option *opt,
> -				   const char *arg, int unset)
> -{
> -	if (unset) {
> -		recurse_submodules = RECURSE_SUBMODULES_OFF;
> -	} else {
> -		if (arg)
> -			recurse_submodules = parse_fetch_recurse_submodules_arg(opt->long_name, arg);
> -		else
> -			recurse_submodules = RECURSE_SUBMODULES_ON;
> -	}
> -	return 0;
> -}
> -
>  static int git_fetch_config(const char *k, const char *v, void *cb)
>  {
>  	if (!strcmp(k, "fetch.prune")) {
> @@ -115,9 +101,9 @@ static struct option builtin_fetch_options[] = {
>  		    N_("number of submodules fetched in parallel")),
>  	OPT_BOOL('p', "prune", &prune,
>  		 N_("prune remote-tracking branches no longer on remote")),
> -	{ OPTION_CALLBACK, 0, "recurse-submodules", NULL, N_("on-demand"),
> +	{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, N_("on-demand"),
>  		    N_("control recursive fetching of submodules"),
> -		    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
> +		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules },
>  	OPT_BOOL(0, "dry-run", &dry_run,
>  		 N_("dry run")),
>  	OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
> diff --git a/submodule-config.c b/submodule-config.c
> index 4f58491ddb..265d036095 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -2,6 +2,7 @@
>  #include "submodule-config.h"
>  #include "submodule.h"
>  #include "strbuf.h"
> +#include "parse-options.h"
>  
>  /*
>   * submodule cache lookup structure
> @@ -234,6 +235,27 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
>  	return parse_fetch_recurse(opt, arg, 1);
>  }
>  
> +int option_fetch_parse_recurse_submodules(const struct option *opt,
> +					  const char *arg, int unset)
> +{
> +	int *v;
> +
> +	if (!opt->value)
> +		return -1;

It would have been easier to view this change if the original
already had used opt->value to specify where to place the parsed
value, but that is water under the bridge ;-)

Looks like a faithful converison to me.

> +	v = opt->value;
> +
> +	if (unset) {
> +		*v = RECURSE_SUBMODULES_OFF;
> +	} else {
> +		if (arg)
> +			*v = parse_fetch_recurse_submodules_arg(opt->long_name, arg);
> +		else
> +			*v = RECURSE_SUBMODULES_ON;
> +	}
> +	return 0;
> +}
> +
>  static int parse_update_recurse(const char *opt, const char *arg,
>  				int die_on_error)
>  {
> diff --git a/submodule-config.h b/submodule-config.h
> index d434ecdb45..1076a68653 100644
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -23,6 +23,9 @@ struct submodule {
>  };
>  
>  extern int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
> +struct option;
> +extern int option_fetch_parse_recurse_submodules(const struct option *opt,
> +						 const char *arg, int unset);
>  extern int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
>  extern int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
>  extern int parse_submodule_config_option(const char *var, const char *value);
