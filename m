Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CEEC48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 21:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A382E613EE
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 21:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhFIVPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 17:15:25 -0400
Received: from mail-qv1-f54.google.com ([209.85.219.54]:46683 "EHLO
        mail-qv1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhFIVPY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 17:15:24 -0400
Received: by mail-qv1-f54.google.com with SMTP id w9so13586882qvi.13
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 14:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cQaTwe+8K0JXmFXNl2Xj00+ayH5N6TEbOS0VtjjE6qQ=;
        b=kBLfJuev+QVRDQtjYu3Rh4lVdxUltVVmPsB5Col2DzrhQMAWbmH/Gg0DBOqU40YdgS
         M3mR4jD8i99Af+vuuG9P7I/z4mh7glzzUnVqxv8afuezpIVlWAhGDZ0PrzJkApTT49m8
         czrF3cegfQc7pZOmTspRwUKKd9eGbX6RwmmgxWOXU3boCA6pSefgzhI7hwmmbw6vIvPI
         YrDdD7ChtuseaKdQ+wlgQq5DWg2LkkQNdqpgd6slD+rVZYk/VunhfP/NG9lAXuwgUJ/U
         SDITIOOBGumv1OlLMT6yAqfRNBLNDfqZcdL6iYsXylSl+r4Jm+peW6ZmbZ3heQ1Db710
         6OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cQaTwe+8K0JXmFXNl2Xj00+ayH5N6TEbOS0VtjjE6qQ=;
        b=L0UvamTZNVHlvUKRTABOKR3WFCfssIcDKS9mR92gJ9wW/FGd7O0N4E00rFNaCrfJZv
         bmLwFcLYWS6q+VSwkOKRBaWR9OjzRoeVfuUQ4/U/4WABAsIJxXkCmDxOc7m5CxXd8BzU
         OExYBjaLjURFYd1o3TABKe+1ag4GfNCtQqqTHoRlBkMyoLuoiQ6UU4tnKsyPmY1MqSd3
         bPX9uZjGVQsQAoDFbJrSDFir8sB/j1+iBzP6N3s6JENnVQqfsrhpF7nsic1qyKzfGZLO
         CnRDKGdfv24TO8iLsDSjwQ7FfrYzq0u1vsiwLUxMCoJAS2qXkAFax8tFFf32FJaF1xP6
         7l/Q==
X-Gm-Message-State: AOAM531oFhWAxb2Xf0TF/m0OGTy72ISyRBBI2gIQ3Q2sGULStI3taqAX
        DpIivVtbzOIJwmMaYPKe4Nw=
X-Google-Smtp-Source: ABdhPJwICz+ChMvCAzgmfkFo3YV7oNcjMtI8ThGPQnNrFbjKzX7VwQTgbiiJtWaxNQUWIG46YUodtA==
X-Received: by 2002:a05:6214:b28:: with SMTP id w8mr1761436qvj.14.1623273132792;
        Wed, 09 Jun 2021 14:12:12 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:757b:21f8:d6f2:dd1b? ([2600:1700:e72:80a0:757b:21f8:d6f2:dd1b])
        by smtp.gmail.com with ESMTPSA id k139sm885661qke.96.2021.06.09.14.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 14:12:12 -0700 (PDT)
Subject: Re: [PATCH 1/5] promisor-remote: output trace2 statistics for number
 of objects fetched
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Elijah Newren <newren@gmail.com>
References: <pull.969.git.1622856485.gitgitgadget@gmail.com>
 <ad9b451d6823f7158a2b58a82682e0c862a1ef6b.1622856485.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <858bc5e9-17b5-f9a8-2c67-6cffb9e2f968@gmail.com>
Date:   Wed, 9 Jun 2021 17:12:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ad9b451d6823f7158a2b58a82682e0c862a1ef6b.1622856485.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/4/2021 9:28 PM, Elijah Newren via GitGitGadget wrote:
> +	trace2_data_intmax("promisor", repo, "fetch_count", oid_nr);

This seems like a helpful value for lots of reasons.

Thanks,
-Stolee
