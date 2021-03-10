Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0BFC433E6
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 13:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F9C64FEE
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 13:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbhCJNgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 08:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbhCJNgX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 08:36:23 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C008C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 05:36:23 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id cx5so730775qvb.10
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 05:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Aaxr5P/7vx6PXfZVfPQKCfzDYJfXlCU82qamXWWvj5A=;
        b=AomiU3gZIaEV6QwDs0/KDXUsbeaZ1EB+kk3tFVcx9sRrwuGnGontx/7ZiFPbySBDWs
         eAOF1nGUpS5mF+AsJnlUkbqZt53LaeDtcMNTLNQ6Tr9ffaMYBLRGzdJ2dLgwtDfzZ28M
         CMcejNRRNcN0tmDdMBkVm2MMdIyHONpKGFKnM+dUFMF1n1EcwF4l3gXpz06LimDjqpd8
         /Vi+GwpI3UAZn19Trz5blF5+nPnHZK/Ek3wyKFn/oOGnKtNNT9M9DMzGyfoodw+PDrtC
         CoHbE0pmCtdMikmzwEcuSVDe8v2Tc3hDG4gJCKaccmsvYfr2qC9KFuCsMhvyCPmRpoZo
         WKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Aaxr5P/7vx6PXfZVfPQKCfzDYJfXlCU82qamXWWvj5A=;
        b=OHeDG31uFmteKUpfl9gXuMv/qCd/g59Ba/VD8ajZ9vqF6QskkVziQgwqPFMtXnsWoh
         9qA1/46xNByD4MaixED/FrPGehpk2OJPD5j34/29z3h/yhFqFtzd6P14DbuEq9u76Ua/
         Ywe18+6MIIfjGn82ByXGCAgaWcrx4hyc4xmBWLncHP/GEa7C6W8FQgOg8N/6ZWN+nR54
         4JXBHdAjGB448Njznh+ZU18Trg4bd6xQyF1/L8BrYm0qWmdUZoYbkrHWzOWoq29sLOez
         4j5DZ1HeZCUHOAKExlCzKfAOumBMjQwq58uCRwDl1daRfCVmsH5wI0SrT1z8qtfDcKva
         21qg==
X-Gm-Message-State: AOAM530T6P+Bn+iuDq264tTZqb2JiYiMgqkz/3fylU9w/TdG8wd6FZKk
        ZD1RD1ogO6H6ehIEHyCLA+MuKlPsgAi2GvSCmQn1mR2c65NsqeiE
X-Google-Smtp-Source: ABdhPJyosCTT+1IhwYUFXhFL/0OtOOdeigGhF7ww3vGLuaWjNKZoReWCqH7m+CXUoYopLCGrWRpZgkWHnZKKCQLMRPY=
X-Received: by 2002:ad4:5d46:: with SMTP id jk6mr2809511qvb.22.1615383382522;
 Wed, 10 Mar 2021 05:36:22 -0800 (PST)
MIME-Version: 1.0
From:   Aaron Lipman <alipman88@gmail.com>
Date:   Wed, 10 Mar 2021 08:36:10 -0500
Message-ID: <CAEJZ43juPmz2z+J45hJCBzCAG6seG4qbvPh3we4f3iexeU5r+Q@mail.gmail.com>
Subject: git branch: filtering by formatted ref when using --format and --list flags
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few days ago, I wanted to list my branches on a remote. (By "my
branches", I mean branches whose head commit I authored.) The first
command I tried was:

git branch -r --format '%(refname:short) %(authoremail)' \
              --list '*aaron@example.com*'

However, the --list flag only applies filtering using plain refname,
not custom-formatted refs. So I just used grep:

git branch -r --format '%(refname:short) %(authoremail)' |
  grep 'aaron@example.com'

Even though grep works fine, I'd find it convenient for git branch/tag
to filter formatted refs when passed both --format and --list flags. I
have a patch series implementing this, but before I polish my work to
get it submission ready, I wanted to check whether others feel this is
a worthwhile change. Feedback welcome.
