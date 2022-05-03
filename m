Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3084C433F5
	for <git@archiver.kernel.org>; Tue,  3 May 2022 23:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242923AbiECXKi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 19:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbiECXKh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 19:10:37 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE83941F87
        for <git@vger.kernel.org>; Tue,  3 May 2022 16:07:03 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id oo16-20020a17090b1c9000b001c6d21e8c04so1993562pjb.4
        for <git@vger.kernel.org>; Tue, 03 May 2022 16:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=90+S/o8/+mPA+lWoI5FMLO2CCJ28zRTjDeMuSbi03KI=;
        b=M38hAqDFY0juOQf8gj+da1+MlL9QAv3cN06bsRs085BUv47BNP3CEbxssDrsek5kdl
         rINEmki3k6Qe+3kJv5FAWw2kiULX2rXNuZa1MDDzxlRIDCPYF12tznNu5jCEs6uLE/Jt
         RsK2n5pi68h3nrMyik3gQ4KsV3PdSP4k21exEI/kKcxtwkkfHYTl1gE8RcUwgF0Zb3xZ
         +2m/04s2akPmyzVtRWprLQIUwqKZOlR4CC06zXvlczWEjU2cwNTJuAQ154bdX2IL/4H0
         FzhjKrRHxjCv1CWHBvxY1i4WC35t9Ppp+llD4ZcND0+TmhTVhK7+xDm0Q56WtipjRWK7
         lE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=90+S/o8/+mPA+lWoI5FMLO2CCJ28zRTjDeMuSbi03KI=;
        b=rjvsJIgBI101O4mdUl6N8svTbOD5rOCd6fLdxPOxNoIX5zTfCf8S8BEpw3OwObPwFJ
         gcbwvR7xWIrbtRIBqI7E+GnivAaIWT9tgnma1W67s/aTzpuQKjRvtd2HesFE4o90kG8L
         vnAZtlAUeiK/hDio/D57VqKV4CNagQrkf4nj8dFk9wdgPdlnDpKK4rM4guvQ1UOx3N5F
         r1KkO1J2DsgRNElSzfEgwGhoFDEMPyjI8drWOpx9J/t1A++PT1kd74fcYQgzktPPbs5f
         6ZzA9QM9URjVNkUyDRBuDhOzPQ/H6nAUVgfjyICAQaWg5wxeMnJa1E/vttMrNAsguQ9Y
         RDMA==
X-Gm-Message-State: AOAM533hly7UL5tcfUNw+BH0bj4ZZ788HIqvkclrXZW9mrG4MLAU36lA
        Qwm6gbkL24ysFhtSupnTvEgyVezepU0UvHN0a64C
X-Google-Smtp-Source: ABdhPJymqN44JNTEPwWjaids5yqUHBcfNv3zB3DYV5sRAsGR8jT0FyUvKd/Rv23f80p9ZtdrR7ExVD9VOSsfORe0nSdA
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:140f:b0:4e0:6995:9c48 with
 SMTP id l15-20020a056a00140f00b004e069959c48mr18104543pfu.59.1651619223023;
 Tue, 03 May 2022 16:07:03 -0700 (PDT)
Date:   Tue,  3 May 2022 16:06:57 -0700
In-Reply-To: <xmqq8rrjv8x5.fsf@gitster.g>
Message-Id: <20220503230658.4170414-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: Re: [PATCH v4 2/8] fetch-pack: move fetch default settings
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        philipoakley@iee.email, johncai86@gmail.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Calvin Wan <calvinwan@google.com> writes:
> 
> > When the state machine in do_fetch_pack_v2() is in FETCH_CHECK_LOCAL, we
> > set a few v2-specific defaults. It will be helpful for a future patch to
> > have these defaults set if the initial state is not FETCH_CHECK_LOCAL.
> 
> 
> > This is a safe change since the initial state is currently always
> > FETCH_CHECK_LOCAL, so we're guaranteed to hit that code whether it's in
> > the state machine or not.
> 
> What does "it" (which supposed to be able to be in the state machine
> and also not to be in the state matchine) in the last sentence refer
> to?

I think the "it" refers to the initialization code that was moved.

> The patch looks correct and I agree that this is a benign no-op
> because the initial value of state is FETCH_CHECK_LOCAL (i.e. the
> block of code moved here will execute pretty much as the first
> thing, and the relative order between that block and sorting of ref
> list should not matter).  I just didn't understand the explanation
> given by the patch why it is safe.
> 
> Thanks.

Agreed - I think the commit message would be better off if it was worded
something like:

  There are some initialization steps that need to be done at the start
  of the execution of the do_fetch_pack_v2() state machine. Currently,
  these are done in the FETCH_CHECK_LOCAL state, which is the initial
  state.

  However, a subsequent patch will allow for another initial state,
  while still requiring these initialization steps. Therefore, move
  these initialization steps to before the state machine, so that they
  are run regardless of the initial state.

I think this description suffices for a reviewer to see that it is safe,
but if you want, you can add:

  Note that there is no change in behavior, because we're moving code
  from the beginning of the first state to just before the execution of
  the state machine.
