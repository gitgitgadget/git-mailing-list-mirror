Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D12CC3DA78
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 10:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjAOKJY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 05:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjAOKJW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 05:09:22 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133D976B0
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 02:09:21 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id i12so17874131qvs.2
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 02:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwFRkIf1jpdbgoQAGt9V0i8MWc0TLIdc00llqxVrwPU=;
        b=WLh+Cz99VtzPF5c/XDG/nHrn/f90EzuLD95aK6iU3/Jlsczh1Pb8mYdIVGttyzpoKn
         RlOjp/yWmr9aWIbWIjDpE7ug5WQx86hvgmZASvTVCGl/f7HKFkPNt1Vcji80XOCOxK4A
         1+27QnD78BAOahbzOG6C4DS9VZrtoXlW0A70QYhoM564zBH+rXnXxZBQnV7duAWIDvbi
         68ZC6cata5e9niC7jzh106uBaaD4wmLqClLiiE95YLutHQGLFTNUSPX2qi4Rg4AwTzBo
         lbDMGktGbGB/lErbni/IXKD1GlOde3Xfurbni4hUc1rgFvPyZoX8vtfQH4MgCNAoc+Vs
         4Y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwFRkIf1jpdbgoQAGt9V0i8MWc0TLIdc00llqxVrwPU=;
        b=CYw/BPLh4/pQ8NWjgt9xMHwdeS68AJNsT/xWBEDoZmv/rBeowhtfSXzLaBR7B6UzGL
         kjzBVfqmAHHH5JeccZ9iozcjVOW/vk27LFg78v8N1XfI8Br/NzLoI3Eehsk+xIXMdxCS
         N1IDH6uOSMBqPhMSgXI8Q5WNUNR3b/tj4MET/bpqiDeL5KGCU2Ovka1E5+VQU7gh+a/x
         VssiQNIw8FmJ74CYaX47zo9TgjcrB/QfSeHCvKQLB4q1Imd6JCs7iFRYdMPiSWFXxZl8
         2l60H1c8LsB//gqR1P0fP4nz3MbyvXqeBhQKRqEQDBlZIbJ0s6/LjeggvqbBi6tAqFkh
         E6DQ==
X-Gm-Message-State: AFqh2koPzuCtp1Pk2/a2evA7FULcS74qMRA5kO6vo7ugf7eaSPwn93t5
        iIN9lfjS0SNGm+PhAyDlWeFePNJmF0YP0uGg4J5gWLzlWOQ=
X-Google-Smtp-Source: AMrXdXvq0L8kakKmeadCdFclgk/fGPpQuuAQRL8WJR/FMJ9VZX2o5HaZX4RLmj9mTOjL2k240NuAuey/ZGiVa4NMVYY=
X-Received: by 2002:a0c:c691:0:b0:4ec:11a4:13b1 with SMTP id
 d17-20020a0cc691000000b004ec11a413b1mr7023407qvj.94.1673777360159; Sun, 15
 Jan 2023 02:09:20 -0800 (PST)
MIME-Version: 1.0
References: <9c0fda42-67ab-f406-489b-38a2d9bbcfc2@selasky.org> <Y8NB21PExmifhyeQ@tapette.crustytoothpaste.net>
In-Reply-To: <Y8NB21PExmifhyeQ@tapette.crustytoothpaste.net>
From:   demerphq <demerphq@gmail.com>
Date:   Sun, 15 Jan 2023 11:09:09 +0100
Message-ID: <CANgJU+X0LZfpdh4HWFC6-Y=+G6Mv-wKiZWrB=JJwe6CnYKeORg@mail.gmail.com>
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Hans Petter Selasky <hps@selasky.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 15 Jan 2023 at 01:05, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> This is a problem in every Merkle tree-like system.  Most repositories
> have some sort of code review or access control that prevents people
> from generally pushing inappropriate content.  For example, if somebody
> proposed to push any sort of pornography or other inappropriate content
> (e.g., a racist screed) to one of my repositories or one of my
> employer's, I'd refuse to approve or merge such a change, because
> that wouldn't be appropriate for the repository.
>
> I don't feel this is enough of a problem that using a Merkle tree-like
> construction is a bad idea, given the benefits it offers.


[resend in plain text]

It isn't clear to me why this needs to be a problem at all. If the
Merkele tree contains data later in its chain that says "replace
Object X with Y", provided the replacement mechanism doesn't touch
commit objects, only blobs, then you can replace files in the history
with other files without altering the commit history.

Provided the toolchain validates that it has found a proper
"replacement instruction" in the history, it should be possible to
safely replace blobs without a full history rewrite.

The replacement mechanism could be structured so that you can only
"nuke" a file, eg, replace it with a zero byte blob, making it
somewhat less open to abuse, or it could allow arbitrary blobs to be
mapped to each other. So long as the mapping data is in the commit
history it should be as secure as the original mapping no? Git could
be taught to warn the user "Checking out a rewritten blob X as Y, see
012deadbeef for the rewrite instruction." when it happened.

Again, provided this does not touch the *commit* tree, just raw blobs,
I dont see why you can't have an object replacement facility.  Am I
missing something?

Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
