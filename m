Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C4B51FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 18:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752790AbcKQS7U (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 13:59:20 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35761 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752262AbcKQS7T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 13:59:19 -0500
Received: by mail-qk0-f180.google.com with SMTP id n204so234436073qke.2
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 10:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s2vI5pMiL/AdbesqotlrA5nw7IXPrweMtAxqLeb5xXA=;
        b=MVIBe4Q9wx81XufJDDCENEqWIw4/2H1zHdytL4O+zk5Hy45Sm+AUQhPmdWvN0yqzjZ
         0eM3QcEVzAyRX1Ns+ftih0U44nzkOK6wvGCuI8ys2acEnEn7Z2/uz8Kk3HexiSMS27Ot
         N0kLE4rfRLdqAoxntDP66wmr5htocftkD6BR5yjnte+8sr01cuoI0RqaTqHhiB2jG+lu
         Npo2mAfpd3sMG/5nP3qB9zziLJT+9q4a+Ya7IWr8PpIz5cQXHH+TcTUEZ9ERWwdWp7Sq
         e4FxsCvMZo7MTtycnSqQ8vsRM0Dq1AIBVi5nzVBWUr03/tLFrZtPnihxX0Pq/FVLcNDq
         fuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s2vI5pMiL/AdbesqotlrA5nw7IXPrweMtAxqLeb5xXA=;
        b=h+WfdXI5L33C/s0NJ+pp8Xz0MEFhv7N0N4DHYeGP99LERa2MmRbV4MFwzupGVDPWm6
         Y9OTb0/6Rya76MKLHtEuwyAWyzx0msbg/aLtA5YTT32yICWxYMvpBcN8UGVaauAK3xmI
         Dw4cGCcDm9iyhFoWfPwxgSM+JOqGXAjXklt4KFyRYdGwv7skK7m6fszn7vUlAFms8Vww
         SkZq0h/MnaeHIF+w+zzkPukg/m28yxwd4W1LxNdOc1PNKFcNyZPCOIGECZIx5u44WSro
         eUFP065LbgjAi+wYKCrNE2kBYSRdPKTBLVl4JqsU3chW35bBgiISh2I3ID77wfPUUCfT
         9VAA==
X-Gm-Message-State: AKaTC00XHJJfqIrcbvSTyp4w3q2H4hOswxmVo6brirAmNwUVaBcEE7Zv6dmi3UmXbhyyUcOhIj8kdhZxeRWGhjGG
X-Received: by 10.55.105.129 with SMTP id e123mr5576263qkc.173.1479409157950;
 Thu, 17 Nov 2016 10:59:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Thu, 17 Nov 2016 10:59:17 -0800 (PST)
In-Reply-To: <1479408364-150268-3-git-send-email-bmwill@google.com>
References: <1479172735-698-1-git-send-email-bmwill@google.com>
 <1479408364-150268-1-git-send-email-bmwill@google.com> <1479408364-150268-3-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Nov 2016 10:59:17 -0800
Message-ID: <CAGZ79kY1x1HWJFjiyFdMFh8S_Y1F0ecLB5-JPb+nPE0gujfF-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] push: fix --dry-run to not push submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2016 at 10:46 AM, Brandon Williams <bmwill@google.com> wrote:

>                                 sha1_array_clear(&commits);
> -                               die("Failed to push all needed submodules!");
> +                               die ("Failed to push all needed submodules!");

huh? Is this a whitespace change?
