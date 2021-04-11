Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B6DC433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 20:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C507260FF0
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 20:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbhDKUyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 16:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbhDKUys (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 16:54:48 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E01C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 13:54:31 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so10987271oto.2
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 13:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KrhKaBRzhhhBtxcdNhbFHEV4cghUyj58CYGjMQvjfNc=;
        b=CT++yrLG59vu1jlTuO0PqKWUhGewjWPjZlvHysA7IuIWzMFsrx1M8ugLYvkkVYOi+0
         6JJ7/YUNjIu+qbcBAur867R61IRpGLVyyUdfx5ArbxOv35EO9nQbr4zvaRTBda7KgYwj
         7RH1IkJzk6UulR8TvUTpHxGAgzptR3x1WYRs1zdHkqf/t8Jgs5RZpb0H5V5GHxCW/VTw
         StlaX/MQjL1qIZgqEyCFXakJsur649QoW3d28r2HXfm5UTCQadpM8RqB6pypypgiqeFL
         fm7NPWxJi81BJOPjrHZ3tRJH9t2glbexv7GvOrybz/sv7t1q+w1TBUHiahjYKthBk4Eh
         7JBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KrhKaBRzhhhBtxcdNhbFHEV4cghUyj58CYGjMQvjfNc=;
        b=DPV51JjSKMrGW55RCNz5Zwn6DY9d8b8PewAO7fMCdNua9Q1qIbnOXsQ7f6nVPcEmFF
         nWKPz4F88IDk1mCAjsIqZuudmy+6xI5jQh4OYtVKIsHsSnDZvnMOi5ZSJCJ5EEAOVIIM
         t5K3k6H9CR0pNeLepKpEpa+ao1024n8En9vWsto4bxcqdxj+i7TOEG6hEh4OgA1jMJkv
         3V/EMmCsM+pBMZce/dB4j4hY0/WGE4mFT7vCeIc3MLL3qxMVk95wRjAwIZgnwaeaJBAe
         3Hftxo8WwMKdrtFKvwFXia/dv9VQt9d7XBSq1LflHZ4PtaZU8p37fyVfWTscPFg8X6Bc
         z1Gw==
X-Gm-Message-State: AOAM530YOHE0K9j+X4rqv6XOx/dcnSmXkHWNwLNxXRyh3W2wR/rRMLZJ
        3omnXx0+dWtL2UjcB8pkKvQLSqgOyzGweC/H3WHdmfbJWPFVpou1
X-Google-Smtp-Source: ABdhPJzHrdRlYMQ8ix7LqU3NgX2VD82WOdrEdz1OsHX7J3Gs6FmgLfUstRH6X6+8lsb+YRDDGI8ZC3Nmz2LH6g0rMI8=
X-Received: by 2002:a9d:740c:: with SMTP id n12mr20772672otk.21.1618174470896;
 Sun, 11 Apr 2021 13:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210326024411.28615-1-stdedos+git@gmail.com> <20210403122604.19203-1-133706+stdedos@users.noreply.github.com>
 <xmqqr1jq7bzc.fsf@gitster.g> <CAHMHMxUVy4MUarT-q5EHwf_6cPNn+TSmNDuQbuxXvYPpnQTmpg@mail.gmail.com>
 <xmqqfszwhc2e.fsf@gitster.g>
In-Reply-To: <xmqqfszwhc2e.fsf@gitster.g>
From:   =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Date:   Sun, 11 Apr 2021 23:53:55 +0300
Message-ID: <CAHMHMxXKZMju30UKUAYUUOH4fMrtOV7Y3rZyneJ3VJMk15AkDQ@mail.gmail.com>
Subject: Re: [PATCH v3] pathspec: advice: long and short forms are incompatible
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos+git@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 11 Apr 2021 at 22:10, Junio C Hamano <gitster@pobox.com> wrote:
>
> Hmph, that is unfortunate.  As authorship and sign-off is a part of
> the mechanism we use to keep track of provenance of our codebase,
> we'd prefer to be talking to somebody whom we can reach when needed;
> the noreply address apparently is designed to be unreachable, no?
>

I would like to "just" contribute, if possible.
If someone *really* needs to track me down, I assume the mailing list
is anyway already public,
and the patchset title already will directly link to the thread.

With regards,
Ntentos Stavros
