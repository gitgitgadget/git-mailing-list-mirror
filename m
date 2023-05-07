Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A971C77B75
	for <git@archiver.kernel.org>; Sun,  7 May 2023 00:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjEGAPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 20:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEGAPL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 20:15:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE47617FD0
        for <git@vger.kernel.org>; Sat,  6 May 2023 17:15:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4efe8991bafso3692255e87.0
        for <git@vger.kernel.org>; Sat, 06 May 2023 17:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683418508; x=1686010508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqCF/6q9HcmW0PJf+QnWyNeWRpaibF5muwPAGyEAUUA=;
        b=RHn5JPs/crfQWfLKCd6whSgG1/ZmhB2LFfJNm6MpMohsKIf9FYVyka9cC5lNA3J5cU
         0RD94DKCvc5q7WoEukx9ni6ozGbGRTt7lyDWcglN7PcBvNVz21L4EC+atYuxypcSc0oO
         1EaqIWGv3QTBgZoNdfXNGFPcufMghSmHv/j8/FJpMOpTCSvshYy5bwlgwlLKIQyfR1RO
         N3IJ2YWpYhqEcz3QSh0XEXBhVizRhX3Gy3qqHFWFOrAhn2ZhUbRWHLOu0A2yF768FCfE
         U8WMRHuQHfd073ow4+LUVc1R8THEEILzEw17sMdc7F7NrB8bXavs/5wS1yWtgXPEfEzN
         PDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683418508; x=1686010508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqCF/6q9HcmW0PJf+QnWyNeWRpaibF5muwPAGyEAUUA=;
        b=SkBpA1yEZyqgFVByOp79sEq1qmcTAW/fhjUNv7JyzOgbftGnVZZ//zhC/iBj6Sp7Dy
         CPM73W8W+RBuPZuJeVvZtYzg9Ha+SR/0Q3W1aXINDSrkFhi92ACmqueZfE8B6esccSgy
         7/fLSBxD7wkqlHvkw8JB4eWheeTSrZ0lj8adBBPlgbf8IOXxI7+dHuKqu9DA1NaE2Ca1
         muFWPC17vgV1EWzjZODdXy9eKCbs4jirRHatLouI3waM3ZLwJhrgEAVdR/bGxue1hwO7
         ecCrQMYAloFcSZceQ43M5JNi5tko175bXypkkDT6fek7ljAs8KS0QanzrslM7H42vnwf
         mFgA==
X-Gm-Message-State: AC+VfDzQQ7eOWiyonGrQNxaTjQZZnl5bOK3K2pQcF3bkjd0AglqRz2vD
        d8xMUIjQ1clIhPdXuuC1wgTSNoSgOQ0XGA/M8/4=
X-Google-Smtp-Source: ACHHUZ4iADpTYis5W0c0WC/iBglMLR+AsXs1HZ5FnrhhE3hUyTDE5uDxlRZkoUkasWg34r0rrMS/rECgiAoOceTp1JM=
X-Received: by 2002:a05:6512:376d:b0:4ed:d250:1604 with SMTP id
 z13-20020a056512376d00b004edd2501604mr1755444lft.57.1683418507816; Sat, 06
 May 2023 17:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230502211454.1673000-1-calvinwan@google.com>
 <CABPp-BFagTvBTe0XbEOM_hO-vDFwVvSSmGOii1q2=7amqerwtQ@mail.gmail.com> <CAFySSZAOqX0pESfJ-7bYg9iR2RDB9PL6sC4Kcvr_zitdQ1kD_g@mail.gmail.com>
In-Reply-To: <CAFySSZAOqX0pESfJ-7bYg9iR2RDB9PL6sC4Kcvr_zitdQ1kD_g@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 6 May 2023 17:14:55 -0700
Message-ID: <CABPp-BGc6ZK919rEH7-fOVg-nYs2wtvFP-XeQ7V9dEBEJvBYsQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] strbuf cleanups
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 3, 2023 at 11:00=E2=80=AFAM Calvin Wan <calvinwan@google.com> w=
rote:
>
> While moving strbuf_add_separated_string_list() to a separate file
> would mean that strbuf would no longer have a dependency on
> string-list, I don't think that dependency is problematic to begin
> with. Widening the boundary for strbuf as a string manipulation
> library to a string and string list manipulation library seems
> reasonable to me.

Oh, the high level idea behind string-list might make sense at this
level, but I was assuming Peff would show up at some point and
highlight the evils of the current string-list API[1][2][3] and how we
should avoid using, depending on, or implementing something that acts
like it.  :-)

Of course, you're explicitly not trying to make any API or ABI
guarantees, so it's certainly fine to shelve or defer such cleanups
for later.

[1] https://lore.kernel.org/git/Y7lx1hUpZ7zOP1Lo@coredump.intra.peff.net/
[2] https://lore.kernel.org/git/20180906191203.GA26184@sigill.intra.peff.ne=
t/
[3] https://lore.kernel.org/git/20200821200121.GF1165@coredump.intra.peff.n=
et/
