Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB441C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 15:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCC7961019
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 15:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbhHIPqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 11:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhHIPqD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 11:46:03 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BE9C0613D3
        for <git@vger.kernel.org>; Mon,  9 Aug 2021 08:45:43 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id a13so28073284iol.5
        for <git@vger.kernel.org>; Mon, 09 Aug 2021 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZYWvn74wuP6jqJecN+M6Z1wpySf79LWqa9jyDcjGi4=;
        b=JtTuXx86GzfFx0XcCtbLhBTenquoQmilh9a0Vdr7wNeVTSh23pRsuJb3hGx0RvxRMo
         MUE2fVxe2XruOe7zFiqpUmtEEfvySJLdflqssnGYfvh9rkSTmxS2gml+K2Rm/PyFgokF
         C38eYxMrCfFUAwYNYU3NgfjJ8MQZPLsjnlNJDAqTSQbpOCl0ttR1BJgyO4F8uj5VCJbo
         M9ykAObsDWTWBWXym4bEGnhqaxrVnMS/VlFSKli3zXM5NQ3jomRQy2T/bnhBbUGmLh6m
         5K4/acnBU5LlgYCq5u5KoJs2P3wuYRhbVhj81SwGTRBehJyqzPP2UkTk8ng7DDf20b/1
         9sTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZYWvn74wuP6jqJecN+M6Z1wpySf79LWqa9jyDcjGi4=;
        b=itfRZWlIV/NhVTpMEz7m+a6M/8/OleLTxqFLR0FU8hJF1W7PnlVE6MvuxTbfXMI7pR
         APulTisfXZxL8BA1KFQW7UA+kJZYKkP/eZCZlyFlDXih2de3r7tIzrY+9Xugdlz+F2S9
         n6/Ec/RvSvE0mQeVEQwFGdGY51FpcbMY9bhClKHXZ+XYrRnJeruBy0kNAOdUUWP6kYeI
         NXxW7GTLtJ8EYENliflNQWkl3T2wfEMeZL45Enp+fdkFYlcCLLaS5hX3CCZ3qIl8y8xP
         7iPn3FNIyF/PSfSS5YfnVijrWnyqRLhtf9anGzOK1O4sgsQEkrLzKAXxMEeK4jt4eei0
         PuCA==
X-Gm-Message-State: AOAM532Tbny/+Wds1Ji0rtdjt/HyyQk7dT8h8hJZOvnPBJO7WgA1Io1S
        cQcjt1Mx5fmBsJK1Se+Xf5t8FIMsGc88KuVEX60=
X-Google-Smtp-Source: ABdhPJx/qxpqeJXBjcMkp+sxni6nv5JXvnb/kGS1a+aS8qHj+q08MKWJy0LAzaBwfdmJXkeUG6/plO1zqu+6LDTf4tA=
X-Received: by 2002:a02:6606:: with SMTP id k6mr23633736jac.51.1628523942643;
 Mon, 09 Aug 2021 08:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
 <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
 <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com>
 <87mtvolbuj.fsf@evledraar.gmail.com> <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
 <xmqqblc2srq0.fsf@gitster.c.googlers.com> <CAPkN8xKM0zi-AB1xKRGp=whEQTZAbn78w0JjvUXfGfRDky0C=w@mail.gmail.com>
 <08f31194-dce6-9434-c362-94d9a2d97563@kdbg.org> <xmqqlfb3g2jp.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfb3g2jp.fsf@gitster.c.googlers.com>
From:   anatoly techtonik <techtonik@gmail.com>
Date:   Mon, 9 Aug 2021 18:45:26 +0300
Message-ID: <CAPkN8x+agKRRD0Zd-pxs_EuYO_Xm8EyE0nJLCWQB4KNuNkvK8Q@mail.gmail.com>
Subject: Re: Round-tripping fast-export/import changes commit hashes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 4, 2021 at 3:56 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Sixt <j6t@kdbg.org> writes:
>
> > Am 02.03.21 um 22:52 schrieb anatoly techtonik:
> >> For my use case, where I just need to attach another branch in
> >> time without altering original commits in any way, `reposurgeon`
> >> can not be used.
> >
> > What do you mean by "attach another branch in time"? Because if you
> > really do not want to alter original commits in any way, perhaps you
> > only want `git fetch /the/other/repository master:the-other-one-s-master`?
>
> Yeah, I had the same impression.  If a bit-for-bit identical copy of
> the original history is needed, then fetching from the original
> repository (either directly or via a bundle) would be a much simpler
> and performant way.

The goal is to have an editable stream, which, if left without edits, would
be bit-by-bit identical, so that external tools like `reposurgeon` could
operate on that stream and be audited.

Right now, because the repository
https://github.com/simons-public/protonfixes contains a signed commit
right from the start, the simple fast-export and fast-import with git itself
fails the check.

I understand that patching `git` to add `--complete` to fast-import is
realistically beyond my coding abilities, and my only option is to parse
the binary stream produced by `git cat-file --batch`, which I also won't
be able to do without specification.

P.S. I am resurrecting the old thread, because my problem with editing
the history of the repository with an external tool still can not be solved.
-- 
anatoly t.
