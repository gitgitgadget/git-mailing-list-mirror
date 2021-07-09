Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E731C07E9E
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 14:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 412AB613BD
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 14:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhGIO7O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 10:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhGIO7N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 10:59:13 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5ACC0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 07:56:30 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id m3so12482261oig.10
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 07:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=jSst2KpuC8GVZ9VNZVneFO24X5WG2bvipsc/2JlSEaA=;
        b=l0XNmLIEVIRArQ4N/0O3Q+adNOcMteAkmZlF2SLW1GjAFT2Q/fra1I4GRTinNV0gRw
         THRzHQnxtbQwavy0kSbCtkdRltaGxsO4Pk+UZ1UrUoidoiUfi3F7MBVnFKA6iQ6s9akZ
         ezqf9yBH/PBMt6AtbCCG/GrWr1v03bG52q0l1k5/7AO+yc18yqa1/jJ6y2CkyEnWRMRD
         HWBCJyH4iPDc3bwQiIy+ja6Lf95hTrNSqfAHn3RvID5h6j0WGYL/7qfXhkOLFW3PzNQR
         kLxjcYe0C89/qqlif8/+I+Z95zq2WtKG15oxeK4rvmWtoI4gFnHUbv/LFW/1Pzc687LT
         Ujbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=jSst2KpuC8GVZ9VNZVneFO24X5WG2bvipsc/2JlSEaA=;
        b=MMo88uxbJR5PeywJQfh8MNGB2tjSJUaejOaGV9X1GhzH6e/a5/cv52Nc8sD4xWbyHz
         6yH4kSr9ll0fwMt2KnNN69+VQZzS7gf8RuDe2kBcqWfk8whLW82sgxYuaaWcEgSHoR3a
         1H/DhpksbnQTzyad0bUoM4orUtjvmt6HwD3BEhUDhKBBENmGc0iOtFAZhQ6a6oX07IFw
         MVygBNxbfjBslEV0nrudhwRF8t4alG5BYuNxxMIEK/G406bExlMoHVktt/hrst5Q/nzO
         dn9uPXtMTlh4poY8nt0UkICL5G+6nv8K7a81MyLfKiPtjTCkcpYSsAsUZnksxI/Gm47x
         TfCA==
X-Gm-Message-State: AOAM5338PQ7/Kl3+kQoHAZxSyd/QREOVFx8fv+yiYEh0XczaOPbu9+Au
        SiqNpNVF6WxGelAebP6ys5ZoMx9A5Vev3Q==
X-Google-Smtp-Source: ABdhPJyCaeIfkqq6DROV6dD41zp2HOn2U6TOSXVazhH+wlmY8bPKmEU83ZE7PPEs4BgE9JPw+Z1Y+A==
X-Received: by 2002:aca:5f8a:: with SMTP id t132mr8678950oib.72.1625842589358;
        Fri, 09 Jul 2021 07:56:29 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id p9sm1150098otl.64.2021.07.09.07.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 07:56:28 -0700 (PDT)
Date:   Fri, 09 Jul 2021 09:56:27 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <me@mfriebe.de>, git@vger.kernel.org
Message-ID: <60e8639b87a83_226420859@natae.notmuch>
In-Reply-To: <71d3662c-411b-88aa-5cfc-b2f86a067507@mfriebe.de>
References: <71d3662c-411b-88aa-5cfc-b2f86a067507@mfriebe.de>
Subject: RE: git checkout -b refs/master origin/master
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> Especially the effect on
> git for-each-ref --format="ref=%(refname:lstrip=-1)"
> master

It's probably better to do refname:lstrip=2.

> You only get part of the branch name.
> Because "lstrip" does not distinguish between the / as separator in the 
> refs, and the "/" as part of the name.

That shouldn't matter. I use 'fc/area/topic' as names of my branches,
and I know Junio uses similar names: '<contributor>/topic'.

-- 
Felipe Contreras
