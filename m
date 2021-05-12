Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C7DC43460
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D7E61207
	for <git@archiver.kernel.org>; Wed, 12 May 2021 02:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhELCs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 22:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELCs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 22:48:56 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864ECC061760
        for <git@vger.kernel.org>; Tue, 11 May 2021 19:38:59 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso19325715otn.3
        for <git@vger.kernel.org>; Tue, 11 May 2021 19:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=hTiYBp6xhtAIaRbtKt4Ps0xFwVv+zN9Hk9JhKFqWms8=;
        b=Lyt5RCjFyVzvzNxeWOJeYCCH4so+Jlyh2qaxVmxHh2CEVOJEcw9zT7WH6zHms40OoU
         YOUULNgqPA73dOL2mXSs6YZKdwnSG5mh42G2yXNyUUHI4aqSkj9ivXUU5hANVaxfnzJY
         wcIOSpzKNc0Gm9NJsNo/sw+5Yif8r0eOrAazVSLXNvrP9ZYtf2FWYFE+kysrsjJbIpXF
         hSh3BGYuDNyuUcb4lbFLTuJ1K5EkS9up1aUNM3Gie8yIkk35pJnAkwxqJCa2eR/+v4ax
         IshIU5ECHJlTkUTWEDdgJg+k6sEpBG24V7KeJWjejXWOzh1FAEc0fdQ8+TBlAYSKpC4A
         Wegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=hTiYBp6xhtAIaRbtKt4Ps0xFwVv+zN9Hk9JhKFqWms8=;
        b=ZAZxQC0ZclUtOKhdeHWfz9ZszVeSYhOPebUlgrZEa8wCqZHAVC1HdQUo8yZegWOGYM
         for/cJyI2GEv99BaNUQjunT9h1W1dNdtx60UO/8GjAqzyslKeB0bnVK2sbQX+Xt9flB/
         ibuTsCPqjm+exEeDfQ2irDl25M0ZoulArVnWVin3FruI6YILdxpYd4MVvmgBqTfkOUxs
         UCf9pFVwtJcgyPF6G3jZVtabBrvIxv1/vLQifmqZ1JB8yzO5UB8FJGWxUtGchc5vj1s2
         phDgxtE5e0Oxt8n4MRyruaoTP4HwRPaGyLOsYNFfCDvbRVBQBAr+FE6m0Ir01ocwVJ6A
         rqfw==
X-Gm-Message-State: AOAM531oY/LModdHrnTQGrF51d1laKDKl46WGKF7/BR2GdFCTI1JqYUg
        SgfVaji1E1/G7hvBq41oRNk=
X-Google-Smtp-Source: ABdhPJw5/0hafRya997m+buL4+oifcrf+uvPgMWxPdlFrwk9gSI4yXsOlCoinrQn9oWcrVJq4lT53A==
X-Received: by 2002:a05:6830:1690:: with SMTP id k16mr28228290otr.54.1620787138924;
        Tue, 11 May 2021 19:38:58 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id a18sm4295491otp.48.2021.05.11.19.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 19:38:58 -0700 (PDT)
Date:   Tue, 11 May 2021 21:38:57 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Varun Varada <varuncvarada@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Message-ID: <609b3fc167d3b_678ff208ce@natae.notmuch>
In-Reply-To: <20210428184956.GS6564@kitsune.suse.cz>
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz>
 <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
 <YGzoX9OeWMKXpqtf@coredump.intra.peff.net>
 <CAD2i4DDNZ+oOgtp8dcgqwUjtwaTYnNmg2E0oC88ZDW3LYMBiRw@mail.gmail.com>
 <CAD2i4DCtqxziTy5TPjG+U8EGC+8daJGXjpVgxoJwp8__t8fqxQ@mail.gmail.com>
 <20210428085838.GN6564@kitsune.suse.cz>
 <CAD2i4DASL-ZAsLm=_U53zvqMaAC_AOsGnTe-H=XQsfnftgb=rA@mail.gmail.com>
 <20210428184956.GS6564@kitsune.suse.cz>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> At any rate 'strong' is always relative. Unless you have a specific
> reference of average strenth anything can be considered strong or weak
> depending on point of view.

Yes, but "impact" implies the effect is strong, "affect" on the other
hand does not imply the effect is weak, merely that there is some (could
be strong, weak, or nominal).

The safe choice is obvious.

-- =

Felipe Contreras=
