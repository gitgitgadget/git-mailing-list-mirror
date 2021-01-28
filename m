Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2F9C433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 12:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E44264DDF
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 12:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhA1M6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 07:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhA1M6H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 07:58:07 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE1FC061574
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 04:57:27 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id e15so3915468qte.9
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 04:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NnvjRyiZ3LvZ7mpPSToYIG6zcwTuFEwcUi984DBqYkU=;
        b=ooB+9z73jxGjBiZX4CoIOXyoYa+SPJFZfxrQrhXlZs1BIRXric4s4175pkXc5Gxksb
         qSJ7/fBc1NV1RaH7wDXMskMRq8Ozsk5NCRZY/pHmOkR9UeI5xRABy79dtHpNBzugIehu
         vn0mLvkGTTlv7KFYcikrdl0MgfvTjT4XqMINGugjb0yx9pUhbbSrYqZtK9OBr37cHqYo
         adUJJTMDSkzqEqk7YDQxfeqv7yE2S7su+t3nK2WUG4VoFY9jsIOG2KlN5X5Z38JyXhdh
         Dv84sJtTOh3vGhxt/rrvG8OMs2FxoNwNu8v3IwcwyOUzCesjdPbLgd+1nQqrz3Wsc5Hq
         gcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NnvjRyiZ3LvZ7mpPSToYIG6zcwTuFEwcUi984DBqYkU=;
        b=Xqb/nS/r8hyqDsmDZSJ657nquMQZN2HV3yZYUxxabC+Tap4Y0qT2isVdakRIcF7i4A
         CrrL4dRbMFCiyAG31Z8yejy19/twjTaBWTdP9yQ3HlSYlr+r7QZuUs22HOT9f2RDpfN9
         SkIOabS5727pSthudEYYAqylNiD+wxkLxNVNyLMpHx2tZSpCzTKH2ajcdxiCNZClk8UG
         VEb+syKDsSHWa/MMhwUg5I2dg9/F3uB0s7yeln5x3c4xCdhUu+aNuZKuRoSfSoMNml+p
         l9yToMWBwgjsOfuvfvHU+O5l8YMFBmNNebUYFZQw7yt/1Rc8gTFbgMmsG8uTlTKWed3B
         lEQA==
X-Gm-Message-State: AOAM531xj/3MLpx62JkWbZ/6Z9RYUoePbgs+T72BFnNz2eZclHXUiJGD
        /Hqh8FGuq/vZkpjHZXSN0v7zQHI07lrlTA==
X-Google-Smtp-Source: ABdhPJzegDbQ9VOqk9VqjVlLItdLOAKT+arkDfWxl+7Mo7OPahwvTiZ5b8I7kp7FrwGxWeYLZQc4JA==
X-Received: by 2002:ac8:71d6:: with SMTP id i22mr14324447qtp.206.1611838646397;
        Thu, 28 Jan 2021 04:57:26 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:916c:60df:445f:4f0a? ([2600:1700:e72:80a0:916c:60df:445f:4f0a])
        by smtp.gmail.com with UTF8SMTPSA id k7sm3344846qtg.65.2021.01.28.04.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 04:57:25 -0800 (PST)
Subject: Re: [PATCH 1/6] commit_graft_pos(): take an oid instead of a bare
 hash
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <YBJVuckmbGriVa//@coredump.intra.peff.net>
 <YBJV07YU1Y+siwZc@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <493fcc80-c793-0738-3b8d-b486fd05355b@gmail.com>
Date:   Thu, 28 Jan 2021 07:57:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <YBJV07YU1Y+siwZc@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/28/2021 1:12 AM, Jeff King wrote:
> All of our callers have an object_id, and are just dereferencing the
> hash field to pass to us. Let's take the actual object_id instead. We
> still access the hash to pass to hash_pos, but it's a step in the right
> direction.
> 
> This makes the callers slightly simpler, but also gets rid of the
> untyped pointer, as well as the now-inaccurate name "sha1".
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I think this one is an obvious cleanup that we'd want whether we go
> further in the series or not.

I agree. Thanks,
-Stolee

