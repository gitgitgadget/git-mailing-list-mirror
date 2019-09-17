Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB87A1F463
	for <e@80x24.org>; Tue, 17 Sep 2019 10:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfIQKvH (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Sep 2019 06:51:07 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:44221 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfIQKvG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Sep 2019 06:51:06 -0400
Received: by mail-lj1-f182.google.com with SMTP id m13so2939529ljj.11
        for <git@vger.kernel.org>; Tue, 17 Sep 2019 03:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pwgaUrYRRJevCK9CjdKFd6vuHyxd7V5NW4PjCQRetJY=;
        b=gv29nZeaMbN7E87Wjr1AlmMmWNqspgoMleMkRuUtgo3+p7s8CTUuf4+O5o/D7QUx3J
         tbKMCk84JXAkNkt3hVi6zPQnJZ7FzohjF1qqMOCCdbzq8BFdXEsmLuhFcjh8iJZeCS5x
         /8iTwhLIcznumu3lkHfCuUp4TA+w23mm+aPLlwgSUpQNOmcSYYzmcShlLATrJ/6YhjMl
         pvO26DFGFB1GJUl1mF9pP52cxkA5i6TgtAyn03sa+dPdchHqSxOWUDaFhbmiR2yN/gJ4
         9igL+GSGNY4LsJHTs5t2npTRpHtEwSYkVhAAWlgx21yA6kyYA8fynAqYixBOeUqnX1T4
         VAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pwgaUrYRRJevCK9CjdKFd6vuHyxd7V5NW4PjCQRetJY=;
        b=sJrtvAt23S9rd9bFoNUYRAjT4AcIp+aBWSzc14dUMTKrD1denvae/1ha8Lk+GwyIZl
         b9q9B1NS2dBukUvV2wdp/nAYc76xofk7+MFlAErAEHUt9C0bzD79WKe/kyRItHhGVsy4
         OEZHVy7JNVRXG/Y+cWKH1Mtdig/cXsSyKs9YAftnatuutiz3zJH3zg4VCl4ImimLHwu+
         GIUmZFyyhNn6hRjwmSPVy9jaEY0Wbn/yaPwrZzavh891a01RXNobRP0jge7KEQGfz6SI
         PqWnzR+lCDQYVVa2Kmj6nYoA0LerxT+vPKvffk2YLmOQn+Aga1RhszaF6RWW4P2ehgHk
         G+8w==
X-Gm-Message-State: APjAAAVHhAC66SPqenF2i53SZbHK+bbRNTeNYiqx8d1dLMyQAZCTBLST
        ZbpZ8HwIoYzz94RZyaq5xfRa5V5LZ7r0ueTqvHuhC7UpYIg=
X-Google-Smtp-Source: APXvYqwpzP0cUMiXBtoY4Uv/wH0C438tJJE73tUsibHeTQHFZU6hyv62a3XSn9GOjY+kknu8FJG6Vun4Qj16uj2N8DY=
X-Received: by 2002:a2e:9c16:: with SMTP id s22mr1522458lji.70.1568717464462;
 Tue, 17 Sep 2019 03:51:04 -0700 (PDT)
MIME-Version: 1.0
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Tue, 17 Sep 2019 12:48:23 +0200
Message-ID: <CAGr--=+L6tff-5oSX9oAF6AnvPwv8GDxb8vfyhRBnSS+JU7AAw@mail.gmail.com>
Subject: git-gui Makefile: cannot derive correct sharedir when gitexecdir has
 a space char
To:     Git List <git@vger.kernel.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


I ran into som issues when compiling git-gui on Windows. Turns out
that the "sharedir" variable gets an incorrect value when "gitexecdir"
contains a space.

For instance when
gitexecdir is set to "/c/Program Files/Git/mingw64/libexec",
sharedir becomes "/c/ Files/Git/mingw64/share".

Perhaps it is me doing something wrong when setting the gitexecdir env
variable? I use
export gitexecdir=/c/Program\ Files/Git/mingw64/libexec

If that's a way to do it, should the Makefile be modified to derive
sharedir another way? Perhaps with a check if we're on a Windows
system.

What do you think?


Birger
