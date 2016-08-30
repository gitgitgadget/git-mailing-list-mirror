Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16A171F859
	for <e@80x24.org>; Tue, 30 Aug 2016 11:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758394AbcH3Lp7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 07:45:59 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:34323 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758149AbcH3Lp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 07:45:58 -0400
Received: by mail-oi0-f52.google.com with SMTP id l203so21886920oib.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 04:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=O6i3E0C2/isBu1VMNEecvFe1JC3Izp1fH31NojAtxQ4=;
        b=FoZqQiyrkXjHpvOGd5SozPuHkKzNUnM3QMza+OM0PbWhzgKRMsJ3ms7frw27f4ac/W
         zE56LyryP5GwqjhSA8YFQVdu2DgphLDI6jJWelqCP4sB61FO0eqHUosFvXDTaSDbZFy9
         6e7sujSKtSIQLMnLHS6a30WolyyFZUQV+MH/pV7v0LN9WoroZs30+8e+ERQsrM0maXXS
         G0chTC+S/RIpYbN5rKyefDunESZ6t62bn/PCXW26nFhe1WpUn9Uia6UKoT9Y9uIE2cTR
         A6A3NHs1+NMc9774f62gHsb1PaO8UdkM+k4nq7VO3rQYFVNR314GSUi8bj3O2GOTHRPL
         5MqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=O6i3E0C2/isBu1VMNEecvFe1JC3Izp1fH31NojAtxQ4=;
        b=ItI/gyW5pnByTzIsPMNdH1UV4aA0RYdhQcyZyPY2TQ3Je0uxBxQUi6pRo0WztBkC8o
         Iv9m6U+PrDfg5JWFVF1wLRbqtl4qvBJIltfBXG/+Kr7ojvgVHHAinBaKpNnxnt/StqC9
         4Fz+7CjiWOye9I+qiBW3H0sMGDaOVsdstA220JSVxHkXnGGDa1vs6DBJ0/hl2Ogl1Tep
         BR3F+P0B3ujVCtv3xjMNtPzjjK0rEnSaDaki0WGQI06l8jiiOJ1iVxMnVBN07iYtKwOl
         0d763buMOI2XfAXQXL28bLQFj+afo5muvIbUd83MUZrVSCxKtaOFmYWWt4zdg/Itww6c
         +ZFA==
X-Gm-Message-State: AE9vXwN4oaQlQPDFY3zIFUldYbvp5ntAgeF+bMY7pzNznq5iCnQPVhP5y0y33F4VPeUdPyZKfTZ1N5ij6+fPgQ==
X-Received: by 10.202.242.214 with SMTP id q205mr3386897oih.60.1472557557016;
 Tue, 30 Aug 2016 04:45:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.77.213 with HTTP; Tue, 30 Aug 2016 04:45:56 -0700 (PDT)
From:   =?UTF-8?Q?Thomas_B=C3=A9tous?= <th.betous@gmail.com>
Date:   Tue, 30 Aug 2016 13:45:56 +0200
Message-ID: <CAPOqYV+C-P9M2zcUBBkD2LALPm4K3sxSut+BjAkZ9T1AKLEr+A@mail.gmail.com>
Subject: Bug Report: "git submodule deinit" fails right after a clone
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I found a curious bug in git version 2.9.0.windows.1 (run on Windows 7
via git bash).

If I clone a repository containing submodules and run a "git submodule
deinit" on any of the submodules of this repository without executing
another git command, this command fails.

For instance:

(let's say the repo MyProject contains 2 submodules: Submodule1 and Submodule2)

$ git clone ssh://****/MyProject
[ ... "git clone" output ... ]
$ cd MyProject
$ git submodule deinit Submodule1
fatal: Please stage your changes to .gitmodules or stash them to proceed
Submodule work tree 'Submodule1' contains local modifications; use
'-f' to discard them
$ git submodule deinit Submodule2
fatal: Please stage your changes to .gitmodules or stash them to proceed
Submodule work tree 'Submodule2' contains local modifications; use
'-f' to discard them

First the error message is strange.
Then what is even stranger is that the error disappears if a "git
status" is run before the submodule deinit...


$ git clone ssh://****/MyProject
[ ... "git clone" output ... ]
$ cd MyProject
$ git submodule deinit Submodule1
fatal: Please stage your changes to .gitmodules or stash them to proceed
Submodule work tree 'Submodule1' contains local modifications; use
'-f' to discard them
$ git status
[ ... "git status" output ...]
$ git submodule deinit Submodule1
Cleared directory 'Submodule1'

I have been able to reproduce this error at least 10 times and with
different repositories so I do not think it comes from the state of my
repositories.
Moreover, the use of "--recursive" argument to the "git clone" command
did not change anything.

Are you able to reproduce this problem?

Thank you in advance.

Best regards,

Thomas
