Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB9DC7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 23:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbjEKXtC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 19:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238915AbjEKXtB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 19:49:01 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083F32D7B
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:49:00 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-55a20a56a01so165569377b3.3
        for <git@vger.kernel.org>; Thu, 11 May 2023 16:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683848939; x=1686440939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0vL5NVwFM8oJbnyBeNr1Ip8kX2OHAU1s32LFTOPrveU=;
        b=p+GGJPsKl8iyTj5yArLttPnXmz7y2LZMv4EBhElSBgWHFim0/FSesJXTWfEPc/4utE
         qCMQtZBZQURjoRkhKyGgAir6UZottQxZD5iUdS4bLZHWy2/m02l8Jwvu7QNNx6psHmlz
         8flytVXmQ1l0dvM1bpQ4m5xRI29+dLG+JnVkW1PwnRBjSlJU/u/CsqHBiby2fKvOngQ8
         4zAbItSMM/leGrBOq8xfdxUy8gZ5tZv/Jaf72Wbowk/s0jfzgjECC8e89M4iREtRpmNd
         JsZ2yeJCKaATt9jHgNjQCO64R+ixdhaU+yWal1FLWGJDvNXCQkepwanDInliu2UumxXj
         YrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683848939; x=1686440939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vL5NVwFM8oJbnyBeNr1Ip8kX2OHAU1s32LFTOPrveU=;
        b=C6yK64mnioDz5xvLsWLKAH/uWhw9iQGvejXzRMw59IjqBmMVobcScs6A/R3DGPyZE6
         TBQ8Y2oIqQHsWXoI3IUqKZwcIxIsziDtAfDFJXmLwp8ow26VO+00Y5UtPgLNB0Q/XMx0
         qjJ8Bfly2g2/uIuF8gU+eVxc4fJ/KTH3RxlUf496TrX6fBWe1iM47FqwwQN16z5jpheN
         7E/FS0dL5WIbYpPW8DHT9M/m+PefAuqtoYw6txKD9Il/t7Neh6QL5Ufp1ucpwePwFbwz
         cDxygl7j/+fXmFd356r633pYl7OYRJnUbhBxsbfmC+j1NrSC7hyr31sfU6zfVDKR9/9O
         +Htg==
X-Gm-Message-State: AC+VfDz+1hyCuga5RkHEEiuREDNXT2le1bO7+5ouhTKlvX4YfsjQBRxQ
        XmtkxSS+6dMsjJUQnNqf/iISJQ==
X-Google-Smtp-Source: ACHHUZ4tXGxPiz4ktni+OO97FTJgDFPw0UyA0zszutC7ptrnphrTc6e2jp/D0wtgX5qf2OWBiLlM7g==
X-Received: by 2002:a0d:ddd0:0:b0:560:f684:a8a6 with SMTP id g199-20020a0dddd0000000b00560f684a8a6mr3985524ywe.28.1683848939192;
        Thu, 11 May 2023 16:48:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q82-20020a817555000000b0055dbeb68f7asm4459697ywc.69.2023.05.11.16.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 16:48:58 -0700 (PDT)
Date:   Thu, 11 May 2023 19:48:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 0/2] pack-objects: introduce
 `pack.extraRecentObjectsHook`
Message-ID: <ZF1+5PSgo3zAOYS+@nand.local>
References: <cover.1683847221.git.me@ttaylorr.com>
 <xmqqttwisaj5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqttwisaj5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 04:39:26PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Here is a reworked version of the patch which introduced a new
> > configuration `pack.extraCruftTips` to keep additional objects from
> > pruning during a cruft pack-generating GC.
> >
> > The third round was significantly more complicated than necessary, and I
>
> Hopefully you just meant "the previous round"; in a follow-up you
> mention that this is v4 and not v3, which is also a good explanation
> for that "third round was too complex".

Yes, this series being the true fourth round, I was referring to the
version I sent in:

  https://lore.kernel.org/git/27a7f16aab35b5cac391d9831aadb0f2e2146313.1683151485.git.me@ttaylorr.com/

...which this version is significantly less complicated than.

> > I am hopeful that others think this version is in a good spot. As in
> > earlier rounds, I would appreciate an extra careful review on this
> > topic, because of the changing default I mentioned earlier.
> >
> > Thanks in advance for your review.
>
> Thanks for working on it.  I am in the process of pushing out
> today's integration cycle already, so this topic will have to wait
> until tomorrow's, though.

No problem. Happy merging ;-).

Thanks,
Taylor
