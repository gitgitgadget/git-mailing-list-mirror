Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E3EC43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 23:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiGLXKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 19:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGLXK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 19:10:28 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF859B1A9
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 16:10:27 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id f12so7436658qka.12
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=BcdxbO9FCqNwh1Y7GgtrAvJ2qFmJzahX0FaTfDpkpPY=;
        b=MARwSUqWLOOvyrcpwBt3YkKEAudENowlupmbwzqXfUuj2EQRsxWLTfqKSczHjPHmp+
         2Vp9RKnrtOFJ/S2EbNyAhlOH8Sxtg9UeuOZzu/OUGB6kxPnfqcj96TSz20FFeEWDFze+
         8dfmi8Y+UW+/Nqp0eXTyls8hZWt23uWsM/R7j41jMWEqCBuJxe6L5Mq5E34vsSyL6ZM9
         aL3Qt122hwYMbutSIZEjgsSzJSKIfD9nJLc9DD0f4BC/zPLwOtc+ASqTRyL/SsU68LVa
         bDn6qXPEQ9onppr7pn3mkiySlZBxPPM+8zNhlajDgQLvVGgdMLj2duejJ3qreA4cAkzz
         zxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BcdxbO9FCqNwh1Y7GgtrAvJ2qFmJzahX0FaTfDpkpPY=;
        b=3Waw2mqQb9nSUdgPIxLW4+aAu//eeejiYNY6UdO2siUWUZ5nAPGh7j/Qb8G8uslQ8X
         zD1jrkZy92fv6LdXoo38A0GdTVVtj2Qd/I0fJ9MVn+5uDPc3Wnxgl+LEMxyJB2WZTZNk
         Z3c1Yky0PpTOXu32FgyqVT9vF+7EuUZrRzu93uvWA3yrn8FrzSroC6OTYIA4TsTvzePz
         vHvdNTxtctyrt93qr5j4N9XeQ0Is8cfrNtaDEFeq3MfcxLLirksVJk10YXTERAuKrngm
         iROOpVyVqEQANOHNLIIqOUv5YityjSOKEma0ndrntsC+4FWe61vqnhw2FL7GHiQBtEai
         69OA==
X-Gm-Message-State: AJIora+MND+/dYPIvguBv+EA+q8FZKo3P7FKKPR9c/TZ280vE9XfIwEk
        0HXgtyqPML9YukbVF3MRdM4a+h7Xi7Jv0A==
X-Google-Smtp-Source: AGRyM1uLx8/7Nk40FgexHnCqV/+MGDLNTRCNAKYLxKhVue6VzxMLzaxSiwv+zMa7G31KeKhnBzzvVQ==
X-Received: by 2002:a05:620a:2845:b0:6a9:b149:8d31 with SMTP id h5-20020a05620a284500b006a9b1498d31mr565220qkp.86.1657667426561;
        Tue, 12 Jul 2022 16:10:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w20-20020a05620a0e9400b006b5b1d632bbsm848434qkm.99.2022.07.12.16.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 16:10:26 -0700 (PDT)
Date:   Tue, 12 Jul 2022 19:10:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com, peff@peff.net,
        ps@pks.im, wfc@wfchandler.org
Subject: [PATCH 0/3] commit-graph: fix corruption during generation v2 upgrade
Message-ID: <cover.1657667404.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This brief series resolves a bug where a commit-graph would become
corrupt when upgrading from generation number v1 to v2, as originally
reported in [1].

Some speculation occurred as to what might be causing that bug in the
thread beginning at [1], until the problem was explained in more detail
by Will Chandler in [2].

The crux of the issue, as is described in [2] and [3], is that the
commit_graph_data slab is reused for read and write operations involving
the commit-graph, leading to situations where data computed in
preparation of a write is clobbered by a read of existing data.

The first patch demonstrates the issue, and the second patch prepares to
fix it by introducing a helper function. The crux of the issue is
described and fixed in the third patch.

[1]: https://lore.kernel.org/git/YqD5dgalb9EPnz85@coredump.intra.peff.net/
[2]: https://lore.kernel.org/git/DD88D523-0ECA-4474-9AA5-1D4A431E532A@wfchandler.org/
[3]: https://lore.kernel.org/git/YsS7H4i5DqUZVQ5i@nand.local/

Taylor Blau (3):
  t5318: demonstrate commit-graph generation v2 corruption
  commit-graph: introduce `repo_find_commit_pos_in_graph()`
  commit-graph: fix corrupt upgrade from generation v1 to v2

 bloom.c                 | 10 +++++-----
 commit-graph.c          | 12 +++++++++---
 commit-graph.h          | 15 +++++++++++++++
 t/t5318-commit-graph.sh | 27 +++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 8 deletions(-)

-- 
2.37.0.1.g1379af2e9d
