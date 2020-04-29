Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC23C83000
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 15:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7513320775
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 15:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdBS/ltS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgD2P5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726539AbgD2P5B (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 11:57:01 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464E1C03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 08:57:01 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m13so2108536otf.6
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 08:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tHrg4iPWJwnmL6PpMTykQBEBtCCgTIoiP09J5zdcyXI=;
        b=OdBS/ltSKWO6Ko8eIG+kaffLzgzBgqXlajRPO+nbhRf3yDPlDjv5CD28RpDCIdyarx
         6ZuidcmChLxoStT4rWYH53xv/5c3U2kBXYpqHFxnbmJl1vyoqJAM2/iyX+4uv5NK9oct
         OYzj03zIausTDx3mP2ciqEF/J9ivhy7qU9Cj2VNE6Tjk33m6xhxqQZe4l8TUsK2xevpJ
         mE0QuRbGuPhfmskM3wk/NRC7mS00W0A3rysa/0bREiQ9ll/PpB9D6MLoC3HJzbygFIFK
         ZdYlSzqOvHanVpj4PjuYRyZ65DDKUdUXrqg6LY7rtx0m/TNxb1EDaJda/R5GiPi1vLdj
         g7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tHrg4iPWJwnmL6PpMTykQBEBtCCgTIoiP09J5zdcyXI=;
        b=EcHAwMsLZy21AlLuhl8KZpAUJGJEvzLHGwE5WVPGf9or202EcSe6QrWCDABEiTR0jk
         zMcuqV5xigpG9ea8++kCxE6TAsRcWejeUPcA+3NWjtgVa/HQrjellAFCXK8Ro4uk0oXZ
         okl9So7mBUnKJK5ctxhvgEQGQiFaZeyxiHlZewewgZFh5m1C8VDnrpB9xvUFsr3C9B48
         grt642G7J+RmD/4UbTGyihqhfB0YvP91NSN1uA6fWnSfC8NwBJBV9sRbAgiKEQPqno9E
         or9uTp5mTiW2lM874hvQ2k9CVBccKdI1dlQERa/GeNYdmsGxqos/mcNGL9nWw29mZ1aL
         sSsg==
X-Gm-Message-State: AGi0PuZB5RSuUurCPC4vnxr8UTb0XW4UTpPnTh5TMIjE7QpZH5knsiUQ
        hsXh30J9r2Kwgj1eapzeWKcXfk/q/W+p/jhmmkc=
X-Google-Smtp-Source: APiQypKvkMSiZV0aeXEvXgZH269HSQSSmvoLgJfM1f9z3fqoM70wouFKlTI1LjaJnlJGo91MgR3qkehUTEF1mQj/v4w=
X-Received: by 2002:a05:6830:1ae3:: with SMTP id c3mr28063744otd.345.1588175820576;
 Wed, 29 Apr 2020 08:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com> <20200429093811.8475-4-shouryashukla.oo@gmail.com>
In-Reply-To: <20200429093811.8475-4-shouryashukla.oo@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Apr 2020 08:56:49 -0700
Message-ID: <CABPp-BFt_5-OyOw9YbYJhhu1P4CJLOi65wdyRckOY5_acRejGg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] gitfaq: fetching and pulling a repository
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 2:38 AM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
>
> Add an issue in 'Common Issues' section which addresses the confusion
> between performing a 'fetch' and a 'pull'.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  Documentation/gitfaq.txt | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index 6f32846e3d..e091513639 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -253,6 +253,26 @@ way of cloning it in lesser space?::
>         Any entity which has not been cloned to save space can be cloned
>         on-demand. See linkgit:partial-clone[1].
>
> +[[fetching-and-pulling]]
> +How do I know if I want to do a fetch or a pull?::
> +       A fetch brings in the latest changes made upstream (i.e., the
> +       remote repository we are working on). This allows us to inspect
> +       the changes made upstream and integrate all those changes (if
> +       and only if we want to) or only cherry pick certain changes.
> +       Fetching does not have any immediate effects on the local
> +       repository.

Maybe change that last sentence to "Fetching does not modify the
current branch"?  The local repository certainly gets bigger, and the
remote tracking branches are updated as well as their reflogs, and it
might trigger a gc, all of which sound like immediate effects to me.

> +
> +       A pull is a wrapper for a fetch and merge. This means that doing

...for a fetch and merge or a fetch and rebase.  This means...

> +       a `git pull` will not only fetch the changes made upstream but
> +       integrate them as well with our local repository. The merge may

...with our current branch.  The merge or rebase...

> +       go smoothly or have merge conflicts depending on the case. A pull
> +       does not allow you to review any changes made upstream but rather
> +       merge those changes on their own.

I don't understand this last sentence.  You can definitely review
changes made upstream after a pull; e.g. git log @{u}@{1}..@{u}

> ++
> +This is the reason why it is sometimes advised to fetch the changes
> +first and then merge them accordingly because not every change might
> +be of utility to the user.

I don't understand the purpose of this paragraph.
