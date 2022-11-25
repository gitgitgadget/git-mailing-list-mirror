Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83587C4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 22:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiKYWsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 17:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiKYWsD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 17:48:03 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC5A1A22E
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 14:48:02 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f7so8089410edc.6
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 14:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BXx+5ctbQhhQvzuU4iqRIe1JKsDTiaKb+1/LGbvI/v0=;
        b=dzphSGW9otjpB2BDemehxJODoobv3kqIZRjhciQyhsFeJOSbloNWeStbwz6/yJhrmj
         x58i7Or5S3XyZs5raWqVrbylBWG17KkAGu7E6KsPoeNC/iOQlKSmtLNci+TfIDsTrg6d
         /WlUzhZOSUYDG6HT6v8d20IS9QQWMO7E0+b8/qWyw4KxAl0DthTwLawQ5A9aImGq4dia
         34vkzYr6C8LxyLLB0heNH9HvdC0Wl1z77/MIFuG5LdXOoLisjZlORCKf5cM2qCDWr10i
         YYVT/QnxCV6udQBdoVIren6XmBYMnuggXD/bz8PIXeHZC6UFPonYQ8wVe3zeggziB1lP
         DarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXx+5ctbQhhQvzuU4iqRIe1JKsDTiaKb+1/LGbvI/v0=;
        b=pr5yf1fTMArDZ2H8KWS/arBW//vEyTO0mCTkymcvVSHkgP8zIQw28S+qf9HlzKJobn
         D/vtRvE/iarzsR3Ho4+xe0YBBWs6yUfSUWKD3zC+OSRltaxlOUzG1qN5U/+UNYN11n1Y
         i3zTtDRbumAdnJdVhE6yLwCJN0OjpsRMCfmVbJuHK+Lnj0MjJc0gxfdcHbjlpIiwag3Y
         VJPtvZhZwJMCdzErv6nhCf6jGKDzciWDt7KCSfdLwbY5s9P96xNatgq7GuHxiRDgS5ua
         PVqzzpHuKQOz5ejAeQqxE0uvn02jgpsPQ8WSMxNR609hExy1gX8VDadNSw3/tHankjRr
         f85w==
X-Gm-Message-State: ANoB5pkGQV/6VSkRurdDXufq36SaRT7e7llBJpmVmL+n+16Ue6THlqFU
        Efe6rs1UcdKThROZcRH7DbYd1DFEEgQQiDBh
X-Google-Smtp-Source: AA0mqf7nRgWT6q8rikTXH9DL4uup0Ja720Am2GjSuv6Q/rb+1pCa7BGVHI2DTADhWhCUTm/nbFcncA==
X-Received: by 2002:a05:6402:181:b0:461:ea0c:e151 with SMTP id r1-20020a056402018100b00461ea0ce151mr23099394edv.376.1669416480240;
        Fri, 25 Nov 2022 14:48:00 -0800 (PST)
Received: from gmgdl ([213.143.127.178])
        by smtp.gmail.com with ESMTPSA id nb12-20020a1709071c8c00b0078df3b4464fsm2100050ejc.19.2022.11.25.14.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 14:47:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oyhUD-000bfb-2e;
        Fri, 25 Nov 2022 23:47:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sean Allred via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Subject: Re: [PATCH v2 1/2] var: do not print usage() with a correct invocation
Date:   Fri, 25 Nov 2022 23:45:04 +0100
References: <pull.1434.git.1669321369.gitgitgadget@gmail.com>
 <pull.1434.v2.git.1669395151.gitgitgadget@gmail.com>
 <a7ff842a3e8d30cad7f18427bc812f542b998efc.1669395151.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <a7ff842a3e8d30cad7f18427bc812f542b998efc.1669395151.git.gitgitgadget@gmail.com>
Message-ID: <221125.86tu2mmz1e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 25 2022, Sean Allred via GitGitGadget wrote:

> From: Sean Allred <allred.sean@gmail.com>
>
> Before, git-var could print usage() even if the command was invoked
> correctly with a variable defined in git_vars -- provided that its
> read() function returned NULL.
>
> Now, we only print usage() only if it was called with a logical

"we only ... only if", drop/combine some "only"?

> variable that wasn't defined -- regardless of read().
>
> Since we now know the variable is valid when we call read_var(), we
> can avoid printing usage() here (and exiting with code 129) and
> instead exit quietly with code 1. While exiting with a different code
> can be a breaking change, it's far better than changing the exit
> status more generally from 'failure' to 'success'.

I honestly don't still don't grok what was different here before/after,
whatever we are now/should be doing here, a test as part of this change
asserting the new behavior would be really useful.

> -static const char *read_var(const char *var)
> +static const struct git_var *get_git_var(const char *var)
>  {
>  	struct git_var *ptr;
> -	const char *val;
> -	val = NULL;
>  	for (ptr = git_vars; ptr->read; ptr++) {
>  		if (strcmp(var, ptr->name) == 0) {
> -			val = ptr->read(IDENT_STRICT);
> -			break;
> +			return ptr;
>  		}

>  {
> +	const struct git_var *git_var = NULL;

This assignment to "NULL" can be dropped, i.e....

>  	const char *val = NULL;
>  	if (argc != 2)
>  		usage(var_usage);
> @@ -91,10 +89,15 @@ int cmd_var(int argc, const char **argv, const char *prefix)
>  		return 0;
>  	}
>  	git_config(git_default_config, NULL);
> -	val = read_var(argv[1]);
> -	if (!val)
> +
> +	git_var = get_git_var(argv[1]);

...we first assign to it here, and if we use it uninit'd before the
compiler will tell us.
