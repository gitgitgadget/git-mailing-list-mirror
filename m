Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB41DC433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821D264EC0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 02:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhBKC2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 21:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhBKC2N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 21:28:13 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2980C061574
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 18:27:32 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id r21so3825048otk.13
        for <git@vger.kernel.org>; Wed, 10 Feb 2021 18:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s5lKTuvU74b3X8xob8bLCrUi+w94Wky8Q5TwBlolnEg=;
        b=Mh3R83aO8v6pvCD/L7PrSBJfy+EvN8owaBYhCB42l7skIyZnf9XoWBQrzPA6WDfh78
         gJdBoiCeIIfnoFzKodWZlEDwhpvrhwxvQx/iGntA/dDfY4aCJEK/DyQwHkPuJsK9G58N
         DHOAJX1VVHR+4bEejonvBBpVT8LaU+Nglbi4reKbWzYyAjf4gyMK5kP5rqV/hlgHNhqg
         KAuhI2tIEAuVlaRbPr5TqYO9dwvNYGx8HvzrYNCfY/hbu+ng1Gf50aB0jxwGeJDrxA9T
         QBl1iW/tkO2IIpLBkYFqzXAM8ArpPECuWxFFY0cP97tA7UPnoOc9sz6D0K5Nb6ytVDBS
         CiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s5lKTuvU74b3X8xob8bLCrUi+w94Wky8Q5TwBlolnEg=;
        b=HYbAwTBF/Ik952FVvoEkqi0iyNaA0+WcHZLXplW4duIHwxpaobps2BZgdwQv0BvfeA
         k3qtqtlLYMzRarNYhFkJ8w0JdZ3+2Tv7Z/Z/omtWSKsUizzWeWa/pNTgiEWyfWTl48rD
         Kq9Mm3lXH3AvpwxN2s0/EspJ5UWf+I6Xe8AZYYSIINQcsGobGXMqCeOOTnwTe7JGBY6U
         hMyM9TrrdxnaTGEzxq4vx0iPiY59ibDLV1Fc3JO0PX12V4vGxcccfVAfL2uRRnzCIpem
         7kQmVBxHxub1vPnwID4hiS+gW+GS3DBbZ6Wrj0rdsMuTns98RCOTZ2ZbgNHrnEacXrjH
         7ztw==
X-Gm-Message-State: AOAM5329rVYbIv4oswa4x1mgBhlAityGHRQ9mVMCiszhuwIBALsl30mN
        PQ3hMKEZ/wYjcyjKJ7zd4zn5pLRZcZBshA==
X-Google-Smtp-Source: ABdhPJxgqdzqpSe1m4yS9LRpop7VYTEajL5kNYL9RjfiJ+Cqb0pdILSrUzqORKTJBquZAxdbfayl6g==
X-Received: by 2002:a05:6830:18e6:: with SMTP id d6mr4405542otf.251.1613010452288;
        Wed, 10 Feb 2021 18:27:32 -0800 (PST)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:5030:63f6:1d3e:64d9])
        by smtp.gmail.com with ESMTPSA id u126sm897497oig.55.2021.02.10.18.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 18:27:31 -0800 (PST)
Subject: Re: [PATCH 1/9] t/helper/test-read-midx.c: add '--show-objects'
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
References: <cover.1612998106.git.me@ttaylorr.com>
 <e36acb005d3563db772711207d2af3df03685bd4.1612998106.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7b422082-d6a9-5e64-17a0-559da7777a08@gmail.com>
Date:   Wed, 10 Feb 2021 21:27:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <e36acb005d3563db772711207d2af3df03685bd4.1612998106.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/10/21 6:02 PM, Taylor Blau wrote:
> +	if (show_objects) {
> +		struct object_id oid;
> +		struct pack_entry e;
> +
> +		for (i = 0; i < m->num_objects; i++) {
> +			nth_midxed_object_oid(&oid, m, i);
> +			fill_midx_entry(the_repository, &oid, &e, m);
> +
> +			printf("%s %"PRIu64"\t%s\n",
> +			       oid_to_hex(&oid), e.offset, e.p->pack_name);
> +		}
> +		return 0;
> +	}
> +
>  	printf("header: %08x %d %d %d %d\n",
>  	       m->signature,
>  	       m->version,

It seems a little odd to me that the list of objects happens after
the header information. Probably doesn't matter in your test cases,
but I sometimes use the test helpers to diagnose data during development
and could see piping this output into 'less' and wanting the header
at the top.

Thanks,
-Stolee
