Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92639C433E2
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 08:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D83A21D92
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 08:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHlaCJIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgIKIUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgIKIUv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 04:20:51 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D171C061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 01:20:51 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z13so10126452iom.8
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=t3gRnRl0ok//oST32ofcJVzkpx1ZVLuk5V9kd6fr8aA=;
        b=KHlaCJImZ3qcAFlGD3+l2Zc9jS+Etj+jn+OqO+ACx3pYD6aRMZvsS1fxVmrQHI4x8/
         R6q9Te4Ppf9wLbxQsNziEVK1r7tQ+6+90lNnv/4AcNncYlRjq/A8scijs2aB+x51T7dn
         QXAKE24biLYTg4PG3PgkQXsH3tT2jT6bOc4DHTATqpVExD9Y7UmF/y0SdpMjESZqy2Z4
         15jbtw45/wRu7FxfIuxqJaztNTr3eqWWh3/y7r8EZopyqkRYpfeI0Jfpk6qn2DIwTvaL
         AJlj/e0ItZRBWQxvca6QyqoEJK5u+pYWl54zZw/vHXqhaVYEEw79x14xrVdcI/utv8+7
         XY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=t3gRnRl0ok//oST32ofcJVzkpx1ZVLuk5V9kd6fr8aA=;
        b=H8Sek07VnGzOYnVXeNs8QdrefdfLuX6lCydw9qvSNGy+O9SzWVIM8oUIlgW7tBKGxm
         fgEhog+2065wgrMgjRgs+y0ppB6N0nMxklA+YhKkf2ct1zSd6D+m66vNK5VMpZS4aFIR
         UaTe4J7VUc3F88ebCGGL8xdm8Hn/gwnvnKuGN4HTzGhLw+IPR29z4K+pg82AeibfeI47
         OvVkr1VMnqcBIxKTjNJy/VHaUUTQ9Hw9egM1ZpxVTQjLeOPCmXtVaJPGQkySib4KciDr
         rPGOySxJ0JGJcKJLQ47fJgFw9HBJ4I9MhD8X+wOxlspz6lXub9PVt7qaoxFZUvq2c2Md
         gA6w==
X-Gm-Message-State: AOAM53338aj6BXxxQVoZ9x25m12C+//HkgTVSvDDU0o8CF8UAmnOclfx
        p+O7lYqe0acOre0LharrK98gRnN7qjEFUxi26YTSziPNOQU=
X-Google-Smtp-Source: ABdhPJz3WfShhwmyxAvJGPVMQ6cVt4AB/Y5nHKq8uu1vFDT8huNPLXQ8O4Cw6oLNmJ6OkuD+JPTNjF6jj3KUcS6Ndn4=
X-Received: by 2002:a05:6602:6c9:: with SMTP id n9mr870937iox.91.1599812449803;
 Fri, 11 Sep 2020 01:20:49 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?J=C4=99drzej_Dudkiewicz?= <jedrzej.dudkiewicz@gmail.com>
Date:   Fri, 11 Sep 2020 10:20:39 +0200
Message-ID: <CABJqhQNh2Qc2Btp==bGUbT-AaSjGdGEmhtphQQyX=nqjWOis0A@mail.gmail.com>
Subject: Cannot run `git submodule init` on Cygwin from script with strict
 error checking
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm running git 2.28.0 on Cygwin. I have a script with:

set -aeu

at the beginning (as all scripts should have). In the script I'm trying to =
run:

git submodule init

When running via "bash -x script.sh", I get:

+ git submodule init
++ basename /usr/libexec/git-core/git-submodule
++ sed -e 's/-/ /'
+ dashless=3D'git submodule'
+ USAGE=3D'[--quiet] [--cached]
   or: git submodule [--quiet] add [-b <branch>] [-f|--force] [--name
<name>] [--reference <repository>] [--] <repository> [<path>]
   or: git submodule [--quiet] status [--cached] [--recursive] [--] [<path>=
...]
   or: git submodule [--quiet] init [--] [<path>...]
   or: git submodule [--quiet] deinit [-f|--force] (--all| [--] <path>...)
   or: git submodule [--quiet] update [--init] [--remote]
[-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase]
[--[no-]recommend-shallow] [--reference <repository>] [--recursive]
[--[no-]single-branch] [--] [<path>...]
   or: git submodule [--quiet] set-branch (--default|--branch
<branch>) [--] <path>
   or: git submodule [--quiet] set-url [--] <path> <newurl>
   or: git submodule [--quiet] summary [--cached|--files]
[--summary-limit <n>] [commit] [--] [<path>...]
   or: git submodule [--quiet] foreach [--recursive] <command>
   or: git submodule [--quiet] sync [--recursive] [--] [<path>...]
   or: git submodule [--quiet] absorbgitdirs [--] [<path>...]'
+ OPTIONS_SPEC=3D
+ SUBDIRECTORY_OK=3DYes
+ . git-sh-setup
++ unset CDPATH
++ IFS=3D'
'
+++ git --exec-path
++ . /usr/libexec/git-core/git-sh-i18n
+++ TEXTDOMAIN=3Dgit
+++ export TEXTDOMAIN
/usr/libexec/git-core/git-sh-i18n: line 10: GIT_TEXTDOMAINDIR: unbound vari=
able

(TL;DR: This basically boils down to GIT_TEXTDOMAINDIR being unbound,
i.e. uninitialized/non-existant.)

When I exported GIT_TEXTDOMAINDIR with bogus value from my script
before calling "git submodule init":

export GIT_TEXTDOMAINDIR=3D/bogus/value

I got (only error shown):

/usr/libexec/git-core/git-sh-i18n: line 20: GIT_TEST_GETTEXT_POISON:
unbound variable

I set it to `false`, restarted and then got:

/usr/libexec/git-core/git-sh-i18n: line 28:
GIT_INTERNAL_GETTEXT_TEST_FALLBACKS: unbound variable

I set it to empty value, restarted and then got:

/usr/libexec/git-core/git-sh-setup: line 91: LONG_USAGE: unbound variable

This is when I gave up.

Same script run with git 2.21.0 on Linux has no problems, but I
haven't compare differences between two versions, so I don't know why
it stopped working.
--=20
J=C4=99drzej Dudkiewicz

I really hate this damn machine, I wish that they would sell it.
It never does just what I want, but only what I tell it.
