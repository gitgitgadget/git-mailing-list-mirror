Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C609BC432C3
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 16:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24AF2068F
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 16:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfKYQLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:11:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34791 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbfKYQLE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 11:11:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id j18so242017wmk.1
        for <git@vger.kernel.org>; Mon, 25 Nov 2019 08:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+wIXxkvBdL3rmoyv/DvwVx8nb1MKasdOzLDTXjy9+Q=;
        b=JXbOG1q3nlksvZistP/OrtB5b0D8uThS8LjfeosWfW5ASNOsQtwHid0krNPx46m4Wm
         ETRK+e9QJbTwkhb+GhYL952ByPAIfDq6Db3ZgJ98RiWHq8vFXf9r3dltEHgNqWBwFj+v
         aaX6Wjt1KSUQi//PXkSvjQVmtoio9rLHEItS7DAT6Kk/c7ofSWVebRR4hfcO21MShAYW
         ipgA+sUHG3Xg7FmZgJNBiotajEHPnQ76bOSu9vING8jaV/IAzFANxHcyQY7HWGM5ksbO
         r5qNGbxgZWfJ/J6eBrAnLJFgn3TACE/MT2jjb5CXC6txqRnePDXD2wkrC9TMV7ReUlFd
         ueoA==
X-Gm-Message-State: APjAAAWsjZ2AwBVkzJvL/8F6fKlojhwgD3QFrLv4YHWPgDRfYjv5+fPX
        Md3Q3wiKCcX4ugMXt5xQ7h3DwcQ5GsfouL2Ty7Lfhlen
X-Google-Smtp-Source: APXvYqwRo8prds28RQewjHK+3idwidhAMhP18KCjvhFDLX6YOsL4P5xilfJ9v1h4Tgr8RkTmF4x9uZ8SrwajffKwE9E=
X-Received: by 2002:a7b:c94c:: with SMTP id i12mr25788360wml.95.1574698260529;
 Mon, 25 Nov 2019 08:11:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.467.git.1574345181.gitgitgadget@gmail.com>
 <pull.467.v2.git.1574451783.gitgitgadget@gmail.com> <037f2b2975e06847443aef46939e3c712053dedf.1574451783.git.gitgitgadget@gmail.com>
 <xmqq5zjb2vsx.fsf@gitster-ct.c.googlers.com> <340859a7-5cc4-f641-818d-fcedbf29a2a6@gmail.com>
 <94573071-556b-caae-b159-40c168a08f44@gmail.com> <xmqqr21wy80o.fsf@gitster-ct.c.googlers.com>
 <43bdadd2-9ea9-4e50-1f47-ec18e0db4794@gmail.com> <nycvar.QRO.7.76.6.1911251652510.31080@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1911251652510.31080@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 25 Nov 2019 11:10:49 -0500
Message-ID: <CAPig+cRg1WchC=-4qc51KQLgYewiYtEsu+RTf=_jbw3sZznjew@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] sequencer: fix empty commit check when amending
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 25, 2019 at 10:54 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Mon, 25 Nov 2019, Phillip Wood wrote:
> > On 25/11/2019 03:00, Junio C Hamano wrote:
> > > That "git rm -rf ." scares me, though.
> >
> > I know I'm not too keen on it my self but we need to empty the worktree and
> > index if we're going to switch to an unborn branch
>
> How about `git worktree --orphan does-not-exist unborn`?

git-worktree doesn't presently recognize --orphan, though it would be
nice if it did. In fact, I clearly was thinking of --orphan (along
with -b, -B, and --detach), when I wrote the implementation, as can be
seen from the commentary in one of the original patches[1]. That
--orphan never got added was either due to an oversight or it was one
of those "we'll add it when someone actually needs it" deals.

[1]: https://lore.kernel.org/git/1436573146-3893-11-git-send-email-sunshine@sunshineco.com/
