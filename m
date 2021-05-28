Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC95FC4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 22:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6879613E3
	for <git@archiver.kernel.org>; Fri, 28 May 2021 22:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhE1Wq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 18:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhE1Wqg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 18:46:36 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B92C06138B
        for <git@vger.kernel.org>; Fri, 28 May 2021 15:44:57 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id x15so5754717oic.13
        for <git@vger.kernel.org>; Fri, 28 May 2021 15:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=44OJa+jL4ncaei1MQXB4xZiClrJar1SjMSxuS7GPUVM=;
        b=BBLYlMx/doHGSvueRhMzgXemjNt5UVrh/Ce1cES6M/9mL2SbxFAWctqtql2gK+8Ys6
         MMJ4plcG62rEpWlhiU1Qb+Q8DnUCA3kYGQqpWCT/HLOob/wkXO3nFo0LK4/EqiTE5qS8
         cKPHu+jbZKkg9IBRTBBatQWk5vQ2dVS+j+rskh4f/qst63wxKYRg63+rOLuEsLn7H23u
         nnvc5xEqPCsqpdcsIVI/YtVDCXwMggBBU57u7/jnY3GEUYGvjYwTtAkDM+GCPz9724mw
         yk2z7FpoPX1qxF/CDPGr6/w7/c39dlZJVabrU+HQBcaDa6L+aW2YYz85jqAjY8ZDClZu
         lOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=44OJa+jL4ncaei1MQXB4xZiClrJar1SjMSxuS7GPUVM=;
        b=dVpV8GEc8ViySeSFhb+qZ1ApBxU/odB5bsNLDGtmQYQBEzAs6jhp6uVzEdgZle75gC
         XQPElrciaEHbEjO/pA4p6OGIR1v99KOFA/wUD4OsfxPZXmziJBO6u0jdBR28I9LKdA6c
         nQQubqrDZHGsJJbDqJTos+6FewEty0BLlmcltbmeyhWQLsTAptW1to1n7yrodyiMSAsR
         ISo+IyrZsDjhTsmWfNCq+looXKRp8DO6kVv3vW9h8tU9iyJgd/HFzb4n8apoAMmlBqad
         Yg9gxNTkeagCgMUdqzM99vdbhac1mmkb7OOlomTXRfJj9kITgIK2Nl6NYET9Vg4QxxEv
         TSAg==
X-Gm-Message-State: AOAM533TbfUS/gTzrv5Kbbpf8Zf9iuoHFa36HcT72z09fpg+8wMIB3zZ
        InZ28Gjn6f/Aw0zcQoSTy/1Aa8PRt8esYwcvheLQRKWb2hSJ8A==
X-Google-Smtp-Source: ABdhPJywvwUmcsiwuvnY9xLteqKINjP6K3JV25uEji67CDcRUtUTWgHtP4dgNgDShrwyZkbHZxg5V8esbeoLCEb+Buo=
X-Received: by 2002:a05:6808:13d5:: with SMTP id d21mr7633719oiw.31.1622241896870;
 Fri, 28 May 2021 15:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <F58C0A40-A1B4-4B47-A8EA-20FEAB011B0D@botech.co.uk>
In-Reply-To: <F58C0A40-A1B4-4B47-A8EA-20FEAB011B0D@botech.co.uk>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 May 2021 15:44:45 -0700
Message-ID: <CABPp-BGUxHiYLjVcqBc0qpaHpd5MZCN_6S0YpH8tKcP3GSV2Pw@mail.gmail.com>
Subject: Re: bug report: git checkout deletes worktree file even though it is
 excluded by sparse-checkout
To:     "Tim Renouf (open source)" <tpr.ll@botech.co.uk>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, May 28, 2021 at 1:46 PM Tim Renouf (open source)
<tpr.ll@botech.co.uk> wrote:
>
> Hi all
>
> I have a bug report: git checkout deletes a worktree file even though it =
is excluded by sparse-checkout, even if it is dirty.
>
> Watch this (starting in an empty directory):
>
> $ git init
> Initialised empty Git repository in /mnt/amd/home/trenouf/amd/tmp/git/.gi=
t/
> $ echo file1 >file1; echo file2 >file2
> $ git add file1 file2
> $ git commit -m"commit 1"
> [master (root-commit) 4f7035d] commit 1
>  2 files changed, 2 insertions(+)
>  create mode 100644 file1
>  create mode 100644 file2
> $ git rm file2
> rm 'file2'
> $ git commit -m"rm file2"
> [master d025c99] rm file2
>  1 file changed, 1 deletion(-)
>  delete mode 100644 file2
> $ git checkout master~1
> HEAD is now at 4f7035d commit 1
> $ git sparse-checkout set /file1
> $ ls
> file1
> $ echo dirty >file2
> $ ls
> file1  file2
> $ git checkout master
> Previous HEAD position was 4f7035d commit 1
> Switched to branch 'master'
> $ ls
> file1
>
> I set up sparse-checkout to include only file1, not file2. file2 is now n=
ot in the worktree, even though it is in the commit I am checked out at. Th=
en I create file2 with arbitrary content. Then a git checkout switching to =
the commit where file2 is removed also deletes it from the worktree.
>
> I assert that file2 should be left untouched by that checkout, because it=
 is excluded by sparse-checkout. I guess file2 had its skip-worktree bit se=
t before the checkout that removed it from the index; that should stop it b=
eing deleted in the worktree.
>
> To be clear, I expect that last =E2=80=9Cls=E2=80=9D to still show =E2=80=
=9Cfile1  file2=E2=80=9D.
>
> Thank you for your attention if you have got this far.

Thanks for the report.  It's another example of how
"skip-worktree-means-treat-the-file-as-matching-head" causes
confusion.  You can find more issues with
present-despite-skip-worktree files at
https://lore.kernel.org/git/CABPp-BF6GpoDtMfpzf=3D3VWL_puuRH-cNV=3D9KajdF10=
03Fe05jA@mail.gmail.com/,
including reasons they come up more often than you'd think.

We do need to get these fixed up, though I don't want to step on
Stolee's toes with his sparse-index work, and I'm hesitant to open new
big projects until merge-ort is complete.

> -tpr
>
> [System Info]
> git version:
> git version 2.31.1
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.8.0-53-generic #60~20.04.1-Ubuntu SMP Thu May 6 09:52:46 U=
TC 2021 x86_64
> compiler info: gnuc: 9.3
> libc info: glibc: 2.31
> $SHELL (typically, interactive shell): /bin/bash
