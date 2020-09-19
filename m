Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488C9C43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 09:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D647A21D43
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 09:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=diamand.org header.i=@diamand.org header.b="a6EUUoUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgISJEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 05:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgISJEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 05:04:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4C7C0613CE
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 02:04:09 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m6so7869663wrn.0
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 02:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=vhzrEDvzuXgRyzwBcG4JzR7wj/NiHYRNOidYYpUZV9E=;
        b=a6EUUoUUzUotVc1RVbm07cgGy+H2nZ/N5vaDUXRVrVPSK2qw8RQCPCKHsbgUsJ74rB
         a7/1pTwnoKEHCpgog7Wf2UmfZys+b9keW4eQ47xmsJiMMrr9BHo3Pb7Y90yeQ6qgNJMk
         Gd/B2rw9bduY/xFb2UTu8ajFMyEJPHz2Wdva8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=vhzrEDvzuXgRyzwBcG4JzR7wj/NiHYRNOidYYpUZV9E=;
        b=V024j5zWYwLtIk5NLqSj1ZTsERqlyJ8ekPSRwBGj+J7dUUEC6YZGLOf3B9C9L8G2jv
         3j2quBlHw5nD/HbQUy55imFCXZdIGOaEElKzRcIbFTAEuAcBn8pVYnJBJ1rySO4pIvhF
         Bp8ayaNgylJ3dVmCUXM9xbb6Dv/4Q/kIKrk085HLe3xGTawrUNH1tZps68hvOTdzRvbX
         fweUH3MY5Txp67F89inMfO8LoPPnhVGnBogS+2cvJ3avVrygwPaR+KMTlbMD/TW3Qv/j
         fUGxlR+I0fLES+ErorNdVSC7Pvc3Q7wUWuTZ4qpPoQf9N41Z6J6biAjmI4IGv9rNGIHr
         s/Gw==
X-Gm-Message-State: AOAM531tRkwFSbk3dEAKgzAacUBoG7aq8mQMK2xOuKEl8SY5w/HbVT6Y
        xVGI0Zn3nm4pAcUblOXITWKfYXtkD8TTdmscmafMCpNB+m+7sQ==
X-Google-Smtp-Source: ABdhPJzrkOpd/xKdkJDcCWhv0CKQHtM7YhdrEtX3wzeA/apL+E97pZQx4NNadw3FFtbFMwtKUih3n9RfI8hh+6n3Heg=
X-Received: by 2002:adf:dfc3:: with SMTP id q3mr40254741wrn.238.1600506247762;
 Sat, 19 Sep 2020 02:04:07 -0700 (PDT)
MIME-Version: 1.0
From:   Luke Diamand <luke@diamand.org>
Date:   Sat, 19 Sep 2020 10:03:57 +0100
Message-ID: <CAE5ih78zCR0ZdHAjoxguUb3Y6KFkZcoxJjhS7rkbtZpr+d1n=g@mail.gmail.com>
Subject: How to checkout a revision that contains a deleted submodule?
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Maybe this is a FAQ, but I couldn't figure it out!

I have a repo which has a couple of submodules.

At some point in the past I deleted one of those submodules:

    git rm sub2
    git add -u
    git commit -m 'Deleting sub2'
    git push origin
    ...
    ... more commits and pushes...

Now I go and clone the head revision. This gives me a clone which has
nothing present in .git/modules/sub2.
    login on some other machine
    git clone git@my.repo:thing
    cd thing
    ls .git/modules
    <sub2 not present>

So when I go and checkout an old revision where sub2 is still around I get:
    git checkout oldrevision
    fatal: not a git repository: sub2/../.git/modules/sub2

What am I doing wrong?
What set of commands do I need to use to ensure that this will always
do the right thing?

Thanks
Luke
