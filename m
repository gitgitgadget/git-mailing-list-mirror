Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439A5C77B7C
	for <git@archiver.kernel.org>; Wed, 24 May 2023 21:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjEXV1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 17:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEXV1C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 17:27:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575C9C5
        for <git@vger.kernel.org>; Wed, 24 May 2023 14:27:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba83fed51adso2626644276.0
        for <git@vger.kernel.org>; Wed, 24 May 2023 14:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684963620; x=1687555620;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TqinlcTRjLWdajcl3jgUT0y06NKnvLWSm2Q3OI6ONsY=;
        b=Jn1920DzNxSaZKLTaZljiti0+VNgCB8dpbKmAcSDt5rRQgYbo6ZuVCwSMt4lDBlkz5
         96DXds/wPUTgo87SlcPCKDI/UYjWbxr6pXpctAvdvS6A/hUR+1Oh2PB73gLHFkWcVtAG
         vZn3wTlUyuqwsTdvG009HMNIFzI+S1G3g+eTg37aWZHzwJaAfNcQrMM9yWsJ72QHfoPi
         XZShkb+JYmRW5ixcoJStAQw1sdcsHnzl/HkozZyTFIsx+a87WpEP5Qs0CbEY2N7C/6xG
         3VHd7OwKahJV4qemoQXSE5L/ojLACaXsH93sb3QP90n+4Z0CwnQUW16QzZmBEq40rJj+
         MwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684963620; x=1687555620;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TqinlcTRjLWdajcl3jgUT0y06NKnvLWSm2Q3OI6ONsY=;
        b=K7xfasXpFccWZC8gm7+2oi6oY+YtPFDjQMZQHZwxHNZiDrpo0f+30K/LqQvi2ufojY
         z3fCwOlEaxyB20D6X+U/7SRev5XeJC6oV2Zo/N7Cv0slWHWgX4/oDJl2BzM+KGjrvd2L
         yITsEz2TI1W0z4L1Rx5GC7lZZsPxbE8tCDWR6sTzmz5gjWaGyLb3sln9EMtonTBmJHnp
         EKB+BZq56t0UcQ1iyqjxf4EUpBQM7uo4+sYColss1o6+79hAZrU/di8zTSGDaswq4q/T
         ifd38xHvu7R3bknua4c9mxKFTkIaxJyIBD1FgNV1Nv75lNZuemp6KFlGGhOqfM5HEYAX
         Bo3g==
X-Gm-Message-State: AC+VfDy559mtly9dkzMYEkCT3TDsMZ/yHwumUDKmyf0LzPkhY8SrvVgz
        LFlrGLlKDQlbsXc9Ji5yZFO/QwhvVBJWo1nVppCg
X-Google-Smtp-Source: ACHHUZ4aS1MAT54Aq3eeJRrmvV7sC94Ce8swYdCQkl65GDIcTgZ49gH9kTFWyaArcIJsAb+VO9v9gc0wnHfWfowUp9CB
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:77af:4a9f:351d:a204])
 (user=jonathantanmy job=sendgmr) by 2002:a25:69c1:0:b0:b9f:14a5:b3b5 with
 SMTP id e184-20020a2569c1000000b00b9f14a5b3b5mr499106ybc.6.1684963620641;
 Wed, 24 May 2023 14:27:00 -0700 (PDT)
Date:   Wed, 24 May 2023 14:26:57 -0700
In-Reply-To: <xmqqv8gihahz.fsf@gitster.g>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230524212657.1348621-1-jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] commit-graph: fix murmur3, bump filter ver. to 2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> I may be misremembering the original discussion, but wasn't the
> conclusion that v1 data is salvageable in the sense that it can
> still reliably say that, given a pathname without bytes with
> high-bit set, it cannot possibly belong to the set of changed paths,
> even though, because the filter is contaminated with "signed" data,
> its false-positive rate may be higher than using "unsigned" version?
> And based on that observation, we can still read v1 data but only
> use the Bloom filters when the queried paths have no byte with
> high-bit set.

There are at least 3 ways of salvaging the data that we've discussed:

- Enumerating all of a repo's paths and if none of them have a high bit,
  retain the existing filters.
- Walking all of a repo's trees (so that we know which tree corresponds
  to which commit) and if for a commit, all its trees have no high bit,
  retain the filter for that tree (otherwise recompute it).
- Keep using a version 1 filter but only when the sought-for path has no
  high bit (as you describe here).

(The first 2 is my interpretation of what Taylor described [1].)

I'm not sure if we want to keep version 1 filters around at all -
this would work with Git as long as it is not compiled with different
signedness of char, but would not work with other implementations of
Git (unless they replicate the hashing bug). There is also the issue of
how we're going to indicate that in a commit graph file, some filters
are version 1 and some filters are version 2 (unless the plan is to
completely rewrite the filters in this case, but then we'll run into
the issue that computing these filters en-masse is expensive, as Taylor
describes also in [1]).

> Also if we are operating in such an environment then would it be
> possible to first compute as if we were going to generate v2 data,
> but write it as v1 after reading all the path and realizing there
> are no problematic paths?  

I think in this case, we would want to write it as v2 anyway, because
there's no way to distinguish a v1 that has high bits and is written
incorrectly versus a v1 that happens to have no high bits and therefore
is identical under v2.

> IOW, even if the version of Git is
> capable of writing and reading v2, it does not have to use v2,
> right?  To put it the other way around, we will have to and can keep
> supporting data that is labeled as v1, no?

I think this is the main point - whether we want to continue supporting
data labeled as v1. I personally think that we should migrate to v2
as quickly as possible. But if the consensus is that we should support
both, at least for a few releases of Git, I'll go with that.

[1] https://lore.kernel.org/git/ZF116EDcmAy7XEbC@nand.local/
