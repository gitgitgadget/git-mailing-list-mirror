Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2B0C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 12:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348179AbiFVMvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 08:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbiFVMvU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 08:51:20 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E20610F
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 05:51:19 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id AF2223F4163;
        Wed, 22 Jun 2022 08:51:18 -0400 (EDT)
Received: from jeffhost-mbp.local (addr-66.249.231.194.nptpop-cmts01-cable-sub.rdns-bnin.net [66.249.231.194])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8778E3F4148;
        Wed, 22 Jun 2022 08:51:18 -0400 (EDT)
Subject: Re: [PATCH v3 5/5] bitmap: add trace2 outputs during open "bitmap"
 file
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
References: <cover.1655018322.git.dyroneteng@gmail.com>
 <e118758d1dada378d65d58579cc1372fa547d720.1655018322.git.dyroneteng@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <78966fb1-d5be-2fb5-0f68-0fce0b93d249@jeffhostetler.com>
Date:   Wed, 22 Jun 2022 08:51:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <e118758d1dada378d65d58579cc1372fa547d720.1655018322.git.dyroneteng@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/12/22 3:44 AM, Teng Long wrote:
[...]
>   
>   struct bitmap_index *prepare_bitmap_git(struct repository *r)
> diff --git a/repo-settings.c b/repo-settings.c
> index b4fbd16cdc..5bc7a97a6d 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -8,6 +8,7 @@ static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
>   {
>   	if (repo_config_get_bool(r, key, dest))
>   		*dest = def;
> +	trace2_data_string("config", r, key, *dest ? "true" : "false");
>   }

We should not be doing.  This would dump every repo-related
boolean value on every command.

I already have a GIT_TRACE2_CONFIG_PARAMS and trace2.configparams
that will dump "interesting" config values to the trace2 log.
Just set one of them to a list of regex's.  Look at the comment above
trace2_cmd_list_config() in trace2.h for details.

We also have GIT_TRACE2_ENV_VARS and trace2.envvars that will dump
the values of "interesting" env vars.

You can use these in your testing to log the config and env var
values that you are interested in.

Jeff

