Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1A5C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 20:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353395AbiETUBW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 16:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353391AbiETUBV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 16:01:21 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3145A1EC64
        for <git@vger.kernel.org>; Fri, 20 May 2022 13:01:19 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g12so12088698edq.4
        for <git@vger.kernel.org>; Fri, 20 May 2022 13:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yiD8DaaQNaF+8wA0z7T1/BxjCJGiRMc3QRCpMEAAIJQ=;
        b=I5saXz4bhECUBJwpjC5Nv2D9RSI4HYJYkP/AoaXT59oL3t4nHHAbqqUTEwg9peEsTe
         XXAav+sCEFJHpn6ENIOLlz7lr+BE1UH7/Y9d7qiCzkRVcC7htZpLoc7rEje8d3tRdIk4
         TMiD+I4i0V27yhovvSMEaKaKYq9D5nVtMIuP4idyoHHte1WLbMMzYDMEP3Zzbb4s1DKS
         GjuO50rbpQ7scVZ4Du2ivQ7Uo6Oy9UOnvgNDuYpl5BlckCj7lfS0okTNkrZdDqoZnX7g
         gC1bUYva+aVTttMzpTejImCzdz79ufXKCNJs6xjgmm9taU2xT74YiyDowalN2NlFMX4l
         gy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yiD8DaaQNaF+8wA0z7T1/BxjCJGiRMc3QRCpMEAAIJQ=;
        b=zQEtERlEbU/Ld+12zhSBFc2qQ95BA+waqJDcHcfDHdfsVj41rjhLHOfkaG309Z61hO
         bx0JA3um/c+CV4Ub/5wUGT41AXcC9Zv+hDpywoX67i0ycHkcgwEq3go927almOcs3um8
         bDmIkkLRXOCeJARWjUrelPlkByVoADNfM9sSabODo+zp49cw7Qcf0j12hkbsq75h+/AC
         oDZcCII6K/ehCCm+q7A5jrloPfLSV9zeYkXjkjFKLabfSLUikDbfLA1+mSjx/FQnjuLV
         lb2tsWmAYci4bsZxvg0Bi08zURC9c/tWsPW5BZokq3PIuGmqxst8pYjFEfJLXTHOEFTp
         vdtQ==
X-Gm-Message-State: AOAM533QC7AQkHCCueysYn4MTjFrod49+53BffcGFv3KqZr8G6n2Cwao
        fB33JTliqOI7M+HupQKoHsI31jdGnvd3Q7gbltE=
X-Google-Smtp-Source: ABdhPJy9VH540oK78S6P6e9VKiZh8SPTdqgAn4C9ab/vNzXisKTpfrdHe5R5np4P5CJNCRHLBrBorcy0YUjwf3zltwA=
X-Received: by 2002:a50:fd11:0:b0:42a:b6af:6e13 with SMTP id
 i17-20020a50fd11000000b0042ab6af6e13mr12684420eds.221.1653076877704; Fri, 20
 May 2022 13:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220505203234.21586-1-ggossdev@gmail.com> <20220510171527.25778-1-ggossdev@gmail.com>
 <20220510171527.25778-2-ggossdev@gmail.com> <xmqqsfpfhdnh.fsf@gitster.g>
In-Reply-To: <xmqqsfpfhdnh.fsf@gitster.g>
From:   oss dev <gg.oss.dev@gmail.com>
Date:   Fri, 20 May 2022 16:01:06 -0400
Message-ID: <CAAA5oLkpATLtxgLDg3tZzSZLd_cUGkOeDrMN-5QgTqPOhRRAOg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dir: consider worktree config in path recursion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I think I've mentioned this ealier, but the above only describes the
> scenario and does not say what behaviour is expected and what behaviour
> is observed.  "no longer works" is OK, but not sufficient.

I've updated the commit message for the fact that using option
`--git-dir` can also cause the traversal to skip over the repository.
I've therefore had to be a bit more generic in the description, so let
me know if it's not specific enough.

> > +     git --git-dir="test1/.git" config core.worktree "$(pwd)" &&
>
> I wonder if this lets funny paths to be added to the index, e.g.
> would "git add test1" recursively add everything in that directory?

Yes, it would recursively add files inside test1.  I've added testcase
3c which I believe does what we want but let me know if that doesn't
address your question.
