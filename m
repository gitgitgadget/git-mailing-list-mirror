Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB67EC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACCB260EBC
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 14:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbhG2O6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 10:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhG2O6d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 10:58:33 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5280C061765
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 07:58:29 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id x3so6216583qkl.6
        for <git@vger.kernel.org>; Thu, 29 Jul 2021 07:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KsH3FEeAv8x6Aoid1SS7IGAioBOpxMKmyRvn3zBipHc=;
        b=k5+iQhXYHfyr1VghLepiPgdVBlTvV6O4hIpwfxImUI3aQh90K9iTg87b1e/PmiO7AF
         Dg1QsMZVXywouuph+kaIr2Hafd5gJ5quK7c52/x7f8WXD9ce5gFYQse6Utr+A7UUByjY
         qQ9kM4nZb6f2GHOqerGb//VZxaAoIfx7Tx/UeSAJx3ekay4u6TWnvD5i/6vT0Bcnam/s
         v5FEuemhhVA+R4T/rNHgVfqpVq2QklNA1uRbm4z4PBlM+Q1oI7SCgno0d25GZ0TOTGik
         lWUEr+ruEghDU0v/l65+522JvIo/TVVsh/Gx1SlQFfznXRhGE3ZtEdoqZjcp7MpryQ/s
         dQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KsH3FEeAv8x6Aoid1SS7IGAioBOpxMKmyRvn3zBipHc=;
        b=pLB/R1Cgi9cgH4a2ti8rrGdqQCaUowBB5no+QfB3b3Ox+Cd79d1Qw9YSzGTFkAr7oO
         H7NhIqhBA9oDbYVhQcsuJ7xmobFI1TfLGlLtxegaS+HvO3rQIFv89bFfCVtmmjX0kr1f
         4euMalJRG7Vzo1NaLk9swD8T8PV+ry2Q3poEbDod9zIMqhvbnChS75++mAZfbKKIN/KI
         MSCQjHH5J08GRtXRH2O6CZTJY6IYmIzxpY0JkBYLobNw9zKfh172j98+z6xDAhOF7KJp
         ZezYyU8JmV9AvGVyKmJ1dJz6Hf2I7Nz5rAqrFbIuN0CqSWiVO49r76bftPufXU1L017z
         2ImQ==
X-Gm-Message-State: AOAM530FhO+bqX+omXQSZyl8jDnD+2Q5qPjEhOu+OFVFO7HL3aNVdQf8
        iWuHCGPl0Eg0qMLdvUSdHzU=
X-Google-Smtp-Source: ABdhPJwqVLmH0ENbFMylzIgLEqIbMzrSlqzqFHLZoWn6EreBN5d3unLr5dvaYrgXjEcFAKkMMaj/fg==
X-Received: by 2002:a37:2d04:: with SMTP id t4mr5550145qkh.463.1627570708765;
        Thu, 29 Jul 2021 07:58:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:444a:5a21:a4e5:7d54? ([2600:1700:e72:80a0:444a:5a21:a4e5:7d54])
        by smtp.gmail.com with ESMTPSA id q11sm1780485qkm.56.2021.07.29.07.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 07:58:27 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] Final optimization batch (#15): use memory pools
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
 <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <629ee63a-4585-be6f-d8f3-28944bbc7ace@gmail.com>
Date:   Thu, 29 Jul 2021 10:58:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/28/2021 11:58 PM, Elijah Newren via GitGitGadget wrote:
> This series textually depends on en/ort-perf-batch-14, but the ideas are
> orthogonal to it and orthogonal to previous series. It can be reviewed
> independently.
> 
> This series is more about strmaps & memory pools than merge logic. CC'ing
> Peff since he reviewed the strmap work[1], and that work included a number
> of decisions that specifically had this series in mind.
> 
> Changes since v1, addressing Eric's feedback:
> 
>  * Fixed a comment that became out-of-date in patch 1
>  * Swapped commits 2 and 3 so that one can better motivate the other.

Changes look good to me. Thanks!
 
> Note: Stolee also had an interesting question about whether we should tweak
> the mem_pool_*() API; he and I were both worried it was a bit much, so I've
> left it out unless others on list chime in with their opinions on that
> change.

This was mostly a thought experiment on my part. There is no need to
decide one way or another in this series since it would be easy to
adapt what you have here to match a change to the mem_pool_*() API
if we thought that was a good idea. (Still not sure it is.)

Thanks,
-Stolee
