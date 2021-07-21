Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB21C636C8
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 02:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C193610F7
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 02:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhGUCJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 22:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhGUCJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 22:09:25 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C66C061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 19:50:03 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so803018otl.3
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 19:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=+i+NSZYw5JbVhuuxlROURkMmpaYnVZPJluTXVDHYacg=;
        b=euZUjhDNiTvD2ISn2wAisE5MDI1B2gs2/ONtpJ+str7Y+rqcPtWn7dZwqkCKg8RbL8
         eogkJ2rckljKf3+8eoaCQQeQjw5P66YtUQeBA1E9CCU2hEAow+0oHLsc/papB+CD4emh
         O60+99IfT/RGdP/KZJ/lcmaTBNYfbiQtVJkvOe4ZFyy8MnDW8Wg0oJvDDm2EFDc7XeoR
         VA8O3e5OPOuBoz/YmH5EkmdDt9CexvqntjW/KqieRUX+s80vPua3MQr0FcxB1jv4VDgY
         3F5WjIaEsXL0zHc5Qwcha3CcAKvK33Az1VRSK9Z9gIqGTMNyJ02441IZxEXjR3Btr89x
         Gcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=+i+NSZYw5JbVhuuxlROURkMmpaYnVZPJluTXVDHYacg=;
        b=A/RrVmxlCYqfudvkkbIvau944jsRLikZ+VdoYd8P02HzY39+SZpvya+7tlq1LU2il3
         CtL6muHmmHU33bRfpLvcroIwda72vHgSDg7mbutC2ta6xe2amRIk+v/JZtSjFAQ5J2YV
         GQMUKKHa1GBzDTDUFwY6O1JsiHSXFvj8MqAZzIkLRWJ78vjlIDa3eQrccKud/OmUorO2
         CDdkkDGBSQolIzX3Ngo4h8ZHkItd7rRLbfPYyv5Hb4TDr8K0TkGvH0r5gRRw85lbwSWU
         pu2vOT7kP9XWE3f162IWTnO0XfSE1RCWi+lQh87g30n38dAfkO/27oqezHpbpzUHPqlp
         WjSA==
X-Gm-Message-State: AOAM5310IsuSbgoyYHJZwIoNVRnfj8dzpEA5RU7PHLmQmgiS04Pz6AgK
        XbM8Sf3h0irz2UTIYIz9WZk=
X-Google-Smtp-Source: ABdhPJz0G34xgX2FiPXB+4Re+gc5PyyocGS5TYssk+8DLLRjXFWoxMO0ueihJn/fOfbOXnssdw3JmQ==
X-Received: by 2002:a05:6830:2a0b:: with SMTP id y11mr12023907otu.275.1626835802724;
        Tue, 20 Jul 2021 19:50:02 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id w27sm4341201ooc.17.2021.07.20.19.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 19:50:02 -0700 (PDT)
Date:   Tue, 20 Jul 2021 21:50:00 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>,
        Git mailing list <git@vger.kernel.org>
Message-ID: <60f78b58dd8f7_14fda7208c5@natae.notmuch>
In-Reply-To: <CAOLTT8T0oKQ2jCjcmjd6mfYeFFZESgCvV2iOLeUQ1b_byB2UZQ@mail.gmail.com>
References: <49498ed0-cfd5-2305-cee7-5c5939a19bcf@campoint.net>
 <87a6mo29dp.fsf@evledraar.gmail.com>
 <CAMMLpeQ5Lh8xfqTZoM74f616wE7ZhqWArL1WgGiMtiJSfrYcYg@mail.gmail.com>
 <87h7gsvybx.fsf@evledraar.gmail.com>
 <60f5c7b867941_141e5c20886@natae.notmuch>
 <60f5d3ac6ce_14538820823@natae.notmuch>
 <CAMMLpeT3bJcr7mRDpxmk32VqpAbNpN=fgPjmkcY+0zOBYruybQ@mail.gmail.com>
 <60f61b81a3b74_14781320816@natae.notmuch>
 <CAOLTT8T0oKQ2jCjcmjd6mfYeFFZESgCvV2iOLeUQ1b_byB2UZQ@mail.gmail.com>
Subject: Re: progress test failure on fedora34
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu wrote:
> Hi, I met this bug too on my ArchLinux.
> =

> Felipe Contreras <felipe.contreras@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=
=9C=8820=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=889:04=E5=86=99=E9=81=
=93=EF=BC=9A
> > Yeah, this fixes it, but it doesn't seem we are setting any
> > bash-specific options right now, and additionally I don't think bash
> > should be doing that in the first place. If the shell is
> > non-interactive, why is checkwinsize being honored?
> >
> > Moreover, why does it work with prove? I'm investigating that right n=
ow,
> > but so far I haven't found any reason.
> =

> I ask this question on IRC #git, and ikke said that after bisecting,
> he thought that
> this bug was introduced in c49a177be.

Yes, this was already known. The root of this thread [1] mentions
83ae1edff7, c49a177bec is the second parent of that comit.

But I don't think the bug is in git, it's in bash.

[1] https://lore.kernel.org/git/49498ed0-cfd5-2305-cee7-5c5939a19bcf@camp=
oint.net/

-- =

Felipe Contreras=
