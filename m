Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FF9EB64DA
	for <git@archiver.kernel.org>; Thu, 20 Jul 2023 20:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjGTUUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGTUUL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2023 16:20:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA153271C
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 13:20:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bd69bb4507eso1031087276.2
        for <git@vger.kernel.org>; Thu, 20 Jul 2023 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689884409; x=1690489209;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5lAqhJokKdK2AbZE0bbTqVd68xZwJO0hMwj20AeIfqA=;
        b=VZqwp3rUWHRenIRANtbsbEpGJvCrqoD191yYSCHWaxK1QPSNXeYjp580lXvmVuVbhS
         p3TkCBAyMElLEjUVfSplI99E3lAXmFU74MBSD/rzL57iPoN71xuN6CD177wM5fzuSw3q
         Qf4JedTZIA5+NJPcJPPIG9C0QYWmCkr5PxRuO7tgA0yFRVJincF1Dx117C4h2XJ/oJqQ
         Kw6pKIk9AYJOG3LUtz4HfvkrequRBCJtp+bsZG1+TBnx6DWXh/yvHz5udwiRQgH3+yo6
         02TkE7xqCWbylZP+o1D+NLTq3i+AGg+ZNmj9utha0oLmYXD/yg1w/le9qpqf/uLNu8Rw
         ViJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689884409; x=1690489209;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5lAqhJokKdK2AbZE0bbTqVd68xZwJO0hMwj20AeIfqA=;
        b=Et/flZYuxQtF7bOvWVD+maic8013eWf0/1P4twEx+ksStb9wINxg40oGUmUu0Xr/Ju
         kzt4vSeyKQZA1SboN9HmLeJqG44pT/QJ/o4JC1JFxx3imhcF1f7QfCxDIalspXAR7t92
         CnSw2n7rFzMCnS14zl+uT+A1xWl9mIcp5J0c/EUDvvyAFJh2LMUEPgB21/SVWga+w5gD
         pvYELXjEalIx3ZdVp2yDiSpD96+fhfLkbIUlZxSqFDxZpkmAs+hLZ88ysl4bslL1HZN0
         l0HrI4AxoJk6gNLXaMlBq3im59E1iDDWubUkcFnY6aw7oLqm31W3GGp9ZYRy3qZAQJ2e
         QTKg==
X-Gm-Message-State: ABy/qLY95MP3wHuXedCwza4lajmhkmpdL5yZuvNTxQW3i+2nXQ6y5JgY
        w4czHldhUmCbHgIUG8P9yjs9vLVaDWrWYl0hamx2
X-Google-Smtp-Source: APBJJlFnIf/IGFbONCcdqWyXoNuUPZCxefl2XeSsl1u1ehj6YWKFze2nnIiiOnJ1UZxOohJi+6PwgCBKhUPgW20Tt9xT
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:387b:f15b:5fda:c8a5])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:1205:b0:ccf:6bfa:2a03 with
 SMTP id s5-20020a056902120500b00ccf6bfa2a03mr426ybu.7.1689884409085; Thu, 20
 Jul 2023 13:20:09 -0700 (PDT)
Date:   Thu, 20 Jul 2023 13:20:06 -0700
In-Reply-To: <ZLgcfvIrV3TapMAp@nand.local>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230720202006.3815802-1-jonathantanmy@google.com>
Subject: Re: [PATCH v5 1/4] gitformat-commit-graph: describe version 2 of BDAT
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:
> This is a little beyond the scope of your series, but since we're
> changing the on-disk format here a little bit, I think that it might be
> worth it to consider whether there are any other changes that we'd like
> to perform at the same time.
> 
> One that comes to mind is serializing the `max_changed_paths` value of
> the Bloom filter settings, which is currently hard-coded as a constant,
> c.f. 97ffa4fab50 (commit-graph.c: store maximum changed paths,
> 2020-09-17).
> 
> We always assume that the value there is 512, or the environment
> variable GIT_TEST_BLOOM_SETTINGS_MAX_CHANGED_PATHS, if it is set. But it
> might be nice to write it to disk, since it would allow us to do
> something like:

That's true...I do think it makes sense to either have both
bits_per_entry and max_changed_paths (because if we are reusing Bloom
filters when writing, presumably we would want to make sure that the
existing ones were generated using the same settings), or have neither
(since we don't need them for reading).

Having said that, I am inclined to not change this, so that the offset
calculations are the same for both versions (e.g. in the test tool
too), and as far as I know, we haven't had problems with this. But I can
change it if people want.

> > +	in Probabilistic Verification". Version 1 Bloom filters have a bug that appears
> > +	when char is signed and the repository has path names that have characters >=
> > +	0x80; Git supports reading and writing them, but this ability will be removed
> > +	in a future version of Git.
> 
> Makes sense.
> 
> Thanks,
> Taylor

Thanks for taking a look.
