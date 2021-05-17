Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB06C433B4
	for <git@archiver.kernel.org>; Mon, 17 May 2021 20:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 532966112F
	for <git@archiver.kernel.org>; Mon, 17 May 2021 20:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbhEQUZi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 16:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242411AbhEQUZc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 16:25:32 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD83C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 13:24:13 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id v8so5703252lft.8
        for <git@vger.kernel.org>; Mon, 17 May 2021 13:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zpEORg9Y7MGonmA2yCAYcv9mCfOVLbCkotShmjsB+W0=;
        b=G5dOKsaNFvZ46fUeK8tHKj9KuQmbhXe1A2QyZlJyTO/ATPaefJY09bo0KbqP+vIkFK
         hPCPdgg1JHlzPYY1I7RWgDOQCs+EraSZ1WAwclPf1//IKMPzljcfaTXz3gXQJLtEHNGU
         BLzMIhtDv7ZuKany1nBG4EARPxWhqa2BNqO6pXddyy/Oh6+oYQCCPti1H/iHH8GCWavz
         stxbgKBGS66rrKVugE21KQz1B66QpnrhgeuYaHDrsvlVSKXfseB5VoiPt49Wkl/iCdAG
         8BreEAaXRcWD0HdgrzRPzpHeXcmXFQadWsbfsdlD4skWjfTUf3NrbqEe5oDBj1C4NVqt
         DPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=zpEORg9Y7MGonmA2yCAYcv9mCfOVLbCkotShmjsB+W0=;
        b=HlVg9sTGKVLOFRz3j+B4vNc0UlkX3u1mkiEAc9+9xinL1gDsrernlGoIrg2o18EliP
         YxfdOI2kMnUZpRCL1G8pacB/dXAW9tYsBfqZFQm/HKZEI/A3MJxUUfMqMTSyk68QkZGE
         o8s+8hqU2vHHiPMM7Ew6SUu6WHA/XztPL9DAZwsTVJaHLo14HEkfMpLqCIsLrF7IRvRj
         8Om3gTywrn8KBwMtB5qG4nWqAKrGJu3HTgwCo5W4M/hp/3h7ALWCHCnTlos1rS7EGvhF
         ygs3jxYrldTr0pXEOQegjwY+RYlXNmYdSYYS88TVkR2XAiEZdxaixYmVKgJUcDaAqp0k
         EM/w==
X-Gm-Message-State: AOAM530lO9J1s2Enw66e84oQ5zk1SUVOkFDdO8M/vXooh907iXaBFziM
        f2nuZMlch12kiz9BPTZgz7IjT16ORZE=
X-Google-Smtp-Source: ABdhPJymCNjYeOtPBS+XI2RdXKPvOlk520xblZW7ITJmYnF33lKsyfTyWhoHmfu1Z6DDrxUr/7k8Sg==
X-Received: by 2002:a05:6512:228c:: with SMTP id f12mr1151616lfu.320.1621283051888;
        Mon, 17 May 2021 13:24:11 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j14sm2051047lfc.47.2021.05.17.13.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 13:24:11 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v1 5/9] diff-merges: move specific diff-index "-m"
 handling to diff-index
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210517155818.32224-1-sorganov@gmail.com>
        <20210517155818.32224-6-sorganov@gmail.com>
        <xmqqwnrx5dfv.fsf@gitster.g>
Date:   Mon, 17 May 2021 23:24:10 +0300
In-Reply-To: <xmqqwnrx5dfv.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        18 May 2021 05:10:28 +0900")
Message-ID: <871ra5f6s5.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Move specific handling of "-m" for diff-index to diff-index.c, so
>> diff-merges is left to handle only diff for merges options.
>>
>> Being a better design by itself, this is especially essential in
>> preparation for letting -m imply -p, as "diff-index -m" obviously
>> should not imply -p, as it's entirely unrelated.
>>
>> To handle this, in addition to moving specific diff-index "-m" code
>> out of diff-merges, we introduce new
>>
>>   diff_merges_suppress_options_parsing()
>>
>> and call it before generic options processing in cmd_diff_index().
>
> This change has a small but obvious fallout.
>
>     $ git diff-index -c --cached HEAD^
>
> now starts failing loudly.  Earlier, it silently fell back to
> "combined" diff of one parent, which is "-p".
>
> I think the end result is good (and luckily, "DIFF FORMAT FOR
> MERGES" section explicitly limits "-c" and "--cc" to diff-tree,
> diff-files and diff (and by implication excludes diff-index) so I am
> sure there are small but non-zero number of people somewhere in the
> world who has "diff-index -c" in their scripts that suddenly starts
> failing with the version of Git with this change, but we can just
> say their use was broken ;-)

Well, I'm not sure. If it's a problem, I think I can add -c/--cc parsing
to diff-index that will simply imply -p. This way we will be more
backward-compatible.

Thanks,

-- Sergey Organov.
