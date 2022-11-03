Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0E6C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 09:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiKCJO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 05:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiKCJOR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 05:14:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60A8DF29
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 02:14:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id t25so3473377ejb.8
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 02:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vJLMbM68RJSeLnbNpjJ1r57tEGQiCXaB5lO8KsZdeAI=;
        b=ER/nHLJFLyRpnCiHmVO/3jbksJV0y9XgvuuTSBIJmF46QZK4SStRpAFvT0iBFXPZ1v
         fN5uYJBQZZv78Mw86CHyJ0ZF5yjW6WLuAFJcVSKvGstxFL9b2C+EuDJChtmVhSycjY8w
         WbjVhMmOqRJ8vA83c+IRg+XdREPK6lMZKyrjPeMJlreHDgsnj+nNVegd0i+kw4TwXnS1
         rT9RixbkVFxNvuOAGwW/k6NzRxs67F5hZ093SLOhp7GxNFYaVaHvsWifrU3Qjb3+F8MI
         32aXv6ZkHyOV9LyaFKnVNII3PMVw5tQ8adE8RXY5xJ2+2VxGb8LCziQMn+EVDujAd3ne
         mAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJLMbM68RJSeLnbNpjJ1r57tEGQiCXaB5lO8KsZdeAI=;
        b=IIoB0ZLybQ6MupsWLCHiEd+9u8GHNzK9tEWG+DZveTcmHWX9rMn/HzwdRuAQECw2US
         YnWiRFyG6h52nHJ0gz8v7jFBhXiPL1rSHlf4b/8j6AxkLNIyK1hyT7dsFPMWFZ4yPf+3
         gJ3/g4Tiaftl4kbxa9vdAbHNaWfe+NiO0TuHmOAQwcRRDgwIGHnDMbFIzuDNmQvzcrER
         lnVcSOVNR5lSwL1EB478nUdVXfSjRsFABqIWjpgWdyKDd5kNWb3YKtsscozqsUb0xHkE
         +rTo8m4gYUlLcqv06ooYbHfvKE5FOjTKC3vurno7CjS2+9hKZIVZ7vCkST4R+Axjuaz5
         hcuA==
X-Gm-Message-State: ACrzQf08oRrP5v18gsE8rI3M9wL2tiBZjiRYeOw04uPFK/msIeUl53Nx
        vfQM287e80YoADPx07drxnY=
X-Google-Smtp-Source: AMsMyM79svfY5mIXonyyhGCgZF4L5d0XC1ZWKm9N9d33MKww8rpPNJjSoUojb01DcZPnQtGjogIB6w==
X-Received: by 2002:a17:907:2bd5:b0:76f:591c:466b with SMTP id gv21-20020a1709072bd500b0076f591c466bmr26858609ejc.504.1667466855232;
        Thu, 03 Nov 2022 02:14:15 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906318500b00741a251d9e8sm236580ejy.171.2022.11.03.02.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 02:14:14 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqWIf-00CLPg-2g;
        Thu, 03 Nov 2022 10:14:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC/PoC 2/5] Documentation Bundles: ignore artifact files from
 creating doc bundles
Date:   Thu, 03 Nov 2022 10:12:17 +0100
References: <20221102224843.2104-1-philipoakley@iee.email>
 <20221102224843.2104-3-philipoakley@iee.email>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221102224843.2104-3-philipoakley@iee.email>
Message-ID: <221103.86zgd81jtm.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 02 2022, Philip Oakley wrote:

> The Git documentation contains many examples that can be prepared as
> repository bundles for users to clone and explore without any language
> or translation confusions between the written word and intended code.

I just find this commit entirely confusing, we're adding .gitignore
entries, but nothing generates these yet (but I'll read on). All to
describe some seeming future feature...

> There are also a large number of example repositories in the t/ test
> system can can also be exposed to users to highlight the critical
> distinctions tested therein.
>
> These documentation bundles will be prepared ar part of the test system.

s/ar/as/

> Start by ignoring those parts which will be considered build artifacts,
> the GIT-BUNDLE-DIR, and the `.bndl` bundle files themselves.
>
> The artifacts themselves will later be manipulated by the `make` elements
> of the documentation system.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> ---
>  .gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/.gitignore b/.gitignore
> index 6ded10067a..b96a4ce5df 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -3,6 +3,7 @@
>  /fuzz-pack-headers
>  /fuzz-pack-idx
>  /GIT-BUILD-OPTIONS
> +/GIT-BUNDLE-DIR
>  /GIT-CFLAGS
>  /GIT-LDFLAGS
>  /GIT-PREFIX
> @@ -250,3 +251,4 @@ Release/
>  *.dSYM
>  /contrib/buildsystems/out
>  CMakeSettings.json
> +*.bndl

We've been putting quite a few things in .build/ recently, so whatever
this is, if you put it in .build/test-bundles/ or whatever you don't
need to write "clean" rules for it, or add this ignore entry.
