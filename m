Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6E1C5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A582074B
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 17:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZvP5ulJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgKKREF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 12:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgKKREE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 12:04:04 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A37DC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 09:04:02 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id m13so2916189oih.8
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 09:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6NZ3ZfKXNkuZsX5slrWhkJPLc8RZfN8HqdjaJ3mcVf0=;
        b=ZZvP5ulJnkptXEs+Hb8wW6AfE4wphrwRFvEZ6JJ2fcDUB8buByfbk54oomoPg8tHnD
         BE//yMSjNIK7EZGwSLRhc2IvZkz652Y+JS9qZYlpCdEe2uEXQ0C30WCuO31sZhMVKi/V
         MWrvcwB381uLkqrBRei0KE6uCNQW/lQltG0BAMBhxWR6uy1tvn1l2YTkmVNz7HEaAbuG
         BmF7ECURZyhY5X1V1v7KJLpUAiToJ+Tsfo+T+9Zk9zzZIRlctZUobQwtwzWiFeXMO+gi
         ZR44sRNbdttsiRWvs0wD6M/7RQOK/mpKzyw1U2o3FoiEgREk4mnb7AdWFXAsHkdhyu/z
         Q0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NZ3ZfKXNkuZsX5slrWhkJPLc8RZfN8HqdjaJ3mcVf0=;
        b=dlSs6ynIwoE/ESI3XdepWU5s3xyfjJAlrRfQNgP4jNxMWa22JSAxjaaEujI+CSHUIJ
         8ZVi3dKQdIOajyrZ1jGZY9zfQBCl6UxF0amMTxiDmq5QEtzhDw71TagrLIqdoWl5sSBA
         9o6eNanRNNk1FfUgs7qL/L3UuAC7cyeuih1jgNJgTMTgThyqgdUCG5l+cxrBsXJr9K8v
         jsNiJ2r8yEH9ty8tTbk1W4vr+znGWJEyED6G2YK58wjNQsuxJTF41VzV2LaZbhSv4zoi
         wJZho18sULcohwWiwnnwH/D8yysnSPfsXreN8CYOFtabSF7D/gQfvQvUvs//9PMG1NkM
         HqIw==
X-Gm-Message-State: AOAM532nyiuy9StLVMfbxRcGpVuBR7bjOWib8hHoPAhrG3TLqwF9BIeR
        CUU/DUNjgO1YzORKGREcQwhzOWqZohcHK0PK2fBSrRlrTiw=
X-Google-Smtp-Source: ABdhPJxlmZLP2ESH+l2Ojyk18avgBpKImU5vqdfLgCpkSVVtRe3JZ89HP0kpxd9oeXfIYlDmDu91UnfS9BmDOeXynFI=
X-Received: by 2002:aca:3756:: with SMTP id e83mr2756336oia.31.1605114241608;
 Wed, 11 Nov 2020 09:04:01 -0800 (PST)
MIME-Version: 1.0
References: <20201102204344.342633-1-newren@gmail.com> <20201102204344.342633-5-newren@gmail.com>
 <cd05d258-a526-9843-f646-d2d42f1b8cbc@gmail.com> <CABPp-BFd2Wg-9h9+Gx20szX=YfKLqvBMWGg-eZU0yL8_DPh6kw@mail.gmail.com>
 <91898d2a-174f-a9c6-f174-3c7809f79b34@gmail.com>
In-Reply-To: <91898d2a-174f-a9c6-f174-3c7809f79b34@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Nov 2020 09:03:50 -0800
Message-ID: <CABPp-BENqoXL9yPW1DnoEa89oGxM2J1H4Vz3VE5r2-D+-m=PKA@mail.gmail.com>
Subject: Re: [PATCH v2 04/20] merge-ort: use histogram diff
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 11, 2020 at 8:51 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/11/2020 11:47 AM, Elijah Newren wrote:
> > On Wed, Nov 11, 2020 at 5:54 AM Derrick Stolee <stolee@gmail.com> wrote:
> >>
> >> On 11/2/2020 3:43 PM, Elijah Newren wrote:
> >>> I have some ideas for using a histogram diff to improve content merges,
> >>> which fundamentally relies on the idea of a histogram.  Since the diffs
> >>> are never displayed to the user but just used internally for merging,
> >>> the typical user preference shouldn't matter anyway, and I want to make
> >>> sure that all my testing works with this algorithm.
> >>>
> >>> Granted, I don't yet know if those ideas will pan out and I haven't even
> >>> tried any of them out yet, but it's easy to change the diff algorithm in
> >>> the future if needed or wanted.  For now, just set it to histogram.
> >>
> >> If you are not making use of the histogram yet, then could you set this
> >> patch aside until you _do_ use it? Or are there performance implications
> >> that are also a side benefit?
> >
> > Long story...
>
> ...
>
> > Does that help?
>
> In summary, you have some concrete reasons to prefer the histogram
> diff other than just "I have some ideas that might pan out later" so
> this code change is a good one but could be better justified in the
> commit message. Does that sound correct?

Sure, I can add some additional wording about those ideas and the
concrete issues I want to fix.
