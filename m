Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49147C433E3
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 19:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2298220729
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 19:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvGuIUI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgG0TZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgG0TZD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 15:25:03 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3644FC061794;
        Mon, 27 Jul 2020 12:25:03 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id l27so6005441oti.3;
        Mon, 27 Jul 2020 12:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TkkaEaYrW9Ou9eLGe8+HDBCdjCYlztr1vWyVAlzywno=;
        b=SvGuIUI84PASUgAtr463yZ2TI370rAkkKu4nXEOZa0xnBKuNVIrL/7Pnv+7hIl58eO
         9zvJ+/ZsaX9Li5bsZFWxrMdB8w+P5tAGQV2eU/rzEzqAO4lqSr6dID2cfZigcaMm+lDZ
         TW0sVICwCNyQjECeKoETHQoSAss6R600R+2bjrxd64hnO9rsr4f92BE6fZ7ciRHrW9q0
         EI3jg8Er2NruG7tHUX8BSdqVckgK+fVfzzWumhzdeuJ+zH/a032kErTd98/bIIxg95XY
         +nYHNUyMac+wDAoCAzZgHEIAVPX9c+WxZJ0zI0AbQi7d4AhdID/ZB+gjlLfWxSIwuSe+
         H2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TkkaEaYrW9Ou9eLGe8+HDBCdjCYlztr1vWyVAlzywno=;
        b=la8ebMbHej02/KiVx7Qa3pUNcDShjUFDn8mPex1hUcDJe6Rfg9y9sLOus8UG9GzdfM
         55AXtWMN5vdZAwR4ZUQBfdZDBgsTVjy2qA6w03Ilw5/UjrFL2GEdzaM7hED012yYIWXs
         xlKwHRvzjWJphNSoGAIqI1orqj1JHZ9d2fcwNTlqJvYFzmCvXAsSNpakEhIhl/1N0sUD
         tWU3NWCNgCa1FlbYtskYioFzKDeiDRxEWQd5RI0YBgB/1e++tl3YNb9pGcNWzUcIzpNn
         fCRRQl4KmlowWPW6LFpjSdoG1Yf22MYxVfaOADV7aljZJ2pe43lqJywRwCuPJLqVicZQ
         K1rA==
X-Gm-Message-State: AOAM531sujewsb0FWcIQaSH01QFi2HgPWBJVmJgi5P/AuYDaZcORTTu/
        U9PIsjC/CrMVEQrfgs0y/MCwnzAEprrOCyr1KUc=
X-Google-Smtp-Source: ABdhPJzRZUVzK9YksuDYqiN9J56vcfGtqGCG5Fxl5KpmbaYPXsmczkfESbdsaOjpVHN6OLH4Dw6NEhxh+0pjO+hPDAc=
X-Received: by 2002:a05:6830:1db5:: with SMTP id z21mr21943641oti.162.1595877902390;
 Mon, 27 Jul 2020 12:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq5za8hpir.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq5za8hpir.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Jul 2020 12:24:51 -0700
Message-ID: <CABPp-BGVFKKm+n8wTN9dqbA6=HJSZ5m3bnG7fLZ5DGevXSXBAA@mail.gmail.com>
Subject: [ANNOUNCE] git-filter-repo v2.28.0 (Was: Re: [ANNOUNCE] Git v2.28.0)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Jul 27, 2020 at 11:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> The latest feature release Git v2.28.0 is now available at the
> usual places.  It is comprised of 317 non-merge commits since
> v2.27.0, contributed by 58 people, 13 of which are new faces.

The latest release of git-filter-repo, v2.28.0, is also now available.
It is comprised of 15 non-merge commits since v2.27.1, including two
changes from new contributors.

The public repo of filter-repo is at

    https://github.com/newren/git-filter-repo

The tarballs can be found at:

    https://github.com/newren/git-filter-repo/releases

git-filter-repo can also be installed via a variety of package managers
across Windows, Mac OS, or Linux (and maybe others)[1].

New contributors whose contributions weren't in v2.27.1 are as follows.
Welcome to the git-filter-repo development community!

  * James Ramsay
  * Jonas Bernoulli

[1] https://github.com/newren/git-filter-repo/blob/master/INSTALL.md

----------------------------------------------------------------

git-filter-repo 2.28 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

(Note: Additional information is available for many release notes at
    https://github.com/newren/git-filter-repo/issues/<NUMBER>)

* New features:
  * ignore comment lines in --paths-from-file (#111)

* Fixes:
  * allow globs to match file or directory names (#114)
  * use new --date-format=3Draw-permissive fast-import option to avoid
    fast-import failure on malformed date timezones (#88)
  * fix undefined variable names reported by flake8 in rare error paths (#1=
28)
  * fix crash from assuming parent is an int (#131)

* Documentation:
  * document mapping output (#117)
  * ignore the generated documentation (#127)
  * several miscellaneous doc improvements

* Miscellaneous:
  * make tests individually re-runnable


Changes since v2.27.1 are as follows:

Elijah Newren (13):
      INSTALL.md: fix missing trailing backquote
      t9390: make tests individually re-runnable
      filter-repo: allow globs to match file or directory names
      filter-repo: ignore comment lines in --paths-from-file
      git-filter-repo.txt: point people at the generated documentation
      git-filter-repo.txt: be more forceful on the wording of --force
      filter-repo: make fresh clone warning scarier
      INSTALL.md: wording clarification on what repology.org tracks
      contrib: rename no-op-example to barebones-example
      filter-repo: use new --date-format=3Draw-permissive fast-import optio=
n
      Contributing.md: link to Nicolai H=C3=A4hnle's code review comments
      Fix undefined variable names
      filter-repo: fix crash from assuming parent is an int

James Ramsay (1):
      git-filter-repo.txt: document mapping output

Jonas Bernoulli (1):
      .gitignore: ignore the generated documentation
