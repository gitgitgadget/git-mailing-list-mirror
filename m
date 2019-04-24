Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 644941F453
	for <e@80x24.org>; Wed, 24 Apr 2019 13:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfDXNhT (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 09:37:19 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:37366 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbfDXNhS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 09:37:18 -0400
Received: by mail-qt1-f169.google.com with SMTP id z16so20244614qtn.4
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 06:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=I17FYb4evBCoI/iQlOw2UFVmXZCHkgKoWqZJxTKwG30=;
        b=M2B29b/XL2+9Bx7x0zMOH3rvQJCelYHL2s4bUUmeKzYr4szt2retM7HTbDIXA+Hv8I
         W7Dg4aXIyC9/LB118vU1vmIJbNQ3ptxrcBMN5cB9++44nHCuDavOgmCafxjgtJIBSvFB
         LXEbOtLckPkYF+quHS8Nzp3N1swegG6kYQdevT6sqXLW8+Y2k9/Y+Keceg5YJpsLfYRX
         Ia6oH/I9J3zSrYc03vdymTVDEGcTrbL956ORvjLkO+DhuYBkoi5N7Qs/HLvwC78lfgwN
         FZz9CRWsqlK4m0j3LdD/PpPyFwHJ+dHMqRZQZGXDTQrK1tOWj8O2eQq5trmIVBnEGCB8
         hw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=I17FYb4evBCoI/iQlOw2UFVmXZCHkgKoWqZJxTKwG30=;
        b=EAPfO3iyfwphfU4fAsBM/KIM9JTs9H+plEtqJpgahcaCVKOuFk8Snmj6c3sMMbdOnV
         txni9Bv8P69dmQ0aBIhZX7a8NZxParHGmED/E68I2dp0pDcPm78f97+oQrSS7yuLmuSU
         SkTiYw6hI0QT20lEA45B/a0rC/5wqYnwFmRJDqUJYqt1tLko0gRQEpoDiGbyFDucQjbf
         CEcQtAbixgXotHs8VL0wfZK6Ph/8L3gQXphQprHgMYG+PClUGJvvx/5KtgYMm0fkIwft
         Tm5pw1m7tW7LACUExqf5A+GerKyUXbEA1dYSe1RWKZv7Cv5NSIgM2EhsPQvZqRevxFU/
         ly6Q==
X-Gm-Message-State: APjAAAU54q6v+bnFOqx2EosNPsihvJKN3clbGVRoCHhaK+SNGsVCNctt
        1KcPri7mXN4z4akUaGioNuzyLWK8rw/6PlEWXCjhzrii
X-Google-Smtp-Source: APXvYqwVRyJvS65dSUswOaYQHk2oIZ8i4ueqhlADOXpKkCDRy2coIUG6xI/vJfm8FggV827rS0cYd5KKzjSLJaKCybA=
X-Received: by 2002:ac8:16c1:: with SMTP id y1mr11523309qtk.369.1556113037167;
 Wed, 24 Apr 2019 06:37:17 -0700 (PDT)
MIME-Version: 1.0
From:   Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Date:   Wed, 24 Apr 2019 15:37:05 +0200
Message-ID: <CAA01CsoJZMJ86mpybukqT0hVnvXi0FuRjZ23akM5kNPBdT754Q@mail.gmail.com>
Subject: Checkout file without changing index?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

what is the standard/recommended way for updating a file to given version?

I was familiar with "git checkout revision -- file".

But it updates both working tree and index. I had some changes in
index (staged) and "git checkout HEAD -- file" silently overwritten
it. Well, probably my mistake, it's documented.

After searching a bit I found "git show revision:file > file". But
it's problematic:
1. works only for 1 file. "git show revision -- file" does something else
2. requires full path, so you need to specify "git show
revision:relative/to/top/dir/file"

If there's no other easy way, maybe we could add "--no-index" to
checkout: "git checkout --no-index revision -- file" (or similar -
maybe use options from git-reset).

My use case: I had some changes prepared in index and wanted to
compare the prepared version with some older version. The file was a
zip file plus we use LFS so there was no other way than to "checkout"
the file, unpack it and diff it.

-- 
Piotr Krukowiecki
