Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F066202A3
	for <e@80x24.org>; Wed, 18 Oct 2017 18:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751509AbdJRSD2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 14:03:28 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:47615 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbdJRSD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 14:03:26 -0400
Received: by mail-io0-f193.google.com with SMTP id h70so7166183ioi.4
        for <git@vger.kernel.org>; Wed, 18 Oct 2017 11:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EunsCAPvbEn6WMPMLk9f4q2tZIXRsayA2GqS6ezCLdo=;
        b=u28I/lTvcmRDIr+9B+SSZFoGB7KuiUHGXhDBO8fgidyujT8Kh8bZMP067uYeJ2ronQ
         FfskwRnh5tf9fcrTLgm6uJfXC8i6P3Q8K8/sJWOcWIW22kJew0khYuRoTBCq6Wug5OdY
         7p7swsTmBOa15t3lI8A2iXyjCBlP6riIOjLUmmw5fzzpRDm+bKCLIghy1Q/8w0VXb868
         khgdu762hJBS0VdIHSHM0pZyzs2uQKXuFGTFRrnCokHEea5pdXSNmFy+V9gXBKOKjlsR
         XNV51j8Bump7kuoCezwfqUWQALyr/zqkG6H1QHHKBAxHXPKDkMVzkDLmrigiHhoPEmCH
         1/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EunsCAPvbEn6WMPMLk9f4q2tZIXRsayA2GqS6ezCLdo=;
        b=aj9tfpnsA+FLcKDK+b/AMDKYUk88lVDQgxnOndLGVf7FT+Ck/RIJj9Z5l6+LIaffyZ
         gF341Wj5pVNiP3iaXpFixvEkXg1G++WAmKVSomXwCf8X2pabb1ZwZ9nrb0LJfux3Xb8w
         t3sktyUhjszGq21HYpxOoIRQ36Qd3MxswS5oHjZgjToVpQVMeKY05/+QHtvDohLes1GQ
         JyphFvwYo+HeYJMUzjOsbhLOVXWxBKiIFCdrQEd4I2RASzxEXIdTnKvDwaJtudQKaJPu
         IwU/cnEr2Ykk1iRQEMJOdvBO3iM1P8etFaiZhB5GSsITXPs7Y+k8TxwASkRnfNTeLC2H
         dPnA==
X-Gm-Message-State: AMCzsaVQnqpKGIi4jxZvxSDo84b3VAxbpQ6lUUAXtVhlZaYHPkh3iDyc
        Tu8e3WJVdl2isFvma9eK1khsiA==
X-Google-Smtp-Source: AOwi7QCosA/VtIzjLGaXWRIBneglX8oXr3YA0okmG86OhGScwKKyG6LKeAu7HD7JVgv0Wp6KKlfeSw==
X-Received: by 10.107.169.34 with SMTP id s34mr24098666ioe.103.1508349805249;
        Wed, 18 Oct 2017 11:03:25 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:550:4cf:a88:68a])
        by smtp.gmail.com with ESMTPSA id e68sm409321ite.0.2017.10.18.11.03.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 18 Oct 2017 11:03:24 -0700 (PDT)
Date:   Wed, 18 Oct 2017 11:03:22 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>, sbeller@google.com,
        jrnieder@gmail.com, Jens.Lehmann@web.de, git@vger.kernel.org
Subject: Re: [PATCH v4 3/3] submodule: simplify decision tree whether to or
 not to fetch
Message-ID: <20171018180322.GA155019@google.com>
References: <20171016135623.GA12756@book.hvoigt.net>
 <20171016135905.GD12756@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171016135905.GD12756@book.hvoigt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/16, Heiko Voigt wrote:
> To make extending this logic later easier.

This makes things so much clearer, thanks!

> 
> Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
> ---
>  submodule.c | 74 ++++++++++++++++++++++++++++++-------------------------------
>  1 file changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/submodule.c b/submodule.c
> index 71d1773e2e..82d206eb65 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1187,6 +1187,31 @@ struct submodule_parallel_fetch {
>  };
>  #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0}
>  
> +static int get_fetch_recurse_config(const struct submodule *submodule,
> +				    struct submodule_parallel_fetch *spf)
> +{
> +	if (spf->command_line_option != RECURSE_SUBMODULES_DEFAULT)
> +		return spf->command_line_option;
> +
> +	if (submodule) {
> +		char *key;
> +		const char *value;
> +
> +		int fetch_recurse = submodule->fetch_recurse;
> +		key = xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->name);
> +		if (!repo_config_get_string_const(the_repository, key, &value)) {
> +			fetch_recurse = parse_fetch_recurse_submodules_arg(key, value);
> +		}
> +		free(key);
> +
> +		if (fetch_recurse != RECURSE_SUBMODULES_NONE)
> +			/* local config overrules everything except commandline */
> +			return fetch_recurse;
> +	}
> +
> +	return spf->default_option;
> +}
> +
>  static int get_next_submodule(struct child_process *cp,
>  			      struct strbuf *err, void *data, void **task_cb)
>  {
> @@ -1214,46 +1239,21 @@ static int get_next_submodule(struct child_process *cp,
>  			}
>  		}
>  
> -		default_argv = "yes";
> -		if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
> -			int fetch_recurse = RECURSE_SUBMODULES_NONE;
> -
> -			if (submodule) {
> -				char *key;
> -				const char *value;
> -
> -				fetch_recurse = submodule->fetch_recurse;
> -				key = xstrfmt("submodule.%s.fetchRecurseSubmodules", submodule->name);
> -				if (!repo_config_get_string_const(the_repository, key, &value)) {
> -					fetch_recurse = parse_fetch_recurse_submodules_arg(key, value);
> -				}
> -				free(key);
> -			}
> -
> -			if (fetch_recurse != RECURSE_SUBMODULES_NONE) {
> -				if (fetch_recurse == RECURSE_SUBMODULES_OFF)
> -					continue;
> -				if (fetch_recurse == RECURSE_SUBMODULES_ON_DEMAND) {
> -					if (!unsorted_string_list_lookup(&changed_submodule_names,
> -									 submodule->name))
> -						continue;
> -					default_argv = "on-demand";
> -				}
> -			} else {
> -				if (spf->default_option == RECURSE_SUBMODULES_OFF)
> -					continue;
> -				if (spf->default_option == RECURSE_SUBMODULES_ON_DEMAND) {
> -					if (!unsorted_string_list_lookup(&changed_submodule_names,
> -									  submodule->name))
> -						continue;
> -					default_argv = "on-demand";
> -				}
> -			}
> -		} else if (spf->command_line_option == RECURSE_SUBMODULES_ON_DEMAND) {
> -			if (!unsorted_string_list_lookup(&changed_submodule_names,
> +		switch (get_fetch_recurse_config(submodule, spf))
> +		{
> +		default:
> +		case RECURSE_SUBMODULES_DEFAULT:
> +		case RECURSE_SUBMODULES_ON_DEMAND:
> +			if (!submodule || !unsorted_string_list_lookup(&changed_submodule_names,
>  							 submodule->name))
>  				continue;
>  			default_argv = "on-demand";
> +			break;
> +		case RECURSE_SUBMODULES_ON:
> +			default_argv = "yes";
> +			break;
> +		case RECURSE_SUBMODULES_OFF:
> +			continue;
>  		}
>  
>  		strbuf_addf(&submodule_path, "%s/%s", spf->work_tree, ce->name);
> -- 
> 2.14.1.145.gb3622a4
> 

-- 
Brandon Williams
