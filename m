Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF99C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 13:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5650D61090
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 13:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241465AbhIWNsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 09:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241463AbhIWNsh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 09:48:37 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B244DC061756
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 06:47:05 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id 2so6221666qtw.1
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 06:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GergCB3M63JOjVQNcFrAqfqOULpPgs+U5aya01kVjA8=;
        b=hdTNIJGQBx6bSuVkj8Ww7mla8zBsn6US6oCqmDoUKKoAvQfafc9OE0wwzZtE5tZeRk
         3GhpEwwdph1SE4fFIjFYKApjZVQyz1Xl6Yc4VO9eN49xSFUCIETOafehYbyuwVB8ASD/
         RAgMyYVLKw0FSAJj7zX11/hLqZGQq1SSmYYTM3SQ73pzMwV8LXL1u4xFZ/7/SicHVOg0
         KQrRNruFQ/AwJWDTwYhX6goJP3obq3EUwazb3W7tB+6ZAm0mJaN5oDjl7r9RCdZZZEbw
         WnkspUbN7fh/OTr3Ss00chNs6DXMhVLijKxeIR2vpyMV5A8awwmxuGhyN8GgRVFQPxiu
         DGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GergCB3M63JOjVQNcFrAqfqOULpPgs+U5aya01kVjA8=;
        b=NisAxVvWtLQBuxtHdQY2/7isGJSHaDQPyXCJFjN5TFQzY2y82h4quKCHBv3mtDo+pg
         uXQwivyJtY+p1aG7Q/cQa224gmnl16mfrQQ3IoFPAXBxTwOLGOKpkHdhapS7QEiS2rhT
         ZX+gqH1HFAEQzsWR1zCF93czyxKvLb1wi+E3LV/4Lq7kGE9lw2FN1modHct4bKYyBddI
         oI9ehrSAQNPo0F5bCAlAm7peh0K1LODbElVQsi+xOB0vOQ1BoJeyNeNJmUgBoLA9ERZK
         v1i8m3Bm6qe+2J5rJ11FPWWUIyP81j4xy582HzR36CRAHCLld279sXN1NOdmt10z1LUl
         d3wQ==
X-Gm-Message-State: AOAM532ACf8RwCm0urNjD71u7MSFEzZnYkx5MtzXTalGxgCMyYSmXGf2
        u3TxeEWhYjhfJcxAIn+7upe59yOw4+EcOA==
X-Google-Smtp-Source: ABdhPJx6SMUcLz4BfKg7njEDqxV6OkBhKB+ajVp/p7D9s0181rYfbf2ZSVhYh7tGxSS3wRAX2ik2Ug==
X-Received: by 2002:ac8:411d:: with SMTP id q29mr4781202qtl.349.1632404824805;
        Thu, 23 Sep 2021 06:47:04 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b4dd:ad18:da7f:7cfe? ([2600:1700:e72:80a0:b4dd:ad18:da7f:7cfe])
        by smtp.gmail.com with ESMTPSA id g13sm4113063qkk.110.2021.09.23.06.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 06:47:04 -0700 (PDT)
Subject: Re: [PATCH] doc/technical: remove outdated MIDX default note
To:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20210922221342.6867-1-e@80x24.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9ebb4c34-8cdd-3120-ff9a-0e47099c3cf6@gmail.com>
Date:   Thu, 23 Sep 2021 09:47:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210922221342.6867-1-e@80x24.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/22/2021 6:13 PM, Eric Wong wrote:
> Multi-pack-index files are used by default since
> commit 18e449f86b74bab35b150549c8342d252fe7ae00, so the
> outdated note was misleading.

You are correct that the note is misleading, but it is still correct.

A user can _disable_ reading MIDX files by setting core.multiPackIndex
to false. If this was in the user-facing docs, not the technical docs,
then I might push back on trying to make that distinction.

> -- The core.multiPackIndex config setting must be on to consume MIDX files.
> -

As it is, this deletion is fine.

A nit on your commit message: format commit references like this:

  18e449f86 (midx: enable core.multiPackIndex by default, 2020-09-25)

Thanks,
-Stolee
