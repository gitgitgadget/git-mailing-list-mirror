Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D460C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 11:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0D7221EB
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 11:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dinwoodie.org header.i=@dinwoodie.org header.b="RbE/LBNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgIKLjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgIKLhk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 07:37:40 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7742C061786
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 04:31:02 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id n2so9149743oij.1
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 04:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rC0Q5LBKsllOQlSFyZXo3/5ytAdMr1latVzNNTfF+0w=;
        b=RbE/LBNLXpcqN/ZF3Z8XJo4i4A74B+nJWNuVJJp5BLVDvz1l/u61TOJmOBtrHAFAx8
         ffu6NRVe4CY0SKP1i87c/L638b+MvdtD1da00vVxK4JhPHyIfcLJb6vZaYZn5QPzSmKc
         KuzWmoqJlrneG3UEd/ikuQfowQyW/u6Qsxhgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rC0Q5LBKsllOQlSFyZXo3/5ytAdMr1latVzNNTfF+0w=;
        b=P9HFTe0LZ+08vJ0+LQPDQkMAKRAKAe91WitTXRNT95tE6Gc1AIlI1tCkMqgq7janYm
         1xrGMPnaFq3t3T/FIqxjH1cUwXvmn0bvCsBJ/LWYhuxbyAcsTilajqMQszJJxJErpsMo
         agxMYNeiCPvAwg6u3UDMxn8JEWHF3r/rGclDao0gfE6X8Wic9A7RjW5YBoaMZ5uUC4t2
         86fzMAdH+s6h3H7H24n3fhIvc9I41QiLltokSs+AiaL6JIl/heGPN5ekqmVkGyd0dC1E
         6fVFc+JbVOqKXGHx56vj4J0GcA1uVV9nFJS5TR4MdjpteUZHtJKFu2V9AlsBMpcUzO9i
         XQfw==
X-Gm-Message-State: AOAM532AkVXZUqIAThPBijcby2/YrSwD9Mluw7u6I7MNMJ2wt30Z9KY1
        qWOWBBj4O0sspWkqwvGjpxaofLm3LQj5iUYYT9MpQw==
X-Google-Smtp-Source: ABdhPJxLtrEdD4VuFd+L3EHY1/LXzZ17vkRx1bX5DCz2wnni+QBtsBpCjWrrG50QfQjOqy7jz6QZLuqVMyhdVLQCU6M=
X-Received: by 2002:aca:bec5:: with SMTP id o188mr983139oif.21.1599823857483;
 Fri, 11 Sep 2020 04:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <CABJqhQNh2Qc2Btp==bGUbT-AaSjGdGEmhtphQQyX=nqjWOis0A@mail.gmail.com>
In-Reply-To: <CABJqhQNh2Qc2Btp==bGUbT-AaSjGdGEmhtphQQyX=nqjWOis0A@mail.gmail.com>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Fri, 11 Sep 2020 12:30:21 +0100
Message-ID: <CA+kUOan0N32W22xkoYsGYqM7rJDnc=tjQe_2Hnh2H47=19bbeQ@mail.gmail.com>
Subject: Re: Cannot run `git submodule init` on Cygwin from script with strict
 error checking
To:     =?UTF-8?Q?J=C4=99drzej_Dudkiewicz?= <jedrzej.dudkiewicz@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi J=C4=99drzej,

On Fri, 11 Sep 2020 at 09:20, J=C4=99drzej Dudkiewicz wrote:
>
> I'm running git 2.28.0 on Cygwin. I have a script with:
>
> set -aeu
>
> at the beginning (as all scripts should have). In the script I'm trying t=
o run:
>
> git submodule init
>
> When running via "bash -x script.sh", I get:
>
> + git submodule init
> ++ basename /usr/libexec/git-core/git-submodule
> ++ sed -e 's/-/ /'
> + dashless=3D'git submodule'
> + USAGE=3D'[--quiet] [--cached]
>    or: git submodule [--quiet] add [-b <branch>] [-f|--force] [--name
> <name>] [--reference <repository>] [--] <repository> [<path>]
>    or: git submodule [--quiet] status [--cached] [--recursive] [--] [<pat=
h>...]
>    or: git submodule [--quiet] init [--] [<path>...]
>    or: git submodule [--quiet] deinit [-f|--force] (--all| [--] <path>...=
)
>    or: git submodule [--quiet] update [--init] [--remote]
> [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase]
> [--[no-]recommend-shallow] [--reference <repository>] [--recursive]
> [--[no-]single-branch] [--] [<path>...]
>    or: git submodule [--quiet] set-branch (--default|--branch
> <branch>) [--] <path>
>    or: git submodule [--quiet] set-url [--] <path> <newurl>
>    or: git submodule [--quiet] summary [--cached|--files]
> [--summary-limit <n>] [commit] [--] [<path>...]
>    or: git submodule [--quiet] foreach [--recursive] <command>
>    or: git submodule [--quiet] sync [--recursive] [--] [<path>...]
>    or: git submodule [--quiet] absorbgitdirs [--] [<path>...]'
> + OPTIONS_SPEC=3D
> + SUBDIRECTORY_OK=3DYes
> + . git-sh-setup
> ++ unset CDPATH
> ++ IFS=3D'
> '
> +++ git --exec-path
> ++ . /usr/libexec/git-core/git-sh-i18n
> +++ TEXTDOMAIN=3Dgit
> +++ export TEXTDOMAIN
> /usr/libexec/git-core/git-sh-i18n: line 10: GIT_TEXTDOMAINDIR: unbound va=
riable
> <snip>

I think there's something odd about the way you're calling `git
submodule init`: it should normally be a separate execution that
wouldn't inherit the `-aeu` or `-x` settings from the parent Bash
process. It looks like perhaps you're `source`ing or dotting in the
`git-submodule` script? Whatever it is, I think the issue is down to
the way you're using `git submodule`, rather than a problem with Git
or the Cygwin Git build.

I  did just try to reproduce the problem using Git v2.28.0-1 on
Cygwin, and wasn't able to:

```
$ cat test.sh
set -aeu
rm -rf testdir
mkdir testdir
cd testdir
git init
git submodule init

$ bash -x test.sh
+ set -aeu
+ rm -rf testdir
+ mkdir testdir
+ cd testdir
+ git init
Initialized empty Git repository in /home/adam/testdir/.git/
+ git submodule init

$ echo $?
0
```

HTH

Adam
