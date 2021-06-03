Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100E1C4708F
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 01:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9243601FD
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 01:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhFCBij (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 21:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhFCBif (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 21:38:35 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF3BC06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 18:36:51 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso4262894otu.10
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 18:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=92KZvFfQ0n254J7sYmio1p/UdwNg1M/cDeFUX0kVxz8=;
        b=WCNcLipPDXXgLsQeIhnwF03jyUb50aZI7mrYUmmfHiooYt07tWBgDNaz6zA5Dlbj0Q
         j9C2azEcYSStaOib//BVQgYsDdrzCyP0/TEzmQMIe6aPPuJhyXRkS//x2PUvUcPwgBQx
         0PS4Slqf1wdFsxULxntcl5LGzqI31xELZe4hYxm7/S05iN6aH2YC0x0QEmJf9up+KzrI
         waHaqERMTCFqRTIVS2vdvIT1yAxVrW9ROJjDq8RRUydiWImkVxH9jHhuv/EdU89D56Km
         WFTeAcU9DfO2ot8A7eE9t4FVfwi9KIQqYqO38QsUJUYOZoFSvlnxY6aGtudi4tXxOBRu
         U0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=92KZvFfQ0n254J7sYmio1p/UdwNg1M/cDeFUX0kVxz8=;
        b=hZhazw9Bh2qXhzKqkwl78QOutgakOZ5HIXdpeCJslx+HCm3nkP3inP9YO0qLh5vDu9
         Ih/PfMpnYiEjiDovDyE4tAk2ATeizcyMhWXkoyVztpNPqgfmKt1l0PIzxOevTmo1fkxW
         1wn5chTb/d58ua0/XhCHv8wWZms7gFzGnqmmiaj9jFfsZNT8WSG4otg0hDYH/MXa4uk2
         7dRsZ6UMXLMsEDz5m5uKrvMWJzQR3xMF4WVcgA2lOHJgHBq3VsZw+OQsDTPSxdR0ySfa
         nYcXBcTi8Egke8qwfN08vfmyIcedss6JYCJws8/xX74ZrSS+I3I4qZle/FQZNnTSYy7u
         c70A==
X-Gm-Message-State: AOAM530tXes5i64ibQJA7i1QBTEfwFXr2XTbF4x8iPMZaxpD/2Ja8RaV
        2U1kHeQIO14ZwwY4ZDd7My8=
X-Google-Smtp-Source: ABdhPJx1hUqpqUjX5kPxcyS11dTljAz8nJngsXI3h6dl0wjI4BsErw4JgB+ATGI+JO+v6l8cG6chTQ==
X-Received: by 2002:a9d:4046:: with SMTP id o6mr28125141oti.189.1622684211183;
        Wed, 02 Jun 2021 18:36:51 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id q5sm391350oia.31.2021.06.02.18.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 18:36:50 -0700 (PDT)
Date:   Wed, 02 Jun 2021 20:36:49 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <60b832316cfa8_187c7d20826@natae.notmuch>
In-Reply-To: <CABPp-BH7f+sM_POEsSSvmz_p=oEzHQcvTk_cEhTGeb-yq9fq_A@mail.gmail.com>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <87wnrd6wqj.fsf@osv.gnss.ru>
 <CABPp-BH7f+sM_POEsSSvmz_p=oEzHQcvTk_cEhTGeb-yq9fq_A@mail.gmail.com>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Tue, Jun 1, 2021 at 3:39 PM Sergey Organov <sorganov@gmail.com> wrote:

> > [diff]
> >         algorithm = patience
> 
> Any reason for patience vs. histogram?

Is histogram better than default?

> > [merge]
> >         conflictStyle = diff3
> >
> 
> Anyway, here's my list to join in on the fun...
> 
> [branch]
>         sort = authordate

Nice. I didn't know that existed.

I have `tag.sort = -version:refname`, and after a few days without I'm
wondering why it isn't the default.

> [alias]
>         brief = !git log --no-walk --abbrev=12 --pretty=reference

I find it odd that you prefer `git log --no-walk` over
`git show --quiet`.

> [log]
>         mailmap = true

Another one that I don't see why it isn't the default.

Cheers.

-- 
Felipe Contreras
