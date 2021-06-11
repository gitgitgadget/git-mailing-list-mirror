Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA37C48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 20:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D430A613C3
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 20:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhFKUk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 16:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhFKUkz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 16:40:55 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70935C0613A4
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 13:38:57 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so4368396oth.9
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 13:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=EhoYilDIeL5Shz2d2LJuDs8dA2UwvP/MgwN1aN73huo=;
        b=eyaLdhlpU/W7MdpVmDCa8Ght2L63BNAhl3Q/k/I/9pY9pDpUV4oKDkp3ZLZqA39zDP
         IJRDINOIoVh3o5WDlRxpGukQhY0mYxHIpOlmytRr9HGSd+CoIASK6bYDXOdgNqppAR/Y
         S2zuXznkhgCPZIWtiO2/BvOmiKrqqoxLEzqlZ7ar9KZg4pURJ3MiPwEUh3vhNIP+u7ey
         fDgeLM+pbqEJYizKXZWp125L99QXLRzh2pgzLQQ7qSCvDXSLLmvQLSo+cya/W9n1rktQ
         r6kWomj9hiIaEXbUzqcADeoPnOPNoU4t7QZgAgcUmSBQ9NiC7HDAYv3ZgBCoU8NsXWyo
         JrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=EhoYilDIeL5Shz2d2LJuDs8dA2UwvP/MgwN1aN73huo=;
        b=UkYkfszfkSm4LbIW0XIcBi8F4/bt9oA+FgU1czywT5VQCWodsx8C8HRslpvgXtuFmW
         hmbIFhohj2jTVzmn96ZbEQgCq1nJOocxrc/ZaAFuZA+hET0uqesUwZkxDWoa01PXAr9T
         lctQAsIcC3i9tKl2uxoSys0xUFPiqh3fJ2nwwaU7ug+5gUYduuou9UybJ80ViQpiXVMZ
         7SW0vEhoVj/DTBvywrIMhGRVbXYMzvtHbmNVvM6AxtvgVRUFtwMioCpAxGIyvljAYk3/
         PbvWXx9urcFGSdRTrvt55AlXdpt5HBB6iOMBuvJOAQShDPEaxUHLJH+MHzxyIRPZDP6R
         Jkzg==
X-Gm-Message-State: AOAM531cTdgoONuH4IQDGMthnXby8e2tq/CH0wZWtG/uAfFq8IKcYC/U
        pMgRkSpRV1hWq6k3KHdrB34=
X-Google-Smtp-Source: ABdhPJyYjf1fhyub5Fhgbdta0z0dl/+MtPZ2KLcIXOQthNrfh1JGvFGwVP1aQCi/ExPu+RwjGrvyaA==
X-Received: by 2002:a05:6830:1b6e:: with SMTP id d14mr4596432ote.186.1623443936000;
        Fri, 11 Jun 2021 13:38:56 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id x199sm1370507oif.5.2021.06.11.13.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 13:38:55 -0700 (PDT)
Date:   Fri, 11 Jun 2021 15:38:54 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>
Message-ID: <60c3c9de3482c_8d0f208ab@natae.notmuch>
In-Reply-To: <f4488360-bdaf-3e97-69c5-00087f797117@gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
 <87a6nz2fda.fsf@evledraar.gmail.com>
 <YMKTARn368Qzsqc2@camp.crustytoothpaste.net>
 <87pmwt1dz3.fsf@evledraar.gmail.com>
 <f4488360-bdaf-3e97-69c5-00087f797117@gmail.com>
Subject: Re: [PATCH v2 0/4] Use singular "they" when appropriate
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 6/10/2021 6:58 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> > The skepticism about this being needed at all isn't an opinion I hold=

> > about software documentation in general, but about software in Git's
> > problem space specifically.
> =

> A change that says "don't use 'he' and/or 'she' unnecessarily" is
> important to encode as a project guideline so we can stop having
> discussions about their use whenever they are introduced in a patch.

That has historically never been a problem.

And there's no need to make it a problem.

> There is value in having this decision encoded,

But such decision has not been made.

And more importantly: there's absolutely no need to tie your correction
patches to a change in the guideline.

-- =

Felipe Contreras=
