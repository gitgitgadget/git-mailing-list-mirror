Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2AF220248
	for <e@80x24.org>; Fri,  5 Apr 2019 08:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbfDEIMC (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 04:12:02 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:47012 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEIMC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 04:12:02 -0400
Received: by mail-ua1-f68.google.com with SMTP id v7so1769397uak.13
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 01:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s27eic6YFpCmNu4ADBzOxrnxim/TIwgHUifJFw81r04=;
        b=WJ8LuaJ5nyLSfaC3oAEN0pWeksM4EZpzUB6JBa4bW0pA8fJwDKCwu8viG38fTcUZpL
         n2A+N42XVUi2BsOCq9EcXkKkSMGKpEI/OefE++HsZHWFXhdv3eRTYDH4oeKStVh8Knmf
         nzrSPuxvhp9n94FJkiQzTWOaH7+k1GiwbqyyHAzKwB9TfTFfAG1LSIXpwccNiP8iWq1k
         Vwnf3oq+QucHY2Twc7bSp4ELX3kc/VZ5abNyFErsU/42B9Nyst3wtoxJgceTW+8N8W1u
         QZKzgkzOquICHqyIXJRWQP2mh8Jy9vO4hW8GRFnESFbhALZeHsyEnCeqUVyppUJPSET7
         GuaA==
X-Gm-Message-State: APjAAAWNUQM2D2ibT0C7qby1LlFlM1GpnfCnuV1gKq/1em+195QPqQ0F
        1FUclKMOeOLF7+YlDn5GjaIuFbULSYl6BGNz0Gw=
X-Google-Smtp-Source: APXvYqwu38Sn54D0uZJX1zJUowA1J/bLOCgq5KfQc3puBOjTa0jiZlfji6uyTDNaNh6y/prNy6wDT+38wAwTO87Yf5M=
X-Received: by 2002:ab0:7493:: with SMTP id n19mr6741754uap.121.1554451920723;
 Fri, 05 Apr 2019 01:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAA01Csp7y9=2n9=TNYMMw9LUO_cENz7FBeZjFrUd2FvHFT9NCQ@mail.gmail.com>
In-Reply-To: <CAA01Csp7y9=2n9=TNYMMw9LUO_cENz7FBeZjFrUd2FvHFT9NCQ@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Fri, 5 Apr 2019 17:11:48 +0900
Message-ID: <CAPc5daVQTouBVqJPccQNdzFP6XYEL7G2UUH-HC4QgYdRWt__Kw@mail.gmail.com>
Subject: Re: "commit --author=..." does not work if global email and name is
 not set
To:     Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 5, 2019 at 4:35 PM Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
>
> Hi,
>
> I have a repo downloaded on machines which do automatic tests.
> Sometimes I want to make a quick fix there and push back to origin.
> Reading git-commit docs I had impression that I can use "--author=me"
> and it will work. But it requires setting global user name and email:

You can still do

 git -c user.name=me -c user.email=me@my.addre.ss commit ...

if you do not want to follow the advice message to store the ident
permanently.

>   git config --global user.email "you@example.com"
>   git config --global user.name "Your Name"

Technically, what you are missing when you give --author is only
the committer ident, so you can probably use

  GIT_COMMITTER_NAME=me GIT_COMMITTER_EMAIL=me@my.addre.ss \
  git commit --author=me ...

even though it is not any shorter ;-).

I think all of the above is quite expected. The fact that --author is used to
specify the ident of the author is a good sign that it is different from the
committer ident (otherwise the user would be using a configured default
ident that is always used as the committer ident, without overriding it
with the --author) option.
