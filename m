Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE5501F453
	for <e@80x24.org>; Thu, 27 Sep 2018 17:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbeI0Xcu (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 19:32:50 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38369 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeI0Xcu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 19:32:50 -0400
Received: by mail-it1-f193.google.com with SMTP id p129-v6so8517950ite.3
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 10:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1b5F5rSn0U+0XFJyYKYRC2xD+fKYYza/wq1BkWt9hk=;
        b=lS3ikUuIge2mMJCP47b62sYyINwK382mlNm6JC0woIJ8ZX+9wGq+nT+7JLPOxapRVy
         EEd91HGH0MbI5vmjK9uXaX3Ij/ZEyp70V7AOJXmyGYP8/gfL32A84AHQC3bSHZTKxWuO
         1ozhpl2W0NjzYYBVlkzbNhkc/SKFxqurdHwDCO+50Uo4119Kei3ipUA4Q7tXot8PnrlU
         SaW38RiTsDE3gz/VP9YsHKkN/C7jKBt9t/V7xDO1W0W8K1W2pybuxdNApy5lCRXxmHG9
         YxPVFn/Mdhlo/eD8fArJ/C+RBq0WZn8bBVa8Et3X4fR1niHRLLeb4/u6gS4VRDli3JfY
         mpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1b5F5rSn0U+0XFJyYKYRC2xD+fKYYza/wq1BkWt9hk=;
        b=Y+68xTNT1YeJfIwWIq76sV1z46Q2sL+lppQ3+wqYjZfwShKj70dObXlNvxr/iYHVtM
         mqGbjPs4d22xlKreH/03GrNa9XHuPCSeT9nQkSXNhVe8L36ciDgu8cXvWA5bK6ECfFnH
         Vxo4U07td39EBQfqdJN5tvki9+OV7eUMXe1inzg6mS4FHfWnjm/5hq0FhFDDYf/2nEXf
         WerPuk6HHCljkFI4bx1JwKxCt2dDdgRBnLoHeB5PtnJUNMXzbLXjKZOigZXTGNwn0iao
         vpiN1LVFe5u5Ddkj5R6CjGoifI3zMSkHOZr5OjuF4PUJTowOOhCKq9IFzTHAMBlapzaB
         weVA==
X-Gm-Message-State: ABuFfogjYOe5IMueAwrcLemUb8dzR/5kEhzRSCmw6mJhKvx1V0Qd85pP
        VhWdrTUA6Os5HIAcvCW4/Z7KOrSvbr5zzIEjLJI=
X-Google-Smtp-Source: ACcGV60JhREWCUUdyV7wIepusveCaQC3iovHbREbop8J5Hph4j2WuQ5zATtLKNsx0ekRnTlvbzgVSORbUq7KJAdFEXU=
X-Received: by 2002:a02:49d7:: with SMTP id p84-v6mr10777336jad.97.1538068414338;
 Thu, 27 Sep 2018 10:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180823154053.20212-1-benpeart@microsoft.com> <20180926195442.1380-1-benpeart@microsoft.com>
In-Reply-To: <20180926195442.1380-1-benpeart@microsoft.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Sep 2018 19:13:08 +0200
Message-ID: <CACsJy8BdKo-TQi2YuPjyoTb3uyqKLvJKNOSD5cdopygm3y4CcA@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] speed up index load through parallelization
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 9:54 PM Ben Peart <peartben@gmail.com> wrote:
> The high cost of parsing the index extensions is driven by the cache tree
> and the untracked cache extensions. As this is currently the longest pole,
> any reduction in this time will reduce the overall index load times so is
> worth further investigation in another patch series.
>
> Name                                    First    Last     Elapsed
> |   + git!read_index_extension          684.052  870.244  186.192
> |    + git!cache_tree_read              684.052  797.801  113.749
> |    + git!read_untracked_extension     797.801  870.244  72.443
>
> One option would be to load each extension on a separate thread but I
> believe that is overkill for the vast majority of repos.

They both grow proportional to the number of trees in worktree, which
probably also scales to the worktree size. Frankly I think the
parallel index loading is already overkill for the majority of repos,
so speeding up further of the 1% giant repos does not sound that bad.
And I think you already lay the foundation for loading index stuff in
parallel with this series.

> Instead, some
> optimization of the loading code for these two extensions is probably worth
> looking into as a quick examination shows that the bulk of the time for both
> of them is spent in xcalloc().

Another easy "optimization" is delaying loading these until we need
them (or load them in background, read_index() returns even before
these extensions are finished, but this is of course trickier).

UNTR extension for example is only useful for "git status" (and maybe
one or two other use cases). Not having to load them all the time is
likely a win. The role of TREE extension has grown bigger these days
so it's still maybe worth putting more effort into making it load it
faster rather than just hiding the cost.
-- 
Duy
