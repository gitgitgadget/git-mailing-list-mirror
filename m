Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6653C77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 06:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbjELG7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 02:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239989AbjELG7P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 02:59:15 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263EB4C02
        for <git@vger.kernel.org>; Thu, 11 May 2023 23:59:14 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f24ddf514eso7040756e87.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 23:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683874752; x=1686466752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvbcLSMb3ZDtdRHNTAebKjpMdZieIPHXkPeTjCXTlDE=;
        b=bD6TXw0VuF3klWGYiRasZ/HGGtQSLdoucR4aLyzfbfy8xblVF8N/lRdlzMYqFVhVir
         3nUiFkkvqFubuvinknRB5A0KQl3b6C373cvrT9fDyk4D7vbNmM4u9M42AkGSmaJ2A1gg
         CiMuDppZmJfCi2xLSrKCki7QCtqFyBYDm65/PW7kB2aS1kzxbq1qFRlszdQJ4vz8RTmB
         m4m7N7HDnqXIrbB3TeNywmwOXGi5Qvulv6yL2f+dRO/kuVCptUGwtotBnW7MJGq+nFTp
         EH241C7oydL0kwlOfTywyAOeNKxbCJfxgKqUM+hc1ZWvgtS5/+RYQAukkgMnBQNAc8OQ
         jrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683874752; x=1686466752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvbcLSMb3ZDtdRHNTAebKjpMdZieIPHXkPeTjCXTlDE=;
        b=I097sB+Gp8oIiby3KyUF5Yq17GSBD3xpiaqvOeM1BoK42ma/K4CA2OU6mj9ysKMUab
         U1kqkI9CwxR6pfcsi4kDoIVjRvID8087pwxaHGOcUUNVEh+aGj3gpo5i87wF79TEM+l1
         GzdVeOdlQ7p9RnvvNP8Ohds3MMmpsy7TosLmqQPo+7IdxO7woFCdjjGCQLcZ6i5yBDtA
         9reKZG7TxfRWypOt0NKI3mcP3liSh2eBCmBO9X5Ox8pe6q07nW/qxhvFQOTNq9hqISCT
         cs81Gnm/rvz1gH4013VOuKKOrsXcMelRsigbfS2QRCHe2cDIY5SXw1RAF2xOUTUWMRFA
         SdZQ==
X-Gm-Message-State: AC+VfDw7PKFRrXya+fFZND7MCJBryRNY25aPno5cQgEEXHKK7+KXR2oC
        kBfrb5ZtApcYrT0D2NWkLsf0V/2Kc8oMSZRovXbGpAiDLrc=
X-Google-Smtp-Source: ACHHUZ7pBPBLEiuxOlgcmuhp3aFC8VfvlLKn7TvpXCGFEIB0PymIBx8bo0VXBipEvu+AKO7pzvFqEpXr5kKphBUAwVg=
X-Received: by 2002:a05:6512:932:b0:4ef:ef67:65c9 with SMTP id
 f18-20020a056512093200b004efef6765c9mr3954448lft.23.1683874752002; Thu, 11
 May 2023 23:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com> <20230511174158.939431-1-calvinwan@google.com>
In-Reply-To: <20230511174158.939431-1-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 11 May 2023 23:58:59 -0700
Message-ID: <CABPp-BHv5zve7hFx9r1baGoKAo3E7jyofLX9+S61OxJxaFBrmA@mail.gmail.com>
Subject: Re: [PATCH 00/24] Header cleanups (final splitting of cache.h, and
 some splitting of other headers)
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 10:42=E2=80=AFAM Calvin Wan <calvinwan@google.com> =
wrote:
>
> > This series continues to focus on splitting declarations from cache.h t=
o
> > separate headers, and also cleans up some other small header issues. By
> > patch 16, cache.h is gone.
>
> Congratulations on slaying the cache.h beast! Glad I was able to follow
> the entire series to see how many headers cache.h eventually splits up
> into.

Thanks.  :-)

> Most of the patches in this series LGTM, but I do have a higher level
> concern. A couple of patches in this series splits files from foo.h to
> foo-ll.h and foo.h with the goal of having other files only include
> foo-ll.h when needed and not foo.h which has other unnecessary includes.
> While I believe that having less unnecessary includes clarifies which
> files have what dependencies, I also believe that we are missing
> documentation for how new functions should be added to either foo.h or
> foo-ll.h. What criteria are we using to separate out those functions?

Right now it's a bit loose, and focused around structs rather than
functions and function declarations.  I'd state the guidelines roughly
as:
   * The foo-ll.h variants should only #include whatever headers are
necessary for the common structs they contain to be well-defined
   * The foo.h variants should take things (particularly inline
functions) that require additional includes
   * We should prefer forward declaring structs rather than
#include'ing a header where we can (though that's a bunch of patches
in a follow-on series I've prepared)
This is even a bit murky because of my use of the word "common".  For
example, I kept odb_path_map out of object-store-ll.h and left it in
object-store.h, because there were only 2 files that used struct
odb_path_map, while there are 56 that use the structs in
object-store-ll.h, and the declaration of odb_path_map requires
multiple extra headers.

Now, you specifically asked about where function declarations and
functions should go, and I side-stepped that question.  In part, I'm
leaving that undefined precisely because I was focused only on header
cleanups and not source cleanups, and I suspect that diving into the
code will yield insights about where we want to fit the boundary for
those.  So, for the many function declarations that could go in either
header and satisfy all the above rules, I think the libification work
you and Glen are doing is likely to nail this down a bit more.  Once
we have rules for how to divide those up, or even just a few examples
that we have good arguments for, then we can happily start moving the
function declarations between these headers.

Does that sound fair?
