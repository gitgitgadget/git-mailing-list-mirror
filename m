Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE03C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E0DE60EE7
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbhJKUJx convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 11 Oct 2021 16:09:53 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:45703 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbhJKUJw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 16:09:52 -0400
Received: by mail-ed1-f51.google.com with SMTP id r18so72250875edv.12
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 13:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N7nhtAJQF2RlRpKlJ+lb9146/1FasMPSOS62c6N3WqE=;
        b=SrKXSdOnQR6wedRKGTrmdNhjb5TDtei2spBf2NOiUKRbPMK53LYKUVko3eWG8PBcfS
         uIIxtZuXDVk6bEsNKbgwIAdHBWrt5H/X+rSGwNJIDy0018R60Ga78pmfccviSyaUfrkS
         pnfONqTsdZTaMTzqqanU0zq4UtHndSgNSKePEaCmlTxo9abx2b7qCrPhVZCCHD3gzuRH
         uTWW+IcaqwIG2Ew7OE7qk8yXkoFlP6B13VGniotq7zK3Ekh5yldlaQoTAVE3QcDZ0UY9
         Ll1ij8U3FfO7aWGcmHSTetoKEqu3GEnnAxPGGnEha4NfDn134CYFcEQRhy5vZIs5jYQE
         Ri6A==
X-Gm-Message-State: AOAM5303v9HFwWNeGCVv5RznYjfrt6dsMkv5yrZFTIbmmBR6icsAdCGr
        95n+j8qr+MoMlB4KVHF86G3OQWrXhtn2FYErS4iBoscZZ9jaaw==
X-Google-Smtp-Source: ABdhPJwmcOwlcR4R+Hdm7q2kCw+DyqUqHmkziBbsA1UgnIHXRP0P+E2xsrXa1FB0k9foen/XZOMOdrMI9JC3HYrI0BY=
X-Received: by 2002:a17:906:480a:: with SMTP id w10mr28658640ejq.262.1633982870873;
 Mon, 11 Oct 2021 13:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211011121757.627-1-carenas@gmail.com> <20211011121757.627-3-carenas@gmail.com>
In-Reply-To: <20211011121757.627-3-carenas@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Oct 2021 16:07:40 -0400
Message-ID: <CAPig+cSJentAiOGhqKpgZgXDW9NAK3OMHhKyn6auYN7b=Vk74w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] rename all *_sha1 variables and make null_oid
 hash aware
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Cc:     Git List <git@vger.kernel.org>, angavrilov@gmail.com,
        Pratyush Yadav <me@yadavpratyush.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 11, 2021 at 8:18 AM Carlo Marcelo Arenas Belón
<carenas@gmail.com> wrote:
> Before this change, creating a branch in an SHA-256 repository would
> fail because the null_sha1 used was of the wrong size.
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> diff --git a/git-gui.sh b/git-gui.sh
> @@ -1820,10 +1820,14 @@ proc short_path {path} {
> +if { [get_config extensions.objectformat] eq "sha256" } {
> +       set null_oid [string repeat 0 64]
> +} else {
> +       set null_oid [string repeat 0 40]
> +}

Should this be using:

    git rev-parse --show-object-format

rather than reading the configuration directly?
