Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144F5C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E46C561167
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 03:24:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349990AbhIIDZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 23:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349199AbhIIDZy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 23:25:54 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C890C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 20:24:45 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id g9so502568ioq.11
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 20:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Dg3V7Gzj8JcwDHuGld13QZgrSTVnaTZJjcsH1ooXsX0=;
        b=gXwiHIzbiLO6UkDnU/8AiBVrHNymqLKMWHxujl8SqrsRAAr6dAl5taKOGKUd9tRoEz
         X7BYywxrafsJoKLu0FDvwFSTmJnOau+LB/hGmO3fZesnJPV8rLstCXiYFJgIZXABzr5+
         d036vuVAcaRY0ebj6DX2apDQbeoCYvt2tOcZaO8y+MzzQxQ22OcdmdihcS5MoEq/dw8P
         iSso+qzYIH2/j8lh93Csh4EZ2Lw3U+IRMJjmGloPmfLw1uU7Ixhiuq59CTnMBB4Jfm/C
         SgNWtyP9PtcplgLHK7aaxsn20Ti/9kkaZH+hGsiQR3drkRfEwI1nkpPP0mA8Gs55NREx
         /7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Dg3V7Gzj8JcwDHuGld13QZgrSTVnaTZJjcsH1ooXsX0=;
        b=miz+/dNEMNRtfHqXwAFowbf6mWjoeKiXgsMMA4e4oLjIRIKai7eudy7t7JzA75pAp0
         4XwPRyaEK4KGwWOdhaSOaKiz4rKD1a184d2WLtNipBRlXUmCymlqd6gr1UP4Ja4Ee5Mz
         1cuCfdx3efrkaNHQQqhZpQsb0Si7qhQRT3x8GqWMEc0yS0XYa+xf+UC0QdfAm7CqCmlQ
         oC/Lg6YtnnBlYHh5mTS0RDUhTEOYaHSOjjvJ1MBKm1LMZJh4NGNuj71DsczIzX6+xcAr
         LBAMW/Tgo2pYFT44pXxMc0lQEgWhT2CwnbNIBvizU6XThChpN+6dsF2aAiFP0NbQD+rd
         Ix+w==
X-Gm-Message-State: AOAM533XhSEweQdGtAn+3X/zRX34R0PjhndNBfS43RVHjP0UwLH+Pvra
        7CfQjj1ErPBBTz/vFlPDHo1jnhASb+0LiIdN
X-Google-Smtp-Source: ABdhPJwO+Js0K+IVg05Ltb3yziiYFDOiy35mzRQDhxOodW5K2V4sNdGhh7M1J52pNy7pHUy1Oc52ug==
X-Received: by 2002:a02:7818:: with SMTP id p24mr866333jac.72.1631157884745;
        Wed, 08 Sep 2021 20:24:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s6sm283458iow.1.2021.09.08.20.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 20:24:44 -0700 (PDT)
Date:   Wed, 8 Sep 2021 23:24:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com
Subject: [PATCH 0/9] packfile: avoid .idx rename races
Message-ID: <cover.1631157880.git.me@ttaylorr.com>
References: <cover.1630461918.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1630461918.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is a unification of [1] and [2] which together prevent a handful of
races when code that writes packfiles moves the `.idx` into place before all
other auxiliary files are properly renamed.

This can lead to races like not reading the `.rev` file even if one was
generated and is about to be moved into place.

Credit goes to Ævar for preparing what is more-or-less sent here. I polished a
few of the commit messages, and added the second patch on top of his result. It
isn't necessary, but felt like good hygiene when I was reading the surrounding
code.

Thanks in advance for reviewing.

[1]: https://lore.kernel.org/git/cover.1631139433.git.me@ttaylorr.com/
[2]: https://lore.kernel.org/git/cover-0.3-00000000000-20210907T193600Z-avarab@gmail.com/

Taylor Blau (4):
  bulk-checkin.c: store checksum directly
  pack-write.c: rename `.idx` files after `*.rev`
  builtin/repack.c: move `.idx` files into place last
  builtin/index-pack.c: move `.idx` files into place last

Ævar Arnfjörð Bjarmason (5):
  pack.h: line-wrap the definition of finish_tmp_packfile()
  pack-write: refactor renaming in finish_tmp_packfile()
  index-pack: refactor renaming in final()
  pack-write: split up finish_tmp_packfile() function
  pack-objects: rename .idx files into place after .bitmap files

 builtin/index-pack.c   | 48 +++++++++++++++++------------------
 builtin/pack-objects.c | 15 ++++++++---
 builtin/repack.c       |  2 +-
 bulk-checkin.c         | 31 +++++++++++++++++------
 pack-write.c           | 57 +++++++++++++++++++++---------------------
 pack.h                 | 10 +++++++-
 6 files changed, 96 insertions(+), 67 deletions(-)

-- 
2.33.0.96.g73915697e6
