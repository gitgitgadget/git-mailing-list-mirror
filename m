Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FE8E95A8E
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 09:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345985AbjJIJ6R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 05:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345964AbjJIJ6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 05:58:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E599C
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 02:58:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b2cee55056so789970066b.3
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696845493; x=1697450293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VBncQ491THWwMSunG3g2GULi5+wEVWo/su0NakPjLZc=;
        b=mWBMXuf3zx7MqjrNa2/sngg6OjYsLGI7VB/VOvp6jslCrfbn37YfgTCioxAQIFYiU1
         AEh+eQM8UexMIr5DJdFhNDQdCmUfRldtETI1EcJzD4llbWc8yaiWnRR26ms7g24zYJuh
         /kh0XOU/Bo+m0KyhoFEZgRns4J5UJC5GmxTw0icB6HmAlETXMzjmWlGR+qpJ47fDxR84
         a+NCWmjkfttTplgKH9uh7cx7XLBSdW2kVWHlpxYg4tY/toTQIvVHGXYKqgjsQ4HSwTRt
         sEGZitiP868bmHnj4YxQaeyay9h4ozO5ou/sVu7RPiSgpZIqKW/nFGVWJuU8bArjDLyS
         G34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696845493; x=1697450293;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VBncQ491THWwMSunG3g2GULi5+wEVWo/su0NakPjLZc=;
        b=peFnRil6R8ajmUDntdZX3kBPd+s47xLQuM65jCK/iKSvnQnvP/AE1cEUwPQnWkSyFM
         +ytmX4FDChXRtJKlqTAfTzOHpCoejsCNFOJ/1WTzktB4XiYF8/j7nzBP6pBXafiooHkd
         fW3a7sP3anHh0pb33KZnKDM7qqsvz9VDGImSu2Q0Uy+DZbj8wINNe+5RueezBoosWA01
         VgZEaMsBFhYINmcoVKxlWyiVC4DJ4Oak6uRz5puY/m5NOA9WWiIKjspzbCFFsGsOkkDG
         d9qUqZ7pmIjRY2uV9P2htEENeQaEwbuT3rMm+QpgX2B3/trIenqdR3sVn7ha4qe4HOY9
         7WkQ==
X-Gm-Message-State: AOJu0YzDgU8s3XPRzHpu6hGGkJz+ggX9/iUIutTDfBQJFLNskDyqb4yJ
        mA1k98s8ey/+oJIPwQuqBO2iMgdXGF4=
X-Google-Smtp-Source: AGHT+IEullrwGhAEIk1RZURNS6FHX/MALe4HHdzw0Iu4k9Y91xuOeRI0S8VN1NH1xogUjxAxReHrJw==
X-Received: by 2002:a17:906:3298:b0:9ae:701a:6efa with SMTP id 24-20020a170906329800b009ae701a6efamr12218936ejw.69.1696845493049;
        Mon, 09 Oct 2023 02:58:13 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id ce24-20020a170906b25800b0098669cc16b2sm6504405ejb.83.2023.10.09.02.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 02:58:12 -0700 (PDT)
Message-ID: <a482d047-dd40-436d-8daa-0c74780af11f@gmail.com>
Date:   Mon, 9 Oct 2023 10:58:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6] merge-tree: add -X strategy option
Content-Language: en-US
To:     Izzy via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Izzy <winglovet@gmail.com>
References: <pull.1565.v5.git.1694853437494.gitgitgadget@gmail.com>
 <pull.1565.v6.git.1695522222723.gitgitgadget@gmail.com>
In-Reply-To: <pull.1565.v6.git.1695522222723.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/09/2023 03:23, Izzy via GitGitGadget wrote:

Thanks for updating the patch, sorry it has taken me a while to look at 
this.

> From: Tang Yuyi <winglovet@gmail.com>
> 
> Add merge strategy option to produce more customizable merge result such
> as automatically resolving conflicts.
> 
> Signed-off-by: Tang Yuyi <winglovet@gmail.com>
> ---

>   static int real_merge(struct merge_tree_options *o,
> @@ -423,7 +425,7 @@ static int real_merge(struct merge_tree_options *o,
>   {
>   	struct commit *parent1, *parent2;
>   	struct commit_list *merge_bases = NULL;
> -	struct merge_options opt;
> +	struct merge_options opt = o->merge_options;

Copying struct merge_options by value here is unusual in our code base. 
I don't think it introduces a bug (there is no function to free the 
resources allocated in struct merge_options so we do not end up freeing 
them twice for example) but it would be clearer that it was safe if you did

	struct merge_options *opt = &o->merge_options;

and updated the code to reflect that opt is now a pointer or just 
replaced all uses of "opt" with "o->merge_options"

> +	if (xopts.nr && o.mode == MODE_TRIVIAL)
> +		die(_("--trivial-merge is incompatible with all other options"));

This is good, thanks for adding it.

> +	for (int x = 0; x < xopts.nr; x++)

This is not worth a re-roll on its own but as xopts.nr is a size_t we 
should declare x to be the same type rather than an int.

The tests are pretty minimal, ideally we would check that "-X" works 
with "--stdin", that it is rejected by a trivial merge and that one of 
the other strategy options works.

Best Wishes

Phillip

