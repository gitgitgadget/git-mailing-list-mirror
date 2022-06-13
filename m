Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C4EC43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 01:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbiFMBN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 21:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbiFMBNw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 21:13:52 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1620220CE
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 18:13:50 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id c144so3066150qkg.11
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 18:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Brn6JpUF2pKWaNmvcDAh7H6EP45vvtf08Musak6d3jE=;
        b=J1XkrwyQPEgzaxd68lQR+Xa7TuCd5w9ScIs1CObHGZ/mhscVw51MC0VDpyYd2zzgtX
         RzJxymm5vGRLKadj4mQcJktJBaglbgKBr+tQMDzQWsJkfqsRAOZ5ehzYwLaGW1CQKqt/
         veRnlZDsuDR7ZZE8X0XCxevljMN0rK3vGKtz3GPZoqgM75scKrbVcvi8LeMkGUvfdjYA
         muYXKaVhM93mu2Qyf6It7N8vpEzoKYVeRL9ezMbax+4xDMeHgw4EGpBFCi8znG61ntbg
         BiLTR26jTTnSKzhKCZfrVy7z99vz6PLVTp0dpcHZcEb6+L5EJFZl56NyWguyxAfOhlmV
         eUxQ==
X-Gm-Message-State: AOAM533PHCkTp0GNKKxvx9mf3qHYg5X3L52TX7o4PnfNzhyiWaO0uT6G
        mVoovR3q6F+qzXRXxXpHBoCoyAtGIz8=
X-Google-Smtp-Source: ABdhPJwivDwOkyXV7gUzv/Bbk1ai3qKM2VAOzfg7NfeWFMOO7pL168vHGsStnPC51QWRv0traMa1hg==
X-Received: by 2002:a05:620a:2848:b0:67d:35de:bb5b with SMTP id h8-20020a05620a284800b0067d35debb5bmr37455289qkp.499.1655082829379;
        Sun, 12 Jun 2022 18:13:49 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id u21-20020a05620a455500b006a6edbbca84sm4436173qkp.94.2022.06.12.18.13.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 18:13:49 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-30fa61b1a83so37269427b3.0
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 18:13:48 -0700 (PDT)
X-Received: by 2002:a81:3d09:0:b0:313:6a95:d84a with SMTP id
 k9-20020a813d09000000b003136a95d84amr27634625ywa.277.1655082828705; Sun, 12
 Jun 2022 18:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqa6awvp60.fsf@gitster.g> <20220608152437.126276-1-fs@gigacodes.de>
In-Reply-To: <20220608152437.126276-1-fs@gigacodes.de>
From:   Andy Lindeman <andy@lindeman.io>
Date:   Sun, 12 Jun 2022 21:13:32 -0400
X-Gmail-Original-Message-ID: <CA+vJLftKhkuVp3b6Tk4WezeCWpYq2Tdy9vRtjxdopbgV94ZsxQ@mail.gmail.com>
Message-ID: <CA+vJLftKhkuVp3b6Tk4WezeCWpYq2Tdy9vRtjxdopbgV94ZsxQ@mail.gmail.com>
Subject: Re: [PATCH] gpg docs: explain better use of ssh.defaultKeyCommand
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 8, 2022 at 11:24 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>
> Using `ssh-add -L` for gpg.ssh.defaultKeyCommand is not a good
> recommendation. It might switch keys depending on the order of known
> keys and it only supports ssh-* and no ecdsa or other keys.
> Clarify that we expect a literal key prefixed by `key::`, give valid
> example use cases and refer to `user.signingKey` as the preferred
> option.
>
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
>  Documentation/config/gpg.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
> index 86892ada77..86f6308c4c 100644
> --- a/Documentation/config/gpg.txt
> +++ b/Documentation/config/gpg.txt
> @@ -36,9 +36,12 @@ gpg.minTrustLevel::
>
>  gpg.ssh.defaultKeyCommand::
>         This command that will be run when user.signingkey is not set and a ssh
> -       signature is requested. On successful exit a valid ssh public key is
> -       expected in the first line of its output. To automatically use the first
> -       available key from your ssh-agent set this to "ssh-add -L".
> +       signature is requested. On successful exit a valid ssh public key
> +       prefixed with `key::` is expected in the first line of its output.
> +       This allows for a script doing a dynamic lookup of the correct public
> +       key when it is impractical to statically configure `user.signingKey`.
> +       For example when keys or SSH Certificates are rotated frequently or
> +       selection of the right key depends on external factors unknown to git.
>
>  gpg.ssh.allowedSignersFile::
>         A file containing ssh public keys which you are willing to trust.
> --
> 2.35.3
>

Nice. This makes sense to me.
