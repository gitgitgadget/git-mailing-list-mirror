Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A1BC43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 03:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADAC21D7D
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 03:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="sEBsbTom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfLSDJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 22:09:48 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44263 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLSDJs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 22:09:48 -0500
Received: by mail-io1-f67.google.com with SMTP id b10so4216427iof.11
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 19:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/XfRXyMRdLcr1QTjAKgTSeI+s1uBm61/dDDgFNPfR2I=;
        b=sEBsbTomihe+4zwpq1rP8YscONtx3ZYb1V8M5kA9lam8alttxSGP4o9Uq7q/JEU6d0
         Lki1xDWStNSOshdPDf0QHu+oPz3BOlur+rkHuFTrlLIos5k8iKRo9jyO+JKGBY8ZYvaT
         gM1ofPbnNJ3NvULRIpWcXy4JRFta1sck2fTMlH/KwJUvCi7pmnljzuEfyCGULg4zrIok
         bLkNLhZ0SEw7aeajoIUu4uvlLSNZ49d3ySZk9PjJNQ0Ti3mi7MGIp8JXRXxmIJhG63X1
         L56KoJYpU5o33ue5M42VqHCODs0iBolxAxwsUYf1STiYyDtRsq7vRP63tfNocbWZiRiO
         it+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/XfRXyMRdLcr1QTjAKgTSeI+s1uBm61/dDDgFNPfR2I=;
        b=HuB32MBAU9HPYxymTW+jmkSPn17+FEvlOkPENhZl32SAI81DgQFW/jeiD5wu1QTsnA
         nSY/4QCDlX1rrTD24SFfFgiZIP2khMzzUeCur6NwwBc3eBr5PBkKvHb8QY/3+vDTkYR4
         OlTh3OFNnAbFSSRNM9ITfwm/fPoJ/qkR6Jwe0wkpAPyf3OJeTezbUfUr0OCKZ/CVQxlv
         0bpBCDKjnYRnjFhfdGIXZ0lECGkU663popO+mjUd7tGk0tjtlEg9BC2FsBCR98NE9PRY
         mxP7EaV6d+GEkAVFXQlUgbHHnte0/AkR3i5gSQaX5qBM4xH+yrAjdUkTcgSRAVHIRv0g
         W4dg==
X-Gm-Message-State: APjAAAVIx3ZvtxLrb8sWFJoTJSJBBA/4HG7TUl86mG7sm4a5zFcciVab
        1N2yyys3cmm5tRGa8zUT0kOJGG5QrzzOxSuX5Xkc6FWjFvQ=
X-Google-Smtp-Source: APXvYqy4jvYbfDRtCmqQ0LO6rCztdIKTxMLastKRty0eASwLNUFJG9CkNG+Ycze7NDDK6D7TnNQMddOXiDCB2W9wVNY=
X-Received: by 2002:a02:8525:: with SMTP id g34mr5215002jai.72.1576724987003;
 Wed, 18 Dec 2019 19:09:47 -0800 (PST)
MIME-Version: 1.0
References: <62a8f522.6873.16f1c0243f6.Coremail.wuzhouhui14@mails.ucas.ac.cn>
In-Reply-To: <62a8f522.6873.16f1c0243f6.Coremail.wuzhouhui14@mails.ucas.ac.cn>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 18 Dec 2019 19:09:36 -0800
Message-ID: <CAGyf7-GK4SJ8oqJ-n1gCdNOq0Dwsxy4V7Eep7qXTsd51pVz7rA@mail.gmail.com>
Subject: Re: How to determine a branch whether has a specified commit
To:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 18, 2019 at 6:42 PM wuzhouhui <wuzhouhui14@mails.ucas.ac.cn> wrote:
>
> Hi,
>
> I know
>     git branch --contains <commit>
> can display all local branches that has specified commit. However, specify a
> branch and commit, I don't know how to determine whether this branch contains
> this commit.
>
> I think
>     git branch --contains <commit> | grep <branch name>

"Combine" the two commands: git branch --contains <commit> <branch
name>. That will either output the branch's name, if it contains the
commit, or nothing if it doesn't.

A different approach would be something like: git rev-list --count
<commit> ^<branch name>. If that returns a count of 0, it means the
commit is reachable from the branch. Otherwise, it'll output some
positive count indicating how many commits (including the specific
commit you asked about) are not reachable from the branch. (I suspect
you don't really need the count, so you could also use "-1" instead of
"--count".)

Hope this helps,
Bryan
