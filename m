Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD318C07E96
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 13:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 979D261167
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 13:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhGONje (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 09:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhGONjd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 09:39:33 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C496BC06175F
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 06:36:39 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id n24-20020a4ad4180000b029025bcb88a40eso1526155oos.2
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4Za2zpiVrHCY/jgwYKsj7ob7w5SE9XPwFa867Bv7XHU=;
        b=dyutYscIaCBmMrX2Dg6M++tQE/1kaSJxO+qJaHxSFSPdXwYwL23Xpm+9Mk7vmU8cCm
         EAeXUDkRn1uvO2tMpqVpzvMaE4TaKeB6WLX3RC1VVcKcU+H05QKDX6T4xGI4n87NUbRY
         WqTTYpml0b5V1lgv2v8xfcD22lX9FO3cVrvhP2uH1xtBAoM8Fu0oRJtVmsjGubGhco9H
         8JL98R5tS7yr5MqW+u0E+eVYy4ARrmRB5EPMEYBi0dD5c4gBraoh4y9MMc62YQ1HGLzI
         Jsib7ekH8Uz6uYkgnNtSZeRHTpGX+9I3eIUdRT4c0WcR3Z6BE0zjlm762x6tUp95AHNe
         OH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Za2zpiVrHCY/jgwYKsj7ob7w5SE9XPwFa867Bv7XHU=;
        b=pp+/NjXartfPvqjutQs7o+5uqJwiJjjF9JV+kIy5vqqZgR9z1KyBD4mwzmz14THO7n
         3DttwkGpv2CglDyZ7Ip4xQVm/imQeBt4o/Vu7YBPNz+TAkuHr2ccfJ7F9i/MxuCOOpsN
         aDjom37m2erUx7Zw9Narpny8ePFlupB+Sqcy8IJE73PERnGDk7AfXafJIyFN9QK31vlP
         JZwxq7lZF3XpkaZzWFQzlxl10AjJGpeiemJPTLkVckAijGOTctRkmFiuhpRyS7oU31Ce
         hxWLiTeiOC1P465hcIo7cm0H0wquv2U5OTctuUgyak/xpcnLfItRWICS0bxvli6+sjdc
         UWrA==
X-Gm-Message-State: AOAM533Y5hxXSjaS/DN0RNLhFN3NzETealfYtiYzAuzaSp2jB2Xzib8D
        un2HDT1gPdZIv3oYswSw4Zs=
X-Google-Smtp-Source: ABdhPJxBGEW3AmQxrCHEuY6uL4DyQ+mbiLX2X4tRphI8a4HaSWRtxh+RjA7UR7kdtShsywV18AT6cQ==
X-Received: by 2002:a4a:94e2:: with SMTP id l31mr3460571ooi.62.1626356198347;
        Thu, 15 Jul 2021 06:36:38 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b51d:31f1:a0d6:7fc2? ([2600:1700:e72:80a0:b51d:31f1:a0d6:7fc2])
        by smtp.gmail.com with ESMTPSA id a44sm1051243ooj.12.2021.07.15.06.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 06:36:37 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Rename/copy limits -- docs, warnings, and new
 defaults
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
 <pull.1044.v3.git.git.1626309924.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9ae3987e-2d28-a308-3d12-28ec3c8e996f@gmail.com>
Date:   Thu, 15 Jul 2021 09:36:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <pull.1044.v3.git.git.1626309924.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/14/2021 8:45 PM, Elijah Newren via GitGitGadget wrote:
> Fix a few small issues with documentation and warnings around the limits for
> the quadratic portion of rename (&copy) detection, and bump the default
> limits.
> 
> Discussion on bumping the limits can be found at [1]. Although it appears we
> generally agree we could switch to an unlimited setting for
> merge.renameLimit, that would require some changes to progress bars to
> notify users how to take action once things start taking a while. So, for
> now, just bump the limits.

I briefly read through the responses to v2, and it looks like you
updated your v3 appropriately. I think the changes since v2 also
satisfy my comments on v1. This version LGTM.

Thanks,
-Stolee
