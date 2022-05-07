Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0378C433F5
	for <git@archiver.kernel.org>; Sat,  7 May 2022 04:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445485AbiEGEOC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 00:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiEGENz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 00:13:55 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D1B658E
        for <git@vger.kernel.org>; Fri,  6 May 2022 21:09:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t5so10648305edw.11
        for <git@vger.kernel.org>; Fri, 06 May 2022 21:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YyVAfsFYSDZ71CPu8mTReetOYKAxDfIx5KPEslxQGA4=;
        b=Y2yzyAwWrXbhCPP2/bD1UMF1U4oGlJrXq886Fb1UMHnVu4OLAcokWo2RWKA0n69Kx/
         gq716YJDn1r8YvmKJ8ZH1fon1NKzNwzc2Mi+K06e5oaLgU5JX4ckaMU+Qn+d7DxvD4BU
         /q5qgGcmiXswLcWnUAEUSe+zfm4T+LPR9nnzS2pW9Yhgd5rX5AZgVbYRmozhU5qoIGY6
         lNqonWBOc9EiVNhHm2mX3ux3Uxek2S+DovGyUifugxI5FwcX3Hzw2UUodVC4h9bLVc1t
         c07+JVYFl1Jwv/Crj2+FgEECC9ci9l7xe3kwcUNhst+nyJ3SgyZ1jejiylATJSgGEg1n
         nLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YyVAfsFYSDZ71CPu8mTReetOYKAxDfIx5KPEslxQGA4=;
        b=TcnjotiRsGMI4aZRQNW8tNkGEuyF+8K14hlfMm94ppDnR1U7Z6ytgy3iLmssFMp26T
         qO9UPigSKkaSOlQ0vHPOAY0KwFbnOXxCEpieKSXubSUJoyJcBZMxOzkzcjvwN8WRskcT
         lgBJTXi72a9EsTVYJD8r41KZPIqTXFtco5oGa3uevqHFnUSzcJ6hUIVtrg7jAWjjqqjz
         0zxdDcBKt80iUNzMlmHU67VdStIOJ5/bZw2FctaX/jQGNeo81Q7KvZXvBnNpiC+bPAfg
         cm/2YOxHMEyAOBz1MdCboeiVVYVkb4NwCOpCizkrvMlrCXaWU6UNn9i5+MBQuxPL0IC0
         luDg==
X-Gm-Message-State: AOAM530IqbfXRC7wpohQdU4qSzSEAR1Z1jWnnBmoEYHy5PNHoAxwyO79
        nNl/QGg15jaWB0/SN2okU9s7PbPXzXhkG5HXZOo=
X-Google-Smtp-Source: ABdhPJwiBPrTGKU8U57anGCHTY0wV4xJPeqEm14qe8icg83fkDFOq9wl1gPNDDus7omk2WrS+BH5FJJvvW4qSNGCKr0=
X-Received: by 2002:a05:6402:1297:b0:428:3848:a89d with SMTP id
 w23-20020a056402129700b004283848a89dmr7031448edv.94.1651896596588; Fri, 06
 May 2022 21:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8S8rh+VYcuaqBeNtmphiRqw7HropLFpkxfnTJq6BngGXw@mail.gmail.com>
 <CAP8UFD2p+Evqv_MBAgv23zooppsNWjOw6ZU2GLqAq_skZoJPOw@mail.gmail.com>
In-Reply-To: <CAP8UFD2p+Evqv_MBAgv23zooppsNWjOw6ZU2GLqAq_skZoJPOw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 May 2022 21:09:45 -0700
Message-ID: <CABPp-BGD3AZvXwmSHfQQ_xh_UqevH23kdBYijAWUk8GHu1q0Qw@mail.gmail.com>
Subject: Re: Question about pre-merge and git merge octopus strategy
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, vascomalmeida@sapo.pt
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 6, 2022 at 10:24 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Fri, May 6, 2022 at 10:15 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> > I am thinking about if git can "pre-merge" multiple branches, which
> > can check if merge
> > will have conflict, but not to merge them actually, like a option `--intend`.
> >
> > I find "git merge-tree" can output merge result in stdout, which meets
> > my needs, but it can only
> > support two branches' merge.
>
> Elijah (added in Cc) has been working on "git merge-tree" improvements
> based on the new "ort" merge he developed. It supports merging 2
> branches, but maybe there are ways to make it support more than 2.

The primary issue with in-core octopus merges is that there are lots
of questions about how to handle conflicts; possibly even more so than
git merge-tree --write-tree brings up, and that took us months of
discussion.  In particular, with octopii, do iterate merging one
branch in at a time and stop with any conflicts (thus potentially
stopping N-1 times when merging N branches), do you attempt to just
run all N-1 merges and have conflicts that can't readily be expressed
in the index (especially for non-textual multi-way conflicts, but even
nested conflict markers for text files could be painful), do you
attempt to handle the multi-way textual conflicts a new way with code
replacing xdiff/ in order to avoid nested conflicts?  I wasn't sure
what to do, so never implemented that in "ort".

Of course, people could roll their own by just serially merging pairs
of commits, and then rewriting the history to replace the string of
merges with an octopus.  Or perhaps just use "git merge --no-commit"
serially, though that only works if the branches touch disjoint files
(otherwise one of the merges will complain you have changes that could
be overwritten by the next merge).  And yes, if you don't want to mess
with the working tree/index, you could serially use the "git
merge-tree --write-tree" once I finish it, but it's not ready yet.
(Sorry about that; I've got a bunch of nearly complete changes from a
while ago but just didn't have much Git time.  I'll try to get to it
soon.)

However, I think Junio said that octopus merge only handles trivial
cases anyway, in which case an iterated "git merge --write-tree" would
actually be a sufficient solution here and we could sidestep the more
convoluted cases.  But, sadly for ZheNing, that option doesn't exist
yet -- It's still under development.

> > So I find git merge with more than two branches can use octopus strategy.
> > What about git merge --no-commit? Which will not commit automatically,
> > so we can check if they have
> > confilct, and abort merge.
>
> Yeah, I think that's what you want.
>
> > I think it's not useful for git merge-octopus, because if we meet a
> > merge conflict, we can't find
> > MERGE_HEAD at all! How can we abort this conflict merge?

MERGE_HEAD doesn't have anything to do with aborting the conflict
resolution step.  When you need to abort, the thing you want to go
back to is HEAD (which represents the commit you had checked out and
were merging the other stuff into), not MERGE_HEAD (which represents
the branch or branches you were merging into HEAD).

> I don't know octopus merges much, but I think you should be able to
> abort using "git reset" (maybe with "--hard").  If the merge was
> performed using --no-commit or if there was a conflict, then I think
> it should be expected that there is no MERGE_HEAD as no commit would
> be created so MERGE_HEAD would have nothing to point to.

MERGE_HEAD isn't something created during a merge, it's something that
existed before it -- namely, the tip of the other branch we are
merging.  For an octopus merge, you'd thus expect it to have N commits
rather than just 1.

AUTO_MERGE, new to ort, is something that is created during a merge
and when the merge interrupts due to conflicts to ask the user to
resolve the conflicts, AUTO_MERGE represents the tree checked out in
the working copy (thus it is a tree that likely has files with
conflict markers in them).
