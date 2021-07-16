Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28553C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 15:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F41613CF
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 15:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbhGPPGl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 11:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240205AbhGPPGk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 11:06:40 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED124C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 08:03:45 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id o72-20020a9d224e0000b02904bb9756274cso10164216ota.6
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 08:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hVSjEISxUZUZXunrcJhcA901NNyCzmyIg6hB8mTNGBU=;
        b=VZxF23ogxxf5Dc4NFM5yoDkX8Kdphn3jsuTX3IR4c+Cz+De+bBsUW15jXuX7OGlIGc
         zIeRSbhXDN+xHbf5dAgDVt0QmFmYMKf5lBFq+usKEw//RGhOLTtyJXV6h1nEJcOFki+W
         fC1XhmmqrgF871d/Wo+mNpIriRReC8JTkzZr05JoszWdbIqSdntkG+A7ZfCzN8KXPr9N
         6LvBLKVJuNxTe5jFdFIOTPH293eszseycVeAz/WlaJi73ASmOxMW+i38/bkyzHJYRBFm
         qjJhORZglrxzUxBkg1ckp9Fu9xw10QpctzAgNlHCG7yqvFB+BihdHx48gbsOSLMLGgGj
         ok5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hVSjEISxUZUZXunrcJhcA901NNyCzmyIg6hB8mTNGBU=;
        b=YtX3ASbu+Aa+zKym7FYkAyFGYY8VFgfFrNEMOVUQJkMwqMe9+LcVIcVBvqKo1eQAWB
         EbYfrFXIj6YWKPBnsxjk6hH0XTiDD29w7WZkOtP/KyV4wctYD1zVQRslw7bORpE6gMCQ
         RZbou1dMs+YxecBdcYURc+IF5BuGoqf8BwMhUtXXOUHwXsJhCAJsTERodY744zUGEgzG
         JZ7dR4hqp2xWYt/6Hcs2S4MewmATLV/OLJ69HbT/OE20qzfvWKEsHe+6vHeHrpCin0nc
         YaNoiRVV8cKZJdDKJwpz01n3iJU879Cvu2belp93K1omKUdf8jsV9B7YZfXAZ7UJ+k0r
         uMXw==
X-Gm-Message-State: AOAM530jysJAR0ldwLUrNkK7u+V25CO37L0U2n9ArfLa0G5xuB0j4qkP
        UvQ1DiR/AuruQGW1VSCQsDffg2p8JfnnchIL/XULbUMx
X-Google-Smtp-Source: ABdhPJzLRW5I1zIoN2LBXaW2wsWRHuqX7Eqz5CoCFTF/95z58UrMkBvhzG/KXojGPLV6bnN/McusisIAgJF+ST/THeY=
X-Received: by 2002:a05:6830:78c:: with SMTP id w12mr5597728ots.162.1626447824848;
 Fri, 16 Jul 2021 08:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <c62933fb-96b2-99f5-7169-372f486f6e39@aixigo.com>
In-Reply-To: <c62933fb-96b2-99f5-7169-372f486f6e39@aixigo.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 16 Jul 2021 08:03:34 -0700
Message-ID: <CABPp-BEHZcfZNL+PG1vmqXGf4Qs3eoULb4NDDgbmOB30HzJu_Q@mail.gmail.com>
Subject: Re: pull.rebase config vs. --ff-only on command line
To:     Matthias Baumgarten <matthias.baumgarten@aixigo.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 16, 2021 at 7:52 AM Matthias Baumgarten
<matthias.baumgarten@aixigo.com> wrote:
>
> Hi,
>
> this is my first time contacting you guys and girls so I hope this mail
> achieves the expected standard. I've discovered the following behaviour
> of git:
>
> If pull.rebase is configured to true and git pull --ff-only is executed
> it seems like the config wins, i.e. issuing "Successfully rebased and
> updated refs/heads/...", which is not what I would expect. I always
> believed that command line options would overwrite configured options.
>
> Is my assumption that command line options always win wrong or is this a
> bug?

It's a bug.
