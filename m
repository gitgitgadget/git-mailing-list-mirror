Return-Path: <SRS0=OIeF=BS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39826C433E0
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 13:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D1E20759
	for <git@archiver.kernel.org>; Sat,  8 Aug 2020 13:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbchH6qA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgHHNq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Aug 2020 09:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgHHNq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Aug 2020 09:46:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF9BC061756
        for <git@vger.kernel.org>; Sat,  8 Aug 2020 06:46:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t14so4307753wmi.3
        for <git@vger.kernel.org>; Sat, 08 Aug 2020 06:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MHwUvZtzmdUXdqBep7DC2AMeDUbrlJkUngCuub8v5Ts=;
        b=pbchH6qAJfvj46RTaM4CikkKstqPintbHzZ7IcFL9JW+9Gp6ApoDt6Uq34lNPMxzHT
         gbi5CQ39baQB+TKJGDayd61uc7tKAwpyVe/92sDM6vpMX9mxumRxuQ8m2objhyNiipLW
         8gNSqSTYUCf1bXH724KC+QL2wiqrEVMre5c870kGQuQZfy/I6gPKbn0z7NMR8sL7/lOX
         9DgBHMwvd1kFNlBFDBjydKr+X3uG4yGaKfNJZKiGSMlgGOQHJJkFrO7l9NBBUOIivSla
         NHmsM8TK0tZ9Xi3lkLoHFfSVegSRxrXcUf10RwyEurz/fjMox4DOtBQofHs+nlb4TbHF
         pAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MHwUvZtzmdUXdqBep7DC2AMeDUbrlJkUngCuub8v5Ts=;
        b=fvlLLHmnhix1jWQFeSATZay14EBp/Ad6r5xIfJUv51yNGkUzh5L6o6MRDTg5JZIT/A
         khr6o6gRkU1A5h/DGdI7jWuPk0LTBqQdLeJUmxQfxHxVButqmVyqCZOqOCrjYbq8IMVE
         aRg+9ohBD8h3AiUO0iD2h5jMNsWwq/XmoHeAH8ppMQa5KNj8BGXAoZdpbAh9bQ2Y8DDk
         KOPd8y4wZTYIRBsc00tgdXZ4/r/UI3dJ2AdWeoqAxa0Hha0Ypf6PbuPUnJQEje2VowvS
         jmgI9oYG+rIZGVNNpBbz/W1wJZZ8WFH7yHFZHlcsHw/skdcDTyivvRkSXwklUktkvdmS
         LPcA==
X-Gm-Message-State: AOAM5339gr0RlSk5E6bABcboArW1rhDmhg1KCLJB09u148iQWcfc1zkF
        2M92+pUx84ikPWqZp4yrI63Oa3K0
X-Google-Smtp-Source: ABdhPJzyG01xhpkoid2rc8AWbb7NyQPm5KI8Mr6VRx9AY414zBe5+iB/a6elePReXkRVZpPeM0ViFg==
X-Received: by 2002:a05:600c:2184:: with SMTP id e4mr16552802wme.24.1596894380763;
        Sat, 08 Aug 2020 06:46:20 -0700 (PDT)
Received: from [192.168.1.240] (161.252.189.80.dyn.plus.net. [80.189.252.161])
        by smtp.gmail.com with ESMTPSA id y84sm14488583wmg.38.2020.08.08.06.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2020 06:46:19 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 2/3] apply: make i-t-a entries never match worktree
To:     "Raymond E. Pasco" <ray@ameretat.dev>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20200806060119.74587-1-ray@ameretat.dev>
 <20200808074959.35943-1-ray@ameretat.dev>
 <20200808074959.35943-3-ray@ameretat.dev>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <db1c56f6-bcd2-bbd9-aa63-70d54215cd44@gmail.com>
Date:   Sat, 8 Aug 2020 14:46:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200808074959.35943-3-ray@ameretat.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Raymond

On 08/08/2020 08:49, Raymond E. Pasco wrote:
> By definition, an intent-to-add index entry can never match the
> worktree, because worktrees have no concept of intent-to-add entries.
> Therefore, "apply --index" should always fail on intent-to-add paths.

I'm not sure I understand the logic for this. If I run 'git add -N 
<path>' and <path> does not exist in the worktree what's the reason to 
stop a patch that creates <path> from applying?

I was relieved to see from the next patch that this does not affect 
--cached even though the documentation says it implies --index. It might 
be worth mentioning that in the commit message. Also it would be easier 
to follow if the tests were in the same patch (this is what we usually do).

How this does it affect --check? `git add -p` uses --check to verify 
that hunks that the user has edited still apply. It does not let the 
user edit the hunk for a newly added file at the moment but that is 
something I'm thinking of adding.

Best Wishes

Phillip

> Because check_preimage() calls verify_index_match(), it already fails
> for patches other than creation patches, which check_preimage() ignores.
> This patch adds a check to check_preimage()'s rough equivalent for
> creation patches, check_to_create().
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Raymond E. Pasco <ray@ameretat.dev>
> ---
>   apply.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/apply.c b/apply.c
> index 4cba4ce71a..c5ecb64102 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3740,6 +3740,7 @@ static int check_preimage(struct apply_state *state,
>   
>   #define EXISTS_IN_INDEX 1
>   #define EXISTS_IN_WORKTREE 2
> +#define EXISTS_IN_INDEX_AS_ITA 3
>   
>   static int check_to_create(struct apply_state *state,
>   			   const char *new_name,
> @@ -3747,11 +3748,21 @@ static int check_to_create(struct apply_state *state,
>   {
>   	struct stat nst;
>   
> -	if (state->check_index && !ok_if_exists) {
> -		int pos = index_name_pos(state->repo->index, new_name, strlen(new_name));
> -		if (pos >= 0 &&
> -		    !(state->repo->index->cache[pos]->ce_flags & CE_INTENT_TO_ADD))
> -			return EXISTS_IN_INDEX;
> +	if (state->check_index && (!ok_if_exists || !state->cached)) {
> +		int pos;
> +
> +		pos = index_name_pos(state->repo->index, new_name, strlen(new_name));
> +		if (pos >= 0) {
> +			struct cache_entry *ce = state->repo->index->cache[pos];
> +
> +			/* allow ITA, as they do not yet exist in the index */
> +			if (!ok_if_exists && !(ce->ce_flags & CE_INTENT_TO_ADD))
> +				return EXISTS_IN_INDEX;
> +
> +			/* ITA entries can never match working tree files */
> +			if (!state->cached && (ce->ce_flags & CE_INTENT_TO_ADD))
> +				return EXISTS_IN_INDEX_AS_ITA;
> +		}
>   	}
>   
>   	if (state->cached)
> @@ -3938,6 +3949,9 @@ static int check_patch(struct apply_state *state, struct patch *patch)
>   		case EXISTS_IN_INDEX:
>   			return error(_("%s: already exists in index"), new_name);
>   			break;
> +		case EXISTS_IN_INDEX_AS_ITA:
> +			return error(_("%s: does not match index"), new_name);
> +			break;
>   		case EXISTS_IN_WORKTREE:
>   			return error(_("%s: already exists in working directory"),
>   				     new_name);
> 
