Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FFF120954
	for <e@80x24.org>; Tue, 21 Nov 2017 08:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbdKUID6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 03:03:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57663 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751151AbdKUID5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 03:03:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8DE7BF8EE;
        Tue, 21 Nov 2017 03:03:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=cKSCkFlsUnuFmsCQ+RE7phnMKj0=; b=b5i1bf8TSQ19OZR8tK2O
        EHh3kxDDnPnbdKZAS2Odq9uiVp2ubTzqtzLpn6F68cWNs0bm2x2j7t9+WZO6NhK9
        gbErK0J+1eNCaoM/nBBn4wGa87hfb9ei9tHZ1MAdgX5xEpgZF/hpOaemwUkljPF4
        ZER/knoQtQHzXmV8elrdukI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=OlWUDLyiofhAxYY/6aOm6vA+MDJKN0kRvlVbJ3yMyZeNdK
        ynFh27LKJ1PveioZ3HxkgcV4hyPWSQCknWmE1pu1mFxCm7CCo87zhB4iQbHxJgms
        iejeKASmZgJN4xxoMmiCQ0n38piGj2IYlscSIEEaY51w6HQIEeoDpqLWB5t4c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1B50BF8ED;
        Tue, 21 Nov 2017 03:03:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54C0EBF8EB;
        Tue, 21 Nov 2017 03:03:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuyu Wei <wsy@dogben.com>
Cc:     git@vger.kernel.org, pyokagan@gmail.com
Subject: Re: [PATCH] git-pull: Pass -4/-6 option to git-fetch
References: <20171119110132.folfzddhdorb6wqd@debian-dorm>
Date:   Tue, 21 Nov 2017 17:03:55 +0900
Message-ID: <xmqqzi7gys5w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85CFCBEE-CE92-11E7-A59D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuyu Wei <wsy@dogben.com> writes:

> The -4/-6 option should be passed through to git-fetch
> to be consistent with the git-pull man page.
>
> Signed-off-by: Wei Shuyu <wsy@dogben.com>
> ---

Sounds sensible.  "git pull -h" output automatically gets extended
with this change, too.

Thanks.

>  builtin/pull.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index f7e2c4f2e..166b777ed 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -113,6 +113,8 @@ static char *opt_depth;
>  static char *opt_unshallow;
>  static char *opt_update_shallow;
>  static char *opt_refmap;
> +static char *opt_ipv4;
> +static char *opt_ipv6;
>  
>  static struct option pull_options[] = {
>  	/* Shared options */
> @@ -218,6 +220,12 @@ static struct option pull_options[] = {
>  	OPT_PASSTHRU(0, "refmap", &opt_refmap, N_("refmap"),
>  		N_("specify fetch refmap"),
>  		PARSE_OPT_NONEG),
> +	OPT_PASSTHRU('4',  "ipv4", &opt_ipv4, NULL,
> +		N_("use IPv4 addresses only"),
> +		PARSE_OPT_NOARG),
> +	OPT_PASSTHRU('6',  "ipv6", &opt_ipv6, NULL,
> +		N_("use IPv6 addresses only"),
> +		PARSE_OPT_NOARG),
>  
>  	OPT_END()
>  };
> @@ -522,6 +530,10 @@ static int run_fetch(const char *repo, const char **refspecs)
>  		argv_array_push(&args, opt_update_shallow);
>  	if (opt_refmap)
>  		argv_array_push(&args, opt_refmap);
> +	if (opt_ipv4)
> +		argv_array_push(&args, opt_ipv4);
> +	if (opt_ipv6)
> +		argv_array_push(&args, opt_ipv6);
>  
>  	if (repo) {
>  		argv_array_push(&args, repo);
