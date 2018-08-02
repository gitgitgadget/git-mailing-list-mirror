Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FF151F597
	for <e@80x24.org>; Thu,  2 Aug 2018 17:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbeHBT3E (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 15:29:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37084 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731202AbeHBT3E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 15:29:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so2946379wrr.4
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 10:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ixNXjRYZ8ZwFFkfeO3ktOiAbmyZE8F66lAW1hwNgv4o=;
        b=Bzm8SiO5k3+Xtwy5RzLFRm8Vs6orvM+NUvVb+/EIIpKYc4KJWb5ONj4LSj+gZQ0AiY
         2MSBGnkVTP5nE9u/JHsO7J765b6XansNid/wfm2c8xY0KYxMRK7TyOaCpmfZHj0eZsei
         uqR4jMoS8xAjoFPBYOnOdaWh37ljZEqHNo4Jxll65l7BvgxVeu/t0oFUPifikVzNbRBy
         2UlyZ5N7PsFMdMOu4GpZA7g11Pr+Y6JLq0MMva7PxbSRVkIw06hQRLw7zAxXYY1rsYCB
         KLUqocTLlqPq+5SZ7E1Djuo+GnUsggAkpOQsJO7Eg9Qy6SLAWcBOujHbTXAJQquO/UI2
         KX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ixNXjRYZ8ZwFFkfeO3ktOiAbmyZE8F66lAW1hwNgv4o=;
        b=ko59ScUAJtrmu7mEi/0ojEW/8nfPjx8f9t1eDE1PrFGT0+ZMkF6UvOvRvoNC9Rq6yu
         XcnUxgYLy4aLZ8MSnJsaG4HEAOWnl2mWjyWHwH/8e0uwD4v3dszFlDKdLfRWU4AVqoyo
         yo0/qh03JTtGYg9LDvENSU4CXfs5NocK1kirkZ4gBCuHWkWYuwc6m56AXwNZyHBoM8rz
         aK29tO/lP/zM4gLHe38EuAwb+7WmWCQK0Sh1mq7XzFwrYIPtmQ3WRrkkmXq1gvaUGVzn
         yg/1tnYRDKOjGannz/aKEeXjIyeGrHnpNcurKjAtnsbCrAylJsJDdAK+/9Bey07LAbzq
         2Grw==
X-Gm-Message-State: AOUpUlFqeRM0A4wDKWMkUoE5PZLai6TEgYaU3/aGhccnDLSNl8dMo0Zm
        DVHaETNDJz20AfJ+n4oZvmvY/Bqt
X-Google-Smtp-Source: AAOMgpfhuwzhOko9n8mBqbU4PI99bR4t3aWLvJLpt9RoYEfw+VFbMgVIVVPehhsR3MzxfNQxPz2YTQ==
X-Received: by 2002:adf:cd0e:: with SMTP id w14-v6mr275671wrm.226.1533231415612;
        Thu, 02 Aug 2018 10:36:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w8-v6sm2853067wrp.72.2018.08.02.10.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 10:36:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH] color: protect against out-of-bounds array access/assignment
References: <20180802093208.27420-1-sunshine@sunshineco.com>
        <nycvar.QRO.7.76.6.1808021438460.71@tvgsbejvaqbjf.bet>
Date:   Thu, 02 Aug 2018 10:36:54 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1808021438460.71@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 2 Aug 2018 14:38:56 +0200 (DST)")
Message-ID: <xmqqftzw3c21.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Eric,
>
> On Thu, 2 Aug 2018, Eric Sunshine wrote:
>
>> want_color_fd() is designed to work only with standard input, output,
>> and error file descriptors, and stores information about each descriptor
>> in an array. However, it doesn't verify that the passed-in descriptor
>> lives within that set, which, with a buggy caller, could lead to
>> access/assignment outside the array bounds.
>
> ACK!
>
> Thanks,
> Dscho

Did you write a buggy caller that would have been caught or helped
with this change?  You did not write the callee that is made more
defensive with this patch, so I am being curious as to where that
Ack is coming from (I wouldn't have felt curious if this were
a reviewed-by instead).

In any case, this looks like a good defensive measure.


