Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C94F1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 01:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeC3Bp0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 21:45:26 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35142 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbeC3BpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 21:45:25 -0400
Received: by mail-wr0-f195.google.com with SMTP id 80so6905081wrb.2
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 18:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QShSzDSS2wTUdSh8Znq8RqlPPhtKDze73YYGLobc+mY=;
        b=TYus2hrYLX16AZT39T2ooOYck/nrs2K48SS9J/U52d919xVxcUIDPmRs7/0n9ss5Cm
         m7higtLwpdbi6P/CH2VuRsgaarvhf6z0ob4bqck166aMnrYWZTnqOGMux4Kl9F1EhEGd
         6r+J5ngefmsmEGpKz4BdIoKjSvxeHpUbueITaLEKlaKRNxsN5iU77mcqKlj2rJtVVzDq
         oYFwPs8sxmjtI/3v2X68kb9TVOjuWLr2UJb2psY54OM77p5GTkAQH9uMj9KceoH8ppsc
         9s743GcFSiQIqJcqYv9SySDGa/ydruYFxQtelyvqAnD274VY8Yx6LZMXUxn7wOO3MmdZ
         fRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QShSzDSS2wTUdSh8Znq8RqlPPhtKDze73YYGLobc+mY=;
        b=HZlnQkO+l5kt/TzjJo8PUUYawmVDgvsQOHQrJTJK9rNzJalbbEywRzgNpvuIq9RJsF
         3TIbLWwDSaJhrTo6LY745xhRco7nDl2iQSjPlHVD8WJ4pk50GD8Q9Vi5jCPWPrtMSoWi
         ooS2HnXDEkZcKOPiOOv2YOWhu6QeZ3jMj1CsrBZ4Puz6Lx186omOGj2ImEhJuJm/WGg4
         SPjkg6FUf9mRGvT6xpSFK5NRP1bJBAJzzAKW3yHXlgq4bNKwsiAMcnOfGut1ChzIRmE3
         vfH4U/dUyj4PDGJXyeNDIMMi9/Ef01lBYo438deyeDctiCKhzmppbMfCziOhjIRzT32T
         VSOg==
X-Gm-Message-State: AElRT7GxZLIomSSJQ6Sa/UtRvM2CtNaBAHeoh7N/E2eqMRr6lAUy7eDH
        lHuAMfMwIVCYmbvAPGMmmEg=
X-Google-Smtp-Source: AIpwx49dh+nfToCJVUWPdIpmaLXrMGa6PNiMGnLFk03MFch3wgJ02q0f3iX+WFeNteBa9envHGT0mg==
X-Received: by 10.223.219.198 with SMTP id e6mr8848890wrj.212.1522374323858;
        Thu, 29 Mar 2018 18:45:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z16sm10526415wrc.70.2018.03.29.18.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Mar 2018 18:45:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC/PATCH] upload-pack: disable object filtering when disabled by config
References: <20180328203303.GA260688@aiede.svl.corp.google.com>
        <20180329215502.GK2939@sigill.intra.peff.net>
        <20180329220257.GA209272@aiede.svl.corp.google.com>
        <20180329221725.GM2939@sigill.intra.peff.net>
        <xmqq4lky5x9j.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 29 Mar 2018 18:45:20 -0700
In-Reply-To: <xmqq4lky5x9j.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 29 Mar 2018 15:31:52 -0700")
Message-ID: <xmqqsh8i49qn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I think I'd agree on it being a release blocker. Given that your fix is
>> really a one-liner (3 of the lines are just changing the variable name,
>> which I agree with), I'd be fine with applying it on top rather than
>> reverting the original, even if it means delaying the release slightly.
>> It seems like about the same amount of risk to me.
>
> Yeah, I would say we should just apply the rfc/patch as-is directly
> on 'master'.

... which just has happened.

Thanks.
