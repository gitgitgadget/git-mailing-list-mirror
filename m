Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B627C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 13:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DFD5208E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 13:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+jpye2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgGaNp4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 09:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgGaNpz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 09:45:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B0BC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 06:45:55 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id q4so19175499edv.13
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 06:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/fTnZsu9wDbWCpmdieZx+pMEE12WS7JPPFcItdtzzA=;
        b=K+jpye2xypPuMz0pQyyUzb/1duoOtzMq6997jNC2nE+cLQC67fDGntBct5bLw3XsW7
         dtDL/hQj8KJI+XvpgSmGCg2nnLZ+GaG8b+r7Vu9cP6mUjyuU/337aA6r83BS64oniJ2N
         1op6VJlJPSHxZVrJnIpbL4cjexzijg5glwn/3LSR+EBrDRMFlD1umrZc3OyWYuZpLoIO
         VyrbX9Fy9cjImb51I+9cVqK3qz2+p/1zZraD8sSSO9e3qDFVYN+0qdyqZxndbwbqEc6C
         ogeN12MXz44w5rM+Mim/HWlHkEY/WyQje4daMavTdAcPZWSKBLtNHmmFQm8c9nTvF+0x
         dX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/fTnZsu9wDbWCpmdieZx+pMEE12WS7JPPFcItdtzzA=;
        b=F8PEyisJ/By09kHQZjWwlczOJXIq6M2stbq+RL/yMbKz7fP6KdonxDU5W4eK4JMWZa
         VGU0alSJgmMcypjmw5HChAfe19sXdfyZhLdxYfsrFebwhREQK6FPJqyo7lGGrwLE/htN
         LmNjByHeLhvIK9Chl8HxqKq4ZdRPh0QGVPDVvia4JhRs1v7Hwhai2mW3dc6WWEyuUBep
         nCqFB7ObvhRz39dNYXn/Sj2n76+/J8FzMfePiMCeuH2Msueh5laaXffUjr0hHy/l9ULk
         MwymeSlmTgj1OiVZ51X55mn685p6x+DkU9kG1s4KGx0p+ZQphU24PULErpgPtoBnrIJs
         QQWw==
X-Gm-Message-State: AOAM530GgJ5wST+Ne8GL6cJFPAuVNr8CES544DzQzlwRZPy36YzBg7Bh
        3mW9RPLiy868grMdcnithlUuuLVzre6oRetTi0c=
X-Google-Smtp-Source: ABdhPJy6KCLGYsEKRiiMP3PHzKxhGVhfpwdw+9P5bgHZaSnYmhmg5lgTqiRSaAJaNwxArScFSKeTl2o8WH5RbEPCw24=
X-Received: by 2002:aa7:cdd2:: with SMTP id h18mr3906706edw.387.1596203153306;
 Fri, 31 Jul 2020 06:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200505104849.13602-1-alban.gruin@gmail.com> <20200630151558.20975-1-alban.gruin@gmail.com>
 <20200630151558.20975-6-alban.gruin@gmail.com>
In-Reply-To: <20200630151558.20975-6-alban.gruin@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 31 Jul 2020 15:45:41 +0200
Message-ID: <CAP8UFD0QR6cS4XxzLoQBsDAP3sDz4yXkkT1_Vgs_hVdWC+QRvg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] stash: remove the second index in restore_untracked()
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 30, 2020 at 5:16 PM Alban Gruin <alban.gruin@gmail.com> wrote:
>
> This removes the second index used in restore_untracked().
>
> The call to `read-tree' is replaced by reset_tree() with the appropriate
> parameters (no update, no reset).  The environment of `checkout-index'
> is no longer modified, and the cache is discarded when it exists.

Do you mean "when it exits" or "when it exists"? It could be confusing
as you use "exit" not "exist" in 2 previous commits.
