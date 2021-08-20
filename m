Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CD3C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC85160BD3
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 15:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241089AbhHTPhj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbhHTPhd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 11:37:33 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8C1C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:36:54 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so14569875otf.6
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 08:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mLl8scm0ok8QH8+vBxTFUahLzCnes7xN14YfztK3ATo=;
        b=SEWwQvS0yWG3/fnShsaSykv5HG0xbaCSdB3t3q2MeaIz065KZkHDoL+KO66W25Cn+t
         hLVhGzdlAcTJWdLZTol51Ha42nupRDo5kcPa1a7QWVxR6LxpLQ3f7TOI9wRnguYNJztB
         bdqUckPZnBOf9eMODTvQ9p3wmdqnFnKuEOJ/kG8yEvfuJ/gDCYtP6vB+KIyormFBlUQB
         gZ+zwhq2AfvEPiD4jbr2n1V67ByGTq6CpFaQ9noSd7wVj6BW1VGZC+XrBMp0ouP/aUL3
         lXlRV9uOLzN+vZZfgZjUaHTk2ZLdkrI+Rir82QuWzyLA8iWIdLiNX92AM9hHe8ux6xgy
         arDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mLl8scm0ok8QH8+vBxTFUahLzCnes7xN14YfztK3ATo=;
        b=qd/XB+EdbwGpmIVsLuxikdYnglEtGLwNEHL/AdY8i/Oihy4J+iQI/npzmXwSxo//Np
         5aaSK5j7fXCAS2a82JUf5BYhKaprR7iIpOYD+dJVcKLfywdnWCStBvgAvPOowu428g5p
         g12n/Q9h0zKFmPNFY+N8I3as4de40+0rLnZrXY8PpWO+IyGcO87XzxvIgTIW+jdIqg0r
         j5WXYVy112JgG7AMMg00GLC2EvViQOx9cLwESTz6J5Eio489PVKEnRhdOUIBL+Kup80o
         rDc01I94O/3bTKtvw0CVvPruQ4X3/bFFC45NrBtKtS8jUHXlaxxaRwkZzJGa88j5NG2Y
         owBQ==
X-Gm-Message-State: AOAM531HFhSRw3kD3r9TreXwxyNzJdZwnZvKuXWcYc4EKqwUELactdMz
        Nz517opZnUBJRFCOSmUaC2E=
X-Google-Smtp-Source: ABdhPJyxZUzdPcQ9oG8cXcWzGkyH9hnUe9onq03B2ik5kkqIZam4bv8nln6RLT7dCWbp4L5oH76H+w==
X-Received: by 2002:a9d:6490:: with SMTP id g16mr17500949otl.184.1629473814060;
        Fri, 20 Aug 2021 08:36:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f436:fc6f:2dd3:d49? ([2600:1700:e72:80a0:f436:fc6f:2dd3:d49])
        by smtp.gmail.com with ESMTPSA id m15sm1416910oiw.18.2021.08.20.08.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 08:36:53 -0700 (PDT)
Subject: Re: [PATCH v3 6/8] attr: be careful about sparse directories
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        matheus.bernardino@usp.br,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
 <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
 <c9e100e68f80196a35a37b5d0aad74e8e1174766.1629206603.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2108191008160.55@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b101db8d-0156-c90a-1324-e916c0a3b979@gmail.com>
Date:   Fri, 20 Aug 2021 11:36:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2108191008160.55@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2021 4:11 AM, Johannes Schindelin wrote:
> On Tue, 17 Aug 2021, Derrick Stolee via GitGitGadget wrote:
>> +	/*
>> +	 * In the case of cone-mode sparse-checkout, getting the
>> +	 * .gitattributes file from a directory is meaningless: all
>> +	 * contained paths will be sparse if the .gitattributes is also
>> +	 * sparse. In the case of a sparse index, it is critical that we
>> +	 * don't go looking for one as it will expand the index.
>> +	 */
>> +	init_sparse_checkout_patterns(istate);
> At first I thought that `init_sparse_checkout_patterns()` is called by
> `path_in_sparse_checkout()` below, and therefore would not be necessary.
> 
> But it is! Without it, we have no way to test whether `use_cone_patterns`
> is set, because, well, it gets set by `init_sparse_checkout_patterns()`.
> 
> Would it therefore make sense to refactor the code to have a
> `path_in_sparse_checkout_cone()` function? Or add a flag
> `only_in_cone_mode` as function parameter to `path_in_sparse_checkout()`?

One way to clean this up as-is would be to replace
 
>> +	if (istate->sparse_checkout_patterns &&
>> +	    istate->sparse_checkout_patterns->use_cone_patterns &&
>> +	    path_in_sparse_checkout(path, istate) == NOT_MATCHED)

with

	if (!path_in_sparse_checkout(path, istate) &&
	    istate->sparse_checkout_patterns->use_cone_patterns)

to get a similar effect. However, it creates wasted pattern-match
checks when not in cone-mode, so you are probably right that a
path_in_cone_mode_sparse_checkout() would be best to short-circuit
in the non-cone-mode case.

This special casing should be rare, so I don't think it is worth
adding a flag to path_in_sparse_checkout() and making those call
sites more complicated.

Thanks,
-Stolee
