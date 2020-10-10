Return-Path: <SRS0=cZ0k=DR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB419C433DF
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BDB420795
	for <git@archiver.kernel.org>; Sat, 10 Oct 2020 22:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rItrnqDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbgJJW4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Oct 2020 18:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731271AbgJJTGP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Oct 2020 15:06:15 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8342CC0613BD
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 12:06:14 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n6so13631364wrm.13
        for <git@vger.kernel.org>; Sat, 10 Oct 2020 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+pC7wpRiac4x1Bar8vBsxpe7MYAxKBROLdV7NEP1/0E=;
        b=rItrnqDIdbVsg8A8F7Xt+5I1szUE4p8472w5GQBfnnl5L1CV34gvA3Z6MP4apG+0oO
         eClG8Kck9s6HLKvZCE4SVhZji8+pbg5WFMrWN2YPDp/+m/mxfzHDwwRw6fcqXfPBFA8U
         Uiy75Rw1CeDqsmg5Ho6WE8+R8GGprcVS9buQmtA93DD2v20qh0fcj/EhzyOka2SRW/yr
         IybffU4P5PtN88xP0onKXMogE0mlxC1sskeuuvLLKf9m+cTqSqBknwv1ozqYiRBMAOFT
         txPaq3Wz7s7PQfZA91uUMV+bM3YhY9wpnCzDezYQcKVdUsFTok3MuDp+eomrTgl53aAA
         Vrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+pC7wpRiac4x1Bar8vBsxpe7MYAxKBROLdV7NEP1/0E=;
        b=kKDrTzb31ig3O94BPIT75OjF17Kjdai75Rmpc4uISHXCPI7QVDRI1/9S9FcR2rBHSV
         gQOtxq8v1U4QYP4+Lyid+kZTP7bG7JsvjL38MMBcSNFJPg7TraAf8z+zNQDoXzuUgQG2
         r1KoLTtwX28W9ryyPO2MJCHa/Pea2M6IeekznayFBBLpqA7HnKNVIR8NohzGtxYlQ2wl
         +UEpr2DcZBiYakLFlf7qtKYF3VFIgzlw88B/jeJwC3Y/Udsy6j4w1EehOVw1L9T+I/gZ
         BQ97/6IRXyq8bwHRpcU+JqKvVb81EMZI2oIWX2zd8p3/1yenBlcDsx1VmS8foJYn2Tof
         BWuQ==
X-Gm-Message-State: AOAM531WixYbwB2HACieaouhCqcFH8YlgHXNgkMSnzCngH3P4gLIlVq0
        jniSryt2LxBTHCWNBPpr6QY=
X-Google-Smtp-Source: ABdhPJxs0Ms2n3EXzo7zG5XgTqtV1YUZARLzRuFtRoQnUFzMmkIUVlHSh87ULwWz9gZgk4EEDYrw9Q==
X-Received: by 2002:a5d:4cd1:: with SMTP id c17mr8990907wrt.109.1602356773181;
        Sat, 10 Oct 2020 12:06:13 -0700 (PDT)
Received: from contrib-buster.localdomain ([79.140.120.253])
        by smtp.gmail.com with ESMTPSA id h25sm32410wrc.55.2020.10.10.12.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2020 12:06:12 -0700 (PDT)
Date:   Sat, 10 Oct 2020 19:06:10 +0000
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/2] teach `worktree list` to mark locked worktrees
Message-ID: <20201010190610.GA23099@contrib-buster.localdomain>
References: <20200928154953.30396-1-rafaeloliveira.cs@gmail.com>
 <CAPig+cQXkP8vTNR+LJ4fZRT-an0vEgKxcFpfi+aQ-BdipTgq=A@mail.gmail.com>
 <20201002162802.GA15646@contrib-buster.localdomain>
 <CAPig+cR8D13cM8OewRVYfg7wNjVC05tVQw80-dm4B5XPmjHJWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cR8D13cM8OewRVYfg7wNjVC05tVQw80-dm4B5XPmjHJWw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 09, 2020 at 06:50:02PM -0400, Eric Sunshine wrote:
> >
> > Sorry for the bit late response.
> 
> Likewise.
> 
> >
> > Doing a little investigation on the code, it seems the machinery for checking
> > whether a worktree is prunable it seems is already there implemented
> > on the `should_prune_worktree()`.
> 
> Yes, when I mentioned that in [1], I envisioned
> should_prune_worktree() being moved from builtin/worktree.c to
> top-level worktree.c and possibly generalized a bit if necessary.
> 
> One thing to note is that should_prune_worktree() is somewhat
> expensive, so we'd probably want to make determination of "prunable
> reason" lazy, much like the lock reason is retrieved lazily rather
> than doing it when get_worktrees() is called. Thus, like the lock
> reason, the prunable reason would be accessed indirectly via a
> function, say worktree_prunable_reason(), rather than directly from
> 'struct worktree'.
> 
> [1]: https://lore.kernel.org/git/CAPig+cTTrv2C7JLu1dr4+N8xo+7YQ+deiwLDA835wBGD6fhS1g@mail.gmail.com/

Appreciate the tip, I will be working on the prunable annotations, verbose
and other information that was proposed previously for the "worktree list"
command.

> > Additionally, having the ability to see the annotation and the reason in
> > case you see the annotation seems like more complete work for the intention
> > of the patch.
> >
> > Unless you think that is better to start with the annotation, and some time
> > later addressing the other changes specified by [2].
> 
> Whatever you feel comfortable tackling is fine. The simple "locked"
> annotation is nicely standalone, so it could be resubmitted with the
> changes suggested by reviewers, and graduate without waiting for the
> more complex tasks which could be done as follow-up series. Or, expand
> the current series to tackle verbose mode and/or prunable status or
> both or any combination.
> 

Thanks. I've just resubmitted the "locked" annotation patch, as you said,
it's nice standalone and can be integrated and hopefully will be already
useful for other git users and soon (hopefully :) ) will submit new patches
for the other changes as proposed by [1].

[1]: https://lore.kernel.org/git/CAPig+cTTrv2C7JLu1dr4+N8xo+7YQ+deiwLDA835wBGD6fhS1g@mail.gmail.com/
