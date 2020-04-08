Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CE7C2D0EC
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 01:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C16206F7
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 01:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkLD1PdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDHBjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:39:53 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37624 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgDHBjx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 21:39:53 -0400
Received: by mail-ot1-f66.google.com with SMTP id g23so5271118otq.4
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 18:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gziqoAHkpCu0w3FLbtdzaggpOAFSSZ/f2lt1fZeECQM=;
        b=SkLD1PdUuX3xYK0InAag45o+ZteOtQyuH6yayTHMiUgyZtrRxh5ghXd2gyb/6Fq8h4
         jcJwOsVifAx3Vd35LUx6fEPGdS/GamL9n6yQgqhajaiye2q4+8O31TxbUP9D6jBdFkdK
         YRsQWV8La7/FE+wd3dtFozjRNC6t8MRVnvoYUP1GCta2RY8gAImWfZ077kJ3KQ0t90V9
         bRcYhsLlDnDsYo/hx7DR60lPvOJbYPazn0d8PzTOYkwowME9BcGr/2kogiaivokuQK1t
         m0MIT8hiO9zvuRwbq3vMK9/zBrN7VJIEGfqnhCyuWuSbwIWDE9rAJFGM6FXxJO6eEpf+
         Yl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gziqoAHkpCu0w3FLbtdzaggpOAFSSZ/f2lt1fZeECQM=;
        b=SuSpYRUibfqS1vNp51Y3NAOr0e4K8iOcj0A0hrlBdhBovigGnyUrAKPVXjakGioJJr
         7I7+0Nw8RXBCasSPwYgiRS4DlShIgplE/m+KFLisu6y6EoRFYM1BuV2dKsh0Cz0VAxVU
         Ofc787d7Y9gCd7pbHlj/lJglqljnKNkccoQBcdPrSel18py0lIGpFU38xNB6z9uCcZBh
         cT7spwibhdvuulFR32MwHMPg+uH0w+5f7ajqWpUyAqQrDjmRtmS+BGstXQewwZowvKyi
         /JTLLouXZG8vOjtTK07dQrwgi/bQJFGqT+adxppcwLYfrXN+Lkw0LjeBzuwOfdus/44u
         O2/A==
X-Gm-Message-State: AGi0PuZNpQANiGCWk6iv/IH3CW8rmIT24wSUkC+5+Uxxx0sc1WNNYOeC
        LxzS9XJ6GvPfUs7sPyQMmc8=
X-Google-Smtp-Source: APiQypITLaEukQ+JNeLJJ+xNu8OcDxVhayHvxBPT3hcJdMrGVtyhNHohVV9LPFUKTDtlLRny/LTjZw==
X-Received: by 2002:a9d:7e8e:: with SMTP id m14mr1000581otp.45.1586309992460;
        Tue, 07 Apr 2020 18:39:52 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id h64sm6147482oia.11.2020.04.07.18.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 18:39:51 -0700 (PDT)
Subject: Re: [PATCH] revision: --include-diversions adds helpful merges
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
 <xmqqv9mapxw9.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5f1c6868-303c-ccc1-553e-e54d0fa8e24f@gmail.com>
Date:   Tue, 7 Apr 2020 21:39:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <xmqqv9mapxw9.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/7/2020 9:30 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>     This --include-diversions option could use a better name.
> 
> True, but I do not think of a better (or for that matter a worse)
> one.  
> 
> As a new feature, I think this is a reasonable thing to want,
> especially it is in line with the push in the past few years to
> treat the first parent history specially.
> 
> I wonder how this would interact with the ancestry-path option?
> That one also, like the simplify-merges option, needs a limited
> traversal, and if this new mode can do without a limited traversal
> (in other words, the output can be done incrementally from the tip)
> and achieve something similar to what these other options wanted to
> show, that would be great.

You're right. I briefly considered the --ancestry-path option before
realizing that would get a huge set of commits (for example: every
topic based on the branch after the pull request was merged).

The --include-diversions works incrementally like simplified merges.
Based on the implementation, it would not change the results when
added to a --full-history query. This makes sense: a diversion would
appear in the --full-history results, anyway.

It is worth adding tests for the combination with --ancestry-path
and --simplify-merges, as the --include-diversions option would
add results to those queries.

Thanks,
-Stolee

