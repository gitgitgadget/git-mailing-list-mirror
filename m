Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EABC2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 05:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3C8E61352
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 05:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhF1FYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 01:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhF1FYE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 01:24:04 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7563DC061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 22:21:38 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id v6-20020a0568300906b0290464d9be9510so6032094ott.12
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 22:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=h1rKCt3Kble1MQF7vJi8BlzTCxXHjE3s/ge4Gr5p248=;
        b=XPjra0AG/qrCAmhLK38JiUGt6ivcYWI4iuNZXXmqHYw6gmNdIk/SnH1q4rHypfqvDD
         hL/cL9/aUGjAFC9VmlRfZ3O8EU67PrbhAEH/F4FfdCJPyamBxTvSt6VrTT+6zqpmCQ3N
         kb0l0uqzxI5UbdVySoeF3ENcVeDflOEnrM6N9n1QSXQZaozZiJOubnv1sX3bA0j0wipk
         CrTpZF9CEH+QTJdv6nzS3Y5Fuuo+7Euw61heuRg0dCR/fkwgAUxLMtlc0sC1KJ98Hic7
         X8lMxr+5nPg5xsJOqm2I9Hc4XYGx4s2FAX568jva39XZznuIbeRKQrw6HHwMsHLXkM+x
         V4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=h1rKCt3Kble1MQF7vJi8BlzTCxXHjE3s/ge4Gr5p248=;
        b=Es6HMZK68exZoQ2w23gCuR0PQfIXmO6tDZmWn1ArwGYA/QJoBApO0zXZ4r4JRzr0PK
         2WQG/QFDJjuemYhOQBK7OtfpNmVoBSaj8SxgRkNvP7BTbY1Fqeg5jIsew7N7DOW9lvIM
         YNYmmbIzt4oSxX8l6lZSZPXkJRdvHwHnl23SQZ+3rHey4EPrn1pUIeohViQ4BscBZ9gL
         ayejKL+Rykl4xNa7+jI0Ls36FPShR19MlZJ79HsxncihrUG1EbV1Fic4Tr+qMuC93ood
         KOAg+SZb7RHWvhzmko+GBWnDNSnDzPS4z6VqomoCy5DK74fw3A3M/gT+pZUqa907NjXW
         Fa/Q==
X-Gm-Message-State: AOAM5304PqQa01gk1CF12hJe3Umt3RdIJJIfxoyKg+kuFGhJy2PSPwEV
        xCIDV7sn3VIwOhrfizoaCbm845y6aCFxDA==
X-Google-Smtp-Source: ABdhPJwf0+BmQqdOMYeRYYWx/G5GdtKaPjUkh/3PvnZ5qOwBlOd6pUYTxWhz5vwi8yLzkpSFR1yg5A==
X-Received: by 2002:a05:6830:1d65:: with SMTP id l5mr2165226oti.366.1624857697801;
        Sun, 27 Jun 2021 22:21:37 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id l11sm901590oou.0.2021.06.27.22.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 22:21:37 -0700 (PDT)
Date:   Mon, 28 Jun 2021 00:21:36 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Kevin Buckley <Kevin.Buckley@pawsey.org.au>, git@vger.kernel.org
Message-ID: <60d95c6024f3d_aaf7e208a4@natae.notmuch>
In-Reply-To: <ec31434f-0c99-ffb7-6eb0-6ecb1f6e761c@pawsey.org.au>
References: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
 <435b0150-cd9f-32ce-7a07-3057ef20662a@iee.email>
 <12dd4f05-456f-c763-441e-5bb16634306a@pawsey.org.au>
 <60d9410bb07a1_aac5d20888@natae.notmuch>
 <ec31434f-0c99-ffb7-6eb0-6ecb1f6e761c@pawsey.org.au>
Subject: Re: Definition of "the Git repository"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Buckley wrote:
> On 2021/06/28 11:24, Felipe Contreras wrote:
> > Kevin Buckley wrote:
> > 
> >> Everything within the .git directory "belongs", in my way of thinking,
> >> to the "repository", that is, the directory that gets created when git
> >> is (init)ialised.
> >> 
> >> For me, the 'objects", the 'ref/heads', the "staging area' and the like,
> >> also lie within the repository.
> > 
> > Does it?
> > 
> > Suppose you have three directories, each with exactly the same contents
> > in their corresponding .git directory, the only difference is the
> > .git/index file:
> > 
> >   a) No .git/index file at all
> >   b) The .git/index file doesn't have anything staged
> >   c) The .git/index file contains some staged changes
> > 
> > Do you really consider them three different repositories?
> > 
> > In my mind the staging area is where you put stuff in preparation for
> > the commit. The commit is part of the repository, the staging area
> > isn't.
> > 
> 
> I think I do consider them as different, yes, but in the sense that,
> because the contents of any working directory can change in isolation
> to the others, they have become different instances (perhaps clones?)
> of the same repository.
> 
> Let's say I make two commits, that resulted in the same state of the
> files in the working directory, but I make them in different order
> in two of the working directories.
> 
> Clearly I need to sync the two different repositories in order to gain
> a consistency across them, and that suggets, to me, that they should
> be thought of as different.

Yes, but this has nothing to do with .git/index. You are talking about
branches and commits. Clearly these are parts of a repository, and
nobody objects to that.

> As to the staging area,
> 
> again, for me, Git has an understanding of a "staging area" based on its
> inspection of the state of the working directory and a comparison of that
> state with what it knows has been committed.

Wouldn't it be much easier to say that git is comparing the working
directory with HEAD?

Clearly HEAD is part of the repository, and so is the commit that it's
pointing to (indirectly or directly).

But that doesn't say anything about the staging area, which is between
the two (in my mind): the working directory and the repository.


To try to make it more orthogonal, let's suppose the index file was
outside the .git directory. Would you consider then the staging area
separate from the repository?

In fact, we don't have to suppose:

  GIT_INDEX_FILE=/tmp/index git checkout @~ -- .

Does that command change the repository in any way?

-- 
Felipe Contreras
