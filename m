Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7B5EB64D7
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 05:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjF3Fso (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 01:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjF3Fsl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 01:48:41 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F250122
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 22:48:40 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b69ff54321so23299731fa.2
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 22:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688104118; x=1690696118;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WrG3TA8RJLiVz0oFe7SNhE0TOouFWr758EzgtBnliwQ=;
        b=gCSfIDYhw98ezXzs8EMsogXVBHJmfUisoeqRoXq6u9lIWUpE/YDMounGC04d7ayCVB
         sSUdkhRn/Q1x23rb8/xsGxgIL4XAYxhWWAVrQDJHQS8/sLWij0vCHN527+SKneaJ0Q9o
         wm/gj5qT+blx/5h8z5LzS5oQRDn58cWDCn/aiBWEidui04AHNndE5G18dphbOuKDHin6
         jHYwQsLtPK47xVIMxihKoYe4WzKN9bLxfb8kl9bZ2h2AEGTVhhlbMSUaLIaRqkrGLvOd
         JbdrI8WMywHPx+2wNuDaR6faiQCAOD/mbhe/NwFKm0cH3EY1BqMRQGRDf0r3WEMdOXs2
         y4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688104118; x=1690696118;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WrG3TA8RJLiVz0oFe7SNhE0TOouFWr758EzgtBnliwQ=;
        b=MWBqOiYvsRaZAEIj2vfNZ/BF4vD/wQsoHbc1J7RZcce401hwJBC0oWQJJsknSdIF2c
         P8tvJRxJ8lsGQSLLNnJUYU2gcGNjxU7TRnPiguUrbsu86Tn6DPp/Zdd5eQiteIIQpHKx
         iNKOGP+RESgUXtRHxJk2I8TppdeDdK3aXvuHz0TcC8PS8c8wYustOW/RRQpUH3ZK2ARm
         EG0T8k93m1JIjuml60J7b1nhPCz1mqUDwpP1Of7wQUtFiVFeX68MGQb+5zz4jY3Biyvj
         5RWbnuaGRN5zA5SBlEoCU3GGfZNP2jArrsGdJDR+mhtMabnEV7tQQwgLvb/KX7wZxVic
         w/0Q==
X-Gm-Message-State: ABy/qLZ89U5XKzKUPHCqcCJeMDlIE5Ns3no24oK42PcfV1QVkDlZzmdP
        MsVmddYRFt4CHDR7OntN3NBNkFOW309k1B9uAFAVTvrf
X-Google-Smtp-Source: APBJJlFfCWSwVhQyQASnwclxhLxABknuCkX6cOnYAV7kRzkrI0Uw/ih6G9lwWguypXPZCFV4Bfw9/YOfOLMm5kvbsok=
X-Received: by 2002:a2e:800b:0:b0:2b6:c886:681 with SMTP id
 j11-20020a2e800b000000b002b6c8860681mr1154936ljg.6.1688104117954; Thu, 29 Jun
 2023 22:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <CADE8Naq5W3Bn=gwV7W-xMvYOMMRO=ZY9Ly6im4Rb_qFjMWTbTg@mail.gmail.com>
 <CAJoAoZ=OEfsgkqsag926tH4GEuafX26A09SGZ1vR1uLh2W_4TA@mail.gmail.com>
 <CAJoAoZnVAe3kvUdPZmanbKffG7cx3Tc-==H4+FH=L5qQP2smEg@mail.gmail.com>
 <CADE8Naonm+bW_jVvJKmnfZWQyX=0-QVSHxpSaHs1qo+5DsCiPQ@mail.gmail.com> <CAJoAoZ=X9hwZZ9eN2X=g04k2E6=wZsY1WEKFydMreNJKM3Mzng@mail.gmail.com>
In-Reply-To: <CAJoAoZ=X9hwZZ9eN2X=g04k2E6=wZsY1WEKFydMreNJKM3Mzng@mail.gmail.com>
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
Date:   Fri, 30 Jun 2023 11:18:26 +0530
Message-ID: <CADE8NaqSn7DvvBHzLhGdWwZtwK+sxoKnVWo_G26P30p_WnVXJg@mail.gmail.com>
Subject: Re: Documentation/MyFirstObjectWalk: add #include "trace.h" to use trace_printf()
To:     Emily Shaffer <nasamuffin@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 30 Jun 2023 at 04:39, Emily Shaffer <nasamuffin@google.com> wrote:
> Yeah, I think there are two things to fix:
>
> First, a patch to Documentation/technical/MyFirstObjectWalk.txt fixing
> the snippets there. (I thought that was what you were offering to
> patch in your original mail, I may have been mistaken.)
>
> Second, optionally, a rebased-and-fixed-and-your-attribution-added
> branch of the reference impl that I can force-push to nasamuffin/git.
> The more I think on it, I don't think the PR will help, since I will
> want to just force-push that whole branch so the commit order still
> functions as a learning tool. So if you have it even in a branch on
> your GitHub or GitLab fork, or a series of patches you'd want to mail
> to me, any of those are fine and I'll go ahead and rewrite my branch.

I will be pushing MyFirstObjectWalk's implementation to my Github fork,
but I might need a day's time to do that(I don't want to leave behind
any mistakes).
You are right, a PR surely does not seem to be the best way to do this. As soon
as I finish(shouldn't take too much time), I will reply with a link to
the branch.
Would that be alright?

Thanks a lot!
Vinayak
