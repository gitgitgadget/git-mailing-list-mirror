Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D88C433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17BFA22260
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uviXRfwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgJST3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbgJST3M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 15:29:12 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB33C0613CE;
        Mon, 19 Oct 2020 12:29:11 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id i12so788321ota.5;
        Mon, 19 Oct 2020 12:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9X8tLHZrbbTbBwxG4qt9upsEtr1ymwTMTBgcrD2t1E8=;
        b=uviXRfwgl93GmkIzrh3OupzoHmJVQDZW7+7zfkNe9WPq08ZSOG5ZjC2ENWpvIsFqZw
         xhYmLxZEGzl+qqjetQK3iJNy6j56YBXgmUpriD0FwX7qvUzYqe/0PXvGF8XDi79OQJMn
         A+z4ES+Pxt0jB7KBWcDKZObkNdCEjLZmBVqoHZcF2tNHhLCD/riOGDSH2F0reHIN7xTC
         FHfVGrGD4xHAdYjjCwVB2yRXuu7h5d7iEDSUnGi4pYxC3l1z9BrbYiLEwK2YGZdNX8dA
         JFZDMyPhDGuqPg6M6MQtZnN0N6O9OqvnkMPwZZjBnNaAH3tjkhJgtjviKlw7bUhktQjw
         ABaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9X8tLHZrbbTbBwxG4qt9upsEtr1ymwTMTBgcrD2t1E8=;
        b=HCILr0BKSIVIIHJ92jwu8Ni8ptdCo8HOq1sp1qO/815u0yylJOis/ySwvQUNobhtjH
         rff/R4+0retRSjnuS5NOlFTaNN8dzaC6KC1soFRasJm+D68yC7lfpG+5g+8MWvVZ7Jt0
         ODRour1KsDj85vnzlFHVWqZsbE0n/aKb9P++O/ikabU/3CVZuHuzoVH2r92ChvcpwsQS
         4+8EC+ax26IwpdJrcd1GmUwqoNLjNnH8zIPhDFj3kKQldZinq/4UGebB+1mvHvhJ6RHX
         kL4ham6ccUYMn6IGXgnWF0n7OoLHF8gTXYlFJNne9FnjQY8E2178/b3rb3toK2iKXOuh
         /FPA==
X-Gm-Message-State: AOAM533jDeO65PGSn5lDvoON4d3Tu1sxsaeVT2VRykNtPRZ3eygPhlFZ
        iBHzFUpRJX2Pvany6kVJodcmJFcspoQExsJEDqtFgCWWg/kMlA==
X-Google-Smtp-Source: ABdhPJyNJ8ZtUZZ8iLIlUpdcaZe6LOgfxGzR9FF0pIiCo6pOyROZMQm6qCAUVV6Yy3cnY4Gx6W2BfSfxvnv5wrhXPlU=
X-Received: by 2002:a9d:6e96:: with SMTP id a22mr1085670otr.345.1603135751057;
 Mon, 19 Oct 2020 12:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy2k2t77l.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2k2t77l.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 19 Oct 2020 12:28:59 -0700
Message-ID: <CABPp-BG+uP2-t62AfgBauvoRtXfF4pU-xXKq3+YEEhjDdiHR_w@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.29.0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Oct 19, 2020 at 11:15 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> The latest feature release Git v2.29.0 is now available at the
> usual places.  It is comprised of 627 non-merge commits since
> v2.28.0, contributed by 89 people, 24 of which are new faces.

The latest release of git-filter-repo, v2.29.0, is also now available.
It is comprised of 7 non-merge commits since v2.28.0, including two
changes from new contributors and one change from a previous
contributor (besides myself).

The public repo of filter-repo is at

    https://github.com/newren/git-filter-repo

The tarballs can be found at:

    https://github.com/newren/git-filter-repo/releases

git-filter-repo can also be installed via a variety of package managers
across Windows, Mac OS, or Linux (and maybe others)[1].

New contributors whose contributions weren't in v2.28.0 are as follows.
Welcome to the git-filter-repo development community!

  * Martin Wilck
  * Tom Matthews

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  * Marius Renner

[1] https://github.com/newren/git-filter-repo/blob/master/INSTALL.md

----------------------------------------------------------------

git-filter-repo 2.29 Release Notes
==================================

(Note: Additional information is available for many release notes at
    https://github.com/newren/git-filter-repo/issues/<NUMBER>)

* Fixes:
  * correctly prune nested tags not matching filtering criteria (#134)
  * only set author from committer if author email not set (#154)
  * fix typo in docs about converting from bfg-repo-cleaner (#148, #151)
  * fix NameError in filter-lamely script (#161)

* Documentation:
  * corrected notes about --replace-text regexes (#145)
  * improved installation instructions, especially for Windows users (#124,#163)


Changes since v2.28.0 are as follows:

Elijah Newren (4):
      filter-repo (README): remove outdated 2.28.0-not-yet-released comment
      filter-repo: correctly prune nested tags not matching filtering criteria
      git-filter-repo.txt: regexes & globs apply to entire file, not to lines
      INSTALL.md: add notes about common installation issues

Marius Renner (1):
      filter-lamely: fix NameError because of forgotten fr module prefix

Martin Wilck (1):
      filter-repo: only set author from committer if author email not set

Tom Matthews (1):
      converting-from-bfg-repo-cleaner.md: fix typo
