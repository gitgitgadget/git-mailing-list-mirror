Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5524CC2D0DB
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 12:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7702075D
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 12:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxZoAQXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbgAZMkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 07:40:04 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]:43502 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgAZMkE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 07:40:04 -0500
Received: by mail-qv1-f46.google.com with SMTP id p2so3223358qvo.10
        for <git@vger.kernel.org>; Sun, 26 Jan 2020 04:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=t6LpEABIBhzLO+3/UFyrBwYt8rIj4W+aVk5mdzA/v4c=;
        b=dxZoAQXzWhfJMZeIKB/f/3TUUUBRLhJRrc4p9UuWjZ9u0c4U8kiqlgDGyIVIyKUI1o
         rsnJTeI6AkDFUp8VVWS0D3wuErYx+DIK91wRHfVP556+B3w21bm/SPsAxRCPTRiTPMDs
         ui8ihqklu+yzhl5pqOdpOiODZ+t1xrqiPJvMIlkvTVqLXVgVsGiI1o04vD/zgbGl2YxA
         Woi84BsDPVQwUxmrIdfWhfAAeGWuYjNdTJQr3qEFwujs+D9XociEtyD7f2UK93QdMtTf
         HeDit5J2rU6bkPeDMhP2+Expx4vbC+7l6EmqumNK3Udzq0IojiYo4s+X1/R9+V6IkoDT
         4e2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=t6LpEABIBhzLO+3/UFyrBwYt8rIj4W+aVk5mdzA/v4c=;
        b=QSm+gGdPST3WiC6QRiWC/7idorI8ibFYfbKAQrw67Ju03roI06jfTCfig+tOXYT7ry
         wfhSZ5XLwoRsW6pgkrr8eG/06h8PpE9P4SIZYgqyJFh3ajoKD46lIlytuejlTQgZeu93
         noHsW9GqHLmDgrh0paBC6gCNGpC7qlBuRK+p8O5A9TzC9BQ50j0zl99BvNgihMpabWWS
         H9YZuMGmHWEZKyKnwuQnM7ouemwxfeCrYllq8cuDVTYtrSx9L8LNjX0ThQGJt3lkzpEn
         ioBwS4oyxpDM1J7lA3VwVrAxGluiEpqpxEUHBrehdHEYBK5BJlNVPfhSir22Lv3U++Fb
         z7wA==
X-Gm-Message-State: APjAAAXgtJcEz4wrHBZWL318hGHZ9/20v+BwIa5vU3SQw1pS+fYdoXk/
        lLc6dUueXmbIdOz9EeYl/Jxld4FlxZDybChrZT6mxLjz
X-Google-Smtp-Source: APXvYqx7lgCAEglFb0T/wEtn+XNrZm2MUitGJNQQkD2B+9aR76OYNPTuo/0b4Jlb/lLrPz9czuCmLrXOAuHAfqDKI10=
X-Received: by 2002:ad4:50d2:: with SMTP id e18mr12691774qvq.9.1580042403374;
 Sun, 26 Jan 2020 04:40:03 -0800 (PST)
MIME-Version: 1.0
From:   Chris Jerdonek <chris.jerdonek@gmail.com>
Date:   Sun, 26 Jan 2020 04:39:52 -0800
Message-ID: <CAOTb1wfoMf338VPRYcjAv+EaMYQxKJ=kP6-qMykG-LfxPrWuag@mail.gmail.com>
Subject: git-clone --single-branch clones objects outside of branch
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm reporting some git-clone behavior regarding --single-branch that I
found unexpected after reading the docs. I'm using git 2.25.0.

The git-clone docs for --single-branch say:

> Clone only the history leading to the tip of a single branch, either spec=
ified by the --branch option or the primary branch remote=E2=80=99s HEAD po=
ints at.

(from: https://git-scm.com/docs/git-clone#Documentation/git-clone.txt---no-=
single-branch
)

However, when I attempted this with a local repo, I found that objects
located only in branches other than the branch I specified are also
cloned. Also, this is true even if the remote repo has only loose
objects (i.e. no pack files). So it doesn't appear to be doing this
only to avoid creating new files.

In contrast, git-fetch behaves as expected (including locally).
git-fetch appears to fetch only objects in the given branch, when a
branch is specified.

Below are some commands to assist with reproducing this situation (but
you will need to update the path in the `git-remote add` invocation
below). At the least, it seems like the docs should clarify the
behavior. (The Python commands were for when I was doing some
experiments with pack files.)

mkdir repo1
cd repo1
git init
python -c "print('a\n' + 10 * 'x\n')" > a.txt
git add a.txt
git commit -m "add a"
# Get object id to check existence with `git cat-file -t` below.
git hash-object a.txt

git checkout -b dev
python -c "print('b\n' + 10 * 'x\n')" > b.txt
git add b.txt
git commit -m "add b"
# Get object id to check existence with `git cat-file -t` below.
git hash-object b.txt

git checkout master

cd ..
mkdir repo2
cd repo2
git init
git remote add other file:///<path-to-repo1>
git fetch other master

cd ..
git clone --branch master --single-branch repo1 repo3

Thanks,
--Chris
