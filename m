Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C38C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F7D164F1B
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhCLULk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 15:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbhCLULJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 15:11:09 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9C7C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 12:11:09 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id cx5so4870901qvb.10
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 12:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d0Mty7TbjnEBncKyx0Jw+PFmtdUP48Vn3TgD8ea/IiQ=;
        b=Kr0LA6iUYPJXXoMJ8B/C2DWWy9lyXtcyQFACyXKRRPYXlKZzJhZ9Ks1z7dPohAIZ/d
         vHKahIohBp+Z5xJLYEcxozuzdhGh81mwxBG1CjqYXMO1zzvfSxLetSeeCP7KbcjXCaSa
         kG+Cw6Vz50WVXpVX1X77aKqA3eslowwrAqRXQtNVmDl6IewzhRXLAJFEYhuscgGI4pKo
         n4ZpnnSgCxdc/VavD+InjA1+uD2Ey6cAjA8P+x4rGqHdwK/33um8naR0bTQn9atppLNH
         ELfW0nXI9rAgkqlviMT3ZSnID6UJ+DOp3Bq61ytRLHbO2Rcu/EdeZISatGjNwqA7qzMy
         M2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d0Mty7TbjnEBncKyx0Jw+PFmtdUP48Vn3TgD8ea/IiQ=;
        b=MMWDaHEVYKlCgu6DwSZOJfmBX4SNp0+tR7C7cfsG/n5OFCEdn1Ez5mk7IjB6poEJzk
         /tyRCXOPdRGLcPPm0h1Vu3zsaPmzP1qM9BCrV669H9x/V7fO2gShA94zBja8LWHeu+IF
         VeULJO6EMMp46DsW3vNzaqmbpvY+b39a6QGSI+Ua3WngzuLBOmoVieTObPvSPBEd69ng
         ZLy8zySnN2vspksU5NyHlpquw06X+ru0ADYBCBXtHNSql5ijLBFK/P2B2L+ShYucshTQ
         +X5ORLazz8cJU2ljY9wEt7G68g9D+qljcoqNnlTMwcnc2/93STHv4qdVz1vqBrbEYoW+
         4Xvg==
X-Gm-Message-State: AOAM5302V/jfwCJXHRpjyR76EvgoWZ2MmqdPDVDIm9Uxl1+OOVinVp8C
        GAnSkA4Gv2m/8qC7KILEFaU=
X-Google-Smtp-Source: ABdhPJwsiShSGvjcTJ7dlRfKbV/Jhzdp8lEmLsDGUXsS+jWfcZKjRqIYaIENaeuTUlfJqpvbjYBkJw==
X-Received: by 2002:ad4:5901:: with SMTP id ez1mr13700162qvb.38.1615579868744;
        Fri, 12 Mar 2021 12:11:08 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:1448:4b23:85a8:b6a4? ([2600:1700:e72:80a0:1448:4b23:85a8:b6a4])
        by smtp.gmail.com with ESMTPSA id g6sm4432968qtg.91.2021.03.12.12.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 12:11:08 -0800 (PST)
Subject: Re: [PATCH v2 05/20] sparse-index: implement ensure_full_index()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, pclouds@gmail.com,
        jrnieder@gmail.com,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <pull.883.v2.git.1615404664.gitgitgadget@gmail.com>
 <399ddb0bad56c69ff9d9591f5e8eacf52cf50a15.1615404665.git.gitgitgadget@gmail.com>
 <xmqq1rckc1cb.fsf@gitster.g> <c5e42675-5f03-728a-60ec-880da368085b@gmail.com>
 <xmqqft106sok.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c730cb8d-06ff-6f86-4eae-812472157327@gmail.com>
Date:   Fri, 12 Mar 2021 15:11:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <xmqqft106sok.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/12/2021 3:08 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>> Ævar, the assumption that led to your e68237bb (tree.h API: remove
>>> support for starting at prefix != "", 2021-03-08) closes the door
>>> for this code rather badly.  Please work with Derrick to figure out
>>> what the best course of action would be.
>>
>> Thanks for pointing this out, Junio.
>>
>> My preference would be to drop "tree.h API: remove support for
>> starting at prefix != """, but it should be OK to keep "tree.h API:
>> remove "stage" parameter from read_tree_recursive()" (currently
>> b3a078863f6), even though it introduces a semantic conflict here.
>>
>> Since I haven't seen my sparse-index topic get picked up by a
>> tracking branch, I'd be happy to rebase on top of Ævar's topic if
>> I can still set a non-root prefix.
> I think all the clean-up value e68237bb has are on the calling side
> (they no longer have to pass constant ("", 0) to the function), and
> we could rewrite e68237bb by
> 
>  - renaming "read_tree_recursive()" to "read_tree_at()", with the
>    non-empty prefix support.
> 
>  - creating a new function "read_tree()", which lacks the support
>    for prefix, as a thin-wrapper around "read_tree_at()".
> 
>  - modifying the callers of "read_tree_recursive()" changed by
>    e68237bb to instead call "read_tree()" (without prefix).
> 
> to simplify majority of calling sites without losing functionality.
> 
> Then your [05/20] can use the read_tree_at() to read with a prefix.
> 
> 
> But that kind of details, I'd want to see you two figure out
> yourselves.

You've given us a great proposal. I'll wait for Ævar to chime in
(and probably update his topic) before I submit a new version.

Thanks,
-Stolee
