Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF1CC433B4
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 19:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550D06128E
	for <git@archiver.kernel.org>; Sat,  3 Apr 2021 19:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbhDCTCN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Apr 2021 15:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236397AbhDCTCM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Apr 2021 15:02:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE40C0613E6
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 12:02:08 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 15so8811448ljj.0
        for <git@vger.kernel.org>; Sat, 03 Apr 2021 12:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FzYqGockVo0rEaVWmvjoq7hJFu7tWNK5LqA1zwQ/JQ8=;
        b=t4sKPLf+/SUQLbHrcYxFRUbTF85W5rd7bsOVnaASI1z1+Zz+gZz2nN06naxf/7SYuD
         CWQL4Bf6InqNxg3WwkfYqHz/ZeC4aCxNgFFZEaqzMXWETS3La3wul4hsP8EqB2+XMkLB
         L0jVvdXaYmjzTD1FQsNvTkRWPLBvowW+q8PCgAD18pMDJP87yMkVGO+p4xPMgFfp11kD
         dwuQr0K0dBsg7NZdDteDPcty3RxguOnQclPuMEBDqjakKH2ewIxPZ5Yhvj8U80mYhNbT
         aQTO3Dt3N8t6jtvV3TcxvQJPLHFVU1afBt+8IoEmNMAH5RzCdjQV+VpZugfG2+SS0flR
         JYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=FzYqGockVo0rEaVWmvjoq7hJFu7tWNK5LqA1zwQ/JQ8=;
        b=iCRJhQ5DoJpnK4pJ00oJIdJY7aIcc2fShBQMmDmZCGEsxLQJPJX3JN2d/BF86KG4he
         Kw8MLCfmb54mw9X7y25SLq9upKGDkw6PRDAGZUEaiRWHdO39/kInrjLFN/M4+AljTwA9
         fZIeQlaiYzywJQw3U6+9dAjlgygvzP+RjTazkoQFvxt3NeaX84WM+A54NVnKI5R3ce1M
         kUD5XCxwjMDgMxLUeMhxExocXveXWJTTUXmONNEJvaVIlQIPk9bPJ/8WBsQN1WSsSRjz
         9GqylZQ/bWnzXtQ8hXSaC0T2woDx7azULuwgFe+WmjZlR4aGBht1+l+PgSPmRyKqcgJR
         G96Q==
X-Gm-Message-State: AOAM530GJ0+lAaSqUEtQnTpcbVgkBtaIRfkjsXDdikWCi0sH+JzvdebC
        uhVSzU5BUJQSGjsnVFy6d7z31q6Ugcg=
X-Google-Smtp-Source: ABdhPJzARH++YMFGch4wwmnz6Ld3UcdglL3J8h6HbaiHzgvi14Yg9ti51nrXuLDgg1AFb9G4gOdC6w==
X-Received: by 2002:a2e:50b:: with SMTP id 11mr12117732ljf.474.1617476521153;
        Sat, 03 Apr 2021 12:02:01 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u10sm1212825lfl.111.2021.04.03.12.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 12:02:00 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     ydirson@free.fr
Cc:     git <git@vger.kernel.org>
Subject: Re: git rebase --rebase-merges information loss (and other woes)
References: <87zgyfmpif.fsf@osv.gnss.ru>
        <667025246.521774815.1617466172428.JavaMail.root@zimbra39-e7>
Date:   Sat, 03 Apr 2021 22:01:59 +0300
In-Reply-To: <667025246.521774815.1617466172428.JavaMail.root@zimbra39-e7>
        (ydirson@free.fr's message of "Sat, 3 Apr 2021 18:09:32 +0200 (CEST)")
Message-ID: <87r1jrmbtk.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ydirson@free.fr writes:

> Hi Sergey,

Hi Yann,


[...]

> This reminds me of the approach used in git-reintegrate: to get merges
> redone without loosing the fixup, it allows you to do exactly this, and
> then is able to use rerere information to redo that often-incomplete part
> of conflict resolution.  Then it squashes the fixup commit in the merge,
> and is able to do that as long as the fixup commit is reachable.
>
> One thing we could do given a merge commit, and provided that 1. we have
> access to rerere cache, 2. a "standard merge" was done, and 3. the merge
> algorithm did not change, we can pretty easily derive the two "separate
> commits" (or arguably "separate parts of the merge").

Unfortunately, rerere is unreliable as you may rebase in a different
repository in the first place. Fortunately, all the needed information
is still there in the original merge commit though.

I suggest you read the following. You will find that it exactly talks
about 2 separate parts of the merge, but does not need rerere to do the
job:

https://public-inbox.org/git/87r2oxe3o1.fsf@javad.com/

To give you even more background, here is a reference to "Git Rev News"
that discusses the issue:

https://git.github.io/rev_news/2018/04/18/edition-38/#general

Unfortunately I've turned to other issues and lost track of what current
situation is, but according to your question the cart remains there
still.

>
> That alone could maybe form the basis of the "redo merge" you're suggesting,
> and would already cover a good number of use-cases.
>
> For the case where the rerere cache is not available any more, I saw
> we have a contrib/rerere-train.sh script, although I never tried it,
> as I had written mine at the time, though I felt it had left it had
> too many rough edges to share. I'm attaching it for reference, as it
> also creates the separate fixup commit (originally for use by
> git-reintegrate).
>
> In fact, I wonder how much replaying merges created by other
> strategies would perform, if we simply try to apply this idea to them
> too.

I deeply believe that Git should not care. You already have a merge
commit. What "strategies" or algorithm have been used to create that
commit should not matter for Git when it rebases *that commit*, the same
way it doesn't care how exactly you've created a non-merge commit.

I think that only after the basic rebasing is done right, some
additional niceties, such as guessing the strategy, could be
implemented, on top of fundamentally correct rebasing.

>
> However, before I get too high on the idea, I have to say that in the
>rebase that triggered this mail the rerere cache failed to get used in
>a couple of situations: I did not care to check but I'd wager those
>were the commits in conflict with precisely the fixup I was bringing
>down below the merges. In this case (quite lots of conflicts to
>re-resolve because of a one-line conflict, I felt so bad), the "apply
>the one-line by hand and juste resolve *that* conflict" approach was
>really effective - so maybe it makes sense to provide the two options,
>which may be suitable for different situations.

I'd not rely on rerere for rebasing merges if at all possible, and it
*is* possible, see the aforementioned reference. Options are definitely
good to have, but the default one must be the safest, that currently is
not the case at all.

If Git tried to actually rebase the merge, it could have happened there
would be no conflict, or else, but the worst situation currently is when
Git silently replaces original merge with something rather different
that just happens to result in no textual conflicts.

-- Sergey Organov
