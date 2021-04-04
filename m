Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5C1C433ED
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 05:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B0336135F
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 05:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbhDDFRO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 01:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDDFRN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 01:17:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFC5C061756
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 22:17:09 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso4330838pjb.4
        for <git@vger.kernel.org>; Sat, 03 Apr 2021 22:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=3ZHD3erzezUm99ATfgmhQVFogLBwraMiObodGIk31RI=;
        b=iD03hzR75BB64ee+o+KEaoBHsxCC/XcxU/g2EVKfftZAXw7D89XYekN7wFgfLRaJsG
         q7rLQp7jPb51ghl7Yhis9FO+w3cM1TCLaEJ+nZaMpbMQTt8CUWYeok+f9ShXGlNil9u+
         dQxiQ8fzN2siH/zR5/ZDkK0zobVOIlYFPfls/43aGnmZoYJrJ1vWrQ5mfRQJEpXLje3G
         n30x6Hc3pyOLG3I42oBldtoTdseSK7WKTAxzv9rgjYeeHfqG7mNoliUVPni97ldCSgXu
         0OXnfjy+/S0bXJR75yeq7dvo2q3vwGhOxM0Kw+5a5yCC/KNoGBlUkskKwPg8bVoTlMBH
         j41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3ZHD3erzezUm99ATfgmhQVFogLBwraMiObodGIk31RI=;
        b=conQyTkoVNV8ZcY1f5kCXRKEe4Xq6rAFexU7E//U+0Vs+YQeBC7i5AfHdn+rKsoe9B
         8ud/9yZ5+jgnY4FBAD6mI+0cOZJhWK0WyieXuAluHcXdtUmCEWl0h9EXTLaDvYwbiWeI
         sfElaXZB6uwnQtIWVUv/YQsHo82w2JEIDEMTnqC0Vt2rtbnxYgrmCyPgPSZl5zM64G4u
         XueggOAsdxSWJHSPuWo0fP/ffJovYjZckmOYzveGb3vLRjMlVLzjYdu0Yso4ovvbqsjC
         RxiyJDdv4P0hX8nAL9MPftFqM+/emcPzeS3qPFIQ5EjBxm1J6nSukdmD5Y6gLt59ONPi
         xh0w==
X-Gm-Message-State: AOAM531ESCmhfKbO/ZmlXfB46aHBOfE0B/fCLpgwKJtuFQHkbJp3YlAa
        2+cGUUyL9pqq4U2ooXNl0TUKM9x543kfdFXmcwI=
X-Google-Smtp-Source: ABdhPJw7Aq+9jjjHi3DcGK9mXlqzAb2/i2D3IG3f2AOuPi63ymKlg7dNqAvv5qzbqvulYCXSZI1m/Q==
X-Received: by 2002:a17:902:9f85:b029:e6:f010:a57e with SMTP id g5-20020a1709029f85b02900e6f010a57emr18649609plq.61.1617513428770;
        Sat, 03 Apr 2021 22:17:08 -0700 (PDT)
Received: from [192.168.10.22] ([103.77.186.50])
        by smtp.gmail.com with ESMTPSA id q205sm13334224pfc.126.2021.04.03.22.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Apr 2021 22:17:08 -0700 (PDT)
Subject: Re: [PATCH v3] cache-tree.c: remove implicit dependency on
 the_repository
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <pull.915.v2.git.1616772930098.gitgitgadget@gmail.com>
 <pull.915.v3.git.1617465421353.gitgitgadget@gmail.com>
 <xmqqpmzazund.fsf@gitster.g>
From:   Chinmoy Chakraborty <chinmoy12c@gmail.com>
Message-ID: <92e1255b-f058-04ef-1901-90cc7d7fb979@gmail.com>
Date:   Sun, 4 Apr 2021 10:48:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <xmqqpmzazund.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 4/4/21 7:19 AM, Junio C Hamano wrote:
> Nothing else needs to be said.  The update-main-cache-tree is a thin
> wrapper to work on cache tree for THE MAIN in-core index instance,
> so it is natural if it needs to pass r and r->index, exactly because
> the latter is THE MAIN in-core index instance for the repository.
> That is too obvious that it is best left unsaid, for the same reason
> why you shouldn't even mention what you did in updating the use of
> update_cache_tree() inside unpack_trees().  There is nothing notable
> in there.
>
> cf. Documentation/SubmittingPatches
> [[describe-changes]]
> [[summary-section]]
> [[meaningful-message]]
> [[imperative-mood]]

Okay, I'll update the message. Thanks for the review.


>> This commit also fixes the `sparse-index.c` file in which
>> the `convert_to_sparse()` and `ensure_full_index()`
>> method use `cache_tree_update()`.
> What branch did you base this patch on?  There is no update_cache_tree()
> call in sparse-index.c on 'master' (well, there is no sparse-index.c
> in 'master' to begin with).

Actually the patch hit against a use of `cache_tree_update()` in

the branch 'ds/sparse-index', so I was suggested by Derrick Stolee

to rebase my work on to of his branch.

You may view the discussion here:

https://lore.kernel.org/git/f187df01-8e59-ac74-01e1-586a7a63fd4e@gmail.com/


> And if you are building somewhere other than the tip of 'master', it
> is necessary to say where, in order to save confusion and wasted
> effort for your readers.  E.g.  "This patch was made on top of
> merging topic 'X' and 'Y' into 'master'".  Then you'd only have to
> wait for 'X' and 'Y' to graduate to 'master' before the topic can
> proceed.
>
> Thanks.

Should this information be added to the commit message

or just the cover letter of the patch?

