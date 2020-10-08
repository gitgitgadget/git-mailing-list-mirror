Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8FBC433DF
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 18:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1C7C21527
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 18:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovJErDv1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgJHSMy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 14:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJHSMy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 14:12:54 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF572C061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 11:12:52 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id f10so6403875otb.6
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 11:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=y+JEDlmdz8R3rB3z9yVvj06HI46ZKof7K6WfmnrKHc8=;
        b=ovJErDv1Ejeqp2m3oietlOHksVszMAh4X6eq6HJ4EHN0xCbMG+uMjcrNdWeEUASb5w
         j9/pedKUTID5gxyGU9xUOmS1r8FUBOO13gZQZQdxhJcxAHEq9Fzg8k0SR5XnVqIyW9Kt
         BYAYCKwLeVmdSbbpNZjRGUKyHgQnIcmeCjMDLvvQ+osJdpcOKrZkH9bwH6vjg3Oo0A01
         Pv7SWmuSPLdlIG2Opg+ezYJwpzZeX2++tgYXObj78bjzJoGi58DFy1eaxvO1qGU2a4X8
         bQttto8eAskE0Fvk7zR5tCS2UGvPjMYAzJCmeaUziFqaFFDa9D78X39QxFPFNZsEhgcc
         nZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y+JEDlmdz8R3rB3z9yVvj06HI46ZKof7K6WfmnrKHc8=;
        b=rWTiFI+bYES6F0ecoUJEmGF4NUM8NNPfpnafkfcCTE3Kt/msDrRpR4tZNlj4bnvDfx
         IxAVKDMMLFnyiKMa84gATe0SKvx8lNo/RrA9nxcilmO/gX1oYAeWyVV+wgHArjyQ+ecs
         q39GcCoG1xBXsmpv61/CjQu23ksaTEqi0xgy9loQ9BjmBgluW4hrIfbXPX7n4OBJ+8QX
         ya3SuL2f/yMpL5f7gOk45z3eow1MKHAynUJk9QRpYkmqMUjTl2pZ8/p75Z2GEiHiXKGw
         6K+N0IkBrM/Bh+DyO9/5wbye7EG0nxMvDBl4KSkUVCzT7QeLguP0/YHwQgSfuHgmBYLV
         3/+Q==
X-Gm-Message-State: AOAM5300yndFWLJ2jIxafw9ptYp/ZWU4RxNiK8MU1V09Ys5F0ZVr5MfH
        EXEtaEwxbd8e1XdNIBSrMrhE2zjzjLVfIQ==
X-Google-Smtp-Source: ABdhPJzjFGiDr+gRFLYaQ9zeTQC09dv6QYMOwbfQE/tzMPxBE3eya3fQKkkwxuYSpLw3xQKMMpJ5eg==
X-Received: by 2002:a05:6830:19d9:: with SMTP id p25mr6281682otp.135.1602180771739;
        Thu, 08 Oct 2020 11:12:51 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:859b:7143:ba12:a6eb? ([2600:1700:e72:80a0:859b:7143:ba12:a6eb])
        by smtp.gmail.com with UTF8SMTPSA id 68sm4569524otu.33.2020.10.08.11.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 11:12:50 -0700 (PDT)
Subject: Re: [RFC PATCH] log: add log.showStat configuration variable
To:     Robert Karszniewicz <avoidr@posteo.de>, git@vger.kernel.org
References: <20201008162015.23898-1-avoidr@posteo.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bec999ef-5f9c-0ca1-ddd9-70b54b8c51b1@gmail.com>
Date:   Thu, 8 Oct 2020 14:12:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <20201008162015.23898-1-avoidr@posteo.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/2020 12:20 PM, Robert Karszniewicz wrote:
> Changes default behaviour of `git log` and `git show` when no
> command-line options are given. Doesn't affect behaviour otherwise (same
> behaviour as with stash.showStat).
> ---
> I've wanted to have `show` and `log` show --stat by default, and I
> couldn't find any better solution for it. And I've discovered that there
> is stash.showStat, which is exactly what I want. So I wanted to bring
> stash.showStat to `show` and `log`.

I'm wondering: why should this be a config setting instead of just
a configure alias?

	git config --global alias.logs "log --stat"
 
My personal preference is to use "--graph --oneline" by default, so
I use

	git config --global alias.lg "log --graph --oneline"

and then type "git lg ..." whenever I'm looking at history. I also
have an easy way to turn off the graph by using just "git log" when
I want that disabled.

> So far, setting log.showStat affects behaviour as described in the
> commit message.
> But it does so for `show` and `log` at the same time. I think they
> should be configurable separately. (log.showStat and show.showStat)
> 
> Before I do all the work, please tell me if this is the right approach
> so far, and if the feature - when ready - would be accepted. (I'm aware
> that documentation and tests are missing.)

If this is something we want to do as a config instead of alias,
I'm wondering if it is worth expanding the scope and thinking about
these other arguments (like --graph, --oneline, etc.) and how they
could be incorporated into a coherent config system.

I worry that this initial step leads us down a road of slowly adding
one-off config settings for each option when:

 1. aliases exist, and
 2. it becomes unclear which arguments have configured defaults.

Thanks,
-Stolee

