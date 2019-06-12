Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFC531F462
	for <e@80x24.org>; Wed, 12 Jun 2019 10:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438077AbfFLKsN (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 06:48:13 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:39922 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438073AbfFLKsM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 06:48:12 -0400
Received: by mail-ot1-f45.google.com with SMTP id r21so14954939otq.6
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 03:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8RVR2u2MNYFYaH4j5kjmeMR0mR1+H5Qqkz4s2s++pz8=;
        b=M6IhKTVsjXXC6Ss87Sp4DIHHcSb7Gi7VqyTU3cAAo3uot/6VNp3lq0dJetaBNeUUDG
         XDwIIv5jNLQAMotpF4/0y8jOtakCgGmD0+4I90uQBE/b99cF4X1gF4lHyU46oxV7P7uT
         egh0lRxn/bcxX/VYLAfq8zEKiwrYNBavQmwGHGZwn5Eoimk5dvoYSFLBltPwsjMq6uwB
         wNjzqL8cuU1uMfamRN+hWQUVO4urdv9CH1V+QwaChCv8olIWqXsrkRETW1VyusJfc3tH
         ObXbyle2SXaZiWcgChuqBKmoB+82P822YE6/sUM6/sCcv+z36Ke/Qns/xrznxnt2QGfG
         V/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8RVR2u2MNYFYaH4j5kjmeMR0mR1+H5Qqkz4s2s++pz8=;
        b=P9zTnXm7Ym19mxcHvKBLbwn42Ib3FXSH8lGgYUo3VTI2bYrk7pM3X9ES1ONyi+iQSc
         hyuLyF0dWQzW07E2yroxXRMPXLMAL04g9KaUu5H5/rQfoazmkeZ/6SNnYbnw4LHfHE2f
         NqQL99SYBMnbqujZJoHXGehp4GwVIGq+qF95usI6xSfjztvOk81u4mT2S2Z98VPZetn+
         pvsQQLCY4FoSDnk1bvHfalH0fbv9Obxij0HM3cq3gPzXe680LYjoVWgQKFyfw/mcOL3v
         KN3Sj339UL9zruLqnjwIZ7xKaT3GySZoro0oncNw5l1rKnU+f92X4fI+74kDXOO+00s5
         8R1Q==
X-Gm-Message-State: APjAAAU1gZnUZfYvGPpCR4YdZ8gz700FhrT2nWMnjXyEvXl3fzXBqee9
        iGHmux/LnHGaeCfh8dLmp5agiswymXKb7rmaFYZBFq/W
X-Google-Smtp-Source: APXvYqwLcNeDEcEtS/DJqUeeCcvSwoGNLwoXSSklyXS9B4lfhtps9Y6s8t2xGP08kcIZKX9pzc/QrtIinPXm5uOR5xk=
X-Received: by 2002:a9d:62d4:: with SMTP id z20mr38625163otk.340.1560336491844;
 Wed, 12 Jun 2019 03:48:11 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander <alexander.samoylov@gmail.com>
Date:   Wed, 12 Jun 2019 12:48:00 +0200
Message-ID: <CABcYkASFxTe7Sq278EqCT1hBQq4Sh47-emNPJcnhA6YWZf+uQg@mail.gmail.com>
Subject: BUG: Git checkout on Linux sets always CRLF regardless of core.eol
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I am trying to checkout out various 3rd party Git projects on Linux
and build them.
Some of them have text files created under Windows with CRLF endings
and it is not under my responsibility to change it.

Thus I have to force LF line ending for Git checkout (regardless of
which line endings the files have in the repo). I use the following
settings for that:

$ git config --system -l | grep core
core.eol=3Dlf
$ git config --global -l | grep core
core.eol=3Dlf

However it does not work. The issue is reproduced pretty fine on
https://github.com/winlibs/libjpeg project. This project does not have
.gitattributes file, therefore I expect that global settings must be
enough to force LF, but I observe different behavior:

$ git clone https://github.com/winlibs/libjpeg; file libjpeg/libjpeg.map
Cloning into 'libjpeg'...
...
libjpeg/libjpeg.map: ASCII text, with CRLF line terminators
(not only libjpeg.map, but a lot of *.c files also have CRLF if you check i=
t)

libjpeg is an opensource project, so anyone can reproduce this issue
on a Linux host.

This makes me think that this it is either a bug or not documented behavior=
.
I tried various combinations with core.eol, core.autocrlf and even
global /etc/gitattributes file - nothing can force checkout with LF!

Could you please confirm whether it is a bug and provide the clear way
to bypass it.

My Git client version: 2.17.1. Please, see also
stackoverflow.com/questions/56546220/git-checks-out-crlf-instead-of-lf-on-l=
inux.

--
Best Regards,
Aleksandr Samoilov
Build & Integration Ingenieur
Compart AG, 71034 B=C3=B6blingen
