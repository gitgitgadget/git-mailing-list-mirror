Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76D6C43460
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB344600D3
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhDMOW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 10:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237029AbhDMOWr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 10:22:47 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DE9C06138C
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:22:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ba6so19634091edb.1
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=WoC7ihjvEFkzlQaX6enY5tl22TGgzIK70JDDZJIl2lw=;
        b=uCKxOZV2qZwERN7VBL4SrvadMM1rEZkgDQZEIfd3X2bHgEEwQ4KDXPOldyuJK7QmPr
         MLRhag7KEwO20kWe0tmVygd9mDUsXST/d4RyYI8j/I4oK0/YafgqXHa7lqLmwwswfbp2
         Ukh82CK6/Ynloo0I+z4smQhJGR3nvB/7ggiupF3RCbBnd8jT8UDuSU+t2DfyGFwlMPC9
         oFMCCkgQ8J2iFqm/WO9/rQi5ejHGiQKXfskOdVfQRXDSL+Y0CoXS8TmQyL3HUYv6LTyZ
         N+XEZ+6Dcat5zqpEHBdwN6GK+apjYa9vxUKJ7BySDeXzYCPngKzDNZjKTHjNXf9OoVCN
         YrBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=WoC7ihjvEFkzlQaX6enY5tl22TGgzIK70JDDZJIl2lw=;
        b=pmV8LsPkAl6nkX/cGuKuuYDwK2Sw1t/DYVFVdVeNi5CdJq/gO+WnOvj+k+xGFDW9qw
         KTrxrHzOy7RVHsE5ZmgOYE6WSPRcJWHCc7f1S5mN4LM1/bTAql3GVHgrq7oDzM1A91Wf
         LJNAUAhf4mCfUtDPNItV9tS+DKCNDpS8SPTqN7JLyHoJwCKgwUj8dUctWQ3VNxxk2VWb
         dAjs1gV4nD+oySTUMEQC2+08UzHy2+b9E74QSDynM+0J1+MKamwGovUUwX19fmq2fqUE
         Rg49jlYNakiPq+914BrJ4SyXleaCOgx391ZOlM+j7DS/XB9UnVtMns4kPHuPjEJKUQN7
         kheA==
X-Gm-Message-State: AOAM5339NvMfrm0vpimb1PeDsCGD5GHYHkjQZdFesxcYUhCnvZjteTdR
        yzClsw42mT9DlFcHs0LXeiadLLgzjTGXPQ==
X-Google-Smtp-Source: ABdhPJz7nPe6+a/gxxKJN8RvVFxz359tndwUCa3Pg9I9u3yGPP3LBAD2cae/2L/9tVMRS7BO2pfC0A==
X-Received: by 2002:aa7:d4cc:: with SMTP id t12mr25392280edr.261.1618323745716;
        Tue, 13 Apr 2021 07:22:25 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u15sm9504385edx.34.2021.04.13.07.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:22:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] git-send-email: die on invalid smtp_encryption
References: <20210411125431.28971-1-sir@cmpwn.com>
 <20210411125431.28971-3-sir@cmpwn.com>
 <87blakgaxr.fsf@evledraar.gmail.com> <CAKYMAEJQOA3.25YK6UYSYFHXQ@taiga>
 <878s5ogagz.fsf@evledraar.gmail.com> <875z0sg8t9.fsf@evledraar.gmail.com>
 <CAKZTYI6U0WY.36DC3N1E4R7D2@taiga> <87zgy4egtp.fsf@evledraar.gmail.com>
 <CALQY92B6OVL.2Z59Y6W51BU4Y@taiga> <87o8ejej8m.fsf@evledraar.gmail.com>
 <CAML4RYHKQ6U.35902JHAIZYY@taiga>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAML4RYHKQ6U.35902JHAIZYY@taiga>
Date:   Tue, 13 Apr 2021 16:22:24 +0200
Message-ID: <87lf9m2rj3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 13 2021, Drew DeVault wrote:

> Can I get one of the maintainers to chime in on this thread and explain,
> in their opinion, what this patchset needs before it is acceptable? I'm
> not sure where I should go from this discussion.

Git just has the one maintainer, Junio C Hamano.

Ultimately getting your patch in is up to his whimsy.

Maybe he'll reply, but in an attempt to save him some time (which I
understand I'm taking too much of these days):

Getting your patch in is ultimately up to you.

So you submitted a patch, got some feedback/review.

Through some combination of this thread (mainly
<875z0sg8t9.fsf@evledraar.gmail.com> and
<87o8ejej8m.fsf@evledraar.gmail.com>) I suggested making some changes in a v3.

I.e. cleaning up some of the semantics (config docs/handling leaking
implementation details) and improving the commit message(s) to summarize
the trade-offs, why this approach is safe/isn't safe/why it's OK in the
cases it's not etc.

So, whatever Junio or anyone else thinks of my opinion I think it's fair
to say that at this point he's most likely to skim this thread and see
that there's some outstanding feedback that hasn't been addressed.

"Addressed" means either re-rolling into a v3, or deciding that nothing
(or only part of the feedback) needs to be changed and/or
addressed.

Both/some of those/that are perfectly acceptable approaches, but in
either case making things easily digestable to Junio will help your
series along.

