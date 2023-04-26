Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4E9C77B60
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 11:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240466AbjDZLNV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 07:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjDZLNU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 07:13:20 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7A249D5
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 04:13:19 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54fe0146b01so83023737b3.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 04:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682507597; x=1685099597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3sutbFG/x/HHpFGaR7jTUO54eIYQ8r1aTX3NeCdTNlo=;
        b=hd1DqsonBeuYP6MrQ0Z54RkVDZOtEfIxkO2rJt9f54FdVNAQvCUwhisW6m6YYFJM4g
         /kdvKxg0u1zFHASKCTrA3mlJcLzIEfyq24SRBLxJLb3eK8xgxKBdmys5xMTbJcOG/xA8
         Qhjniy9PhybzpUE/maA7XUYFJljLc2i95z60XuOEuiKpImHFG/4WdnDtpqTdryIlY4Ch
         BqQEjxC7lYZECWujF+n4uzthR2SlvJHUv6ViYHLcWsL5nM2WYVO00Eke0CnNWADfXV/n
         F2h00AmG+kvblRfVZq+GfpvHQhqJhrICTRmbaLDPRm6erT4YY1C0725TQB7GOKz05K8g
         UISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682507597; x=1685099597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3sutbFG/x/HHpFGaR7jTUO54eIYQ8r1aTX3NeCdTNlo=;
        b=Z4Wl9C4TfYIUvnGo3HpZ/KSd7cMqvw3eVg6vnMsS7Xu/4fiQFWC3RT/oO1kKHiX5Xb
         urL+Ij8v/ZwvJoiodhjTiVNdLA7ciAyJi/G3z2M+GtWDiMBjOgh/UQox/CwWr5Cg51wh
         RmPU6vn28ekYSRI6ZPT1vEKMNJGDmJBe8r5pyif5U/WBVVHqxiFhvd08HsqKqyWfmqOb
         Dp/SpeWUDoR4xQFT4XKHQi/lcVndHwrJM2838FmyQchjCxNRsRiM2T/uFg9hGizeQ7Tc
         Y77wbnD//0RfWABdKz+cyoDDbbJJtP87CK7FwQo3/lhgDOkj8iVEHEWvD+c1i1rpXimB
         zMtA==
X-Gm-Message-State: AAQBX9ewvFakEsZFgA5yL3aZtQnQ799RDD5DgAPbeV82xX1XH+/gOIJB
        RIZBAEyseLuabwiA9uu1SRP8
X-Google-Smtp-Source: AKy350ZKZXRZDjey0TpIjih6w9AB0jmNBWAhT250a2OvEkGlLuBUNqHWdtTD4z3Z8L4U98R1NJCg/A==
X-Received: by 2002:a0d:ea48:0:b0:54f:8d75:372c with SMTP id t69-20020a0dea48000000b0054f8d75372cmr12276154ywe.33.1682507597174;
        Wed, 26 Apr 2023 04:13:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8842:abce:33e9:20d2? ([2600:1700:e72:80a0:8842:abce:33e9:20d2])
        by smtp.gmail.com with ESMTPSA id y68-20020a0def47000000b00545dc7c4a9esm4123700ywe.111.2023.04.26.04.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 04:13:16 -0700 (PDT)
Message-ID: <bf45bfe7-4a29-38d6-b8d7-811581aec82b@github.com>
Date:   Wed, 26 Apr 2023 07:13:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] negotiator/default: avoid stack overflow
Content-Language: en-US
To:     Han Xin <hanxin.hx@bytedance.com>, git@vger.kernel.org
Cc:     xingxin.xx@bytedance.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>
References: <20230424022318.80469-1-hanxin.hx@bytedance.com>
 <cover.1682473718.git.hanxin.hx@bytedance.com>
 <935be72eb92cd2eda7aff43c8cc2306b78b2a146.1682473718.git.hanxin.hx@bytedance.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <935be72eb92cd2eda7aff43c8cc2306b78b2a146.1682473718.git.hanxin.hx@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/26/2023 12:05 AM, Han Xin wrote:
> mark_common() in negotiator/default.c may overflow the stack due to
> recursive function calls. Avoid this by instead recursing using a
> heap-allocated data structure.
> 
> This is the same case as [1].
> 
> 1. 4654134976f (negotiator/skipping: avoid stack overflow, 2022-10-25)

We would typically write this inline, such as:

  This is the same case as 4654134976f (negotiator/skipping: avoid
  stack overflow, 2022-10-25)

> -	if (commit != NULL && !(commit->object.flags & COMMON)) {
> -		struct object *o = (struct object *)commit;
> +	struct prio_queue queue = { NULL };
> +
> +	if (!commit || (commit->object.flags & COMMON))
> +		return;
> +
> +	prio_queue_put(&queue, commit);
> +	if (!ancestors_only) {
> +		commit->object.flags |= COMMON;
>  
> -		if (!ancestors_only)
> -			o->flags |= COMMON;
> +		if ((commit->object.flags & SEEN) && !(commit->object.flags & POPPED))
> +			ns->non_common_revs--;
> +	}
> +	while ((commit = prio_queue_get(&queue))) {
> +		struct object *o = (struct object *)commit;
>  
>  		if (!(o->flags & SEEN))
>  			rev_list_push(ns, commit, SEEN);
>  		else {
>  			struct commit_list *parents;
>  
> -			if (!ancestors_only && !(o->flags & POPPED))
> -				ns->non_common_revs--;
>  			if (!o->parsed && !dont_parse)
>  				if (repo_parse_commit(the_repository, commit))
> -					return;
> +					continue;
>  
>  			for (parents = commit->parents;
>  					parents;
> -					parents = parents->next)
> -				mark_common(ns, parents->item, 0,
> -					    dont_parse);
> +					parents = parents->next) {
> +				struct commit *p = parents->item;
> +
> +				if (p->object.flags & COMMON)
> +					continue;
> +
> +				p->object.flags |= COMMON;
> +
> +				if ((p->object.flags & SEEN) && !(p->object.flags & POPPED))
> +					ns->non_common_revs--;
> +
> +				prio_queue_put(&queue, parents->item);
> +			}
>  		}
>  	}
> +
> +	clear_prio_queue(&queue);

Thanks for this version. It looks like an identical set of actions
in the commit walk, but the change from DFS to priority queue is
a welcome change.

-Stolee
