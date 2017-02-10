Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A5B01FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 18:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753642AbdBJS51 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 13:57:27 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35200 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753382AbdBJS50 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 13:57:26 -0500
Received: by mail-pf0-f193.google.com with SMTP id 68so1090196pfx.2
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 10:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0mP1ywPDb9n4gzcRUILIT7BJX+rZcOu+zyUO9IK2zUk=;
        b=asW1r6B3f/UnZNFHPPgMdTSsPgami6ZBnVH17xTmtDxMrecWqntN83XpitFgAEMlhO
         nxmOJYzO3ne2pMpsn+yNgo13wl/DfW5ZsckRH0cGvXfCF2PPwXHZ6qdpwALF1yCpGWKZ
         ZLy8Cr1jFo51jrnYlKQTj9n8nLnm7S+Bbg5qyytSpBuulpI6tqeNE5lRSQtTjRiUsgPk
         wLOhgLXLvmAE1Ze55wlWq1BCJyd3aeggadF0LbtH1GoFDf0yV7E6X8SxsextFh1G0CB4
         HbhX4zB3Z50QuQxNbrfJR6niDk7MsQbvLK36x1aY4z/cZ/K83gFYD/GRmaXNb6USmr6f
         1S6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0mP1ywPDb9n4gzcRUILIT7BJX+rZcOu+zyUO9IK2zUk=;
        b=snXq7fNzHha4IetH1VFPZFA9jAjivniwF9wqLmPm4XJ5iHi5Ul30Lb+b1vxfqpK+J5
         MDWXvqFMDhC1cowhQ/r4LJZiHgicWAVVZxqXtkalzrfjbyMFR5Jl6B2EpbHUneA1YdVK
         9BHRbhmYaXlOzgU3gAThRMr4aoZR4wYmFqU2DvhavfIaiF6+eFLaYl4hn4Ratm1+OEu6
         czSiIfug3lCwTcXfGgnOWzSd3XQR2A34SllWpY5sJkShDQi9jzwcuOFLSFZ8+5jeTZ89
         8CyaZP0mgKfN6SfIvU1yqyiq6gkOdlue22kodJAqt4SGX1ediEiMyiNBAGkybk2A6PRr
         Sqog==
X-Gm-Message-State: AMke39lFBHht3dykItGv9vf4YhMHlZcpj3wPnfSSOu8MOAaoePH1Kie6rwDK+5ptLQH1Cg==
X-Received: by 10.84.177.129 with SMTP id x1mr13134802plb.75.1486753045447;
        Fri, 10 Feb 2017 10:57:25 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id n123sm7104175pga.9.2017.02.10.10.57.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 10:57:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v2 2/2] rev-parse: fix several options when running in a subdirectory
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de>
        <cover.1486740772.git.johannes.schindelin@gmx.de>
        <9242ee9717dcec95351b356070102f198eeb2537.1486740772.git.johannes.schindelin@gmx.de>
Date:   Fri, 10 Feb 2017 10:57:23 -0800
In-Reply-To: <9242ee9717dcec95351b356070102f198eeb2537.1486740772.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 10 Feb 2017 16:33:46 +0100
        (CET)")
Message-ID: <xmqqo9y9lvqk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index ff13e59e1db..84af2802f6f 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -545,6 +545,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  	unsigned int flags = 0;
>  	const char *name = NULL;
>  	struct object_context unused;
> +	struct strbuf buf = STRBUF_INIT;
>  
>  	if (argc > 1 && !strcmp("--parseopt", argv[1]))
>  		return cmd_parseopt(argc - 1, argv + 1, prefix);
> @@ -599,7 +600,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  		if (!strcmp(arg, "--git-path")) {
>  			if (!argv[i + 1])
>  				die("--git-path requires an argument");
> -			puts(git_path("%s", argv[i + 1]));
> +			strbuf_reset(&buf);
> +			puts(relative_path(git_path("%s", argv[i + 1]),
> +					   prefix, &buf));
>  			i++;
>  			continue;
>  		}
> @@ -821,8 +824,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				continue;
>  			}
>  			if (!strcmp(arg, "--git-common-dir")) {
> -				const char *pfx = prefix ? prefix : "";
> -				puts(prefix_filename(pfx, strlen(pfx), get_git_common_dir()));
> +				strbuf_reset(&buf);
> +				puts(relative_path(get_git_common_dir(),
> +						   prefix, &buf));
>  				continue;
>  			}
>  			if (!strcmp(arg, "--is-inside-git-dir")) {
> @@ -845,7 +849,9 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  					die(_("Could not read the index"));
>  				if (the_index.split_index) {
>  					const unsigned char *sha1 = the_index.split_index->base_sha1;
> -					puts(git_path("sharedindex.%s", sha1_to_hex(sha1)));
> +					const char *path = git_path("sharedindex.%s", sha1_to_hex(sha1));
> +					strbuf_reset(&buf);
> +					puts(relative_path(path, prefix, &buf));
>  				}
>  				continue;
>  			}
> @@ -906,5 +912,6 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  		die_no_single_rev(quiet);
>  	} else
>  		show_default();
> +	strbuf_release(&buf);

This uses "reset then use" pattern for repeated use of strbuf, and
causes the string last held in the strbuf to leak on early return,
which can be mitigated by using "use then reset" pattern.  I.e.

			if (!strcmp(arg, "--git-common-dir")) {
				puts(relative_path(get_git_common_dir(),
						   prefix, &buf));
				strbuf_reset(&buf);
				continue;
			}

I'd think.  You'd still want to release it at the end anyway for
good code hygiene, though.

Other than that, looks good to me.

Thanks.
