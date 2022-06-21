Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB540C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 05:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242636AbiFUF2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 01:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiFUF2n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 01:28:43 -0400
Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C181219C34
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 22:28:39 -0700 (PDT)
Received: from bsmtp2.bon.at (unknown [192.168.181.106])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4LRw6G1WxRz5tsm
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 07:28:38 +0200 (CEST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4LRw6800LBz5tlF;
        Tue, 21 Jun 2022 07:28:31 +0200 (CEST)
Message-ID: <964a9ae5-35e7-8906-314a-f3c27624793d@kdbg.org>
Date:   Tue, 21 Jun 2022 07:28:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] t5510: replace 'origin' with URL more carefully (was
 Re: Test Failure t5510,t5562 - was RE: [ANNOUNCE] Git v2.37.0-rc1)
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, rsbecker@nexbridge.com,
        'Junio C Hamano' <gitster@pobox.com>
References: <00a401d884d0$32885890$979909b0$@nexbridge.com>
 <8d2a0a36-1d2f-c723-db1e-8978e5d03d1d@github.com>
 <00b501d884d7$d8ed1200$8ac73600$@nexbridge.com>
 <495bd957-43dc-f252-657d-2969bb7ad5f3@github.com>
 <484a330e-0902-6e1b-8189-63c72dcea494@github.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <484a330e-0902-6e1b-8189-63c72dcea494@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.06.22 um 00:20 schrieb Derrick Stolee:
> @@ -853,7 +853,9 @@ test_configured_prune_type () {
>  		then
>  			new_cmdline=$cmdline_setup
>  		else
> -			new_cmdline=$(printf "%s" "$cmdline" | perl -pe 's[origin(?!/)]["'"$remote_url"'"]g')
> +			new_cmdline=$(printf "%s" "$cmdline" |
> +					sed -e "s~origin ~'$remote_url' ~g" \
> +					    -e "s~ origin~ '$remote_url'~g")

I'm not sure if this is still an issue, but I recall that there are seds
in the wild that do not grok an incomplete last line. Better make this
`printf "%s\n" "$cmdline"` if `echo "$cmdline"` is not an option.

>  		fi
>  
>  		if test "$fetch_prune_tags" = 'true' ||

-- Hannes
