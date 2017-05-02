Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38532207D6
	for <e@80x24.org>; Tue,  2 May 2017 04:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751091AbdEBEVA (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 00:21:00 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35492 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751066AbdEBEU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 00:20:59 -0400
Received: by mail-pf0-f179.google.com with SMTP id v14so83108293pfd.2
        for <git@vger.kernel.org>; Mon, 01 May 2017 21:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lPx8gEm8KgLdHtu/66Nxsq8h7Xa1bEbb6IqV13gL/9c=;
        b=o+6jOLBn15nO/5rX60Cqtc4iKbwAcq3A23hxoEebt9JVA1t2xfSgQZYcVdqMBjjNjQ
         AZedI7b9slQJt3qHzHhP5R+BpPbzBFw/FxtXG182yyuKhgzfucRkeSfw92Yn/UHpytF4
         scmxxznFn1ipdMWA/glBvjYvWAwHZVv/hDImT2CqGCTpT0h6SosU7iknaiOPk9ByyaTA
         b2L0OuEg7r/xhoyFHLgJgigBpwRsCARllu1cP8G2C6U/rHpSEkbb3ocNoWHPrrB525zT
         u82cV9SWn9MmEbaA0K8gZFimUUFTMdgSSsez8HJKnwmkOQ50ipP1u9j6w8TLf8CAXreX
         1ENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lPx8gEm8KgLdHtu/66Nxsq8h7Xa1bEbb6IqV13gL/9c=;
        b=HO/BCNh3AAET2cBpTeHKrl35Zq/7VGSxhBz1vBdzFiY6r+ZueegyC7XOuKvGSITAWm
         rkPUgIOh6TBVV7AcPrS/t5gSOYeyNe8l0AlMtgj6JROuxOoDerCfkeZdQrQ7zt22c+3v
         0po+1vjpIgLysMMl2kE8enhTS4Qi4xnw5trRRK7ZTjDOCm1nfIxDT7mZxq+QSMXxeiec
         ZqyTnM9wbaNuI/7j07E3+p8D54790D6X4Lw6cI7wxViYp3ZcRMg/oa5HZbarlBn7CdtN
         92iNLGnQWMPUUtIx4isRnHYyq2RrYc99A2CeVrsWVpcOo5q3T+lMs3gk3/dBHNl9k9XL
         djfA==
X-Gm-Message-State: AN3rC/5ItCvZdTt5RoVhm5xf1pwFq0BnEDos8l3hy2kYAJG5IDrRTcF9
        CtiE6JXygQi7KFnVvgNPKc1c+cb/qWrc
X-Received: by 10.84.241.136 with SMTP id b8mr38680451pll.107.1493698858551;
 Mon, 01 May 2017 21:20:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Mon, 1 May 2017 21:20:58 -0700 (PDT)
In-Reply-To: <xmqqpofsdkim.fsf@gitster.mtv.corp.google.com>
References: <20170501180058.8063-1-sbeller@google.com> <20170501180058.8063-2-sbeller@google.com>
 <20170501180610.GF39135@google.com> <xmqqpofsdkim.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 1 May 2017 21:20:58 -0700
Message-ID: <CAGZ79kYC9sycR_R-EM0jFA2YrMjA6jZvXqQud7ShPziW6WaMBA@mail.gmail.com>
Subject: Re: [PATCH 1/5] submodule_move_head: fix leak of struct child_process
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2017 at 8:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>> On 05/01, Stefan Beller wrote:
>>> While fixing the leak of `cp`, reuse it instead of having to declare
>>> another struct child_process.
>>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>
>> This shouldn't be needed as 'finish_command' does the cleanup for you by
>> calling 'child_prcoess_clear()'.
>
> Yes, indeed.
>
> It might not hurt to update the code so that the cp is reused in the
> second run instead of using a separate instance cp1, but that is a
> topic separate from fixing a non-existing leak.

ok, I'll drop the patch and may send another patch later for re-using cp

Thanks,
Stefan
