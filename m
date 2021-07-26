Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB91C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1039C60F90
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 22:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbhGZVXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 17:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbhGZVXK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 17:23:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722ACC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 15:03:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d18so18138698lfb.6
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 15:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iTjELqtA3nIFrXy6CSZHgxkeoGxJOd+AvEYJx93LI/U=;
        b=YDLJoWi14J0aOMeF1tZ4uIOQpiRu6KimCNkknf90JaurXrTG6S+vb/akVoeRy5Qnys
         OO/3ouXXw43gJ2gTDXMi4Te/Z5HZ+CJuw13M8YDlF3uBEmPIgeeBjAp+ZQecWC23F9vU
         zMunluIXeRVW8OCl3AxYIJiPcBjjGh7xSeg2H1WJdKqp0/oyNo3zKu/E1/BYasgU8TlC
         OkZ/+RHEOOZNjBxklPsnVZIRCFmJtUuXKGsqJaPKF+H2cpciKVtzdNbMh4Q0Mr/oFGvC
         0t2d2Jq20zZ5TGGvpzqVJ8faqlQKfvu61Vb63/qEGgaVQP/wRMVgxW0d42Im1kVZtf85
         042Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iTjELqtA3nIFrXy6CSZHgxkeoGxJOd+AvEYJx93LI/U=;
        b=ejJPkgEXqQX5exh8r9VTFbJ+Yn97iU9FTZQV54l4+6S4YDSb/o5Gx8AnRiKJOgmHue
         gQkzMpcPEs7AlT1McUk5qM/yZpgpV2B3/ZtAFmnbdBGdZ/ru2cpJwadLgNmAa+gp7VwD
         dg4FHPV5PE5IXXK+36qfawmJOuQ5pU8m80lbg4gOCyP4TmD/uKe2q+JkV08VBR3JjWet
         2hJiOlu7/raLFO+yZWkAr7BYwlfUMtfw4Xtk8ZrPUhuY64P6N/EekSEbjTe3X2/w92gZ
         J+q7oillRyBdTTbSXpkJu7Pu1+AzwGWxbH3+0TfY4Wjlb9HF64L6Fl7/yTu6EHJToUH3
         XGMg==
X-Gm-Message-State: AOAM5314IcnpV9Lx6G9vMrzXW349SFqsdEhY08PNF+MH7cUW7kMmFNAP
        3fXa5aC/AggUfCY6hVA+UAMngbvjBT8lXwqNYzQ=
X-Google-Smtp-Source: ABdhPJwB4X+6tBpLVKac+Ci8QcY8d7JwzJnKtYsX5ZmTUku212I9WYUy1PR519+TyuprYJQpFZxONmasJ1ze94kQHwY=
X-Received: by 2002:ac2:50c5:: with SMTP id h5mr8385856lfm.642.1627337015782;
 Mon, 26 Jul 2021 15:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <dd4aca2c-9ca2-e489-d78f-9d2a5580f1a5@mfriebe.de>
 <4e9b54b4-8e40-7fd3-ae65-d33390f3af43@mfriebe.de> <04f3b300-3ccf-c91b-6406-6a998b473a24@mfriebe.de>
 <bfc257c7-bf74-06be-ac62-9a6d27f565c9@mfriebe.de> <CAPx1GvcHiaGsuOybOijRYpmivO0dLvUFacAeOrM4DfY-uuXB2Q@mail.gmail.com>
 <070f7f5e-0e6c-2edc-1403-9265c810df17@mfriebe.de> <CAPx1GvdM7CzsbT1SWW9+OPcG9FL7WXQ7YD6aM7P0krujp_OrkQ@mail.gmail.com>
 <67f35be7-3317-6486-cdb6-62eb691eaf10@mfriebe.de>
In-Reply-To: <67f35be7-3317-6486-cdb6-62eb691eaf10@mfriebe.de>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Mon, 26 Jul 2021 15:03:24 -0700
Message-ID: <CAPx1Gvey1uSr58Uf7VpC0c6J+R0tUP=VUP_dGmv_yVO-CwmvXg@mail.gmail.com>
Subject: Re: Files modified, even after: git reset --hard
To:     Martin <git@mfriebe.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 26, 2021 at 12:57 PM Martin <git@mfriebe.de> wrote:
> Is it possible that those cheats also look at the "replaced" (rather
> than the "replacement") commit(s)?

They look at `stat` system call (well, `lstat` *call*) data, not the
actual files.  This works better on Unix systems, where `lstat` is
a real system call, than it does on Windows, where it's faked up
from whatever Windows really stores as information about files.

> I am pretty sure I have "git replace"d all blobs for some of the files,
> and yet they do get phantoms.

The stat data are stored in Git's index.  It's the rebuilding of various
index entries that updates what Git uses to do a fast check of file
status.  (Note that the stat data on the index itself count as part of
the cheating; this gets tricky.  See [1].)

There is an article at [2] on how Windows implements `stat`. It's
probably out of date (says "VS2005").  It's interesting to me what's
wrong here: `st_dev` is made to mirror `st_rdev` but `st_dev` should
probably always just be zero, and they chose to attempt to store a
file *creation* time in `st_ctime`, when that is in `st_birthtime` in a
modern Unix-like system: the `ctime` field is the *inode change time*,
not a file creation time.  (Fortunately Git uses neither field.)

Chris

[1]: https://git-scm.com/docs/racy-git/en
[2]: https://web.archive.org/web/20101214222704/http://msdn.microsoft.com/en-us/library/14h5k7ff(v=vs.80).aspx
