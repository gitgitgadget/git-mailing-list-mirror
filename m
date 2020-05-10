Return-Path: <SRS0=RpNG=6Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE32C35280
	for <git@archiver.kernel.org>; Sun, 10 May 2020 03:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB1B20776
	for <git@archiver.kernel.org>; Sun, 10 May 2020 03:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHLUSvu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgEJDzy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 23:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgEJDzy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 23:55:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54D0C061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 20:55:52 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r16so4913170edw.5
        for <git@vger.kernel.org>; Sat, 09 May 2020 20:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sN+Ahpv268aiGvLOaE9jvcidtQMD87sxgIJeuy54ZC0=;
        b=VHLUSvu1wobhZapco1EsjGMcke09r2JmLjrJFmH6UvIi51UAdvQ4ZhfhsmHAXcEm0K
         YCf5TlOAEXlthOeEqzaZ2Q6xEm2bRwVsmWx6VOJPin1t+5iCvaQzLWFRwDQClIutg/gk
         J7jD7U8DK2GFM3y+NPvE8OM+l8cBWT1xdPP2r22AU/lmIpc2bOwmhoMgp1BqSq3ekKHY
         cbO4gyEwznHUvpSphFy2iM0qU5c3IjNFvjaNctomqI/EMHJItuUYqvVmWkr7uGL/IjQJ
         VeRTFX2UWmT1MdvttPmabQuqgDxrJE9Ki04Keg1sdrSeOdChK/S/MTDsL8OTyiIulE/d
         9n3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sN+Ahpv268aiGvLOaE9jvcidtQMD87sxgIJeuy54ZC0=;
        b=mkXVM3KytYawcuH8GZnnwL0bVcPHXorIR+I85sSCpQoFuCMC79EK9Raynihs7bxu2m
         Rd8Enxp0xz/WBF6aOIFReylQBzEceFKuyb+ySD9IL0o1gwKDiDjDEYFY3rn/b8NgGDu+
         bmarCi/Yj3Z04QOVg8jcK5AsunKfiVzl1a+60KEg/KNhQ0J7TE0aEKnfVRTsh68taf+f
         R56xJBSi2qZo0yUFzxcxJq2uHA32JvmTGsTWjrCcsmzNgWMK98FdQfVFVhpau1uSiaSA
         EJxyU+4H0dlK9rq0A9R979rZH3bAGL9AV7/82NODtT1dVyHrhhXZc6O6gTpNUlw2mtHg
         /s7w==
X-Gm-Message-State: AGi0PubjDLJ273c7wj9C+j6Ip0NVVLAmVd6lejHr/LWBeTy9uSXduKWy
        0x+Dca/kGh2Pw5D/4iFSlbk/rz86OIDblyVVUmi4qW9REkk=
X-Google-Smtp-Source: APiQypIW0OeKYiL0Hwsuh5Qpot4e0NGf/D9O+adGVgt60xGk/ASZWBHDrLvJHhXHWOOuS5/3lqQ7VrXUCz0/b4H4Wnk=
X-Received: by 2002:aa7:db44:: with SMTP id n4mr4957641edt.387.1589082949217;
 Sat, 09 May 2020 20:55:49 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 10 May 2020 05:55:36 +0200
Message-ID: <CAP8UFD1iBxiOZ_OA4DbMF9Kx2UHL15TPygoX6x-JrDGuReG1Vw@mail.gmail.com>
Subject: [ANNOUNCE] GSoC 2020 Students and Projects
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Stephanie Taylor <sttaylor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

As you might already know, the following proposals and students have
been officially accepted to be part of Google Summer of Code 2020:

- "Implement Generation Number v2"
(https://summerofcode.withgoogle.com/dashboard/project/6140278689234944/overview/)
from Abhishek
Kumar will be co-mentored by Jakub Narebski and Derrick Stolee.

- "Unify ref-filter formats with other --pretty formats"
(https://summerofcode.withgoogle.com/dashboard/project/4593212745842688/overview/)
from Hariom Verma will be co-mentored by Heba Waly and Christian
Couder.

- "Convert submodule to builtin"
(https://summerofcode.withgoogle.com/dashboard/project/6451304047575040/overview/)
from Shourya Shukla will be co-mentored by Kaartic Sivaraam and
Christian Couder.

Congratulations to Shourya, Hariom and Abhishek for their work and
dedication so far!

We had many more proposals and students working on micro-projects this
year compared to previous years.

Thanks to everyone who worked on micro-projects and on proposals with
the goal of being selected! Unfortunately it was not possible to
accept more than 3 students and proposals this year.

Thanks to the mentors who accepted to dedicate time and effort to
allow the above proposals and students to be selected!

Thanks also to everyone who helped review the micro-projects and the
proposals, and guide the students!

Thanks Google for organizing and sponsoring this event!

Looking forward to another great Google Summer of Code!

Best,
Christian.
