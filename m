Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F96C4332D
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 021B064F38
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhCQUFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbhCQUFP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:05:15 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CC4C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:05:15 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id l4so40268883qkl.0
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y5YOPUyPejTm5e79gYmJsVaeLJDHJ69vIba9d37O5fM=;
        b=CDfzqbaRE+6UL2q5ii+NjszzvKpCUIB3qK+v7r+8sJYjJc1FXV1RDNmmFmz6GyQq2V
         LcmioSa40RF0TeiMP5rM3AIOAQHIzlsV8FS54DXmKoKQT1T4F3uD5FH7b0F1EKj+oH9k
         vw+S78KFHKdo2uyw1vJGbBcXAQVaaRmU/xxkIKxh5epmjq3QMd6UcER4ttkHUqtepq7U
         8IrkCkgZZPIffE7i2+xtVQbuz17G5GK9OY0SmHGLS5BGq3wx3Nx15ky3ArPfEQV9de80
         DrBCeQz+kxl7jTQ6T/TkTKLNeQqXE90InBKI1IIfj12SUpBexYsembAFbvXFtcBAIRLe
         P4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y5YOPUyPejTm5e79gYmJsVaeLJDHJ69vIba9d37O5fM=;
        b=doW2qgqfrYHbCTmHd6eJR79EJpEkdRWTWh/vrLMSULeXHxQr3htN80nEydoXI46102
         OEobXir6Ifbka3mhkUMdblDi4rLc91BUAhC2NX6r8Svj1HnNigR1w71rZhR54soCufte
         QVU5ZiRo61BYFh9wE1EWFq37fhXo5ieQm7u6EMr79hajSe4Ukw8Z8Fz7qJP/mJNvnHwT
         HSdnagiQ9EUiQj6Ce6geL6wjCtX92Xa3bNjLkttThRznGJVAtWTLFai02/s+WzFPzcMj
         4b3IyGG7kvftubei84M80LdyEv6PjQy+wujkCbxjwSYgS9cvMsX915td4VyWU5iBLknC
         vYzg==
X-Gm-Message-State: AOAM531uDc/5pcUAoMTQbdQqGN2XhcIV0N2nkm6laKhb9NuvIqsCtIXh
        IK9BL5AlUsdkBWmNx3MT3QM=
X-Google-Smtp-Source: ABdhPJzyAjfjvDvUN+MdnWzyK0DVT3gB1YVLtZZhPNXZrANWtw3ni5Y2u8UyOtI7Ns3Lglm6TCLv6w==
X-Received: by 2002:a37:a353:: with SMTP id m80mr1037528qke.14.1616011514540;
        Wed, 17 Mar 2021 13:05:14 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5df9:6440:37ca:197f? ([2600:1700:e72:80a0:5df9:6440:37ca:197f])
        by smtp.gmail.com with ESMTPSA id f186sm3323qkj.106.2021.03.17.13.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 13:05:14 -0700 (PDT)
Subject: Re: [PATCH 06/27] checkout-index: ensure full index
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
 <bfa0164cc3c167e383cdb5405526202432ae624e.1615929436.git.gitgitgadget@gmail.com>
 <CABPp-BF=-2qD9YodpnhYP49EnKEV=MOFDMUnB-agd-d69jVeQA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <08ffff48-7b9c-7113-1a5a-557f3efff26f@gmail.com>
Date:   Wed, 17 Mar 2021 16:05:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABPp-BF=-2qD9YodpnhYP49EnKEV=MOFDMUnB-agd-d69jVeQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2021 1:50 PM, Elijah Newren wrote:
> On Tue, Mar 16, 2021 at 2:17 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> With the caveat in the commit message, this change looks okay, but
> checkout-index may be buggy regardless of the presence of
> ensure_full_index().  If ensure_full_index() really is needed here
> because it needs to operate on all SKIP_WORKTREE paths and not just
> leading directories, that's because it's writing all those
> SKIP_WORKTREE entries to the working tree.  When it writes them to the
> working tree, is it clearing the SKIP_WORKTREE bit?  If not, we're in
> a bit of a pickle...

Perhaps I'm unclear in my intentions with this series: _every_
insertion of ensure_full_index() is intended to be audited with
tests in the future. Some might need behavior change, and others
will not. In this series, I'm just putting in the protections so
we don't accidentally trigger unexpected behavior.

Since tests take time to write and review, I was hoping that these
insertions were minimal enough to get us to a safe place where we
can remove the guards carefully.

So with that in mind...

> Might be nice to add a
> /* TODO: audit if this is needed; if it is, we may have other bugs... */
> or something like that.  But then again, perhaps you're considering
> all uses of ensure_full_index() to be need-to-be-reaudited codepaths?
> If so, and we determine we really do need one and want to keep it
> indefinitely, will we mark those with a comment about why it's
> considered correct?
> 
> I just want a way to know what still needs to be audited and what
> doesn't without doing a lot of history spelunking...

...every insertion "needs to be audited" in the future. That's a
big part of the next "phases" in the implementation plan.

As you suggest, it might be a good idea to add a comment to every
insertion, to mark it as un-audited, such as:

	/* TODO: test if ensure_full_index() is necessary */

We can come back later to delete the comment if it truly is
necessary (and add tests to guarantee correct behavior). We can
also remove the comment _and_ the call by modifying the loop
behavior to do the right thing in some cases.

Thanks,
-Stolee
