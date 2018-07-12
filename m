Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 631171F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 18:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbeGLS5T (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 14:57:19 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:46588 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeGLS5T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 14:57:19 -0400
Received: by mail-yw0-f193.google.com with SMTP id e23-v6so10322743ywe.13
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 11:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpmMG7kTHzS7eiKpQXhdUJf634iwdvOMAT8jltfzC/w=;
        b=HcrDlQsCsqkES0DQDMjRbi14/vwtDZCksxEw5HUQBsD6GK93dpGenXxzSfUS1XBAzD
         4DVuNL25O9IRmxinayCSnR98hm0E6Zf4AC9BZk+y38cc54P5h7wWoX1rR7nPFY7TaZpG
         5Hlc9panTiz3lP1oCWbwJaKRg/AVHTzxlrHW7PRcD19hvcXO0rEsObawLyz0SNUoFlrg
         dxS+s+EfUGdBVXnayGl/g1DPFcKw4U1dKSGNRq2bEVcNZeRy4vnnmSSBr9ef1HdTRWhd
         VJeOsPLizZG2CClmql6F4rcfMhc1o8wrvCFNF5R0C4dsGM9agrmTBuAZSjTWW4VvoRAX
         wj8Q==
X-Gm-Message-State: AOUpUlGIPUOxb+gE0KKHmGpk+Eqf4wGKL9+YX3blgq9eLWRkuDNqCD24
        fNkez8fmGr1W9xOVJ5XuMuqBFnQY1mpHCFh80MA=
X-Google-Smtp-Source: AAOMgpc6+kbP/k7dhShdGfq+KOqIcipM0pZHyZdDVCmJJeavYkk9oLVzX4xieOwYZKVrnuH3SpOBdzAAbgYcEKb72ms=
X-Received: by 2002:a81:110e:: with SMTP id 14-v6mr1702104ywr.16.1531421191271;
 Thu, 12 Jul 2018 11:46:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180702002405.3042-1-sunshine@sunshineco.com>
 <20180702002405.3042-22-sunshine@sunshineco.com> <20180712123729.17861-1-szeder.dev@gmail.com>
 <CAPig+cRYNo_KL02LN1LOa79Zm2oYZqbnBHJ=KDA3oaF4pVfjcA@mail.gmail.com>
 <xmqqd0vsxq47.fsf@gitster-ct.c.googlers.com> <xmqq8t6gxpxb.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8t6gxpxb.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 12 Jul 2018 14:46:19 -0400
Message-ID: <CAPig+cRZmx5_3-a0C=WdWnmcrh4J_1YHY_0FmXZh5LzcDq+6Uw@mail.gmail.com>
Subject: Re: [PATCH 21/25] t5000-t5999: fix broken &&-chains
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 12, 2018 at 2:35 PM Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> Oops, sent before completing the message.
>
>         For that to happen, we need a sign-off ;-)
>
> I guess this one would have been caught with the "sed script on
> subshell" linter that does not execute?

Yes, this is correctly caught when the prerequisite is met.

> -- >8 --
> Subject: t5608: fix broken &&-chain
>
> This is inside a loop that is run inside a subshell, in a test that
> is protected with CLONE_2GB prerequisite, one or more which is quite
> likely reason why it wasn't caught durin the previous clean-up.

s/durin/during/

The exact reason is that the prerequisite was not met (indeed, I
wasn't even aware of that prerequisite), so the commit message can be
more direct:

    This was missed by the previous clean-ups due to an unmet
    CLONE_2GB prerequisite.

Thanks for saving a round-trip.

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
