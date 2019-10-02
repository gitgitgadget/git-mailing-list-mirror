Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FEF31F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 21:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfJBVGL (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 17:06:11 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36894 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfJBVGL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 17:06:11 -0400
Received: by mail-ua1-f67.google.com with SMTP id w7so206777uag.4
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 14:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/+j/bY9HSF3K5hYxT2bn6h3Xyxq0WZgAcbjdaihL9r8=;
        b=NH7hHheA4i36Y+m409SzRrYdsxf9O8JfH09Abiu0YP+IGmNOwZ7lewC0I73whEatts
         tmwo3tGjksEirViBJNrRVGeyg7X7rZls4X9ziTQV2XfUEn/u8Ep0Xskmo0S8KzheYvfP
         yyteYy2dG6dlt9JaR9noyMEOxn2WJjF243QTzQwIVEpTs2DOhSBghcdPN5xzPEO7a8ZC
         uOCuRmGcGtPzbsd7uPJXRdLCLPP0UedzUUJQ67fL/U+MuSGDsxscu82S5Tl+77UsAwpg
         0a5LMk6QsxzXzYGWh5HDKc42uFC0g8BNQtv4UsO6eGZ6VVgL4fyArk4VsfKsHUSvOxR6
         EuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/+j/bY9HSF3K5hYxT2bn6h3Xyxq0WZgAcbjdaihL9r8=;
        b=oJDyMzfaFlewy+mHS6QfrbaPJcsUxuvTFJfpz0KmZxJ/fYtEAH8vgBhHEMsFbMwWbP
         VjZIl0iaPI1E0cVdYju9u1SAAWkUEGGb+RAlSgjMXRPhEzs8/mdvBJ7cc71lUJK65xMt
         f067F+PmfVoGLsAdzUjLeCWWs7Vvn0GFLUjRoXHbz4hKzsLYGWYJqtPlispdslnZdQp9
         NU6dJ53PWyloj591g9PmmTUPrXEgY/GRPA8M0H6Tn3P0N24g8tkEu0TB8hOSBTZXq5xu
         2sOi5oBZJwIl0voFbf2FfA4+RA6GDp7CNprb+ER8Ed9hwiF+Zmcsl8tZCB6DalDlBkvv
         WFMw==
X-Gm-Message-State: APjAAAWgPBi0wEdkluALTCiyPlozw3/LqvLBwfZUO9ShN8CmX+E+8Lp/
        2Rb5uX9QfrHNfJSKFFvFfyD6yP7i1yZIXus4jOTdj8HPojw=
X-Google-Smtp-Source: APXvYqzj4QEYcmie+7OZvEYo3J9XmJDmmV5yDcKDKpSaUSTO6LSuD+ImAaKD/8TlgY6n2IY9l8PaodjQFaBSPI66a0Q=
X-Received: by 2002:a9f:31cd:: with SMTP id w13mr2853163uad.81.1570050368392;
 Wed, 02 Oct 2019 14:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190925014005.17056-1-newren@gmail.com> <20190930211018.23633-1-newren@gmail.com>
 <CABPp-BFckDZL4iAqhHmrXDpFi3eQgvOkbgjJdGRZE4ePUwNDuw@mail.gmail.com> <xmqqzhiidi2u.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhiidi2u.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Oct 2019 14:05:55 -0700
Message-ID: <CABPp-BEJ47MonV2WmD+UornSG5LPmpGAyjWQa_4DTkAfjMjRmg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] fast export/import: handle nested tags, improve
 incremental exports
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 2, 2019 at 1:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > I see you picked up this corrected series in pu; thanks.  However,
> > your merge commit, 2a99d6b6ff7c ("Merge branch
> > 'en/fast-imexport-nested-tags' into pu", 2019-10-02), claims "Seems to
> > break t9300 when merged to 'pu'.".  I know v1 did that and I could
> > reproduce, but I can't reproduce any failures here.  Was this message
> > just left over or is there some problem you are seeing?
>
> I thought that the latest What's cooking written after you sent the
> corrected version hasn't been sent yet.
>
> And the draft copy I locally have for the next issue of what's cooking
> has the comment removed already.
>
> Anything I missed?

I was looking at the commit message for the merge commit where you
merged in v2 of the series, and was surprised to see the commit
message claim there was still breakage with the new version of the
series:

$ git log -1 2a99d6b6ff7c
commit 2a99d6b6ff7cd29cc41d587ae737ffb8e7babea4
Merge: 7d81b61dd0 0e2eeb4cb4
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Oct 2 16:08:06 2019 +0900

    Merge branch 'en/fast-imexport-nested-tags' into pu

    Updates to fast-import/export.

    Seems to break t9300 when merged to 'pu'.

    * en/fast-imexport-nested-tags:
      fast-export: handle nested tags
      t9350: add tests for tags of things other than a commit
      fast-export: allow user to request tags be marked with --mark-tags
      fast-export: add support for --import-marks-if-exists
      fast-import: add support for new 'alias' command
      fast-import: allow tags to be identified by mark labels
      fast-import: fix handling of deleted tags
      fast-export: fix exporting a tag and nothing else
