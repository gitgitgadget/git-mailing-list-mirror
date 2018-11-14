Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEF641F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 16:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeKOClw (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 21:41:52 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:44831 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKOClw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 21:41:52 -0500
Received: from [192.168.2.240] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id MyAsg0DakVlGZMyAsghtKt; Wed, 14 Nov 2018 16:37:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542213475;
        bh=uU9LcwzmMaA8U07tIa11wiHLWBtl4K/3Zulz71mc5OQ=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=GPXo/caA5qbpsVgadEyarMhES0OuARERbPNjyDsGxtu9Ifw7e0GTbSE8D9KakldgC
         YKRquBARCoklXMbZJXo6yzkW/6lyaEqje/vrJ50e34JDK4Kbfo7fFX8it5Acd7rT0w
         vbbdZvnfalt2ktJuWhkl/bePPz1ZHvGQVgw9DqTo=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=OMBL4rd2uPXCnZqFg68A:9
 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] rebase: validate -C<n> and --whitespace=<mode>
 parameters early
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.76.git.gitgitgadget@gmail.com>
 <pull.76.v2.git.gitgitgadget@gmail.com>
 <4c2ba5276636097a1c3bb2207c7537831e9079bc.1542212726.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <ce8e2f7c-cded-0c9d-1306-330711a29021@talktalk.net>
Date:   Wed, 14 Nov 2018 16:37:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <4c2ba5276636097a1c3bb2207c7537831e9079bc.1542212726.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDU0SWQg6qlFnwqE3lNYE4/btyZrurfekL1JFqcq7SUc+yHOjO2EuWLS6mt8dlYLtbVWaTcYh2BW51umyxnY3cRQsKVwOjohrgvIOC/THHXky0w7xPLW
 wyQzDCx2CAAcCc7xLOfR+W78PiUoSioUoGHhvvDvpmgu82azg1jJJ4JPJptTGRR91YIplS6ojoCUu/QeXWl9aJyFtcKrO+dvGbcsx1ohBdcpkV58rXgwbY30
 eM/p/ftgGwWLTHX7boUfmFGG/PNXbqjGrV8JLgy4UENZodTUhwpruWq6QlO6dLU/vZmY1dzyEE1KlKZuH/fRCA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes

Thanks for doing this, I think this patch is good. I've not checked the 
first patch as I think it is the same as before judging from the 
covering letter.

Best Wishes

Phillip

On 14/11/2018 16:25, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> It is a good idea to error out early upon seeing, say, `-Cbad`, rather
> than starting the rebase only to have the `--am` backend complain later.
> 
> Let's do this.
> 
> The only options accepting parameters which we pass through to `git am`
> (which may, or may not, forward them to `git apply`) are `-C` and
> `--whitespace`. The other options we pass through do not accept
> parameters, so we do not have to validate them here.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   builtin/rebase.c          | 12 +++++++++++-
>   t/t3406-rebase-message.sh |  7 +++++++
>   2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 96ffa80b71..571cf899d5 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1064,12 +1064,22 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	}
>   
>   	for (i = 0; i < options.git_am_opts.argc; i++) {
> -		const char *option = options.git_am_opts.argv[i];
> +		const char *option = options.git_am_opts.argv[i], *p;
>   		if (!strcmp(option, "--committer-date-is-author-date") ||
>   		    !strcmp(option, "--ignore-date") ||
>   		    !strcmp(option, "--whitespace=fix") ||
>   		    !strcmp(option, "--whitespace=strip"))
>   			options.flags |= REBASE_FORCE;
> +		else if (skip_prefix(option, "-C", &p)) {
> +			while (*p)
> +				if (!isdigit(*(p++)))
> +					die(_("switch `C' expects a "
> +					      "numerical value"));
> +		} else if (skip_prefix(option, "--whitespace=", &p)) {
> +			if (*p && strcmp(p, "warn") && strcmp(p, "nowarn") &&
> +			    strcmp(p, "error") && strcmp(p, "error-all"))
> +				die("Invalid whitespace option: '%s'", p);
> +		}
>   	}
>   
>   	if (!(options.flags & REBASE_NO_QUIET))
> diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
> index 0392e36d23..2c79eed4fe 100755
> --- a/t/t3406-rebase-message.sh
> +++ b/t/t3406-rebase-message.sh
> @@ -84,4 +84,11 @@ test_expect_success 'rebase --onto outputs the invalid ref' '
>   	test_i18ngrep "invalid-ref" err
>   '
>   
> +test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
> +	test_must_fail git rebase -Cnot-a-number HEAD 2>err &&
> +	test_i18ngrep "numerical value" err &&
> +	test_must_fail git rebase --whitespace=bad HEAD 2>err &&
> +	test_i18ngrep "Invalid whitespace option" err
> +'
> +
>   test_done
> 

