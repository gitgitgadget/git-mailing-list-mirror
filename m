Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7670C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 11:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiLSLHF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 06:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiLSLHD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 06:07:03 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E50B10D9
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 03:07:02 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bj12so20479873ejb.13
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 03:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=isQgPvUIODR4PXnzPj6vS++iKm86cvgpBv5qWjy16TM=;
        b=TQJm5tROtOfIdc+NbZDLZHvI8jENSyebFDh2RxiS3gE8vjuKlSiMnYIxukRJn/DrGX
         p3Xz0a+5NEa2eBSXLEUpntS7/DPh2ca9m050HAX7vNGPH15TNY9GQjKEsOC3BoFfwQTw
         j7cCnmBA7MtbSyqhh0J8Q35kNSrJkUEA5jy3FyhZToSMQCwxchYwr/sL1nvWv9QHwIXl
         FCXt0F953ZjiEfoQH0XMW6PXAKZvTPrffPwCvPshrN/O7EQumWG97FJXteFatO7U3D6m
         RgihrGnxYy8cH8mig+KKyjGMvDM1si8lS3JKuSxsRIc9lDWcb4CZCrGWe9yWI3kf5ly5
         Hkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isQgPvUIODR4PXnzPj6vS++iKm86cvgpBv5qWjy16TM=;
        b=RHT4O1bFIQfjF2sP9Z0kSaFl8fHV8qCqU3/B4e5O/FFR30z8Rxjh4iAzhiKk3ggr2v
         ISiZQyVwuAZKZmBgRLPEQixaLdpBpm5PMJNLV0VfOcU+KRGOfo3whK3CqviX+kRa97aN
         1y/iLDla9zz5KXCkqoQu3EAlFFXRkt7xOu74kgPrh2zka51Lqi93lbTmmE4Ie4mN1qnu
         9fa42WYruC0plbQTDSQ8fwOm+lBXNDYCcYt9Eq+86TGY/ES/h9CO59NuenR9cEVgehlZ
         7a7IpNYEimR/SiKdTlQgQn/jShGGlCHsqvQXs9USVfzqBvccjKeQq9SNpHz0R+PJdVud
         /v2A==
X-Gm-Message-State: ANoB5pk+EqQn8J8ee+5l6iN7f6ymsxmprjSF8as6jCYndbxHBoZvoMbg
        r5XKjzLm4+17wWrrxaevLSU=
X-Google-Smtp-Source: AA0mqf5uHwXhT5gOhM4C04UqD0oDmrUNhSA4h/JIvAoaQZ2+SR/2CwDSYG6bFiBVT9pL7JU3KU5Cuw==
X-Received: by 2002:a17:907:2a02:b0:7c1:10b8:e6a4 with SMTP id fd2-20020a1709072a0200b007c110b8e6a4mr28757699ejc.19.1671448020975;
        Mon, 19 Dec 2022 03:07:00 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b007c073be0127sm4204477ejt.202.2022.12.19.03.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 03:07:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7Dz1-006YAd-2t;
        Mon, 19 Dec 2022 12:06:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, vdye@github.com,
        gitster@pobox.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/3] bundle-uri: advertise based on repo config
Date:   Mon, 19 Dec 2022 12:04:48 +0100
References: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
 <857d1abec4cf124e011c7f84276ce105cb5b3a96.1670866407.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <857d1abec4cf124e011c7f84276ce105cb5b3a96.1670866407.git.gitgitgadget@gmail.com>
Message-ID: <221219.86pmcfzm7g.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 12 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The bundle_uri_advertise() method was not using its repository
> parameter, but this is a mistake. Use repo_config_get_maybe_bool()
> instead of git_config_maybe_bool().
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  bundle-uri.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bundle-uri.c b/bundle-uri.c
> index 8efb4e7acad..5f158cc52e1 100644
> --- a/bundle-uri.c
> +++ b/bundle-uri.c
> @@ -610,7 +610,7 @@ int bundle_uri_advertise(struct repository *r, struct strbuf *value)
>  		goto cached;
>  
>  	advertise_bundle_uri = 0;
> -	git_config_get_maybe_bool("uploadpack.advertisebundleuris", &advertise_bundle_uri);
> +	repo_config_get_maybe_bool(r, "uploadpack.advertisebundleuris", &advertise_bundle_uri);
>  
>  cached:
>  	return advertise_bundle_uri;

This looks good, but as with another parallel topic of yours that I
commented on[1] leaves us wondering if this had any effect.

I.e. is this just for good measure because we have a "r" parameter, or
did we do the wrong thing for submodules before this change? In that
case let's add the missing test coverage.

Or, if it's the former let's update the commit message here, saying e.g.:

	While we should use "r" for <good measure or other reason>, we
	already did the right thing for submodules, as "the_repository"
	would be set to the submodule because <reasons I don't
	know about...>.

1. https://lore.kernel.org/git/221215.865yec3b1j.gmgdl@evledraar.gmail.com/
