Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F5161FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 15:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbdBLPyJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 10:54:09 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:36217 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdBLPyI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 10:54:08 -0500
Received: by mail-it0-f46.google.com with SMTP id c7so164344565itd.1
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 07:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=7yvRHDyyo9p7sFfWNXJ8wYF3KJeKGSkALzMgIb4+QwU=;
        b=epUs3TrmXSPHY5UDZ6GFFnaOtWktYFF80I4cVTXo2qAqR3eEcKOd2XVwFMrp07dElx
         RwnqzZmolBNfw4XLkdjtgk9NrB1kx95/PboCCOuSDn/uk3hR4qpphLOoABBxwEy0Rqwn
         CzVUfzAznvUUYyZxMuVSN5dF14zGKC7nSxNNdwFxMeJlwZ+Ap1sgLbkHGV9a0cKNJdhM
         egrG6xm+2KDG+gfuPA6RmW5TPjBKXYfIfL+8KRBMBrBtpXmsuF10Cq+qAuyia4CJi4zT
         CTzOoDaX+CvWmeGMd/vVJtRRKTP9anQE3ccuSQ+oTTCru6mKEucsbJROoDTXoZIk58Tl
         bfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=7yvRHDyyo9p7sFfWNXJ8wYF3KJeKGSkALzMgIb4+QwU=;
        b=HPuaUZalFgBByoT3qqjQl1+Am7lbU5BU2LMsI6f+2ck8vdqpZnYCPCAACY6nwENWxa
         T1LWAM+vbfi48d54gGwnitvpBJdykkZDnaIDkm62nc/xAr7Yy9zQTjgDypN/IQECVPO/
         qJa7MymuMtI6pvM9NHrNVNVn7p/odjmbr7ICpANC9pJLFFBnltmK62+uPucQ50Ml07lr
         DwcizfOG8jS5PfrkPT6ho3Lnp1N92GYp1bC8tPkzf86w8Ojw3H3PQLjSRFzgViVMjlN/
         0fMvnAnOqR9rrhsscC0/oLn7HXQRLXk7D3FLARtDdNMHtN6Ws1OAbY6CYdLA0aA5gyHx
         +YVg==
X-Gm-Message-State: AIkVDXLx8ViWXNL4rIFTaMITqCs/aPZ4iNAxEc7w/IzW+3fmNGTegjWJiA00zPMCPfhX5Hkqm1bjLKXMxEk3jA==
X-Received: by 10.36.93.213 with SMTP id w204mr39589447ita.60.1486914847534;
 Sun, 12 Feb 2017 07:54:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.132.12 with HTTP; Sun, 12 Feb 2017 07:53:47 -0800 (PST)
From:   Mark Gaiser <markg85@gmail.com>
Date:   Sun, 12 Feb 2017 16:53:47 +0100
Message-ID: <CAPd6JnGC3yeDo_sB+H+UKvh-PbiC2qySC=EbaRNLbkkwYkJM4A@mail.gmail.com>
Subject: Git status performance on PS (command prompt)
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm using ZSH with some fancy prompt. In that prompt is also a quick
git status overview (some symbols indicating if the branch is up to
date, if there are changes, etc..

The commands that are being executed to fetch the information:

For the file status:
git status --porcelain

For the repository status:
git status --porcelain -b

On small repositories (or even medium sized ones) this is fast, no
problems there.
But on larger repositories this is notably slow (i'm taking QtBase as
an example now, but the same is true for much of the Qt repositories,
or chromium or even the linux kernel itself). It's no problem if it's
slow when you do "git status" on the command line. That can be
expected to take a little while on large repositories. But in zsh
prompts the call to git isn't asynchronous [1] so any slowdown will be
noticed as the prompt simply doesn't completely show till after the
command.

I did a bit of profiling in git to figure out where this slowdown comes from.
Callgrind tells me that "read_directory_recursive" takes up ~62% of the time.
Within that call the function "last_exclude_matching_from_list" takes
up 49% of the time it takes to run "git status --porcelain -b".

I don't really know how this code is supposed to work (i'm a git user,
not a git developer), so i hope someone might be able to investigate
this further. I can however apply patches to git locally and help out
with testing.

Also, is there perhaps a command out there that might be better suited
for the git status i want to show in the prompt? What i have now is
merely from one of the oh-my-zsh themes.

Best regards,
Mark

p.s. please keep me in cc, i'm not subscribed to this list.

[1] Most prompts don't have async support, but there are prompts that
do provide this: https://github.com/sindresorhus/pure I guess that
would be a better solution for me in the short term. Still, having the
status being made faster would be beneficial.
