Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F055DC433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 08:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240197AbiDAIXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 04:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiDAIXj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 04:23:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1A724A8AE
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 01:21:48 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y10so2047567edv.7
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 01:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmiklos-hu.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=8kWQc5xt7PXtMNNc0GskSvCbWTVgHRun+GPm9Gh63Cs=;
        b=hP9nh7krf0uKkSOwzvNFyodubx11ZQ7I7gLBw2tAJLdt/YAE4iGNIRkMK/q1vGCH8j
         BmI93LUwo8OTt4EHopfYPOY4fBgUoDTc7NqSkXDrkUc4kGZz82s+/VQ8azH1bBgdcLUv
         xr/SmGoyTPY4dNc3lH2Q3Q523gorcde1GQxrc13WsXNAoqZ+T9/3X3V0dXkMHxgdFalP
         OLy7M1AQHn6HZrqeuZ6ngYWQTWxviKvvsHQ+rywBg4/bhGOJTGk28ZWycVbBX5eWVEOk
         4cy2RZYqFp57LNhHeMPMZJzzwE9mUx5hZKj3oZpsvg7znaDXmrulU2jNxLXulmbfc8uW
         y9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=8kWQc5xt7PXtMNNc0GskSvCbWTVgHRun+GPm9Gh63Cs=;
        b=LOXPiLR3yBY+Q2eWAxM+HZ5nzcx9lFfatPqRawb1ybkD93xsdwdGrI9sIlNYPWetAJ
         wKtUueOnBW4YNoncN846EVCsCaW4iI3OUihfkYeErJUjFzFZnK2ZjrdtPMsjaNZmmfRM
         fmV4sEXVP/Qis+VEVf7THNktwKcf8WV9FahGiOegqFWAVgmYIKvwmbjV0SE1lZgV9xFE
         64AEWJHL6KFm4yyK9iXwlln0eaPibpf0t16cExIph9xLd5ArQNT2DdHHAMF2mJtmWbjp
         jfhhfdGaVFw8TBARvLQ9+D7jB0AL0qthIbUPvGKB9FJ2+kKmcqB/hLb6upeHcJEwkvty
         TUiQ==
X-Gm-Message-State: AOAM532jTf8enZa3DGj4ZdNCIwEp97us7VAOWK76T6XGJjQg0Zv/iEMO
        c6qT4a4s6Mj7RBxHNXMBZ1IR24j3oW5kWQ==
X-Google-Smtp-Source: ABdhPJx0/65QcPwnV0z+wvvKINdU5yyZcB2x3Kxr9+PoZvMGWqxuhp+5p6VYGRrG/cPIHV+eKPBeYQ==
X-Received: by 2002:aa7:c345:0:b0:419:12ae:449c with SMTP id j5-20020aa7c345000000b0041912ae449cmr20014616edr.300.1648801307190;
        Fri, 01 Apr 2022 01:21:47 -0700 (PDT)
Received: from vmiklos.hu (92-249-130-49.digikabel.hu. [92.249.130.49])
        by smtp.gmail.com with ESMTPSA id z6-20020a056402274600b004194fc1b7casm889218edd.48.2022.04.01.01.21.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 01:21:46 -0700 (PDT)
Date:   Fri, 1 Apr 2022 10:21:45 +0200
From:   Miklos Vajna <vmiklos@vmiklos.hu>
To:     git@vger.kernel.org
Subject: git log --since to not stop after first old commit?
Message-ID: <Yka2GSGs3EIXm6Xt@vmiklos.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I wanted to look at commits of a contributor from the last year, and
noticed that I only see commits from this year, not last year when I use:

        git log --author="that person" --since="1 year ago"

Digging around in the history, one other contributor pushed a mistake on
1st Jan, where the author date was supposed to be 2022-01-01, but
happened to be 2021-01-01. Knowing that, it makes sense that 'git log'
stopped at that commit by default.

I wonder though, is there any option to "force" git log to walk all
reachable commits from HEAD, but just show the ones which match the
--since criteria?

Or is this need so special that the best is to parse the output of 'git
rev-list' and do my own filtering for author and date?

Thanks,

Miklos
