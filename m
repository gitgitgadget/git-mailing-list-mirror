Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86FBC433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 00:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B99C8206A4
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 00:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JERtW/8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgFKAQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 20:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgFKAQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 20:16:27 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE665C08C5C1
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 17:16:26 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id c1so2379935vsc.11
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 17:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PTpNsl3emLCiwNpR89teyP/9zRS8vtW127yufTSrE1Q=;
        b=JERtW/8EM5p4cj0WsYotQbb5ODOci3cyXUjhdqm38bxvSFLH2CG/zPKvLM0yYam3ll
         5T7EUgR2Fmdbdfa1/SiqEjUaK6Vhwk2J4cdsC9CUcbo2wzlcOZc2rvSa43OhHeq39Fwv
         uCR21U0CHFWEe0TLwu7pgylt/LDSKq7lpZ/deyW5nfM1aDHAP7vq/sHtKn78NcKmY3fF
         j8YDNoFy38xFxELzQbY4RrqEgc3dPuCcORdICIn+pX+N3b9eaxciyp7mOdM9MqVX1HNv
         VCs5ZL9gJ+44TYVYqpV3l8rGqASJITzPoMxBK+cxt82ilnbVfVxvROYS2/w+qGlFgnpg
         xeFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PTpNsl3emLCiwNpR89teyP/9zRS8vtW127yufTSrE1Q=;
        b=VLmk2Ah6STf949DdVjtAXO05L+eGec0EmUFU3Z3alKtmoaNXamCs83DnPsToBIebgo
         Ej2Sk3uL/5qHgf/CjAGuKeXKCqZDsUA3Qzqm9/vDWVbz/fhf7B0K01dZjzCTRP/42X28
         Dh/+l2fmJqxgHwn6IR5O8Un9kmL1JyQjn7euQpT4Fu3tWTLvIzSCnlcnezr5xPDoH/V6
         UGJOPxQ/8eyUfFUvUANsZRNeqH4iWE4GpbzfE9G8FmSojtrq34+DVNNIFi9zxMGIsV7S
         5/RMXNKIs/62HNHtKKijp3WFdeWb57oPZUrPKdpG6SwWzHRTrqZ/6ScxiD4d20yymzhK
         iDxQ==
X-Gm-Message-State: AOAM533cFrWambzNohKG7lBoesGhF4WU08yHLN+YzhPI6qlm+3gayrgN
        emvPGA9uJAWPI1CsLAAgUWZdWnu9jCd/Fnt2Lws=
X-Google-Smtp-Source: ABdhPJxHUiMvrXfopHKfJ6pHh0NDVP/mIYTMhZgc4WDpBvfsKMwea+cikLbSf0dM+kp2Zn9ncZ1b9Tdzheaq7fBdJ4E=
X-Received: by 2002:a67:6747:: with SMTP id b68mr4818688vsc.5.1591834585865;
 Wed, 10 Jun 2020 17:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq7dweebnl.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dweebnl.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 10 Jun 2020 17:16:16 -0700
Message-ID: <CA+P7+xpMp1Zu6UAoN=uebZ-KOjuhSAJTTnCyHMPxZENweMvCjQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2020, #02; Wed, 10)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 10, 2020 at 4:40 PM Junio C Hamano <gitster@pobox.com> wrote:
> * jk/complete-git-switch (2020-05-28) 16 commits
>  - completion: improve handling of --orphan option of switch/checkout
>  - completion: improve handling of -c/-C and -b/-B in switch/checkout
>  - completion: improve handling of --track in switch/checkout
>  - completion: improve handling of --detach in checkout
>  - completion: improve completion for git switch with no options
>  - completion: improve handling of DWIM mode for switch/checkout
>  - completion: perform DWIM logic directly in __git_complete_refs
>  - completion: extract function __git_dwim_remote_heads
>  - completion: replace overloaded track term for __git_complete_refs
>  - completion: add tests showing subpar switch/checkout --orphan logic
>  - completion: add tests showing subpar -c/C argument completion
>  - completion: add tests showing subpar -c/-C startpoint completion
>  - completion: add tests showing subpar switch/checkout --track logic
>  - completion: add tests showing subar checkout --detach logic
>  - completion: add tests showing subpar DWIM logic for switch/checkout
>  - completion: add test showing subpar git switch completion
>
>  The command line completion (in contrib/) learned to complete
>  options that the "git switch" command takes.
>
>  Is this ready?
>

I don't think anyone besides you has reviewed this, and no one has
commented on the most recent round. I believe this is ready, and in my
day-to-day experience while using this has greatly improved. However,
given that no one else has reviewed it...

Based on a quick blame it looks like some of the most recent
contributors who might be good persons to review this include SZEDER,
Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy, and Jonathan Nieder.

Thanks,
Jake
