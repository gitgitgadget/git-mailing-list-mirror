Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B492C433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 14:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E78E820772
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 14:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ui+8vjiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgFDO1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgFDO1l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 10:27:41 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBD0C08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 07:27:41 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e16so5375853qtg.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 07:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3DSe0bXxTEkMtFBzuW1G2k1klz9vMWKFnKPjvw7qNU0=;
        b=Ui+8vjiTBE4AKWfuji2I4eZ06kidtuiL4Nl296UyvImcQmuoVpfnNqzuVUi2Ev5kGH
         w/NW3/wLifH/NEqqwZNU2MOzgo3o1k6Q11rqs+sk28m6CoE1q4dDe+SlNttf4HJrMdoX
         hcWuCASOVN6x1q13PP+WFjV8VhKVw968qGhXmCusRoOoPJUkRolyLhXEGmQoRkonlYO5
         7FjJeqZGCZVNdpcl68M+LNUdt9Q7GcnyvICpvZ2Uet9A+pn5+kfwmtt5FT9om5R5eZNH
         an3fPiB6pNDvzRofCBp8vB9QVXKgDvmsBcFVBR53w7w5em6UtJwfw9O3oStgwNNKR+e2
         PaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3DSe0bXxTEkMtFBzuW1G2k1klz9vMWKFnKPjvw7qNU0=;
        b=KPufUWBPyrJCIbAxWeqiu+bx45G8PnDNqRKRMc6SPgE92dIsU55MIyrKptLxWE/Cea
         zkpGJ1MnlAMNV0YpEaTaG0IjEdWlzSxvyjLMaOGuCZrN8LW25PeVsnVwu3UmZA1HljgD
         9qDKZRsovsbhywNHmycJLjQSZRS+ynwAT5Zg/i39BGrng1kc90uQQFjOxt+MDQFhwrTw
         uJqJQJpIzRLW4tVHPSqc1UwBoWuVLoAg8PlbM2YstB/gpnlLNoSzg7qs1+X5Inkmmtro
         AHfqZGqGS4Rll6KmatHUlF1HKtL2h0qnLbmO0yokRxJPgoSTipisXcQRXeIxpvw8d+dH
         el+A==
X-Gm-Message-State: AOAM531lYeTHFxZxjwsKokE8i6/3yBmAeJXVJ4ITaOVArXYrWCQ8HhCk
        tlsrjCekx8hcXInjv0MR8OT1gtf0W1U=
X-Google-Smtp-Source: ABdhPJwNRPdQ6Qe2cSXyHQC63+LCA1Qba/iggu5eKCTSKRn2le0r2FIT5/l0vp+4yOGyn4CDf8Hcxw==
X-Received: by 2002:ac8:7052:: with SMTP id y18mr5014851qtm.165.1591280860337;
        Thu, 04 Jun 2020 07:27:40 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id v3sm4479878qkh.130.2020.06.04.07.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 07:27:39 -0700 (PDT)
Subject: Re: [GSoC Patch 2/3] commit: convert commit->generation to a slab
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org
Cc:     jnareb@gmail.com
References: <20200604072759.19142-1-abhishekkumar8222@gmail.com>
 <20200604072759.19142-3-abhishekkumar8222@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9a15c7ba-8b55-099a-3c59-b5e7ff6124f6@gmail.com>
Date:   Thu, 4 Jun 2020 10:27:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200604072759.19142-3-abhishekkumar8222@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/4/2020 3:27 AM, Abhishek Kumar wrote:
> In this commit, we will use the generation slab helpers introduced in
> last commit and replace existing uses of commit->generation using
> 'contrib/coccinelle/generation.cocci'
> @@ -1048,7 +1048,7 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
>  		else
>  			packedDate[0] = 0;
>  
> -		packedDate[0] |= htonl((*list)->generation << 2);
> +		packedDate[0] |= htonl(generation((*list)) << 2);

nit: We no longer need the extra parens around *list.

> @@ -3414,8 +3414,8 @@ static void init_topo_walk(struct rev_info *revs)
>  		test_flag_and_insert(&info->explore_queue, c, TOPO_WALK_EXPLORED);
>  		test_flag_and_insert(&info->indegree_queue, c, TOPO_WALK_INDEGREE);
>  
> -		if (c->generation < info->min_generation)
> -			info->min_generation = c->generation;
> +		if (generation(c) < info->min_generation)
> +			info->min_generation = generation(c);

A pattern I've noticed in several places is that the struct
member is accessed multiple times in the same method body,
and this is auto-converted to multiple method calls. However,
these values are fixed, so it would be better to store the
value as a local variable and reuse that variable instead.

This is one of the shortcomings of the Coccinelle transformation,
so you'll need to manually inspect each of the diff fragments to
see if we can reduce the number of method calls. It might be
helpful to do that as a follow-up, so we can see that this patch
is generated by the Coccinelle script, and then a later patch can
be scrutinized more carefully when you are doing manual code
manipulation.

Thanks,
-Stolee
