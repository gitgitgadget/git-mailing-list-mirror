Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AF401F462
	for <e@80x24.org>; Fri, 26 Jul 2019 23:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfGZXUL (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 19:20:11 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:38544 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfGZXUL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 19:20:11 -0400
Received: by mail-vk1-f195.google.com with SMTP id f68so11050349vkf.5
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 16:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kAjSfotMRzAytQ80xVfIDOMMhgscMoD3+T4b1mZ9yZA=;
        b=li685BekVvrSwFqXWT0Yt0RiM+KTXXeSz3LQZ9+k3fT/Vzb5mJDjFIG+hrN3gMG25n
         R44QQm4OSqcOlYHlVVSCyNnrq0lzn4g3h7kYaR37KP9TN/QBkhBPrlT+a+CelhhEPuD8
         6QZ1FPcXCQDoSolVMmGCcamXuFKw6xLxlTnc7JMdiuZfwuhk+7CochxOOnKt61IVXygP
         KpE83zg1+038A5zmNMScId/QrK6FuJq9bQ1t405uTI2Q95WUA2uPFFUPm1n6g0mizEo+
         8bHo+Bzx9dOqYZAIUjDe+mPLDZydQPUXc5++wp0x2bQNj289YYuAwMyWw7hvTxaODxgI
         Ka1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kAjSfotMRzAytQ80xVfIDOMMhgscMoD3+T4b1mZ9yZA=;
        b=myeKUgw65kioVihi2hzbqF5p7fg19YKStaQPLIr35MkNjB19jgEvVYlONUDt9zw+R3
         wQKiQQCd3DjGGOzDvTREYczOiMBfgdtMtfbjxApBWEB2N0DrMup81shXJwUYFTlzqQFJ
         sq99sSY3uoDpIoMOXfbLTTxudXyCbH1o0Hzp3V2bkiD6nQWJoy890h0IRKltCjoByJHV
         0a6Z38Ui8huymKe+24Yjq3q0BiYmGmCglqFr2dcsImVW1UlSAinzXEJFZkfmxhgmevUd
         yd0t/Wg4HleSAdpQsHL+X545CDVxVnafbvTz2BHgJbEk8ppjJelJMpMOljkPNkKKbrcR
         6RKQ==
X-Gm-Message-State: APjAAAW0tWerCeHFIrZ9l42Ow4FGCLNyLEVBenfUjlNZdXGt/WkvT4pe
        e35mQEzhXTgXMPkMKcZlYdSuOu5YLLaAd5X9urg=
X-Google-Smtp-Source: APXvYqzKUNSKrh1azpxUGU4GiAoJ1ywflebudbKKkeRv9ntbc06wzsPXTYvzDiHioXvSMA7H6xHa6nOSQt90v8j1BFQ=
X-Received: by 2002:a1f:1e47:: with SMTP id e68mr22451834vke.37.1564183209921;
 Fri, 26 Jul 2019 16:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190725174611.14802-1-newren@gmail.com> <20190726155258.28561-1-newren@gmail.com>
 <20190726155258.28561-2-newren@gmail.com> <xmqqo91godev.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo91godev.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Jul 2019 16:19:58 -0700
Message-ID: <CABPp-BHWhhjovb0ENcUva1Y2hJ2GzypefhQhZba5usQUnaBWsQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] merge-recursive: fix minor memory leak in error condition
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 26, 2019 at 11:31 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Returning before freeing the allocated buffer is suboptimal; as with
> > elsewhere in the same function, make sure buf gets free'd.
>
> I do not have a real objection to the patch text, but the above
> justification does not make much sense to me.  The original code
> returned an error when buf is NULL, so there is no leak returning
> directly, without jumping to free_buf: label (whose only effect is
> to free(buf) and return the value in ret).
>
> The real value of this change is it may future-proof the codepath by
> making sure that everybody after an error goes to the same place to
> free all resources---which happens to be only buf in the current
> code, but this change allows it to change in the future, where some
> additional resources may have been allocated before the call to
> read_object_file() and freed after free_buf: label.

Indeed, not sure how I overlooked that buf was NULL since that was the
precise check I was modifying.  I'll clean up the commit message.
