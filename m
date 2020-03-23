Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6734C3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AF620409
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 18:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6s7QoFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgCWSly (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:41:54 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34894 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgCWSlx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 14:41:53 -0400
Received: by mail-ot1-f41.google.com with SMTP id k26so14523357otr.2
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 11:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nKgVggNa7eplBXoVJBAi4jw2MsfcAVPerrDYzzDW6SY=;
        b=k6s7QoFWGNrPgnVyvFf0mo5cGieI+QO1Iwy4CSb4Z+y1d8doKM0rf8dpfbpKIAX/Mc
         7RVgcN67TetoGmlbWZYCG00c49agXerKNF+0bUQ26wl0hQUYQmssqXHXtq0HUgGcl7wI
         ui2yulXHXdjr358JhD2quhtowhSLJewmcRaSoKXedUhj8IkREkNSUxAcWcyuzlQ6AuIZ
         6ABq5UexvJyNB/wob9A+mId+uRWzbngE9g2oBwd9gqyhRe+WryYuPhCf07hWxRi176c0
         1JXBRsJtxm0sJUC8flY/Hpw2ELUVPIKKy+fInm31rLvr6LTphnNRr07iyTpe8XrNw9hG
         YewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nKgVggNa7eplBXoVJBAi4jw2MsfcAVPerrDYzzDW6SY=;
        b=ODO8MxvsC3YAR/PXG2eKV8pBCF7/42FZIrlKuYUu2qUtLqRJ3h14L2gJnb1Jg7EoQu
         jeqo4CiQ0F5w4kXXWPDPxLbKHNSqKlx324RwpBN7hsbNnN/diHAKTXqerlhlP9D3iRuV
         W+DelRGrjyLyvgxOdtO5GzxfKAZHXhjjMRl5S9n6uQhABMX2zHBL9n0jYugfc1ufok5r
         /12IfomlpGRlxpgYKQldiQm00i0bFp2rrb2PRnTTArZP4h1cUVxB2nPdkyPUaaVgA+8o
         RPnTRzil02YaJRNlKzIW1XTqwT+Zgck8oN2qfkIZdr5Xgm2PKl2W4xBPFl2TjNOEVTrI
         RMxw==
X-Gm-Message-State: ANhLgQ2G7DIFsvlCxIsEi5tgMnfR5wM2bBMGENMwp451kLnc29FPQev/
        ODf3cgQcYHt9B0hiS06lbb+Fazzkrvs=
X-Google-Smtp-Source: ADFU+vu9/YCCJwQIL0q75HguYOD7DzD0Us3dKZt+fjmS5V2rbt8s4lGIN2nOrJoyWhhTvSDehVX9yw==
X-Received: by 2002:a05:6830:1ac1:: with SMTP id r1mr14723694otc.139.1584988910940;
        Mon, 23 Mar 2020 11:41:50 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 33sm5275642otn.50.2020.03.23.11.41.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 11:41:50 -0700 (PDT)
Subject: Re: [PATCH v2 00/18] Sparse checkout improvements -- improved
 sparsity updating
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
 <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1a58492d-4e09-c12b-ff53-2f2b9cb2e28b@gmail.com>
Date:   Mon, 23 Mar 2020 14:41:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/21/2020 1:59 PM, Elijah Newren via GitGitGadget wrote:
> This series provides a replacement for the sparsity updating in
> sparse-checkout that is based on the logic from git read-tree -mu HEAD. The
> most important bit is patch 9 and its lengthy commit message explaining the
> current state and rationale for most the series, though patches 16 and 17
> have additional related directions and rationale for the series. Those three
> patches are the most important to review.
> 
> Changes since v1:
> 
>  * addressed several cleanups highlighted by Stolee (and I picked 'reapply'
>    for the new subcommand name)
>  * added three new minor cleanup commits (patches 2-4)
>  * several new patches to adjust the warning messages to look like warnings
>    (patches 11-15)
>  * display warning messages when paths are unmerged (patch 16)
>  * also make checkout and other unpack_trees()-using commands not error out
>    when unable to set the SKIP_WORKTREE bit (patch 17)

I'm very happy with the updates in this version.

> Also, the loop range in display_warning_msgs() in patch 14 might seem
> slightly weird, but I felt adding another unpack_rejects array of some sort
> and plumbing through an extra bit everywhere to notify the system which
> unpack_rejects array to use would have been more invasive. Opinions either
> way (or alternative approaches) welcome.
> 
> I was also curious if I should have squashed all the patches to adjust the
> warning messages (patches 11-15, they adjust the messages to actually look
> like warnings instead of errors), since they are individually kind of small,
> but it looked like it'd be much easier to review if I were to split them
> apart, so I did so.

I found them very easy to review. I had the one comment that was my fault
for not looking one patch ahead. In general, it was simple to see that you
were doing good updates with good motivations.

This is going to help the UX around sparse-checkout quite a bit!

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

-Stolee

