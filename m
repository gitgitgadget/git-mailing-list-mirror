Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD5BC433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 19:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6688020734
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 19:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bc6wSVjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbgFITwz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731214AbgFITwy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jun 2020 15:52:54 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB89C05BD1E
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 12:52:54 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k4so18367876oik.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 12:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=n/V9zYeh77YUnJaq7uA+NpjkRKhnesQPrL2N31dOCt8=;
        b=Bc6wSVjqrTn1XbOBZWfbV0Y2pW7yEr6ZRHnT8tc5lb+Mm1+zMpsbL8Z/BFG2XIL6Wh
         SrTRTjIZrBPq0xLzXBGPkFgFiFyWMd7C7geTCR/kQpdHpkcDD3BI7eo303g7Pb2qkIwQ
         nEqo86NEkR8h8rtoCEF29md28a4mKiOZry7S5zsFrQx6B5nZj6QVXlTVcYsCOWrehnHl
         RTlcIDeevTj9p2vFhs1B1jLC9zYvSSCC+I2nmm2iuOzC5LHV7xJuLZKB9PXX2TFy9xKE
         gE6HVxbD/oNUPZGVUPzIImFNmovjHRg7nPg2e2foBNipi39YrQzqorymu5L0EK2Spej4
         R9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=n/V9zYeh77YUnJaq7uA+NpjkRKhnesQPrL2N31dOCt8=;
        b=UpUous3TmGJ601N8E4ebzk9XG5FGtw2vkB+yZ0V3UBWNVH51HH+fwuIlQi85WLbuuC
         OQ2duU2BbXfJKj9mRvgWEk57zSjwkIwrUomQxMMIh+3jr8o/peyglaOy1GCrOmng5HKo
         hE9+ZsaXYwUKeLL7BA6eJ4rw4I80VpfomUTPxJ2umEllVPOUfPPsHrFiLGUlY144wk4t
         ZoLQs/R21dhruNszC0FRXdBbBFSFFcummygXteZo9ClWfBSSDYSGEC8B10mwFjEjiw99
         alENrd2gxs1Utv0CmN+mtNShZVsMZYYBCkkJRGhXEM1bvMt4nL7xfylU2RXVEcm68zPh
         jyzA==
X-Gm-Message-State: AOAM532VJBilTkGwjjcmqLCGpYVElljJr2jCxZgM4vwSM/xYFTuF4p5l
        QVcnRFcuQrWCv9MUc3Kj+yDP33IXpW5eczkwJpqdcye0USM=
X-Google-Smtp-Source: ABdhPJw4YwbFKiIZZJS+JJ/JnMDkSGVSn0bEFCThvryvX9k9mGFPNk2gOx0URUYHjLF5eO6YblZOHHQs1TMAB/7NM2o=
X-Received: by 2002:aca:ed03:: with SMTP id l3mr4783769oih.155.1591732373723;
 Tue, 09 Jun 2020 12:52:53 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Tue, 9 Jun 2020 15:52:42 -0400
Message-ID: <CACPiFCJKvnDL9Xj1Xs0RCvuhymjDz4N0hT42dNtBQxp+TLiPaw@mail.gmail.com>
Subject: osx autocrlf sanity?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi git list,

long time no see! I am here to ask for a sanity check. I'm on OSX.
Checking out a repository that has an un-controlled mix of line
endings. Mostly linux-style, but some Windows CRLF endings.

A few tests.
 - I set core.autocrlf=input globally --> a fresh clone doesn't have a
clean status files look modified right after a clone)
 - set core.autocrlf=false globally --> a fresh clone doesn't have a
clean status
 - set core.autocrlf=true globally --> a fresh clone doesn't have a clean status

This is git v2.23.0 from Homebrew.

Am I doing something wrong? Can git work sanely on a mixed endings
repo without having to fix the world first?

... I do strive to fix the world (and this small repository), as we
all do, but it should not be a preconditions before git behaves
sanely.

cheers,


martin
-- 
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
