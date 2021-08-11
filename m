Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B07C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 19:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9533060F21
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 19:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhHKTlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHKTlI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:08 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47776C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 12:40:44 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id be20so6261331oib.8
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 12:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=7ObpSRaeCQOTS3rqAgMHO0TS2669L+goDc5eyUirj3k=;
        b=DvvuVFhhU+H6zZbtkUgUBCO+XCakhf6u/jSeKz9UNMV2laYXhM3ETB66bqzu1Qj1xU
         3S7xTCPg6xPFv3zki4LbI0kV648TuwuoI9L8mPHMn6oDZXuTBv1V6cEL1ASWUBbSIM/4
         oFEZfwD3PjC8bCYntRkix3/w7lQmJyb0uba6s8zPc1yuz04i8YWVvpDfs1rHoJx1vAZg
         tpHizHE8UuzN9IwUE974f0s/OtZ0Wyb8qV8rLb0jC+HdNE2xKxbUEwRWukaPDsUIH4Y3
         bHZZNWDgT3rfRIEZtbrLiaXPreL1NwP8ediL8AiLy9NCw+dlc17bRILLiXti0MKexO5u
         wlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=7ObpSRaeCQOTS3rqAgMHO0TS2669L+goDc5eyUirj3k=;
        b=KruLvjyvdPrPSKrsvqyypmOIXiBC2qF4TLmTSbBm/kz5IIXlSb8a07TLnnA2ma+OMS
         6A2AG7ZRpibBgC+XkQGaJ4st4YS3Nmy3vbXGHs9CEB9esJD/ZyiG78tYuY88MrtD8nne
         GCmkcSyt2hJWmYSqvPcKsIMxMTFcIXPbpTJnUhrIPIpfithPt6yumjEl/E0gd2KAfuK+
         oNm0/QycK1ixjGHevILi1SoRY9IZvFY5rfX7iuKvJjsvZ2MIbgeamvgTLsu3xOjkpH2B
         sjDufKSTIT7O+C+DAYuzOwd3Q+32/5hBdTggzxY93GBws01v1W/gakeoJHZPX2Mr4CPh
         0I7A==
X-Gm-Message-State: AOAM5300MpvKIDkysjHxkgeUREyB9pIxFInWPYqafXKWjycT5D/9kwnQ
        i/7BTZZVE7CvnwOxtCvfQmI=
X-Google-Smtp-Source: ABdhPJz9E/T6LyaaLq9MuV7BSExJcNdXZuN/T3D3Ksem3BueH1oYC+CYZuVaju9M8VRLb58xHRKbuw==
X-Received: by 2002:a54:4f19:: with SMTP id e25mr394336oiy.61.1628710843502;
        Wed, 11 Aug 2021 12:40:43 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id 95sm88990ota.70.2021.08.11.12.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:40:43 -0700 (PDT)
Date:   Wed, 11 Aug 2021 14:40:41 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?VmlsbGUgU2t5dHTDpA==?= <ville.skytta@iki.fi>,
        git@vger.kernel.org
Message-ID: <611427b9cd4f1_19f82088b@natae.notmuch>
In-Reply-To: <20210811191637.775693-1-ville.skytta@iki.fi>
References: <20210811191637.775693-1-ville.skytta@iki.fi>
Subject: RE: [PATCH] completion: avoid config variable name lookup error in
 nounset mode
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ville Skytt=C3=A4 wrote:
> Config variable name lookup accesses the `sfx` variable before it has
> been set, causing an error in "nounset" mode. Initialize to an empty
> string to avoid that.
> =

>     $ git config submodule.<Tab>bash: sfx: unbound variable
> =

> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> index 4bdd27ddc8..ecc9352755 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2631,7 +2631,7 @@ __git_complete_config_variable_value ()
>  #                 subsections) instead of the default space.
>  __git_complete_config_variable_name ()
>  {
> -	local cur_=3D"$cur" sfx
> +	local cur_=3D"$cur" sfx=3D""

For what it's worth this would break a fix I've sent several times
already [1].

The proper fix requires changing __gitcomp as well, after that sfx can
simply be " ".

All the patches that fix all these issues have been sent, and if you
want to try them out check git-completion [2].

Cheers.

[1] https://lore.kernel.org/git/20210707023146.3132162-5-felipe.contreras=
@gmail.com/
[2] https://github.com/felipec/git-completion

-- =

Felipe Contreras=
