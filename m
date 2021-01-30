Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED5AC433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 01:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 800A364E00
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 01:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbhA3Bt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 20:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhA3Bro (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 20:47:44 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4F7C061574
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 17:46:11 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x9so454686plb.5
        for <git@vger.kernel.org>; Fri, 29 Jan 2021 17:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uvsBhWWtK1uRJdOuQlnH6Np/I0GFHd9LchLjzmI8P1I=;
        b=IomyeThrELrDMB4aW8f2nWpaxLrV7a/O9pGK18SZVlTOLw0/VBVvj/UWXMKys30xoV
         qIV5jmnUr/QUYieWmwgGRtkK8KG+mhnsDmAs/aISsxcMFnWxD+6nY7YDsAUZtj9kAXoz
         tT4043KB+p1yNn3UVCsX5EtoNI8+v7HOH6mtUkpKY/rI/7NjusC1317XYL1nY1RZqbeE
         yY8ZqSAUXQhyryRq4Uvn7Slul2WbHYG0pqmGti1JVvRxJgkHzQtpV4CXZr0nAyK6X5oR
         OdSpS5j3ThOy50PrajHLw9K7xpUklkWkFfuurSwLAuSFNeF/lbn73jEeAUd3oY/RRxfm
         9smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uvsBhWWtK1uRJdOuQlnH6Np/I0GFHd9LchLjzmI8P1I=;
        b=VF53IPVHvFPdO+Sc0Ag9WpxcWWU+F9WzIXaTAP5DAq6ZEe6RHY2m2uPTXwfd3+HXhk
         0oKBYN2dgtdFZLZ4yh64XDI4OVFBHBi2kiNVsnsOce6VjXIbxRjJBCohNzaxsyvSwxKB
         4LcbiPPUZIpawYdNlOE2x5F1JPj1Qefqdh5wY3HOb9UPTJNcuR+TrrqU3QowCzsoQCEj
         C5PlZ2MA+WMOk5+gxqBxKbcl843aQECGiO2lC5fBKsBfBlHxFNl8LbPjfW5bEDI78E9s
         XByG2q+PfSSO2La13Arm+cC4BHK9qgZkNbIDmhQIvkWaZssa1htEeagaATIGJa0maSIq
         G7Yg==
X-Gm-Message-State: AOAM530vhOlq9z3If9EWcKXVAu+29qSq1eg+WPrD8Y5yUWdutRaLtiA3
        QUNP5pj70n5Ag3ZNo2gvokk=
X-Google-Smtp-Source: ABdhPJwczPYI3PVAPHSMDQQJDsOxkg/EQGmsyaLhWF2hLcMLyew3/hfJuCqdlmiHr18O2virvtwc1Q==
X-Received: by 2002:a17:902:9690:b029:e0:4bf:15e3 with SMTP id n16-20020a1709029690b02900e004bf15e3mr7299137plp.16.1611971170907;
        Fri, 29 Jan 2021 17:46:10 -0800 (PST)
Received: from localhost ([2402:800:63a8:ad95:fbcc:5c2d:9b99:6083])
        by smtp.gmail.com with ESMTPSA id j6sm9852140pfg.159.2021.01.29.17.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 17:46:10 -0800 (PST)
Date:   Sat, 30 Jan 2021 08:46:08 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [PATCH v4 1/7] bisect--helper: reimplement `bisect_log` shell
 function in C
Message-ID: <YBS6YJq0W3VsGf6P@danh.dev>
References: <20210125191710.45161-1-mirucam@gmail.com>
 <20210125191710.45161-2-mirucam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125191710.45161-2-mirucam@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +static enum bisect_error bisect_log(void)
> +{
> +	int fd, status;
> +	fd = open(git_path_bisect_log(), O_RDONLY);
> +	if (fd < 0)
> +		return BISECT_FAILED;
> +
> +	status = copy_fd(fd, STDOUT_FILENO);
> +	close(fd);
> +	return status ? BISECT_FAILED : BISECT_OK;

The old code will write "We are not bisection." to stderr when, well,
we're not bisecting. This message suggested an alternative
 https://lore.kernel.org/git/gohp6kv9bml9qc.fsf@gmail.com

> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> @@ -916,7 +928,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		BISECT_AUTOSTART,
>  		BISECT_NEXT,
>  		BISECT_AUTO_NEXT,
> -		BISECT_STATE
> +		BISECT_STATE,
> +		BISECT_LOG
>  	} cmdmode = 0;
>  	int res = 0, nolog = 0;
>  	struct option options[] = {
> @@ -938,6 +951,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
>  		OPT_CMDMODE(0, "bisect-state", &cmdmode,
>  			 N_("mark the state of ref (or refs)"), BISECT_STATE),
> +		OPT_CMDMODE(0, "bisect-log", &cmdmode,
> +			 N_("list the bisection steps so far"), BISECT_LOG),
>  		OPT_BOOL(0, "no-log", &nolog,
>  			 N_("no log for BISECT_WRITE")),
>  		OPT_END()
> @@ -1000,6 +1015,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		get_terms(&terms);
>  		res = bisect_state(&terms, argv, argc);
>  		break;
> +	case BISECT_LOG:
> +		if (argc)
> +			return error(_("--bisect-log requires 0 arguments"));
> +		res = bisect_log();
> +		break;
>  	default:
>  		BUG("unknown subcommand %d", cmdmode);
>  	}
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 1f3f6e9fc5..05863cc142 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -169,11 +169,6 @@ exit code \$res from '\$command' is < 0 or >= 128" >&2
>  	done
>  }
>  
> -bisect_log () {
> -	test -s "$GIT_DIR/BISECT_LOG" || die "$(gettext "We are not bisecting.")"
> -	cat "$GIT_DIR/BISECT_LOG"
> -}
> -
>  get_terms () {
>  	if test -s "$GIT_DIR/BISECT_TERMS"
>  	then
> @@ -210,7 +205,7 @@ case "$#" in
>  	replay)
>  		bisect_replay "$@" ;;
>  	log)
> -		bisect_log ;;
> +		git bisect--helper --bisect-log || exit ;;

The original code was "die" when no bisect_log available.

I think we need to "exit 1" here to indicate a failure, i.e.

	git bisect--helper --bisect-log || exit 1 ;;

>  	run)
>  		bisect_run "$@" ;;
>  	terms)
> -- 
> 2.29.2
> 

-- 
Danh
