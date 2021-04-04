Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AC8C433B4
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 05:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21E4861262
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 05:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhDDFKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 01:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDDFKR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 01:10:17 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B96C061756
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 22:10:11 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c204so2413934pfc.4
        for <git@vger.kernel.org>; Sat, 03 Apr 2021 22:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=ajLEEh8WlLfLTS62I+vxPAPzWF3fcu+k15Nbs02Q3gA=;
        b=nwP0++kyFujSHBWm/SZ10tkoHcyjlvQScvlsNWw9cJNOdzo1wmg5b4dGoSFt6LhRLc
         Yf6KqwOMDfgZ5jJ7It2qQU7//XS9c9mWIsn/hNCz54YyMbO3yd8Oh5ANYGZhyS97X6An
         p/bjzEGBNh/JKKyXRTprlxptghPaYc/zw7cQE2UI0apPRu+h6gMgqbVIv68EsA2ed4fb
         I3jMdHedAF52MD5cj1V9GR6eOvHplREeALT9qnUJRtKbdng+Zzo06IvjlKFs/Qbkx6N2
         hsG7e0X0Dd7lXJj+XyqofdNdTUU78fHEKpFFxga+AUcbOik+2J7aFij7RpwnzDI0yNVP
         arUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ajLEEh8WlLfLTS62I+vxPAPzWF3fcu+k15Nbs02Q3gA=;
        b=uT59EZ7oe82IeeD0gHiVKCjD+zpRowSSjvewcnzBTNtBUb+dy/TSQ4muGVkXFd14Jz
         /yIgjeZHKxkIq42KlJFP+rgAZuwYJqJQX8pOCrepgXbPXUp6OH64b/xAZLmrqEKgleQb
         RTncC6ccEby9T0axfLykWcp/KMcq6+QzKLNR42v2YNJY+zNP/I3TwaJF9IJvzTJ47VK+
         fL1g35cVVesxzbbUeg7CK8HQlYwiHD+v1wd6wVHnlvDiPMq+n88M/4D+oS6VPj0Wn1An
         h6NXFgoPbMu/b90TXceIInzRJRPMeqqNz6Eey0BahPzbn2qhTDczXonlNZArGVxeF9rl
         tv7g==
X-Gm-Message-State: AOAM530Jkhx5H2qNMP51GDX7DldkEzYyC4maqccYNl4/aijQKzfcODP1
        o+rrFAtIdEWJgnkQDdRJg6BSYgiOgCVmEgRmaLM=
X-Google-Smtp-Source: ABdhPJxJKGmBqMMuHCvWVTHmgKdlMsSjHVTTjOA2O4IGGz0OD2/MSGNtFHKXSFNfsf/qz0qulRSAgQ==
X-Received: by 2002:a63:1c48:: with SMTP id c8mr17289293pgm.234.1617513011228;
        Sat, 03 Apr 2021 22:10:11 -0700 (PDT)
Received: from [192.168.10.22] ([103.77.186.50])
        by smtp.gmail.com with ESMTPSA id g26sm12567495pge.67.2021.04.03.22.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Apr 2021 22:10:10 -0700 (PDT)
Subject: Re: [PATCH v3] cache-tree.c: remove implicit dependency on
 the_repository
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <pull.915.v2.git.1616772930098.gitgitgadget@gmail.com>
 <pull.915.v3.git.1617465421353.gitgitgadget@gmail.com>
 <xmqqpmzazund.fsf@gitster.g>
From:   Chinmoy Chakraborty <chinmoy12c@gmail.com>
Message-ID: <16da2d91-9eda-ddf4-dd87-e07fb2bfbbcb@gmail.com>
Date:   Sun, 4 Apr 2021 10:41:35 +0530
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

Should this information also be added to the commit message

or just the cover letter of the patch?

