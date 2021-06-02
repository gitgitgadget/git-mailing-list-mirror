Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A549DC4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A796121D
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 11:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbhFBLbF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 07:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbhFBLbC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 07:31:02 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7D5C061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 04:29:19 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 65so480527qkg.12
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 04:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ktOK96fMbJBwd8HyIw4m27HfmxLCQbnf+Cahb+X79/k=;
        b=qf5pf3dESXPL6GemqQQt18dAq5gryXa3gfERb+yrJmLKCdLHepBRYar9cZ9Ly5Nrlz
         6Y+8p+puQFWZUtqxBbefHh9h0TjKER/ZKEudTl/IrFuHUhZLLOctO8f+ZaeVpPlU8afK
         5IlJqp6EEPYCYmDQlECaOo/y4RF3Rhk1rdDeqLYJU37h0IxFEA06u5idv0clEmYyeYTj
         M5dmpIgdL0w52oBANmTdbwAuk0lzBJZDki8Navj8Y1PsOQyjhRQ3z98QBga0rXwIb0Nb
         0JQNIRBxsVoQTr4pzmTovi1PT/GFx1+VU1xITLnBTYU3yjxMK6OKt3BbmY0ZWqIG/Oye
         misA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ktOK96fMbJBwd8HyIw4m27HfmxLCQbnf+Cahb+X79/k=;
        b=sRcZ0ow/TgeZx7dotJUnbOwJAR+qt4jxDw7U9zWVDioRXwA0k8EzuLo242HAqYawbh
         H4HWyUUdVWsOtqlc45R9n76HfF0JWgJpGd1EOrNEzJWf9PHf7TRBhKiPQjFKhsYY80Se
         WB9Ta2ELXUGNwduu/WGD1uVafEmWRhJlAtJwf+q22X59KDAObGwlHz5LTk94NaSpHRjD
         wGJihkXq42mHLezlPq+/oIGUmVVmgC6p7K4JCbNrVYnTigFXaA+3qwVLeG6s6GE3orda
         gRsnbXQlIxy/+SPOBMYK2kXR0cIx5D/UNjBVyOaYrY0tJCpBn5yCaHQVXxRH7PuxQf1U
         Ds9g==
X-Gm-Message-State: AOAM530cpu0qat92/PIAEZbmfy7zvP+ijBg9PYVJslcvGTeHe8eCTcy6
        nUyv6Tb8+Fvh7p4QeTSlbyk=
X-Google-Smtp-Source: ABdhPJxb/+Lb+germRqnOYjD94EXKXqMa4tJE6VCl7J2UoGMbDSO3/I0pz6GSCM4yepcadSEtYuHpQ==
X-Received: by 2002:a37:a70c:: with SMTP id q12mr2180186qke.382.1622633358903;
        Wed, 02 Jun 2021 04:29:18 -0700 (PDT)
Received: from Derricks-MBP.attlocal.net ([2600:1700:e72:80a0:e0dc:47dd:9a00:5b65])
        by smtp.gmail.com with ESMTPSA id l7sm6885878qki.135.2021.06.02.04.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 04:29:18 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] merge-ort: replace string_list_df_name_compare
 with faster alternative
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
 <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
 <c4a0f6a9510c6e57604e7b0c62b1216a4f5f5618.1622559516.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <11416fb2-50f1-ebf0-e2ca-cebe64aeeeed@gmail.com>
Date:   Wed, 2 Jun 2021 07:29:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <c4a0f6a9510c6e57604e7b0c62b1216a4f5f5618.1622559516.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/21 10:58 AM, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
...
>  	/*
> -	 * Here we only care that entries for D/F conflicts are
> -	 * adjacent, in particular with the file of the D/F conflict
> -	 * appearing before files below the corresponding directory.
> -	 * The order of the rest of the list is irrelevant for us.
> +	 * Here we only care that entries for directories appear adjacent
> +	 * to and before files underneath the directory.  We can achieve
> +	 * that by pretending to add a trailing slash to every file and
> +	 * then sorting.  In other words, we do not want the natural
> +	 * sorting of
> +	 *     foo
> +	 *     foo.txt
> +	 *     foo/bar
> +	 * Instead, we want "foo" to sort as though it were "foo/", so that
> +	 * we instead get
> +	 *     foo.txt
> +	 *     foo
> +	 *     foo/bar
> +	 * To achieve this, we basically implement our own strcmp, except that
> +	 * if we get to the end of either string instead of comparing NUL to
> +	 * another character, we compare '/' to it.
> +	 *
> +	 * If this unusual "sort as though '/' were appended" perplexes
> +	 * you, perhaps it will help to note that this is not the final
> +	 * sort.  write_tree() will sort again without the trailing slash
> +	 * magic, but just on paths immediately under a given tree.

I find this comment to be helpful.

> +	 * The reason to not use df_name_compare directly was that it was
> +	 * just too expensive (we don't have the string lengths handy), so
> +	 * I had to reimplement it.

Just a hyper-nit I think first person works great in commit
messages, as the author's name is clearly listed in context.
Here, I'd prefer "so it was reimplemented" over "so I had to
reimplement it" as the author will not be present in context.

> +
> +	while (*one && (*one == *two)) {
> +		one++;
> +		two++;
> +	}
> +
> +	c1 = *one;
> +	if (!c1)
> +		c1 = '/';
> +
> +	c2 = *two;
> +	if (!c2)
> +		c2 = '/';

While I'm making other nits on this patch, perhaps this is
an appropriate place for some ternary operators to compress
the vertical space in this method:

	c1 = *one ? *one : '/';
	c2 = *two ? *two : '/';

> +	if (c1 == c2) {
> +		/* Getting here means one is a leading directory of the other */
> +		return (*one) ? 1 : -1;
> +	} else
> +		return c1-c2;

nit: "c1 - c2"

Thanks,
-Stolee
