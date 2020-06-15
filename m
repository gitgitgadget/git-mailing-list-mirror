Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08F4C433DF
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 15:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73835207F5
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 15:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8+L1bzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbgFOPF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730948AbgFOPF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 11:05:56 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D077C061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 08:05:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l11so17506730wru.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XbwRJCCP5OK98bM6Ncz1ALYoFhgck2aLrvkntapeKNo=;
        b=G8+L1bzTAkTXeUolhb5GdZgZaBf0XMcURlH+5cMUCasuBemo67P96YE2ITtHX3RKRX
         ej3cbHRP4xaKZLuaWXhsCdxsIDA/0vxCCSXzM9b2ubzrLDxCMsTLoQ77zFkmNVNeUZOA
         IFBE60Hud+ISvX9u9Oz2WNGWHtAVOKRKLCKFr0LvC2PgNOaTBiRDNFlKNZTPzYKVXexA
         9g4joxcISgfZBL+GIVHFxmuNQzhz4Ic0Kbp3oeUyI9fWipkNMjElJncnMG4yipOKL2yT
         5RBS8xzXaBJzCQrzMg+W+o2ABM0oSpWzsw0nFcwJF35xtfIf78w5EunGwe6qua8jWsqg
         5R/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XbwRJCCP5OK98bM6Ncz1ALYoFhgck2aLrvkntapeKNo=;
        b=AYWUsSv15ArhGzq89+R75Sq3sA6pCbwmZ82JFDDnwZmJAB6w7p7BVNERk3gSH1UvKy
         n5nFbyeI5JSSgnDB3VRmMLYJwqitfBWUfgkJdQfbwWe1wwz73U1LChxmXYZkpOq6KVf2
         EV38UOXC8XP1g4nLaxqWRfAy4NS2GIiOmGF0920kRZ3KbeKDeLDrizs0n10wYzUU5vbO
         OnkGkWDzSYEfEfr5yAbDUa/uCl1c+BFNi1teE1LgZdvIDxvioEeY94aVkL+Y+5AVUX77
         fIrVE7tAODwpkW+V6FcGJawiG+EQ+8m5TPdhOI6PR5DDfFpUVGPUqLA4rxf3QPRUqmL2
         X2Jg==
X-Gm-Message-State: AOAM532NH33s43PUYqqDfPmwQdA83pnCrHCcH+P5m0vxu2vW+qTgZN+q
        nPWItH/4AiPO2GJoN1qh+oixoATQlbg=
X-Google-Smtp-Source: ABdhPJzbG2DvxqkET9JhMJN6tVhjcPOteEB42yfpjZfzxocDnniPObauZzkyRdC4E8aoiki1HCBXPQ==
X-Received: by 2002:adf:f882:: with SMTP id u2mr31031500wrp.40.1592233554788;
        Mon, 15 Jun 2020 08:05:54 -0700 (PDT)
Received: from [192.168.1.240] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id g3sm27642760wrb.46.2020.06.15.08.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 08:05:53 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 05/12] fast-export: handle overridden main branch names
 correctly
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
 <a3be4f39aa240e614a2e12756e1ea864c35137a2.1592225416.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a0982afb-8c44-aeff-1839-6e0aa897fcf2@gmail.com>
Date:   Mon, 15 Jun 2020 16:05:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <a3be4f39aa240e614a2e12756e1ea864c35137a2.1592225416.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi dscho

On 15/06/2020 13:50, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When anonymizing commit history, we are careful to translate the main
> branch name to `ref0`.
> 
> When the main branch name is overridden via the config, we will want
> `git fast-export` to use that overridden name instead.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   builtin/fast-export.c            | 11 ++++++++++-
>   t/t9351-fast-export-anonymize.sh |  6 ++++++
>   2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 1072bbf041f..deeb01b6937 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -515,14 +515,23 @@ static const char *anonymize_refname(const char *refname)
>   	};
>   	static struct hashmap refs;
>   	static struct strbuf anon = STRBUF_INIT;
> +	static char *main_branch;
>   	int i;
>   
>   	/*
>   	 * In certain circumstances, it might be interesting to be able to
>   	 * identify the main branch. For that reason, let's force its name to
>   	 * be anonymized to `ref0`.
> +	 *
> +	 * While the main branch name might often be `main` for new
> +	 * repositories (and `master` for aged ones), and such well-known names
> +	 * may not necessarily need anonymizing, it could be configured to use
> +	 * a secret word that the user may not want to reveal.
>   	 */
> -	if (!strcmp(refname, "refs/heads/master"))
> +	if (!main_branch)
> +		main_branch = git_main_branch_name(MAIN_BRANCH_FULL_NAME);
> +
> +	if (!strcmp(refname, main_branch))
>   		return "refs/heads/ref0";

This leaks main_branch if it came from git_main_branch_name()

Best Wishes

Phillip

>   	strbuf_reset(&anon);
> diff --git a/t/t9351-fast-export-anonymize.sh b/t/t9351-fast-export-anonymize.sh
> index 2415f0ec213..f42be635c2f 100755
> --- a/t/t9351-fast-export-anonymize.sh
> +++ b/t/t9351-fast-export-anonymize.sh
> @@ -31,6 +31,12 @@ test_expect_success 'stream translates master to ref0' '
>   	! grep master stream
>   '
>   
> +test_expect_success 'respects configured main branch' '
> +	git -c core.mainBranch=does-not-exist \
> +		fast-export --anonymize --all >stream-without-ref0 &&
> +	! grep ref0 stream-without-ref0
> +'
> +
>   test_expect_success 'stream omits other refnames' '
>   	! grep other stream &&
>   	! grep mytag stream
> 
