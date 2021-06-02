Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A9AC4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 04:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9336610A1
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 04:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhFBE6W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 00:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhFBE6V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 00:58:21 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEAEC061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 21:56:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id j10so1302244edw.8
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 21:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=oEJFd24TfY24n/XkQezu0FHv0GaRfrlPtOQFzQVjKGo=;
        b=HqnidKrB7K+HDb7y5xPuMpUj2W1fAf6Qi2Fuvm7SAAiTUs1Di29gFFie6ARTeD2xyd
         OwCR9wEdIBqzS+rJw/Oc9gq4/JzAs8c8UwxgSqXZtn8tuGULg7NqZlRrfmpeRdJMiSMZ
         aMORePnw23MUS8XCxI4usnuySQPfTwaiaTF3y4+aaedQFERU4tnGEMmwI2PaXK4QDVZx
         RzT0UN6OCNUBfyxe6O8U25KoZQvR6BDFW2n9CXfE29zRFvFLVt9pwDfGsXx5sfO4+co0
         gyulKuSVX1H1Y3urgGo5LM+QLSS8IM2piG3tdL4E3ATjg3dXXGI0geqfo5/l4vfD+QVR
         feow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oEJFd24TfY24n/XkQezu0FHv0GaRfrlPtOQFzQVjKGo=;
        b=Vmh7Ow4/WfoPS42dEtfy/jeE67gCjrMuCyvvUCJJS/0m5YsXz/XM2QYjmN0GbDQIkq
         CnX0Aci5kdbBsrSZebrD0rq2C+AzAGzDuzAE1mB5jhvGX0YYibgwd9Q350RDR60jR0e8
         wPir2Jv2C1G9tEgehfAT9WDZ5FxuGQ5W7yaig+xTUS4yaL6zbbzOSt+8nj4MDZz5mGtk
         GogDdnr8AFBT4zNTNs24zAM7Gr0STvsSET0s5zM7fDx2nE/HwTHvTTG8FtW7kbRMTOvz
         JV0+SV9NXUdu7xIIpTZdG3IqAux0fMTjrMdmFV85GcGxEWpL4VKkEBK0/VDgDtjZ8mrK
         V4VQ==
X-Gm-Message-State: AOAM530d86o/YditSoqzNJ/uLnFG09oDeP110exxJECFpE9Bsv8FXcZI
        zEY21JLbpsKI7dZmkEb2u5RpJlzd6hAj/KSC94uOwKtOUBhwyzKZOoM=
X-Google-Smtp-Source: ABdhPJw4o6HcV0eZSx2evlHawKh+nuujjgjOAqaB4hxeTdSI5wBr/tdjXDt5oooIpp1heRQlSo7HJEB/isutskeYll8=
X-Received: by 2002:a05:6402:40d2:: with SMTP id z18mr35318742edb.81.1622609796300;
 Tue, 01 Jun 2021 21:56:36 -0700 (PDT)
MIME-Version: 1.0
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 2 Jun 2021 06:56:25 +0200
Message-ID: <CAPMMpogCz4o3ZGYHnux_6w+uFyxV-FR0R1hFNeg1COiv0qd_0g@mail.gmail.com>
Subject: Partial Clone, and a strange slow rev-list call on fetch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi folks,

I'm learning to use Partial Clone, and finding a behavior that I don't
know how to interpret or investigate:

Under some circumstances, doing a plain "git fetch <remote>" on a
filtered repo results in a very long (6-30 min?) wait, during which I
can see the following command being executed in the background:

/usr/libexec/git-core/git rev-list --objects --stdin
--exclude-promisor-objects --not --all --quiet --alternate-refs

So far, I have noted this happening under two distinct circumstances:
* Anytime I try to fetch on a filtered repo with a git 2.23 client -
shorter pause
* When I try to fetch with a recent (2.31) client in a repo where one
large packfile has no *.promisor file (but the others do, and the
remote I am fetching from has promisor=true) - looong pause

Can anyone explain what this rev-list call intends, and/or any hints
as to how I could see what the stdin content being fed to it from the
parent process actually is?

For background, I ended up in the "missing promisor file" situation by
trying to be (too?) clever about the blobs present in my clone: I
cloned unfiltered shallow to a certain depth with certain refspecs,
then added the promisor and filter config, and finally fetched with
"--unshallow". This produced exactly the blob-population state I
intended, but meant the original first packfile had no ".promisor"
file.

Creating an empty promisor file for that packfile *appears* to fix the
issue, and hasn't produced any weird side-effects that I've noted, and
from the "removing partial clone filtering" description from gitlab at
https://docs.gitlab.com/ee/topics/git/partial_clone.html#remove-partial-clone-filtering,
appears to be a reasonable thing to do (the implication there is that
a promisor packfile with no missing objects hs exactly the same
structure as a non-promisor packfile), but of course I would welcome
any validation or correction to that assumption.

Thanks for any info,
Tao Klerks
