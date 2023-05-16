Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B561C77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 00:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245296AbjEPAAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 20:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbjEPAAp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 20:00:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D377DA2
        for <git@vger.kernel.org>; Mon, 15 May 2023 17:00:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba81b37d9d2so353594276.3
        for <git@vger.kernel.org>; Mon, 15 May 2023 17:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684195244; x=1686787244;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ng/pU8yK2pB6DyOyvOtSdxWmMC7Fs3Rps9e7G0tRm7Y=;
        b=bNl+UHwkuYhokag/w9e/WMyqBjUkYBZrIFq1Ft9B45xSHc7fh4VI95+CKw02Iv64T3
         hMMqifAmBh4I14X2aSdjGzzGuS/3zmbbWCbE7gAIBZXYcoH1GpEe4h6u29Mq0tJ2QDQM
         sYbW0u1BXZcn8lwF9hJ7n4djWisJgz0lfg4Ob5Suazq3HN04fpT+e2iTDKLWU2cECD7j
         PT+tJqAjIZkxjiNbG4Bj9r/hojtMIyghkk2/ruZltLuw9XEDRv/KuzXbb6SU42NtTkga
         orYZ6dtLSYahdBZ1/EgHnQBEFUv8vTc88ZxZWD3hdsVPX/c8R1NjbjiqKP+Jk2amXqi+
         6BhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684195244; x=1686787244;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ng/pU8yK2pB6DyOyvOtSdxWmMC7Fs3Rps9e7G0tRm7Y=;
        b=F2lgkbMchr7mqe968tjNbgtuoYZFlx0gStgLRFeXDTbU3Tns8uHazciBtLk8OmrRmu
         ZXNvBceRRlNesPpLZL2RhsOdygL21UYf0Wfei0YtZvi4ma46f8j4fGO3IX9JqGg8qlpC
         lHydF2mHCvjEbmFK3dIjiAIIksl4GtKUj5Fof4oCdA6m+u5+EOprwrYDBI+LwAmzcgIB
         5e4u1qvcfpNdXRxSp/goM+6dBth/af06FKKHAfPXd6IJtop8Cpld8ryHPrgBlH7oE7WO
         JGWpkzGVn/roocigZPylk0vh50cVlhOspwe5TyC0Mz77QS1C0yuaC+kt1OEdLnyUw8XD
         CcSg==
X-Gm-Message-State: AC+VfDxzw+JPYORyIQ6x9BfcBdVZoQwGbz9e8jatGGa5JQZ8euTjyfZV
        Fhjkivt/u5BvwYCVn+c5gWJdGRAYBlAg8urL+6M+
X-Google-Smtp-Source: ACHHUZ6yRBHuJjbgT+5DadnmQFVMowxyIfq6URsN0EBlRpX5PyCoDDQWN4a2RJxmYH540JEAIzR/h4xr4/7tGWJHk/vB
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:3aab:56bd:1f4b:d239])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:12cd:b0:ba7:8099:c5f2 with
 SMTP id j13-20020a05690212cd00b00ba78099c5f2mr3553603ybu.8.1684195244050;
 Mon, 15 May 2023 17:00:44 -0700 (PDT)
Date:   Mon, 15 May 2023 17:00:41 -0700
In-Reply-To: <41183b7baed30ba19e98961944e946919995c2c1.1683875070.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516000041.1458613-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 16/27] read-cache*.h: move declarations for
 read-cache.c functions from cache.h
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> From: Elijah Newren <newren@gmail.com>
> 
> For the functions defined in read-cache.c, move their declarations from
> cache.h to a new header, read-cache-ll.h.  Also move some related inline
> functions from cache.h to read-cache.h.  The purpose of the
> read-cache-ll.h/read-cache.h split is that about 70% of the sites don't
> need the inline functions and the extra headers they include.

Ah, the 70% is not something I would have expected, but since this is
the case, the split into -ll and without makes sense. Up to here looks
good.
 
