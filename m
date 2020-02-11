Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D7AC35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 20:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23FD21739
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 20:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tawDIi5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgBKUEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:04:23 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44888 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbgBKUEX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 15:04:23 -0500
Received: by mail-qk1-f194.google.com with SMTP id v195so11385567qkb.11
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 12:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7Nt7TOGUGD1CZi7k2K9by2qO1K1s7GS5zKDwjByBfNg=;
        b=tawDIi5VAYrsfm0uBdr6ciXM6SvUHvvVjS8UmGhtXdexvA4aj1PnAHW8ALW3Nfxnkc
         yJfss41quxTpJzzSopK2lon4j+SQvBybrS+ZCFX0088wBUzVRdVTdlLXwhZ5WgqhWdK+
         XxnWqnkQCTcbb/pO+UuFXHo8wRl2cV5Motkb9tG1Nxk4R2naVztZX76Xmc7WCzM2JHUt
         Oy/4EZ6W3x2aSukxR8P0a9qaqCnHjhvjKKqkM5YZnI5gUjtZnznn6OUd64XNznjIYt5n
         CPsH2/+zPsym/QG8gwoq6KSt3E1rafavHczokjTLmKD4og43zif2ldUgi5yDZOyp6oBp
         4zGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Nt7TOGUGD1CZi7k2K9by2qO1K1s7GS5zKDwjByBfNg=;
        b=cJ0isJtAlFdNTXEbKFvce9LGjLo1kDIYraZoIkjZ0CqcPg/iEfGPaeeRaaIsD3DqYE
         ssQVBZO58KuUOxIC2mdgXesEYpd74X21tyUggQGu3EZ0Ciwumj45ZVTb1S1PMq7SBwiM
         tXioube6Peh1ZpZ0mYLweK2gTpq4+e8ATx6Gyik90I6YTYanIUG1YvaFQxzhdPTNaAOX
         YsZghqBvZgt0D5GAVYGQ8h86GeV30Nm3OFqQEM7bKmt3JkZ6l93nywEPeegi8BOGcH5I
         EapzExmnkQK3Y0nOwhjNNUBLeBC49FpIClmUPaFn487MuhSnvShdKdJBjkrHUhzSpLXu
         iHDg==
X-Gm-Message-State: APjAAAW5y8YPJF7zFw6l8ItIhDNj4FnyN13ZKGw/IkiPONVI6hL3w5Ex
        KS7KuXoclgCkbYnch4BK/k40TVKZ
X-Google-Smtp-Source: APXvYqzzs6e7j680Zsj1CfmxeMBrxBQgLTRKvAO4A2JiIejRscwY/W6U5ddSdf7B0K/XeDHhVQ0gTA==
X-Received: by 2002:ae9:eb48:: with SMTP id b69mr7840328qkg.39.1581451462488;
        Tue, 11 Feb 2020 12:04:22 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13f:4033:f853:2b3b:f1c9? ([2001:4898:a800:1012:f167:f853:2b3b:f1c9])
        by smtp.gmail.com with ESMTPSA id g53sm2752500qtk.76.2020.02.11.12.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 12:04:22 -0800 (PST)
Subject: Re: What's cooking in git.git (Feb 2020, #02; Mon, 10)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqimkexeed.fsf@gitster-ct.c.googlers.com>
From:   Garima Singh <garimasigit@gmail.com>
Message-ID: <819852c9-68dc-11e3-d81d-ddd216953d72@gmail.com>
Date:   Tue, 11 Feb 2020 15:04:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <xmqqimkexeed.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2/10/2020 5:31 PM, Junio C Hamano wrote:

> * gs/commit-graph-path-filter (2020-02-06) 11 commits
>  - commit-graph: add GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS test flag
>  - revision.c: use Bloom filters to speed up path based revision walks
>  - commit-graph: add --changed-paths option to write subcommand
>  - commit-graph: reuse existing Bloom filters during write.
>  - commit-graph: write Bloom filters to commit graph file
>  - commit-graph: examine commits by generation number
>  - commit-graph: examine changed-path objects in pack order
>  - commit-graph: compute Bloom filters for changed paths
>  - diff: halt tree-diff early after max_changes
>  - bloom: core Bloom filter implementation for changed paths
>  - commit-graph: use MAX_NUM_CHUNKS
> 
>  Introduce an extension to the commit-graph to make it efficient to
>  check for the paths that were modified at each commit using Bloom
>  filters.
> 
>  Breakage due to byte-order dependency reported.
> 

Hey Junio! 

We fixed the byte-order dependency bug in the patch I just sent out 
here: 
 https://lore.kernel.org/git/ba856e20-0a3c-e2d2-6744-b9abfacdc465@gmail.com/

I am squashing this patch into the appropriate commits in v3, which I will 
send out after people have had a chance to complete their review of v2. 

Could you please apply that patch on top of the pu branch 
gs/commit-graph-path-filter so that it also has the fix? 

Cheers!
Garima Singh
