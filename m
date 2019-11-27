Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA283C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 14:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DBF2084D
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 14:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIPAm/up"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfK0OZN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:25:13 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43398 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfK0OZM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 09:25:12 -0500
Received: by mail-qk1-f193.google.com with SMTP id q28so668368qkn.10
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 06:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G0PP498FsqOfz2+7lJoYXm/NuI9r6Xc6XnsWBmW8VeA=;
        b=nIPAm/upNYSaz4o/QS2ZkcR47Z1iUKTm+X+UkFV+Eb2mXklh8Q93YT2M3nIbO7OB8y
         XpgbKLKu+fOGrWMkmp4Yg+wgrU3IimsEPharI6lqTORKq1BngQVMqf/fJCyiJlH0ZXpn
         8hiIER7MdsO7FePnh1aOE2MECVZSRahCeOXYxl0SqDhI44Jy+RsJQK82gFSRbcPRWTi8
         NLUY0ANenpmwYpy5HcbwTL4ug4PIQrlJDEccGMx+NDWn6q3uVn8GmjdlltroznDMTRIq
         ouFVylrr+NiC1sTv5Wj148DygXcJo4AVnu6MryjjkGkQ3Zusz11seOMJPu+AVpvWYrbO
         Izlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G0PP498FsqOfz2+7lJoYXm/NuI9r6Xc6XnsWBmW8VeA=;
        b=nETEQqE4JieGqMHyMAdD1pyuCgvav6FnwFTJ/2HAoFtv0tZvXDw8EKISPudsXhh0Nj
         JadcpAxYQlMlTlBEVJlehXFoEOv+DENnwKFI3RCiZQpdDEBjIdGuwdBwPBe/xyvf4siW
         1460mAbYiS0AJ2XXRjjMYTMRmm8FKdGwX9M3ttWzYF5W5ofYj/JrDUlzl4wXLoCvH4cW
         OhpoHui6ns+Uj+wCyhXT9Csebea/263d/4wLoTAZ5toHZ6JWD3qwjygPNCFFkr43tU8+
         evWfpodOJhL9w2qihT6mJWH1wvcGd/d7wZVqmhy9eyGMZXMbzrUpdtcc5P38inQlkSvQ
         uItQ==
X-Gm-Message-State: APjAAAUDclqP3/yh+kH4xbCFLMzcvgYSzlqj384mhwl2vSHsa+wQTYPJ
        PFxVP179ujyTEQ0nNzIU4A4=
X-Google-Smtp-Source: APXvYqx+eM6C7ExtNVDpam8HZhs5gy6l1BD/7Bp1oo5BgIHIDXIvFUQPk1itclA0x515XABy0zLhEA==
X-Received: by 2002:a37:aaca:: with SMTP id t193mr4228617qke.489.1574864711616;
        Wed, 27 Nov 2019 06:25:11 -0800 (PST)
Received: from [192.168.1.3] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id l34sm393399qtd.71.2019.11.27.06.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 06:25:11 -0800 (PST)
Subject: Re: [PATCH 2/2] revision: free topo_walk_info before creating a new
 one in init_topo_walk
To:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <20191122083704.29267-1-mh@glandium.org>
 <20191122083704.29267-2-mh@glandium.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <46c47a21-d0e1-296f-5563-ae29597f995c@gmail.com>
Date:   Wed, 27 Nov 2019 09:25:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <20191122083704.29267-2-mh@glandium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/22/2019 3:37 AM, Mike Hommey wrote:> diff --git a/revision.c b/revision.c
> index 765a56ae33..7e23c5ed08 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -3211,10 +3211,26 @@ static void compute_indegrees_to_depth(struct rev_info *revs,
>  		indegree_walk_step(revs);
>  }
>  
> +static void reset_topo_walk(struct rev_info *revs)
> +{
> +	struct topo_walk_info *info = revs->topo_walk_info;
> +
> +	clear_prio_queue(&info->explore_queue);
> +	clear_prio_queue(&info->indegree_queue);
> +	clear_prio_queue(&info->topo_queue);
> +	clear_indegree_slab(&info->indegree);

In general I like this change. I'm happy that this was split into a
method instead of crammed into the block of the "if" below.

> +	clear_author_date_slab(&info->author_date);

The only issue I have is that the author_date slab should not be
cleared. That is used by more than the topo-walk AND the values for
author dates will not change between subsequent revision walks. Just
drop that line and we should be good to go!

> +
> +	FREE_AND_NULL(revs->topo_walk_info);
> +}
> +
>  static void init_topo_walk(struct rev_info *revs)
>  {
>  	struct topo_walk_info *info;
>  	struct commit_list *list;
> +	if (revs->topo_walk_info)
> +		reset_topo_walk(revs);
> +
>  	revs->topo_walk_info = xmalloc(sizeof(struct topo_walk_info));
>  	info = revs->topo_walk_info;
>  	memset(info, 0, sizeof(struct topo_walk_info));

Thanks,
-Stolee
