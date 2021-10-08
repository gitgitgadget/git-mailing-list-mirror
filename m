Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0850AC433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 03:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9FD16109F
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 03:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242844AbhJHDzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 23:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhJHDzL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 23:55:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C791C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 20:53:17 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w11so5255168plz.13
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 20:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=t/QLBoAJY7VDSxCW6G3Z3hMhZ1yPJX+3U8ipJijiCEI=;
        b=BUTepdrySwPe66uMdKIeWlkUwnhHVuYOReALbVU/Kj9BmtFnnc7mFAqszot83IWXul
         /cuK6ehaqs/0LFi/0ygj47iNQ9lBDr8oQ7zknMb+msCge4woDw0AXcl/eo/+h0UDptWq
         5vtXanQ3KeWMNGukXTBpYMfiWzgWA7BtSm+eWL5A/weVQmDZiAGfyXZdMEsFUinSWSch
         4cD5VnxTz/ZC3HjRatHNLh1/7QJ+v1OVI09gnED4yw0v97MiArqkKHs3cfSsre5NHbyB
         +5amEjP5clfqYr//UmnjnrxKvkXwo7ycA7NsNQZnCeNZYkSP0QA85k+KuqYelds8Soxl
         dE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=t/QLBoAJY7VDSxCW6G3Z3hMhZ1yPJX+3U8ipJijiCEI=;
        b=LhiYj1NKIfEQTFafFT6y+B9Go2dkJxdyHNn2gyCOgdDhgLTDEcmr5lA9zRkycLszo1
         XzzLcqdxgFakL9mxEaGm0rYoelW6++j9e4nB3xMOq7pXsvCWCwO7KjXwcE4RtnST3cYl
         T7Z9VoS51m4wqgwbRJLkZvCx6gbwGE8Be1Sz4ineGk56/Gf7mY6V7bJNm1mzIJU4EXNm
         gSzTVYCfRKZieCCa4T/baSZ4Ox38A7SSNiKdLq8WfevUaA5twRBO8zvUo2uE6glJXWyF
         V1Tug9wRWnK+1tDWZ0junQuGLtPB/L342xjCkKBf1rcKvhWkbkhCW7v9ZXcES8uGhaqE
         mysQ==
X-Gm-Message-State: AOAM532BxruuxeCSYueqa56PcwAXdQ9TFmcAfgL87TuYIpjsy/1MXnaF
        NZTLR04Bq6QmCR3ExVC+rCduwQf2Synh3A==
X-Google-Smtp-Source: ABdhPJz19kSlUx4kSQ3qdzhRZuK/UntcAh5rYbfuCYwKjSgdm+S+2tdPV2KVxciRkhTu6q3B7vHheg==
X-Received: by 2002:a17:90a:17cd:: with SMTP id q71mr9616827pja.129.1633665196379;
        Thu, 07 Oct 2021 20:53:16 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:970b:a182:aca1:37a6])
        by smtp.gmail.com with ESMTPSA id c192sm529051pfb.110.2021.10.07.20.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 20:53:15 -0700 (PDT)
Date:   Thu, 7 Oct 2021 20:53:11 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 2/8] progress.c tests: test some invalid usage
Message-ID: <YV/Ap9wg6pn00nA1@google.com>
References: <cover-0.8-0000000000-20210722T125012Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com>
 <patch-v2-2.8-7b1220b641e-20210920T225701Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-2.8-7b1220b641e-20210920T225701Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 01:09:23AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> Test what happens when we "stop" without a "start", omit the "stop"
> after a "start", or try to start two concurrent progress bars. This
> extends the trace2 tests added in 98a13647408 (trace2: log progress
> time and throughput, 2020-05-12).

I wondered whether these tests were more testing the helper, rather than
testing the API, but I think this is a good change - you're correct that
having the helper assume correct usage by automatically
start_progress()ing and stop_progress()ing was an oversight. Thanks.

Diff is pretty straightforward.

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
