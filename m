Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34B5E20248
	for <e@80x24.org>; Fri, 22 Feb 2019 15:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfBVP6p (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 10:58:45 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:51463 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfBVP6p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 10:58:45 -0500
Received: by mail-wm1-f53.google.com with SMTP id n19so2416883wmi.1
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 07:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=dzCR0X4XVP6LUAxl1I6ZaX/wffCjEfdCeaSLS5MdcbM=;
        b=o5e82YOOZOu31jtespbJJ8vK2XVn+BWyiS8m4mVMO3u2M4JDPD2Cz+YkRhFoSVGE10
         rYSODoEV8I5BlzrgBzZAdqqhCUROOhy5UGKjJ7HHviDexGbqXUzL1tnT4Rx3Nh7YXWGQ
         oT2+j9FSf/CoSatKaWMp+qLx2aKik1+2OQHRtYmmTgvlOLgnSpUyOeAqLCoi+LMjumHb
         cyZL1SiOwZG0wcm9fjF5O5Qzyt1HnRe0wReKopsnhzDTsVw+GYaJ9R6RoGASaw4nh7AF
         iHIj7cigxiCXKOeS9Mnn8tZf3I8Y/lVj2Zm8g0wEklbGlDh1f2iS8wsxFZeD3Kt6UDPb
         c0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dzCR0X4XVP6LUAxl1I6ZaX/wffCjEfdCeaSLS5MdcbM=;
        b=aLUvZZAUV1HS/W5A7wgVPNvmTgt1/b7cLTgaP9fFzshNtOS8fML0SOfjvACr6yEKPR
         2xX8qH+SCNyVb03QiQy0Sodm9qnishUlaSIpBI1NY/0C16eZ4wgqj39MoIgkLHCZ2yRY
         ZVQYAjGyYIwN8p8jnBn8/75D4noYxWkwhlb9Ij1pYuv1+foAZKKeOSGKaD8jTWiZ0t7p
         gnCmJOHUKd/j0Osx8cShzZyl651zLrvyWvm8PoBU/O0b2PHIWSF4eXzoApP8FD3wmT/N
         cduypZMmLV7ZteC9CYrlTLQY82PGWgmOrLRFrUAX+HKRDG9o3Vu4RteAvJRRWUR5oaG+
         pu8A==
X-Gm-Message-State: AHQUAuaXmT63NFUYqpdluEgi8DGYMHoNmULeHHmej0Ktz6MHRgf6vRDB
        tFXhkwapiTofakMhOjjbhwf93ajAx7u9S/qGef48LzgP
X-Google-Smtp-Source: AHgI3IZbwll2Byowp/HGutIko3n7F2QqBY0WiZhTTknly06Ovz1ro5bxEra5cbjd3eujTCQwB/I1DH2dEq0jkry19qg=
X-Received: by 2002:a1c:6342:: with SMTP id x63mr2914075wmb.92.1550851123156;
 Fri, 22 Feb 2019 07:58:43 -0800 (PST)
MIME-Version: 1.0
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
Date:   Fri, 22 Feb 2019 18:50:06 +0300
Message-ID: <CAL21BmnVkKtYWa1cRL1EJAwtchGcVUzhu0136AuV8uXAi5Kuew@mail.gmail.com>
Subject: [PATCH RFC 0/20] cat-file: start using formatting logic from ref-filter
To:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,
It was a long way for me, I got older (by 1 year) and smarter
(hopefully), and maybe I will finish my Outreachy Internship task for
now. (I am doing it just for one year and a half, that's OK)

If serious:
In this patch we remove cat-file formatting logic and reuse ref-filter
logic there. As a positive side effect, cat-file now has many new
formatting tokens (all from ref-filter formatting), including deref
(like %(*objectsize:disk)). I have already tried to do this task one
year ago, and it was bad attempt. I feel that today's patch is much
better.

In my opinion, it still has some issues. I mentioned all of them in
TODOs in comments. All of them considered to be separate tasks for
other patches. Some of them sound easy and could be great tasks for
newbies.

I also have a question about site https://git-scm.com/docs/
I thought it is updated automatically based on Documentation folder in
the project, but it is not true. I edited docs for for-each-ref in
December, I still see my patch in master, but for-each-ref docs in
git-csm is outdated. Is it OK?

Thank you!
Olga
