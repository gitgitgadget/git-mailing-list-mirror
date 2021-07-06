Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C642C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA4B61C92
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhGFWCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 18:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhGFWCg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 18:02:36 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42319C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 14:59:57 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id u11so1033214oiv.1
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 14:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=BkGkNPybHZE509mN+HfHnW4Y9m05w4hGupwwKys4S9E=;
        b=oK6no6XybOaz3JlpTNBMTJtPRqkv+Zcmv/qQ0eON3mukRHq9FwlDCImZd4v9hJTOe/
         YLgUjH3Qt5T3+AwEAZwV9sUJrZ3CChHtupZ86ueth7XGSj6IUDjOk35ib9lkyt4gNeAt
         rBo4WjSw4XZrRatPQ0KyQZ+j7xEr2ee230fLFJVryuG9wtr6QgVoWdDz1A7Hl3y1A98x
         MxSyXs/tJZOSDitl9bK4H6TQz3SDCKOEHQlgT7WucZmgY2FDdlR5fGLLuCZhxfwVoerk
         +U3ADdfDI4hn4w9huZXdxwUsjl3KmPM286HPLdBnV/2OyW91/r7RDkiRgRkJtohw3gWJ
         NfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=BkGkNPybHZE509mN+HfHnW4Y9m05w4hGupwwKys4S9E=;
        b=SemLwUbrPnR4CL9rqEOfu7L0vnqCL+SBBbAOqZKw2/E7yLZcC4FkVXXb4zwLsFde/l
         8IshmesCCar/X2a60BTCex4oTUEBI4/e9Oxbd8F0r3IFPWeuTB9ZKnj9MvjTci8e7bUn
         +s68zLEHEugozGJg4jjS349bAB8nJOGsfdx6Im7SN+hMUTQZuvtmK2dgKlk1z6/1EzB9
         vhGPMF22r8y8nCz3t8DZr1Mvyrst7Ottw3bB9iY7CgoMAja1QVmQ1BSa2G9Z6jBh+5xL
         7uCIfUqrBK8pKRxM+9EYeYbp3mA5x7oC+Q9f6Ud+ghp0Te1y2rGCqH4IuIf302zYEW62
         tPvg==
X-Gm-Message-State: AOAM532Q+4yEJAWU3PDgc8Xz4ZQ0lwxanwkf8K3qxzGFvQPY09xz1i9Q
        iEuOAoEXWLGuAHyordLpcGg=
X-Google-Smtp-Source: ABdhPJzrBISKlmtohK074tiabt2mbtDRGGBNYrnRmVlwkmJs3UlOK6yqBAmf55Kf3KVFYe8AsNXfvw==
X-Received: by 2002:a05:6808:13d3:: with SMTP id d19mr2112120oiw.134.1625608796688;
        Tue, 06 Jul 2021 14:59:56 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id n1sm3104571ooj.42.2021.07.06.14.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 14:59:56 -0700 (PDT)
Date:   Tue, 06 Jul 2021 16:59:44 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'martin' <test2@mfriebe.de>,
        'Felipe Contreras' <felipe.contreras@gmail.com>,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, 'Junio C Hamano' <gitster@pobox.com>
Message-ID: <60e4d250efe67_1c4281208f3@natae.notmuch>
In-Reply-To: <044e01d771a6$7c8cefc0$75a6cf40$@nexbridge.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <8735sxaqln.fsf@evledraar.gmail.com>
 <60df8c20e8518_28bb20846@natae.notmuch>
 <5cbb845f-b8a6-939e-cf37-a3b375438616@mfriebe.de>
 <044e01d771a6$7c8cefc0$75a6cf40$@nexbridge.com>
Subject: RE: [PATCH 5/5] config: add default aliases
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:
> On July 2, 2021 6:38 PM, martin wrote:
> >To: Felipe Contreras <felipe.contreras@gmail.com>; =C3=86var Arnfj=C3=B6=
r=C3=B0 Bjarmason <avarab@gmail.com>
> >Cc: git@vger.kernel.org; Junio C Hamano <gitster@pobox.com>
> >Subject: Re: [PATCH 5/5] config: add default aliases
> >
> >On 02/07/2021 23:58, Felipe Contreras wrote:
> >> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >>>> +ALIAS
> >>>> +~~~~~
> >>>> +'git rb'
> >>> So 'r'e'b'ase, not 're'base.
> >> I don't know if 're' makes more sense here.
> >
> >re:
> >restore
> >rebase
> >reset
> >
> >And restore is on the level of checkout =3D> so more important.
> =

> I do not want anything helping out the use of rebase, which we actively=
 discourage in our shop

That is a problem specific for your shop.

The defaults are meant for the majority of users. If a minority of users
(who happen to be working under the same umbrella) have a problem with
the defaults, they can change the defaults.

-- =

Felipe Contreras=
