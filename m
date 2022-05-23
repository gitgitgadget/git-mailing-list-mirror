Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B02C433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 07:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiEWHcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 03:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiEWHb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 03:31:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000FD38A0
        for <git@vger.kernel.org>; Mon, 23 May 2022 00:27:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gh17so13782785ejc.6
        for <git@vger.kernel.org>; Mon, 23 May 2022 00:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=gMg9KwvsXh2cUpmfoyVKJWjjV/tx1B0qXxO9B1TyAuc=;
        b=RcE2CYeAqvG6Bs6fPRlHVPU/7YKSwcRILqxH5xlxJM8dxz73D9+Gf8XXANBAabatIy
         g2uprZiiVpdyaVmzYcqk5b5GReprIDiMYAMQKow3x6hBjRBpK0IQEaKV1Flwr80eQ7al
         gmfvNR/D4duPtWPnJguvE2/KwqvZJ51jyMZrI7KJis/dhv3i5o+u1sBj7key617+cGt7
         NeAZtiYPylmS/KtZJvogkkcfFeMr477hor255QVfoYazTd6cdNpk+G8fado+7fzJ1RHd
         3Cuifqa9I2OCLzIx7Q8x78PX5z2qG7PSHUJVn0YJSig/76xHUbnlGT0lfaBhN0R98f71
         xVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=gMg9KwvsXh2cUpmfoyVKJWjjV/tx1B0qXxO9B1TyAuc=;
        b=t3BFfnIXpVe0cDdOY/fv6aiH6vE+9tKYZJ8sxZ3SzuqorXA99o+nJmwC/gXgYewy5Q
         E/+tkpNi4lOco9ff9W31cVX/omLGvayPF3CU3ceXObGmQ3TCyK20fhv7O2AjZLqLFEuv
         cieEe6VaJKe18+I2ksA1+IiQj2e8jbXBKkbZwv+AziwrYt0a8LnQ6AgF/Lb53e3KdLGg
         knKoQSscSs5YgbwZjAPvDcHCKz1vhB+LQ6BZrG/IWE6cNd/PWhW0Sn75iMeQ1Fb2wZEg
         WhO2StcsoEm3StRIJvVveQwrOQoYPlhmcIjrm9/W9PJbCpKoJBMEQRqraqVec6ZoWe7r
         6s7g==
X-Gm-Message-State: AOAM532cVYIoeKxO35cG9lG5bnjpF9A3dAnTprwgA5LAn2fnvNb6LVwe
        FCQ6VLnbDaEFyZQ6G5TXbwk=
X-Google-Smtp-Source: ABdhPJzwwCR7v9rTbBL4UiHkQzHwJvJly1T3uu3Uk3hGOZIh7T7lz6ZiflbhUMdgtNPfqgDCJH5lcg==
X-Received: by 2002:a17:907:7781:b0:6fe:4398:47b3 with SMTP id ky1-20020a170907778100b006fe439847b3mr18196698ejc.513.1653290828681;
        Mon, 23 May 2022 00:27:08 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o18-20020aa7d3d2000000b0042a96c77e9esm7735233edr.91.2022.05.23.00.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 00:27:07 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nt2T4-002mnJ-Nq;
        Mon, 23 May 2022 09:27:06 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Matthias =?utf-8?Q?R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        Christopher =?utf-8?Q?D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v3 6/9] po/git.pot: don't check in result of "make pot"
Date:   Mon, 23 May 2022 09:26:06 +0200
References: <20220519081548.3380-1-worldhello.net@gmail.com>
 <20220523012531.4505-7-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220523012531.4505-7-worldhello.net@gmail.com>
Message-ID: <220523.86r14kzp2t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 23 2022, Jiang Xin wrote:

>  .PHONY: pot
>  pot: po/git.pot
> @@ -3319,6 +3319,7 @@ dist-doc: git$X
>  
>  distclean: clean
>  	$(RM) configure
> +	$(RM) po/git.pot

I think I noted "why not add this to clean?" in an earlier round, but
didn't think it through.

On second thought we should do that, but the reason is that "distclean"
should only clean things that you get if you do "make dist".

I.e. we add "configure" to a generated tarball, but not po/git.pot, so
this should just be under regular "clean", not "distclean".
