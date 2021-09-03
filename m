Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8735C4332F
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 02:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF2360FDC
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 02:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346101AbhICCls (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 22:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345968AbhICClr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 22:41:47 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11564C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 19:40:48 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id y18so5124413ioc.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 19:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=fp/S1fWU1uczpaaiLsv9njFUJDPO35grKq7Vc/3W8K8=;
        b=MkNqKuDKOkFTmb49gI/ayUOF+HeWH2aZmyEjt7b66dyq7acKe0DYCtXrW3fgllJJI0
         hcvTJlYn8IfWcldVsaeoSc2p2E1UIIgo6Edsfx7zLzROGoGJ1tGkXaobqG2xuUg0nIc/
         9DJv08gvxfg9wdCkl6bnv2B2YjVCCReq8MDJh5E/+6GYoFFW9JGrv1eSWJuIObCiyJlW
         pU3XXahPdusWOiht/puUsv/l9xTRyv1FjRRLzO1ufMDGqYjmanlgJ/lIEQ/PpdvPvqkv
         9EUUAR9oyobfcw4af0RcxjnUzbQFx1AqNfsLRHPTBuJ9BHXpcSF4kgSxowbKtR7977Jo
         CvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=fp/S1fWU1uczpaaiLsv9njFUJDPO35grKq7Vc/3W8K8=;
        b=JezdyZ+TF1sOKsaL2P9rbXs0uRF+Yo1QIxk5Jcsla74av6OAsejOArMas1IVFxD8Qh
         7uVzS5ERyYW+KYbi67ZzN5sCFd1ar/D+mqcoy2707FjpRX1SHkOPnNOWednwM3dbll1z
         sMbAW+jiyACZYsPc4QuFnCLAguUIxXvZIVfYOa6TwyUrOQrRlyiDdivCYsq3LFr0gL8Q
         eyFz5/twyJOBOdFFRF/F1gmNH62783Rg1YIitrTZdVAjUTiN/QkjaCLonyMvJLZ9c4fg
         Tz4GeJto+ntiPkSTYg4E/EWu31tbjjnMYSs7hVsiJgKDOWyJGvthfNqEuE6drGiAU3Fp
         4WSA==
X-Gm-Message-State: AOAM532ZDcIbcT84MdVN7lthmXxLfwjuxAtaYepXMgoX7ADg288FFU6+
        /LCAM916O6LHBVfs7BDt7TrlEOeGYUNFURMsq44XcOJjIRpJBhF4kvjZHptW4qSr/9WeFbZrxQ9
        iorwIgihMeEWsgjJb7bsK98h4UoHlnhTlio2bAjCa3b6TXTBrd7feZk2knj38mJC8
X-Google-Smtp-Source: ABdhPJzazyZc+IMIgjD1CxnzdFlX/KlujNi9hconE6WaCCAlg0zRJHZzl82q7tI+KMHEOH+wYRDvwA==
X-Received: by 2002:a6b:6a14:: with SMTP id x20mr1249984iog.177.1630636847253;
        Thu, 02 Sep 2021 19:40:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p15sm2026325ilc.12.2021.09.02.19.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 19:40:46 -0700 (PDT)
From:   Taylor Blau <ttaylorr@github.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date:   Thu, 2 Sep 2021 22:40:45 -0400
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
Subject: Git in Outreachy?
Message-ID: <YTGLLQCvlnT17jo8@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Are we interested in participating in the December 2021 round of
Outreachy? September 3rd (tomorrow at 4pm UTC) is the initial community
application deadline.

Christian, Peff, and I discussed off-list that we would each try to pull
together funding for one intern from GitHub and GitLab respectively.

If we're interested, the project submission deadline is September 23rd
[1]. By then, we'd need:

  - Volunteers to act as mentors

  - Updates to our applicant materials on git.github.io (project ideas,
    as well as potential microprojects).

Thanks,
Taylor

[1]: https://www.outreachy.org/docs/community/#current-timeline
