Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D99C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 19:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A093560FE8
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 19:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbhJYTFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 15:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbhJYTFN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 15:05:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D2FC061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 12:02:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n36-20020a17090a5aa700b0019fa884ab85so158866pji.5
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 12:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=wsonXFlUxPWugHYx666V0VkbMAza7jnuqQL+Dovmbu0=;
        b=dkJCT8lLxVgcVs5UfIkodBGYHvEzypUqDGsUqTLW6GfQXE3VdgTtQ7EPxKfsAHHFNJ
         0wH0GZCZjhrO+d3PgxxxvJgNYDKrGsUrx2o347qNOwLDQ6h/gxmgYIThCjptVt8oTwAH
         2bj3ccR/p9hoigQULw7mQeOWGjRn3uHODn5qArPhRdSm7AbpE331TrdUo/m/AmmhgSDP
         jz/a2fXWHeuzpjgJsSJxl4nETWYovFUBH6EIBwO0T2lDgapoNYRU/2YZMFANoXzPsswf
         TCRb7qbidBupRuD73ZFJ7VY5SunBi9xnVREEbDVbOHJrnQTLSNWcCdUg8RksedNRFEAY
         J+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=wsonXFlUxPWugHYx666V0VkbMAza7jnuqQL+Dovmbu0=;
        b=S+XfqMt0G7U4tO83wMJcCLLr26egdS6CLea5nqCwk2usE12qqTIM9XoItPjCdPxI6+
         iPlOu48/uUXlLmIxyG7q4lmUi0CHJUyWRGlFPJN/e/czpwBk4xNDl1Pd9wQ+FT4VQ/n7
         0Cv4eIR+twYBCq2+XjdqQdqCAwbKy+q8GxCOvKGdV4PZ+UtIHuKWGUmwUz/J7c29TsK6
         5t+krx0n3UbT1aPBVbEMrLugVMdmsVeeyqx2iyV91G9W/lFG/5SQ9/Lq8FU4afsbLVwG
         2hBiFete53opRt4TpTfoMbqSP6gurV4Cri3NbZd/STGlwXZfD53x0zfkPoS+q1+DHwhS
         cVTg==
X-Gm-Message-State: AOAM530HTk602GkST0gT1MoIN4tGF/5eVtTs772a0etV/fWZsm6gYrJN
        I7siPsY9j0BA7t2+DI0MyTFA+k3ym7oxku2OQLCqbJDJn+D3ew==
X-Google-Smtp-Source: ABdhPJziBtna/MHxQDkchUsjQbjdKYc8gQBlTlNP5bu6yfCauCBTXYuxGaKzeKpeE/bAqxmGJYWEC6Wlab9KPuAo6WY=
X-Received: by 2002:a17:902:8690:b0:13f:ffd6:6c63 with SMTP id
 g16-20020a170902869000b0013fffd66c63mr18177262plo.23.1635188569520; Mon, 25
 Oct 2021 12:02:49 -0700 (PDT)
MIME-Version: 1.0
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 25 Oct 2021 12:02:38 -0700
Message-ID: <CAGyf7-HFGgkXsA-MXBOdiogDid+=F8jmqw0zxwQoUzha-jc1Hw@mail.gmail.com>
Subject: Unexpected cat-file --batch-check output
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm working with some users trying to reconcile an odd mismatch
observed in some Git output.

Running an ls-tree for a branch and path, limited to a single pattern
within, shows this:
/usr/bin/git ls-tree -z refs/heads/develop:path/to/parent =E2=80=93 file
100644 blob 4c8d566ed80a1554a059b97f7cd533a55bbd2ea8    file

If we then run cat-file --batch-check, though, we see this:
echo 'refs/heads/develop
refs/heads/develop:path/to/parent/file' | /usr/bin/git cat-file --batch-che=
ck
28a05ce2e3079afcb32e4f1777b42971d7933a91 commit 259
cc10f4b278086325aab2f95df97c807c7c6cd75e commit 330

There's a newline after the branch name, inside the single quotes,
followed by the same branch name plus the full path. In this output,
it comes back as a commit, though. Both commands were run with
refs/heads/develop at the same commit. I've checked for a .gitmodules
file and while they _do_ have submodules, they're at different,
non-intersecting paths to the one in question here.

I can't share the actual repository (I don't have access to it
myself), but I'm hoping someone might have some ideas. I've never seen
this sort of mismatch before; for every path in the repositories I do
have access to that I've tried this for, the cat-file --batch-check
always shows "commit" (or "tag") for the ref, and then "blob" for the
ref+path. Submodules were the only thing I could think of, but that
doesn't appear to be the case. Could it be a subtree instead? How
would I check?

Thanks in advance for any ideas; I appreciate any help.
Bryan Turner
