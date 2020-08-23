Return-Path: <SRS0=2KbR=CB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89535C433DF
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 03:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 646EC2078D
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 03:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgHWDIY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Aug 2020 23:08:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33518 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgHWDIU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Aug 2020 23:08:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id w14so4668069eds.0
        for <git@vger.kernel.org>; Sat, 22 Aug 2020 20:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NhsrHMFk7Y1jqzWqjsP3zIYHy7ne2yvxQZlhdGZLrC0=;
        b=S0hQ306VEPRSeeqx6KhyB3r8Ui0yxcP8sCn20X8rTkS86pNP6di2w9otH43UxcvVDI
         mh4zt84LfNLS2gw9X/VoR+3lgDKlAlAl2QP8ydeGfQFfvKiUf6XuzTyu8D0FyUTFxJp0
         mbAfFqyNmBpMArPgpIGcjk/SJ2j1EZjy1Rdg9VdpeR/gloAN1Zwz+KfY4xZGhBce6BWI
         +WqMqjCGlT65NqA9WN5owao1Ew/d0fhmZjVCUqkGJGoZsYHScNflg/SjPIJiCBR28jep
         B3GIru9txYwK+Bpw7ntJ+nRj8sy+2p97U4D/QoER6ewIE05kBMUddSceB65fW8Ll36o4
         ryyA==
X-Gm-Message-State: AOAM531x6G2/MZeZB0JxA2MUfRn0uDcreALNTKJ1u14eMSJYLve/RnHC
        hfCdB0ABvIGAJcV2ivg1PK436l86rqN3PjoVkRU8UmlQ
X-Google-Smtp-Source: ABdhPJwFHraeH01ZWM9mkvCJVYF2yLiyfzL1UskqIWzufvsxtmx3ppfj2T2VzQDy1VUHYAA33uNkCrXCMXxdYWnvbl8=
X-Received: by 2002:aa7:da9a:: with SMTP id q26mr340321eds.163.1598152098825;
 Sat, 22 Aug 2020 20:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200823005236.10386-1-ori@eigenstate.org>
In-Reply-To: <20200823005236.10386-1-ori@eigenstate.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 22 Aug 2020 23:08:06 -0400
Message-ID: <CAPig+cRjBXEx4ZKRiXOMKhigv6i=uds=DHc8mxSEtqtJOqkN-Q@mail.gmail.com>
Subject: Re: [PATCH] Avoid infinite loop in malformed packfiles
To:     Ori Bernstein <ori@eigenstate.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 22, 2020 at 8:59 PM Ori Bernstein <ori@eigenstate.org> wrote:
> In packfile.c:1680, there's an infinite loop that tries to get
> to the base of a packfile. With offset deltas, the offset needs
> to be greater than 0, so it's always walking backwards, and the
> search is guaranteed to terminate.
>
> With reference deltas, there's no check for a cycle in the
> references, so a cyclic reference will cause git to loop
> infinitely, growing the delta_stack infinitely, which will
> cause it to consume all available memory as as a full CPU
> core.
>
> This change puts an arbitrary limit of 10,000 on the number
> of iterations we make when chasing down a base commit, to
> prevent looping forever, using all available memory growing
> the delta stack.
> ---

Missing sign-off.
