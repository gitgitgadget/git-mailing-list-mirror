Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CF991F597
	for <e@80x24.org>; Tue, 31 Jul 2018 15:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732416AbeGaRND (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 13:13:03 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36865 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732269AbeGaRND (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 13:13:03 -0400
Received: by mail-it0-f66.google.com with SMTP id h20-v6so4944424itf.2
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Va6+QPUcACmvykRCKywXzFFWk8CDjWKJYErCs3ys3Eg=;
        b=ZXR/CIbMcxLq+zIf1OQ2LdAb8BbKp18/Gb9YLuZw6a6IrJzCNrQ8uzhT0aPueGIhYs
         c/D2kMbSEFhFK0a0uO+SMe4sNx6hkKvJMMEMYS171PY9MTevp7Tm9Wki3LxfDAnDQIE0
         g57qIaf3fJAjhutucveoUf8wOZbmo1RXYMNQdguNS6b+jTRXasOdsV2WpHkx1ZUKu6/A
         JYxlW/zQBaR3ptAgrXdQtjQ3kwOpti5IzY5+5XtzxoByHCbAaRewEZ292D3MZPM/EpRE
         OLGtzN/DbLeb5oghQKaW6i8o7G0EFgz3KkEc9zivky2UtWDFdDU3PHa77nafrpDmfDVl
         HWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Va6+QPUcACmvykRCKywXzFFWk8CDjWKJYErCs3ys3Eg=;
        b=VNKjdnW9gN+yhJD8gVa1XXlhutCi0FjIu5xP1Nx37b4xkmQ294yrVit3a0hQrLM3Vj
         LHrzkfqFe9ROf9ulvbOX0ajvra5GxNihJ10j03RBFwSI7muLdUAX0hLe+B2y6JTkGgaI
         nqpsRMMf53rNyuirv9nDNi0LWIL503hhNJTDlLMbRXTfFdw2Lk2p8BBssxL5I2l60c02
         1qcE6Jjetr+Gg4nN6ASvoweWoCC53a5jGBt6Gll+CZrujQ0EMlsjAhGhxdGAzfldBd1U
         kw8y1VkYVMViGgQGggB9rtsWTyDVH1YNBDM7MGyA/bksxrrltFyXMS+S8zxhdkjbkOM0
         QoQg==
X-Gm-Message-State: AOUpUlHT4/urSM1Zpe7EN0izSw0G1O462qpYovz37V0W5BABQ1ZdPgeY
        8hjSN1AzJL3TjBhkgwzbMcskz3dHHQNS8QXEt4w=
X-Google-Smtp-Source: AAOMgpfS50KpCkyb8bGhJW5fjtCVEzP7bR52f3wH0dQnR3QQyI6TsoSE8BRQMSZ8dyaT/O+3YENL+abLwIYZ63Hvtsg=
X-Received: by 2002:a02:7e45:: with SMTP id h66-v6mr21054843jac.97.1533051131484;
 Tue, 31 Jul 2018 08:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180727154241.GA21288@duynguyen.home> <20180729103306.16403-1-pclouds@gmail.com>
 <9a9a309c-7143-e642-cfd8-6df76e77995a@gmail.com>
In-Reply-To: <9a9a309c-7143-e642-cfd8-6df76e77995a@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 31 Jul 2018 17:31:45 +0200
Message-ID: <CACsJy8BUBjPngHz=icHomor-LJOkMLwZ9bQ6YJDxnoXGg++vjg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Speed up unpack_trees()
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 30, 2018 at 8:10 PM Ben Peart <peartben@gmail.com> wrote:
> I ran "git checkout" on a large repo and averaged the results of 3 runs.
>   This clearly demonstrates the benefit of the optimized unpack_trees()
> as even the final "diff-index" is essentially a 3rd call to unpack_trees().
>
> baseline        new
> ----------------------------------------------------------------------
> 0.535510167     0.556558733     s: read cache .git/index
> 0.3057373       0.3147105       s: initialize name hash
> 0.0184082       0.023558433     s: preload index
> 0.086910967     0.089085967     s: refresh index
> 7.889590767     2.191554433     s: unpack trees
> 0.120760833     0.131941267     s: update worktree after a merge
> 2.2583504       2.572663167     s: repair cache-tree
> 0.8916137       0.959495233     s: write index, changed mask = 28
> 3.405199233     0.2710663       s: unpack trees
> 0.000999667     0.0021554       s: update worktree after a merge
> 3.4063306       0.273318333     s: diff-index
> 16.9524923      9.462943133     s: git command:
> 'c:\git-sdk-64\usr\src\git\git.exe' checkout
>
> The first call to unpack_trees() saves 72%
> The 2nd and 3rd call save 92%

By the 3rd I guess you meant "diff-index" line. I think it's the same
with the second call. diff-index triggers the second unpack-trees but
there's no indent here and it's misleading to read this as diff-index
and unpack-trees execute one after the other.

> Total time savings for the entire command was 44%

Wow.. I guess you have more trees since I could only save 30% on gcc.git.

> In the performance game of whack-a-mole, that call to repair cache-tree
> is now looking quite expensive...

Yeah and I think we can whack that mole too. I did some measurement.
Best case possible, we just need to scan through two indexes (one with
many good cache-tree, one with no cache-tree), compare and copy
cache-tree over. The scanning takes like 1% time of current repair
step and I suspect it's the hashing that takes most of the time. Of
course real world won't have such nice numbers, but I guess we could
maybe half cache-tree update/repair time.
-- 
Duy
