Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD08C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 20:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B59DE60FE7
	for <git@archiver.kernel.org>; Fri, 14 May 2021 20:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbhENUyH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 16:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbhENUyG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 16:54:06 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A470DC061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 13:52:54 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so359192otc.12
        for <git@vger.kernel.org>; Fri, 14 May 2021 13:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=7n6SllxxLu4Nj3zAUVdv1TVljZg172mybJLhAXq89GI=;
        b=cUVkFh1l4flliQ9+I/pRgs2y9SzieBTjpiiubmfu+uQgAEEXn9PYZhKgG2phNgPTBA
         MZupRU7Zc5r7IymqhQJPvVYZam1Vj3Wk6MVVaX6KOCzuWGHyxfLvdB3+PRdSdeN5Dlfv
         /uY9iytHDMTD7sq1Sm84q7K4EgUWNPLsnjKz0NO6soGBSYsPPteNuFYDrRBvrZy/aoQp
         r1YWv5a4/RcVhd/YfPcEKFRBPerFiRRdFSQ8kajEAJnW/RLDmvW+nf53eIxX52zzUiOy
         sVUlgJkCkWMmPFa1dJTM0AqE/r9wA3XppS59le1kr0KB6T2PoSe55roziX2uy8vr4hdc
         2HsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=7n6SllxxLu4Nj3zAUVdv1TVljZg172mybJLhAXq89GI=;
        b=pNPJ/SjTxtPRum3S7j6XyPWdeVKUBYzdYCyotbwGOCgzc8yvG5rkb4G/nHBEyLNSpN
         kwWPMizg8VrjsRMpoZYpyKEggzOE5QTDp8EKSHEEWCC9YcqlNFwZg2IGs6PAIXErfoXj
         SVC5iTwLymAGhGyxuudgqiVWllSYUXZOaMJdEn4rOr8RJJz/jAl0HDllzVJiwZNlh1R4
         bW6fELeI8GAu+q06kk3cYySS4g1GfOV/lD3h61cMyuDuhrblnn5tuH5iUnuHMsFrbaJe
         RXF217PJp+RcnJjTVZr973q8Ii1HYqJaAWgA8FrVZeU20Qf7KgTNgFn6HZqKERPvBnYD
         +sDA==
X-Gm-Message-State: AOAM5332yTijw56MxLj+F/Qk6SbjL6GfT0tgQX4qI9nXke5nwjFuEOiO
        vKsouvOD4e+GWNchgS0IDrQ=
X-Google-Smtp-Source: ABdhPJwX60IQfY4n9UtTpL2/YgiYLol/WWFhwdHYwWY2i1Szg/YNuR/SjvA3TKfcYXMfcVNu/94HpQ==
X-Received: by 2002:a05:6830:3115:: with SMTP id b21mr21956033ots.291.1621025574108;
        Fri, 14 May 2021 13:52:54 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id z204sm1378775oia.2.2021.05.14.13.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 13:52:53 -0700 (PDT)
Date:   Fri, 14 May 2021 15:52:52 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Message-ID: <609ee3246708a_43127208a6@natae.notmuch>
In-Reply-To: <YJ7VwbELmik+RVCu@camp.crustytoothpaste.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210514003104.94644-1-sandals@crustytoothpaste.net>
 <20210514003104.94644-2-sandals@crustytoothpaste.net>
 <xmqqbl9e7yqz.fsf@gitster.g>
 <YJ7VwbELmik+RVCu@camp.crustytoothpaste.net>
Subject: Re: [PATCH v2 1/2] doc: add an option to have Asciidoctor build man
 pages directly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-05-14 at 03:58:12, Junio C Hamano wrote:
> > It seems that the latter has several more "attributes" defined that
> > we do not replicate in the Makefile---I wonder if that is a sign
> > that we can get rid of entries for asterisk, caret, startsb,
> > etc. from asciidoc.conf?
> 
> I can't speak to the Python implementation, but maybe someone else can.

Looking at the code there's a global configuration file
(/etc/asciidoc/asciidoc.conf on my system), but the only attribute they
define the same way as git is `plus`, so that's the only one we could
drop.

-- 
Felipe Contreras
