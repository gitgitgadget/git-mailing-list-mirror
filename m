Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01856C11D2F
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 17:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D277420838
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 17:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgBXRA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:00:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43938 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgBXRA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 12:00:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id r11so11248678wrq.10
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 09:00:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSWLsYt7NlVDqsIc/P7NMROFCFIU5U47rNboJCUlNII=;
        b=bWZLocqGiLl0r7bdnDtiIjIH31PSsBMfHs98kJOrrFeMAl0BD0Mb+kScl0RtBErIGJ
         nve84Mo4aQbGEGidYp5b0bdTSoLaTolCcoilK1Vbq5aEL6gyQj5FSEarJ9AxF7Ydjwie
         dw3jgfqF1qfTtEQryy8+Zz7dDK7dpAyCr/r3qg0ihhOj2H2gVvo7zrPFs2DnKmhjlnXn
         LLrdBT+YTevXwpdXJWR2ZKwkFJDbuYFQhqsF/OqFJ7smNFV0mwfDnA/PCHW2i/RtU1a6
         X4MlsdVeLG8mxtQvIVcspZ9vWcL2zMCZ2suEK5PvNCpv/7Kq41l3pEPHQi2+lRjAxASw
         pK4w==
X-Gm-Message-State: APjAAAVpHu1wKH0pGxTjpF9y61QMTRhnbNiIVmRnL6DIJcEeapRDxl7u
        IGJwFgyzZ93AZdxIr/HKHHW0ez6oiDAPfBFrpTA=
X-Google-Smtp-Source: APXvYqxiWps3Sf3RjDfibr4GvphuWBDOXliAlyUBsOWiaQ5OXy/HixnGTfqKfzb+1nvEMREUMmHG6cryi5CvDg5Hxzg=
X-Received: by 2002:adf:fe4c:: with SMTP id m12mr10309242wrs.386.1582563654354;
 Mon, 24 Feb 2020 09:00:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.535.v2.git.1582410908.gitgitgadget@gmail.com>
 <pull.535.v3.git.1582484231.gitgitgadget@gmail.com> <8718facbc951614f19407afa6ca8d6110507483d.1582484231.git.gitgitgadget@gmail.com>
 <CAPig+cTh-uu-obh9aeDOV9ptbVwRmkujgucbu9ei1Qa3qSNG_A@mail.gmail.com> <CA+CkUQ8ZsxesE=d+DQ+67SEHPJXdHjbSKhWeVifPeKBymqy8pw@mail.gmail.com>
In-Reply-To: <CA+CkUQ8ZsxesE=d+DQ+67SEHPJXdHjbSKhWeVifPeKBymqy8pw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 24 Feb 2020 12:00:43 -0500
Message-ID: <CAPig+cRhEhYVtSc=EXFSE9VoVwmRQ2yToqdm=c=4cLVWE1=Yvw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] get_main_worktree(): allow it to be called in the
 Git directory
To:     Hariom verma <hariom18599@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 24, 2020 at 6:09 AM Hariom verma <hariom18599@gmail.com> wrote:
> On Mon, Feb 24, 2020 at 7:12 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> >     if (!strbuf_strip_suffix(&worktree_path, "/.git/.") && /* in .git dir */
> >         !strbuf_strip_suffix(&worktree_path, "/.git/")) /* in worktree */
> >             strbuf_strip_suffix(&worktree_path, "/."); /* in bare repo */
> >
> > Also, please add a test to ensure that this behavior doesn't regress
> > in the future. You can probably test it via the "git worktree list"
> > command, so perhaps add the test to t/t2402-worktree-list.sh.
>
> There already exists tests in "t/t2402-worktree-list.sh" which lists and
> verifies all worktrees. Does this make sense to write a new test that
> also does kinda the same thing?

The change this patch is making is to correctly strip the suffix
"/.git/." from the main worktree's path since that suffix was not
getting stripped correctly by the existing code. We want a test that
verifies that the "/.git/." suffix is indeed being stripped once this
change is applied. If there is an existing test which already checks
the output of "git worktree list" when invoked from within the .git
directory, then that test should suffice, but then I would have
expected that you would have had to tweak the existing test to make it
succeed after this change. If there is no such test which verifies
that "/.git/." is being stripped, then this patch should add one. "git
worktree list" would be a possible way to implement such a test.
