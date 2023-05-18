Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6140C77B7D
	for <git@archiver.kernel.org>; Thu, 18 May 2023 21:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjERVc0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 17:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjERVbs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 17:31:48 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9029210D
        for <git@vger.kernel.org>; Thu, 18 May 2023 14:31:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-643990c5319so1859339b3a.2
        for <git@vger.kernel.org>; Thu, 18 May 2023 14:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684445466; x=1687037466;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9koJJ0rXIdPU1Do64gj+4H4X/tfAYM+RHH2JBrKJeo0=;
        b=oDfxVlqW90MZsUZkprDcc7o037WiZFA4eUNDgYpSGuWTTpTdznSzJPjdauDChKAUpn
         Z2ZwWRRxqaBhrNRkSKj6UxOw0CNEWZ1eu0X9ieuHQx6k46XaV+cMebYYOxI2PE8uWluX
         RucfgxJpKcmCEoT5rAnacX01GoYIElpxUOdDyfO/EkVudRyIXZucWZCt/FJl5GL0lbE1
         23rQWLE0hvODYU4v2FNJzjw08JQbd5iTQ9bcQFOyN/X6dSmwrgcHyq6dRdfvHKH1TSnH
         I3k1hElPC5W12jySMWUzRYTAXLNzkUog7Ao0hoZ9TxCrpG9JBiK9rD1AS9qlOwtP9TLt
         pZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684445466; x=1687037466;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9koJJ0rXIdPU1Do64gj+4H4X/tfAYM+RHH2JBrKJeo0=;
        b=Kf4u1PPVRMqhCH6ZSrHs3Jz20bsLjCVWxMXbaRBiWPwXot1cGKwINjHgY/uk/dp7A4
         yhI3oADB4DdRbau2d8YIDYJBa//qiy3zEKDNpQHlHhKLOMqHSUPPl6a4aZtnbmLQSsq0
         5EeBRVNIR0zwaswmf7lnhRU7BtxOA06DjKDsMwsNEQa3MvzF3K++TwerPOG259c7YY6i
         B3089oluS77NN/529bnTBCSri2arsy8cvnXQGWgfs1OWyhSs+t/tatpXd1ZaZFYCr7Fr
         XAD7YV7dHnuj2/H39ohUlKcEM/zNvopeYnGKTmd836qSBZDQMbyBOcDG1RE49oWgil8N
         lV+Q==
X-Gm-Message-State: AC+VfDzAWpuIkl8y40lmRdX5DkJDwxxkzUxAs1jC5T7R39h0BQKWPI9Y
        174OTsC2FNuEAm6F66XxLHY=
X-Google-Smtp-Source: ACHHUZ4UZoCvioxv4tinTHz87drJ1MkPPKIvvWrb0dh9JynMFq7uctd5BGJWGqoU8C+IBcB5tUO+fw==
X-Received: by 2002:a05:6a00:1594:b0:643:53b6:d841 with SMTP id u20-20020a056a00159400b0064353b6d841mr386886pfk.2.1684445466054;
        Thu, 18 May 2023 14:31:06 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id k30-20020a63ba1e000000b00528e0b1dd0bsm1558040pgf.82.2023.05.18.14.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 14:31:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [BUG 2.41.0] t/lib-httpd/apache.conf incompatible with
 RHEL/CentOS 7
References: <ZGUlqu7sP7yxbaTI@pobox.com>
        <20230518184532.GC557383@coredump.intra.peff.net>
        <20230518192102.GA1514485@coredump.intra.peff.net>
        <ZGaGZACGNLeAsZRp@pobox.com>
Date:   Thu, 18 May 2023 14:31:05 -0700
In-Reply-To: <ZGaGZACGNLeAsZRp@pobox.com> (Todd Zullinger's message of "Thu,
        18 May 2023 16:11:16 -0400")
Message-ID: <xmqqlehls4x2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Jeff King wrote:
>> I tested this manually by mutilating the config directive to "FooBar",
>> which would fail even on recent versions. And then tweaking the "13"
>> in the version check up to "60" to make sure it properly skips even with
>> recent Apache. But testing on real CentOS 7 would be very much
>> appreciated.
>
> I tested on RHEL/CentOS 7 and it does what it says on the tin:
>
> t5563-simple-http-auth.sh .......................... skipped: no CGIPassAuth support
>
> Thanks!

Nice.  Thanks, both.
