Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486BEC4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 11:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 249616135F
	for <git@archiver.kernel.org>; Fri, 28 May 2021 11:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbhE1LiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 07:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbhE1LiL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 07:38:11 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F15C061761
        for <git@vger.kernel.org>; Fri, 28 May 2021 04:36:35 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id i12so2420433qtr.7
        for <git@vger.kernel.org>; Fri, 28 May 2021 04:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XQwNx87o697Kbek8c7iCf/VQiOQoZTAeEKBDh83zybQ=;
        b=LGNZn353owXI1BsZo96Lr7EZibreCD9IRTNhRQbSviHzRBijDR+JgtrCJLbng5GYft
         3Q5n4M6iUz6qy9mAFXQrUOC33lkDyq6xdWugoe/fNmRD9rWJLuWpZb1AnmJL7I0AkQ1P
         a9z+OuV1cyph1WuLnBCYgy+VPZppFq3UgkzEC8vW9ylLb0KAWMKFL9w0/btJHb7lOaJY
         7YOQMh25udaYEDsNsPCZY5hJzrMj8DrgqBOLCPqjj8KsPKl+JFWFQOnUCK2VPx8t0xXl
         Lr/p0jpVa02ZMDSXfIqKMQXX3NCOlgoikJDVPjbt0jZtlMuN/KDQMn+ACrK7arJt/EQq
         0X4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XQwNx87o697Kbek8c7iCf/VQiOQoZTAeEKBDh83zybQ=;
        b=lncli3ktoI7nOmIu6lIezUm9CEhDNC9ipPpCqohWIq4q2J5m/FEnSYdWZ29DVriE6Y
         M4v3OBV/uIz/MACzMpV/Rg7rqnf6L+vk8WZsY5USFLF/lkeYwVUQ10qgLilpvWcDEpW8
         Att1vd/s4sJ381Y1P0Rki9T4BCIjXxjgEFd9V50EDI9OJTNz0Hr0qrZ7A1C7jU8Rk2fM
         KqyluGBQSnCy9E9P2iIcbBgPPBJaxe5btS9f9k3HTbfTtSmKKuCHpf7NTeBcq8bgNDaS
         eyBVhDt8JSMcXuqIsTsExygVD1YeMsjEZxFB13UA7jsowmlOgkhs/YGJo5om+UfVJrUD
         mxFg==
X-Gm-Message-State: AOAM5328hMEucTyECbRh/ui6HanQWrklX4K2o4zEa9EKQ1OrJ/QdZy4W
        Cm28W31T94zXdc6r4wVySF8=
X-Google-Smtp-Source: ABdhPJydkwT8Q7Ge3rXU5SWYlvmCQx2wLBaP6ZA+Oyg0maqtf2gf++UjrJUbNt65iL6USCvWlyM13Q==
X-Received: by 2002:a05:622a:507:: with SMTP id l7mr2980439qtx.276.1622201794786;
        Fri, 28 May 2021 04:36:34 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:f45c:45ae:1e9c:923a? ([2600:1700:e72:80a0:f45c:45ae:1e9c:923a])
        by smtp.gmail.com with ESMTPSA id 97sm3201689qte.20.2021.05.28.04.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 04:36:34 -0700 (PDT)
Subject: Re: [PATCH v4 07/12] unpack-trees: be careful around sparse directory
 entries
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.932.v3.git.1621017072.gitgitgadget@gmail.com>
 <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
 <e28df7f9395da33f24d6b75fa30081074ac6b801.1621598382.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <73d09910-6d1e-014a-ff0a-931cdb71b31b@gmail.com>
Date:   Fri, 28 May 2021 07:36:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <e28df7f9395da33f24d6b75fa30081074ac6b801.1621598382.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/21/2021 7:59 AM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The methods traverse_by_cache_tree() and unpack_nondirectories() have
> similar behavior in trying to demonstrate the difference between and
> index and a tree, with some differences about how they walk the index.

As I have been working on further sparse-index integrations,
specifically with 'git checkout', I have found an issue with this
patch that doesn't show itself in the current t1092 test script,
but appears later as more complicated scenarios appear.

I am pursuing the correct fix (that will also make 'git checkout'
work better) but it might be a week or two before I can send a v5
with that fix.

Thanks,
-Stolee
