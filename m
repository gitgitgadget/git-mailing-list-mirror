Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08390C07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 23:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E5F61427
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 23:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhGBXv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 19:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhGBXv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 19:51:26 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125BBC061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 16:48:53 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so11721229otq.11
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 16:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=wdE4MuOFYeKSDzinfrQuc7STOtMVdjw680Jf7UMBBLc=;
        b=gEkhs7Ojk7icusos4YA/AsU/FORpn0QDdEjHM8VLCO1iTJSO2KQ/Jp7Sgje3b8++sL
         Xuv9g/bbZmcWaEqlv9TCze+aEXGR3zJL0HvmaitbJN/IvZxl/IPlxiviPnK/l623Pr7b
         I0pySwPOfQciU3lscY90V8YKlam3d1OgPPcyyzdnQqwEYshUpI3HzHwAKFlIlpGPhX4y
         5R0aomB6aA4lWKRRGzh4wPqHwCun8QAp9yVoxdjMxIR/ENyYp38fUQBRVL2BJsazFPmd
         DiGa5YByddTpWMk0s/2rVi/77MGKLU64ppJnoYlCZm7MZtTfOiIVO4oHwO63ifxPsiN2
         rLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=wdE4MuOFYeKSDzinfrQuc7STOtMVdjw680Jf7UMBBLc=;
        b=IhRFTwl4b3kf/agVGZ/RKlysMX7fEE2X0TUH+jfK8OIoolnIQKsdblf+MkRw33TfUy
         j+eboD1KrsZnPs+9GXsV7JJaeFwKMXSio24rb3mhcx/rGqT5qvD0ss6XxoE/Rn48UPHa
         u+cUiUqpy7xxVPLghmax1gJf7BdSapMSlRb9oeMWhDoXdNqrfFGS7tVLGVSQIRh8s9YS
         vOR+18De5jize7BOmirAmcQZ9ybxVvdbJxtKuz+9LuSp7hRHGPtxEahI5bxVb2mGhtEX
         sXg5pxbKtpsp9nT7MgjkKzeeuBiSx5Rt4S/9nSNfsVgcu3mhwJbZ3h1s8UmTnw3xTNIp
         NfZw==
X-Gm-Message-State: AOAM5327/hdL4I0Mys7c72SZMUhzDBY0T2zuk5lMq75Um3EaWMpvIYJt
        wnWkXC9C22sYLVxMXEu6oUY=
X-Google-Smtp-Source: ABdhPJwh598s2xTxXl3gUkNawLZMFSpSC1LY8a+VYISblty7hlrAjm8We5W9E5oy19aonakfW8KCzA==
X-Received: by 2002:a05:6830:34a2:: with SMTP id c34mr1397649otu.59.1625269732384;
        Fri, 02 Jul 2021 16:48:52 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id m21sm912282ooe.36.2021.07.02.16.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 16:48:51 -0700 (PDT)
Date:   Fri, 02 Jul 2021 18:48:50 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     martin <test2@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Message-ID: <60dfa5e28158a_3dd2208b9@natae.notmuch>
In-Reply-To: <5cbb845f-b8a6-939e-cf37-a3b375438616@mfriebe.de>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <8735sxaqln.fsf@evledraar.gmail.com>
 <60df8c20e8518_28bb20846@natae.notmuch>
 <5cbb845f-b8a6-939e-cf37-a3b375438616@mfriebe.de>
Subject: Re: [PATCH 5/5] config: add default aliases
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

martin wrote:
> On 02/07/2021 23:58, Felipe Contreras wrote:
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >>> +ALIAS
> >>> +~~~~~
> >>> +'git rb'
> >> So 'r'e'b'ase, not 're'base.
> > I don't know if 're' makes more sense here.
> =

> re:
> restore
> rebase
> reset
> =

> And restore is on the level of checkout =3D> so more important.

Right. Although we don't need to have aliases for all of them it's good
to be consistent, so perhaps:

  rb =3D> rebase
  rs =3D> reset
  rt =3D> restore

I don't use restore (yet), but it's probably the one most people would
use most regularly, so maybe 're' instead of 'rt'.

-- =

Felipe Contreras=
