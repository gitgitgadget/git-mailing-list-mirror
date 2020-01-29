Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE955C2D0DB
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 14:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E541206F0
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 14:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaUMnRf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgA2OjT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 09:39:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40976 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgA2OjT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 09:39:19 -0500
Received: by mail-qk1-f196.google.com with SMTP id s187so17196978qke.8
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 06:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4bM5V2HpvfMElLnn6D9nZupb2NPe8wKc+vt2lPWRtZU=;
        b=IaUMnRf3qE9S7WcVGtgnEx2IuK/oM2NYu+SZ0JWWxAJdAztqhH/f+XQ0xyW0Aa3ycg
         uf0W8p0ortmHAW2eCqmfoBXJqeQjxyZLsS49C6CWaYXQwIBQDHqBjaIHBY5FnpOL9sA7
         3gqpDC1fk2G/7TQ3dksAqkDtUYGOiiWq4goGmkWZKP4vCQBXBz7H4pOC/kv8Ppj2k50P
         T8PZ8kXr46bnkwuH4168IntCGtXQznC+AuGhC9QvVHi7dYvpPhsf16XBJVoeCbQh0L67
         kGiEKtECR/C63qlscXYQCNqdT9gz+Kgig38ZLTXZMAWJt8r5BzRDAfE1qMI+gwsUefWT
         MDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4bM5V2HpvfMElLnn6D9nZupb2NPe8wKc+vt2lPWRtZU=;
        b=kyH+nPWZHtvsQJYSJDf3lP9W+lLC83f0rlgWch2bp9EKc9HpxT329+oeSTemksg37J
         vPmg0qK89i423BvaF9fxtRBueZMa4UXKlpxGCCReHLeNyGzYJxiR3fnGkvJi2VRe5YH5
         9bNzrwVQHcfboTL3EpbUwNSiVrqtmpwepkIZdJMER3uVeGwaClBMwVMGHEEMInhB5oWT
         qovOT0IbcIbzJycsGEoZ6uJyNpP7FdBv9FMf+pHIYDUcyNh3epQbiaBZFijxJU8Ma/3O
         ogXOmSNWUhUMdZ6QgzNiGeGwhsFoLG1DGLyW7yZNE7WnFL4QXjgU0Gbu/dMynJQDleYm
         bQrg==
X-Gm-Message-State: APjAAAVg8gNrhqIHkCig/aUe0AdXIhwTuo6sgHxbCJGDWGk3OaBjkEog
        54fhZcepRTaHOmZvoMnxGyJ9XvErhZw=
X-Google-Smtp-Source: APXvYqzzEvXD/2ZZdJpGdt98x02sBDtypEgImNadYc6ku+jMXerABCUVBEWpNEvoWhnInFVnodVDzA==
X-Received: by 2002:a37:308:: with SMTP id 8mr26750685qkd.98.1580308757391;
        Wed, 29 Jan 2020 06:39:17 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:90b6:a0a:46b8:addb? ([2001:4898:a800:1010:41ec:a0a:46b8:addb])
        by smtp.gmail.com with ESMTPSA id r12sm1034489qkm.94.2020.01.29.06.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 06:39:17 -0800 (PST)
Subject: Re: [PATCH v3 10/12] sparse-checkout: write escaped patterns in cone
 mode
From:   Derrick Stolee <stolee@gmail.com>
To:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
 <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
 <e2f9afc70c92c606a9d93660bce0599b7b7ddf6e.1580236003.git.gitgitgadget@gmail.com>
 <20200129101713.GB4218@coredump.intra.peff.net>
 <20200129103352.GD4218@coredump.intra.peff.net>
 <7a85cded-eccf-9f33-4056-08b2923b2861@gmail.com>
Message-ID: <50a17375-d2ab-239c-8a23-2c8fdd306903@gmail.com>
Date:   Wed, 29 Jan 2020 09:39:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <7a85cded-eccf-9f33-4056-08b2923b2861@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/29/2020 9:16 AM, Derrick Stolee wrote:
> On 1/29/2020 5:33 AM, Jeff King wrote:
>> On Wed, Jan 29, 2020 at 05:17:13AM -0500, Jeff King wrote:
>>>> +static char *escaped_pattern(char *pattern)
>>> [...]
>>> Do we need to catch other metacharacters here (using is_glob_special()
>>> perhaps)?
>>
>> After de-confusing myself, I think the individual code comments I wrote
>> still apply though (especially this one).
> 
> I've applied the smaller comments and am now investigating the right
> thing to do with other is_glob_special() characters. There is a small
> chance that I can replace any "c == '*' || c == '\'" with is_glob_special(),
> but we shall see. At the very least, I'll need to expand my tests.

I think I have a handle on these cases, and I've pushed it to my GGG PR.
I'll let this version settle a bit for more review before updating it
with a v4.

Thanks,
-Stolee

