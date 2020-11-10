Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE853C4741F
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 01:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85051206D8
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 01:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiQ9Mc+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgKJBKY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 20:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJBKY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 20:10:24 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF26C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 17:10:23 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id o15so3020062wru.6
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 17:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yg+dQJlL6dHdS8MRLTCCHCEm6n11KvgZjgvFAx+w8IA=;
        b=BiQ9Mc+PJZ96m4g/NkD5nyClW09Kr4jDZpVYBtKLsTDZ9QY+qKVGWJrJEJVFzT1NXi
         LVj0CFE+hBFF1kO49oa//kmpJDQZ2HKF+GRbiDnBo6iqkRm7LDsHEDGBlJY7wEXlcpVd
         JbYdWO900FqHRFLbUYdlHllI4kCXoHqS4ngztjtEUlJG+cmBk8WQ06+FOm5fMb+HmZDL
         nPyGx3pfueXfMk5jlJKYAGQ3OvvU8Ev51LaZxSKc01wWngtgRsyBjOOPsM1eso4Dynhd
         5b+q0ILpk9WIGR0/t6l9+oItdrLCJ8TDLM2zhdtdhBk+dr1vi+9KK1joCZ1SeuqlRT4O
         0dKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yg+dQJlL6dHdS8MRLTCCHCEm6n11KvgZjgvFAx+w8IA=;
        b=Cw1SlowIeXSvxsgMf2U7hBwxzd9DGkfo3DQRoNTkeUd1FVa61vlr4cRoxpI9v9RGp0
         ZwTunWoMHO95arggtXvj5WCyCBD+uft5yOh1s2A4mrKB/qVu4K4oEKUlPEFvTEuobEqY
         QnwdwTuO9ZBdRg5csrPivOen4dKVOJSqxCJcuhrWdxUuTdsWqFgYJi0eNPqaHYZDJju5
         SYYrBXQeFGlois6//4rrgsR+/dO51Tmj4gL1i0YLuzhRbChiJBiGeAr83j2j4fjTryWc
         WSL8qYB1Xf6ufAdborJ5I/mMoiZ9mHrji0qjxlVKfw399vM4l4GOt3gK/IaNE0Wynb52
         hOFA==
X-Gm-Message-State: AOAM531nLhRFiRdhJ4TYgnYWCtfn4kyHo1qiBCI5It+Ei21JRs9fRDlP
        i/eVKkOkeOP4nuqLSwvYdlz37AGFBTBuSL2cXZJ7JYh/I+k=
X-Google-Smtp-Source: ABdhPJxygJvICLmbxXuDGk8mfU/BM23p1PxHdhN+1EVO23zcnOfHGX3E1LUmVQ3UbE43n6qB3QDmoeGGgxlhuwNSUEs=
X-Received: by 2002:adf:de91:: with SMTP id w17mr20381226wrl.84.1604970622270;
 Mon, 09 Nov 2020 17:10:22 -0800 (PST)
MIME-Version: 1.0
References: <20201109215248.461167-1-felipe.contreras@gmail.com>
 <X6m8R9erSxGlPXq2@nand.local> <xmqq4klyb1w2.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq4klyb1w2.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 9 Nov 2020 19:10:11 -0600
Message-ID: <CAMP44s36ThnMondH8w-VDi4vWNL0Cpkx+o1qRkx_giJvyfh0dg@mail.gmail.com>
Subject: Re: [PATCH] completion: bash: support recursive aliases
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Git <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 9, 2020 at 4:29 PM Junio C Hamano <gitster@pobox.com> wrote:

> >> So the completion should detect such aliases as well.
>
> Two comments.
>
>  - on design, is it possible to make a set of aliases that form a
>    cycle?  do we need to worry about such case?  what does the
>    current implementation do for an "alias" in such a cycle?

Yes. The first try would be stuck in a loop until the user types CTRL+C.

I already sent a second version that fixes that.

>  - on implementation, it is done as a recursive call to the same
>    function, but a loop that naturally maps tail recursion would
>    also be a trivial implementation.  is it worth rewriting the
>    recursive calls into a loop?  if we need to solve the circular
>    references (above) by say limiting the length of the cycle, would
>    such a rewrite make sense as a way to help implementation?

Yes, that can be done. I opted for the minimal change so it was easy
to understand what the code was trying to do.

The second version works in the way you suggested.

-- 
Felipe Contreras
