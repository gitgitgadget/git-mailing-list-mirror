Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C10C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 19:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9554E20759
	for <git@archiver.kernel.org>; Thu, 21 May 2020 19:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wB2AZfFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgEUTAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 15:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729555AbgEUTAX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 15:00:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AB3C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 12:00:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l18so7723428wrn.6
        for <git@vger.kernel.org>; Thu, 21 May 2020 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2hAOpYME+IIwtSr7+nMBwh0Xr9A2EG9gxnOay0ioJ80=;
        b=wB2AZfFVG/x/SoC0bku3NXNGVEoby1+guBMeER4gwvtgjGCEa2VONV4bE6zB0NjH+0
         GS/lPyOeMPIbPFeAuPcmKephRNgyGGjr+xXnU6rTtl+A0lzuAPMzNPBBODJn35wRB+Qw
         pOxz4MjhvhVpQwmMLfiXpuaKLUgwAaCZ2Fj8ac+R+Qii6DCrAcQbfP58VTwxIZoSCXTK
         G4U+dE2C8HFEkNFow+jNweq9OUYv968/iPs00FR6Y3ojSiws0aDeeVgN8MbdOHuNZMXw
         MC5BQKJPwhx3FdrsZU8NCDFDXWSIjQNVzS6Lg4ybzIkQgq3hMknTHlrBUlql0QkC+4P0
         7Bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2hAOpYME+IIwtSr7+nMBwh0Xr9A2EG9gxnOay0ioJ80=;
        b=i+3jr5fLjoRXOOyKMX7zZhfjGIKkgH4SUloM+nbNGnqrYUTvrTzICHv8xhtJi9NwaY
         Mmd7fBC+3yp/I9LgXCY23lB+wDuI6ZVakuzTKA9pdaPfPvStxqS4YRAot3SkICw0S9sj
         m4d4+SFS8fdv9OIokaIk7VcRQlMhQdkKugxPujeocMNPZEM8Uw5Cs8Lt9efkWF410y2y
         L6WGiLEipHXtWIV4poG55zuy4ca7DV4HyK8hbU7mz7kqVyx+d9eUBYYbPKwnKWu8KDFJ
         yu5ZMRIvHALGtbFMzbjAvKqykEVqMEcBUunnkFENZjBQtxQLCi64mC6Ln7IYM2GUmMhW
         OFtQ==
X-Gm-Message-State: AOAM532bZLvW8XmJcKnlXcTmaCgOMRzz9p18JsQvrXxf11h3ptVH0ZET
        2Exzs4q5t7anDCP1oSeSBSMtQ+rYNREkAfqBFDN073iO
X-Google-Smtp-Source: ABdhPJztOkeySNYPopWAufF9uoIEpygiPIHqWxgJjV/Phw86KY1p4qpqadBXPc1lTuuDG7Sd0/PPgqJUvONCOUWXKbg=
X-Received: by 2002:a5d:61c3:: with SMTP id q3mr23792wrv.405.1590087620920;
 Thu, 21 May 2020 12:00:20 -0700 (PDT)
MIME-Version: 1.0
From:   Dana Dahlstrom <dahlstrom@google.com>
Date:   Thu, 21 May 2020 12:00:00 -0700
Message-ID: <CACqwCQiLpZ1HFzgJw0p0KR3jXNsxkhjXmF_huzhv+qkMZmybBQ@mail.gmail.com>
Subject: 'HEAD' is not a commit (according to git-checkout)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

  $ git clone https://github.com/githubtraining/hellogitworld.git
  $ cd hellogitworld
  $ git checkout -b work -t master HEAD
  fatal: 'HEAD' is not a commit and a branch 'work' cannot be created from =
it
  $ git show -s --oneline
  ef7bebf (HEAD -> master, origin/master, origin/HEAD) Fix groupId [=E2=80=
=A6]
  $ git checkout -b work -t master ef7bebf
  fatal: 'ef7bebf' is not a commit and a branch 'work' cannot be created fr=
om it

What did you expect to happen? (Expected behavior)

  I expected a new branch named 'work' to be created and checked out,
  pointing to commit ef7bebf and with upstream branch set to 'master'.

What happened instead? (Actual behavior)

  I saw these erroneous messages (copied from above):

  fatal: 'HEAD' is not a commit and a branch 'work' cannot be created from =
it
  fatal: 'ef7bebf' is not a commit and a branch 'work' cannot be created fr=
om it

What's different between what you expected and what actually happened?

  I expected a new branch but instead saw erroneous messages.

Anything else you want to add:

  This question seems to show the same problem:
  stackoverflow.com/questions/48671851


[System Info]
git version:
git version 2.27.0.rc0.183.gde8f92d652-goog
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
uname: Linux 5.2.17-1rodete3-amd64 #1 SMP Debian 5.2.17-1rodete3
(2019-10-21 > 2018) x86_64
compiler info: gnuc: 8.3
libc info: glibc: 2.29
