Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAE7C2D0CE
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 22:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054FC2071E
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 22:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8TFJvqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgAXWlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:41:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35670 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAXWlS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 17:41:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so3907369wro.2
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 14:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ef7KQOieJN6Xa/3kI92KngXev3jlaHg6Ray+PQfoecQ=;
        b=h8TFJvqe7iSGp249ZhSpQPbVoYULaRFRiScN4KNv7i1QeQdVRQ5gioVa3epm0HX8hK
         3DGiGGzNV8m/6p5BAu1mszEhJPdtB0Z48DSCUUN639FDgaslx2r6+Ma2wLTv+BwFKgCs
         AXH7MPgMjmLFXZXMP8ytfVjySO0w5WRhYglSnOQMwKdEEkwrIr4UnG6yX5PM/eEC2zDV
         hJt9/1jslidOQNgn+AkYumcPO7MD/EmG2iMm9vrBykrRDcXpIBSrNQ+bC3JKEHPStzvf
         pq1vTvo0IrhquMZdEVu2VVKIKm9WyNXC129xDOrVPoR1sjq3gLq1wM/9u0pg/ByKdt2q
         se8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ef7KQOieJN6Xa/3kI92KngXev3jlaHg6Ray+PQfoecQ=;
        b=gsFeK0qCeZRuZEcQQUiYtoGXJg5qeO75lJmqeBhsVZsWG6q8w5L/XAON10frmIP7/B
         T0Yla2Z5AWDwyw8nocnyJY4FtD2qBGlp08bxcGKvbRyZlZTVrODeCWaaARpXuX5czUJH
         W2qinwnmj5W6cVkdw32OSg5VGwY1aMIpe/gEm8Sl586tZJtB65Y+D6Cxf+c/JQjHUeIU
         XKd4t74kZb1GFSE0+a+KwL8nt6fuuMK1Pf9+cJo8WaMFa+ZqoxjtvMX17DltMcqrP0zc
         N1RFm86JZHgIsULFNIcUbsYgCVWRb7XUDL3X8q89GmJ3UJHh63auO0th1fXMd5XLexpf
         QS1Q==
X-Gm-Message-State: APjAAAW8VbiJLbOHrW2CM1CNUmnSLyzl4hs74HtubJoS+nFRlXLVz8uV
        8SDKaqhWZi6MHQPabs5zlAoV1o1B
X-Google-Smtp-Source: APXvYqwAOc83SKbd+4wdK4lmJMuDE96DFG+nUSuKmHvEA85dAG25DrOYINUqiVUdHdARs+GlkNaxbQ==
X-Received: by 2002:adf:82e7:: with SMTP id 94mr7366461wrc.60.1579905676219;
        Fri, 24 Jan 2020 14:41:16 -0800 (PST)
Received: from szeder.dev (x4db61038.dyn.telefonica.de. [77.182.16.56])
        by smtp.gmail.com with ESMTPSA id a1sm8623384wmj.40.2020.01.24.14.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 14:41:15 -0800 (PST)
Date:   Fri, 24 Jan 2020 23:41:13 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] branch: let '--edit-description' default to rebased
 branch during rebase
Message-ID: <20200124224113.GJ6837@szeder.dev>
References: <20200111123533.1613844-1-marcandre.lureau@redhat.com>
 <CAPig+cQXkiFOz5HczPEgXuSOH_3KsCwXwVwe0qvQzLDtFgnAXw@mail.gmail.com>
 <CAJ+F1CKW3NACgPdPbmAzYGVwR4iO3r+LCNq+g5st0gcz4X+fzA@mail.gmail.com>
 <CAPig+cRCMXjjPHc2O8fLmaSm9m-ZO3qR2BoZwG3s5dLHNbiFFQ@mail.gmail.com>
 <20200112121402.GH32750@szeder.dev>
 <CAPig+cRvYzm8Cb-AWqOeANRziWyjhWXT32QJ6TsA1==8Joa4zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cRvYzm8Cb-AWqOeANRziWyjhWXT32QJ6TsA1==8Joa4zQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 12, 2020 at 08:59:04PM -0500, Eric Sunshine wrote:
> On Sun, Jan 12, 2020 at 7:14 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > On Sat, Jan 11, 2020 at 08:27:11PM -0500, Eric Sunshine wrote:
> > > Taking a deeper look at the code, I'm wondering it would make more
> > > sense to call wt_status_get_state(), which handles 'rebase' and
> > > 'bisect'. Is there a reason that you limited this check to only
> > > 'rebase'?
> >
> > What branch name does wt_status_get_state() return while bisecting?
> > The branch where I started from?  Because that's what 'git status'
> > shows:
> > But am I really on that branch?  Does it really makes sense to edit
> > the description of 'mybranch' by default while bisecting through an
> > old revision range?  I do not think so.
> 
> It's not clear what downside you are pointing out; i.e. why would it
> be a bad thing to be able to set the branch description even while
> bisecting -- especially since `git status` affirms that it knows the
> branch?

No, during a bisect operation 'git status' knows the branch where I
_was_ when I started bisecting, and where a 'git bisect reset' will
eventually bring me back when I'm finished, and that has no relation
whatsoever to the revision range that I'm bisecting.

Consider this case:

  $ git checkout --orphan unrelated-history
  Switched to a new branch 'unrelated-history'
  $ git commit -m "test"
  [unrelated-history (root-commit) 639b9d1047] test
  <...>
  $ git bisect start v2.25.0 v2.24.0
  Bisecting: 361 revisions left to test after this (roughly 9 steps)
  [7034cd094bda4edbcdff7fad1a28fcaaf9b9a040] Sync with Git 2.24.1
  $ git status 
  HEAD detached at 7034cd094b
  You are currently bisecting, started from branch 'unrelated-history'.
    (use "git bisect reset" to get back to the original branch)
  
  nothing to commit, working tree clean

I can't possible be on branch 'unrelated-history' during that
bisection.


OTOH, while during a rebase we are technically on a detached HEAD as
well, that rebase operation is all about constructing the new history
of the rebased branch, and once finished that branch will be updated
to point to the tip of the new history, thus it will include all the
commits created while on the detached HEAD.  Therefore, it makes sense
conceptually to treat it as if we were on the rebased branch.  That's
why it makes sense to display the name of the rebased branch in the
Bash prompt, and that's why I think it makes sense to default to edit
the description of the rebased branch without explicitly naming it.

With bisect that just doesn't make sense.

