Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA058C433DF
	for <git@archiver.kernel.org>; Tue, 26 May 2020 23:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A355E2084C
	for <git@archiver.kernel.org>; Tue, 26 May 2020 23:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=digilabs-io.20150623.gappssmtp.com header.i=@digilabs-io.20150623.gappssmtp.com header.b="Qp6vXEoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgEZXni (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 19:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgEZXni (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 19:43:38 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB9DC061A0F
        for <git@vger.kernel.org>; Tue, 26 May 2020 16:43:38 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id r10so408722vsa.12
        for <git@vger.kernel.org>; Tue, 26 May 2020 16:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digilabs-io.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=d1JlR9AuSCVCTARP4LegEEXLwWhNI1ifX12WzKmRTks=;
        b=Qp6vXEoGaf1whKvf5TP3Fk99jg9yDB8t0V7dappqLC7nW/bbwhdknjhV2+5idqhdRc
         cGsvvRhml24c/JP8mpEyFtBJYjWvOfGbCzxM2tvnmklVukl+fSskVyN2jLvytbDRWDwC
         fJpNrA7MBKatuy978xovbIlOE1FOCoG4pCkgu/P7hxdZikBVGPzC8ZvsVR66qPNe73PI
         f9g2UdGoP3o6P6DC3Q6F5eE5f1LPSIwgvB0+xGFGfcCkNYczXUlD/zCZrg+D085Qgjkg
         yrpPuIFH4g62SJ9TCzYCcnDWgPIcPeMuaL5iMkj6ofj+9JGTO0TQ+9z1wrjx26rUle+g
         5R1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=d1JlR9AuSCVCTARP4LegEEXLwWhNI1ifX12WzKmRTks=;
        b=FKFI9V/mkVxR6czOg9UudFdUBAZTis4NrvqFFGybqquONqHsynXMAl5+2NOrDdiyNS
         dBPy9pZepFPKhvhrNUvPQvB87Gvj54ru6fD1eatHZn7spvRrgLlEkKclJ4XuE1E/whDZ
         tB36diWJbaGz7BF4xa22DxFFvmhaY5qleJDqa/pUPjujRQFetzqYxYqmPHtenwgZx/Jm
         wMWo49+FvA8A4r9VguZ4YdG9g2eDOEZ2xTD7E2LeUddBVBW8ZNOLGd1QEoNV2JTAuduL
         GylMwNb9H9hCKaBF55H3r1aewCrTL8ZkLXFY1JUKo+9OR/QiRQVFoecKMUwIlhkW1bRr
         2ilw==
X-Gm-Message-State: AOAM530GC/7QU9+PjJLYHBQvkDrrBHLlOEsVkobymRnUbSeO3FtKtAPs
        t+agL5vTAiH42tnPiWcSRxy/r1P7fgEIuiQFbNiLK40gR/6UXQ==
X-Google-Smtp-Source: ABdhPJy+YCYD/MlNfeeFnbTC0G4RBd02vly4Rq2FB944f4OfvF7U9OcpUFdPDGWv/4k7NrDJHV5eraE9ofVCer5E9Pw=
X-Received: by 2002:a67:d11e:: with SMTP id u30mr2934556vsi.98.1590536617021;
 Tue, 26 May 2020 16:43:37 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Rose <dan@digilabs.io>
Date:   Tue, 26 May 2020 18:43:00 -0500
Message-ID: <CAJGDnb1eXBQtoAtGu6u7atmrHTbmtcBzuZpOixr2EWsLjD1SiA@mail.gmail.com>
Subject: Bug report: Parameters for the `prepare-commit-msg` hook could use
 better documentation.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bug report: Parameters for the `prepare-commit-msg` hook could use
better documentation.

1. It's not clear under which circumstances the number of parameters
varies (e.g. "When there is no initial commit message text, the hook
gets one parameter. When the commit message is derived from another
commit, the hook gets three parameters. In all other cases, the hook
gets two parameters)
2. It is hard to tell what third parameter's relation to the preceding
list of commit message sources. Replacing the list with just the third
item shows that, grammatically, the documentation says the SHA-1 is
part of the second parameter: "The second is the source of the commit
message, and can be ... commit, followed by a commit SHA-1 (if a -c,
-C or --amend option was given)."
3. The types of values the third parameter can take include "HEAD", an
unambiguous sha-1 prefix, or seemingly any type of commit reference.
This is not documented.
