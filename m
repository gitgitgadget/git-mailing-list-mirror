Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AD162095E
	for <e@80x24.org>; Sat, 18 Mar 2017 19:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbdCRTId (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 15:08:33 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:38751 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbdCRTId (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 15:08:33 -0400
Received: by mail-it0-f52.google.com with SMTP id m27so60087996iti.1
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 12:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9v8CEIiKgUM7bDh7F7pT56jzZHZJo1y222aCIU55vg0=;
        b=ifm7hhYWndS5kmxEba8saUSJdpTiJ/GGre798J9xgL37cljJ71EEoLbMZUlg8Jxpkn
         k4CRyMLkgzyEfdOCO0PO6OkvsyTw+2Lslmu6WWYmWQQT30sAtwCgRM8MmEqk/SST+AKb
         4gXSrflnuWSWaRihnqr7HZIWiSkmdEX+c33c+EvGSdjdaWsmLtvaMMEKkFzXfbHImOjW
         aq2pdKL9vsAE5xizi2H3M8mfAU6R5K/6uqyoLgBT7wJsuLq6UYyuHlj0l0siAOsiQGMN
         6pAQD5OTSX2tmSLh5W7uVGVwy5y38bybyH05GrnL4qM9QjFXvVlbr0VGPycKbJvbOcVA
         bilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9v8CEIiKgUM7bDh7F7pT56jzZHZJo1y222aCIU55vg0=;
        b=kWaoimn1IzC9sVrinsjUcZxB52K2oD10jyGrhPjiElHMBu3z9qVO0TXj4495pupU91
         iSjfyEsI2dIPa1S/k/ap8l445246asHe++WlLlx7tVF+KQysx4Ok9Qpp7XRlKt8WpGOc
         JKKIWcj3xl9g0Yd8QvWAyiqKJniJ6rqkpJSClcB9Bjxa3wJPqZF2A2XB174l8F0bruV5
         0H4EyoIJKpG/IRIaEMR3fBJ22jENleyBRYIJKAQEqflyZHFHbvems6nNm/fBr/ps+c7A
         czMB5Ut1dW9Q7QCX8MB4mAc65NmxFSjTlyYxnDseSOfPGW1fIDRbbQO2EF63Jm/9446Z
         wgxQ==
X-Gm-Message-State: AFeK/H2VXLnPARsMcJ9SyUiCUqHzEnUtVRDYqhz2yld3b44HM69C0kHPsiIbd0c/gYLr1yUF88KVX9NJgLoE0w==
X-Received: by 10.107.57.2 with SMTP id g2mr22700194ioa.117.1489859747643;
 Sat, 18 Mar 2017 10:55:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 18 Mar 2017 10:55:27 -0700 (PDT)
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 18 Mar 2017 18:55:27 +0100
Message-ID: <CACBZZX6Bknimu26in8YG7TbsL3hEpmXTYwQAZQ5xK-DFoSatEg@mail.gmail.com>
Subject: How do I make 'git diff --no-index' follow symlinks?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'd like to (ab)use git's nice diff interface and make this work:

    git --no-pager diff --no-index <(echo foo) <(echo bar)

It just prints:

    -pipe:[203030063]
    +pipe:[203030065]

But I want:

    $ diff -u0 <(echo foo) <(echo bar)|tail -n 2
    -foo
    +bar

I went diving through the diff code for a bit, but couldn't find where
it's stat()-ing the two files and deciding it's not going to follow
symlinks.

Just having some option to follow symlinks would make this work.
