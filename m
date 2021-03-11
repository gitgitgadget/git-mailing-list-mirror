Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFCAC433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 14:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31CE964FAB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 14:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbhCKONp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 09:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbhCKONf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 09:13:35 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09030C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 06:13:35 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id d20so20704624qkc.2
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 06:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jD+gSvb/NjVl4DhCWawRObF6C8ltE1ZCYKdL68sGyyI=;
        b=NVL1yg2td52xt69BF3aWiGS4Ofpk/ioFkZvngTBbAXp9UgrRKAioqO0n6jrx0E7arL
         SQhWXc/3a82gE+QlKCKEux7RB23HG7v5LaPojhQrutJE/B06T5xiCo9OXqhB2PARWv7s
         SlkMLc8AHfQWG0b+ki5xMtaV0NOqw/skxfJ66N093Z1aMzpLT8ypTlwc/DwT710GMDlT
         q0nltzfsdr0VUaizud5gt7n6Lw5g5UJSG2bMBY97ZOVfxPh9NwUJhLBNvH8rpZNL5168
         QDJyMmc9nQ2sl0RvJarfOJpGWoqxgIuGKyfyijDQFWw6eXC3oZDFd585ThAmGTK2ByJo
         zEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jD+gSvb/NjVl4DhCWawRObF6C8ltE1ZCYKdL68sGyyI=;
        b=re1s/8Dp+uLTVzgP3GfKmPO26TqH4A/aTkkK0tQPB5OpIfrpnPQaoKs635p1VA+jJg
         lV2q5/x/LTab7gnhH+84k2EIDd/cwhc0pUWsEBQPvPnClFKIi/XrfF2BBDzVKftVmHnW
         O7O4f/5CfoGTNIedx0TN+o9310TxO1xjnatFt4jpubR6ieFXGRsX1b7wr6I4pY2+UxxK
         tYb8k0hlD/6dvvH6qh+mOMdy9NmKD9nGJF+YMfeSOZHjxXM0JvWaXdEJ+oRtCaDY7W6X
         +Xt03MlJLnS812OwivQP+8Ijhkpfr4vYryMLgTanbuN26fKj+fOi1OSkTtI4hSJYtfXh
         3ivw==
X-Gm-Message-State: AOAM531WCqNY86XwEa7iZYTIyiz2kVejPCZ/iehqALroVY+fYYfjoZLF
        7Sdq0ttrzdUVm5BvV05R96M=
X-Google-Smtp-Source: ABdhPJyezIqgBwJ4orls9q+Thj2qym/mOJB3/tab5MHwDX8Pl81GDm0sQZoPaF2aYLxUrT/95yaCfg==
X-Received: by 2002:a05:620a:2116:: with SMTP id l22mr7667712qkl.377.1615472014228;
        Thu, 11 Mar 2021 06:13:34 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:6d39:6117:2464:aeb7? ([2600:1700:e72:80a0:6d39:6117:2464:aeb7])
        by smtp.gmail.com with ESMTPSA id k7sm1725157qtm.10.2021.03.11.06.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 06:13:33 -0800 (PST)
Subject: Re: [PATCH v2 11/20] sparse-index: convert from full to sparse
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
 <f6db0c27a2854b16a3402e4133629a1f479e113d.1615404665.git.gitgitgadget@gmail.com>
 <CABPp-BGUqVC7JV7nnNDTt++rHCxUF+98T0OLq5dFf0mOKkp8fw@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1241c484-62ce-5acb-794e-444ba2cdc4c2@gmail.com>
Date:   Thu, 11 Mar 2021 09:13:32 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGUqVC7JV7nnNDTt++rHCxUF+98T0OLq5dFf0mOKkp8fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/10/2021 6:44 PM, Elijah Newren wrote:
> On Wed, Mar 10, 2021 at 11:31 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> +GIT_TEST_CHECK_CACHE_TREE=0
> 
> I still think it'd be nice to get a comment, either in the code or the
> commit message, explaining why your series needs to set
> GIT_TEST_CHECK_CACHE_TREE to 0.  I feel like I should almost know the
> answer (was this just a preliminary step and it'll later be turned on?
> did the cache-tree checking do stuff that assumes no sparse directory
> entries? is it really slow?), but I don't.

Sorry I missed commenting on this earlier.

The GIT_TEST_CHECK_CACHE_TREE environment is enabled by the test suite
by default and it does extra validation to see that the cache-tree
extension exists and matches the index contents. Since at this point
we don't have the cache-tree extension enabled with sparse-index, we
would start getting failures by those tests.

This is re-enabled in "sparse-index: loose integration with
cache_tree_verify()" so everything is being verified at the end of the
series.

Thanks,
-Stolee
