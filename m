Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B20C636CC
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 22:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBMW6U convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 13 Feb 2023 17:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBMW6T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 17:58:19 -0500
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DABBBDCD
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 14:58:18 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id fu4-20020a17090ad18400b002341fadc370so1770784pjb.1
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 14:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfFH1DhP8xu6PaaRkaYciLlMQGynnqKAvpyMf7D9F7k=;
        b=j4WdQ7FrP7SvFC5KV/QOrLlOjiN7mrnkDm2rLMvYfzLd8DSgsGpx5Jte33Azg0hMlX
         8O6/Qq7T0gQNxcadoKXqP0JiR/gjX/JXtuCM8j3JGJrRMQVHjCL+fswPEi11rLImSoPs
         9KNtadwvISYLwZrLSl63vfeCSCeHJEdO6uzOi3NvnYTg5SIfF0RBOd7Q+DY2qsdODh+y
         dWS/dBg1bwqU+15OT3NFVLeEpdh92ka9EEFQ+InJWiHnkL1z+OzydqB3QLwNWcuJXOo0
         KP22qGbUttb7KPyopPqf96KxD4D1CnWUmUhn8qt7SaG7ulWSc6vlhTgI6Se12Zpwnvt6
         Ie4Q==
X-Gm-Message-State: AO0yUKXr5RNrudshF82Xut5q6xFfdB9aOzv3Peo9S7JUm7Hj1JY2G/TV
        ziW8OE6EuqWzo4SRUlPCLLpQmNDZ1vgfB6DtRAc=
X-Google-Smtp-Source: AK7set8TL4s3kHRo1C2hT48th6H7kLTssUcJDQrqFqQbLC1o3r/Olz37IyONMzk/wPb6R+ECfXSkW7jlEICFJ0sgLuc=
X-Received: by 2002:a17:90a:670f:b0:233:d1eb:de8b with SMTP id
 n15-20020a17090a670f00b00233d1ebde8bmr1667135pjj.130.1676329097660; Mon, 13
 Feb 2023 14:58:17 -0800 (PST)
MIME-Version: 1.0
References: <CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com>
 <Y+qbFN+PhHVuWT2T@coredump.intra.peff.net>
In-Reply-To: <Y+qbFN+PhHVuWT2T@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Feb 2023 17:58:06 -0500
Message-ID: <CAPig+cQ9f0aW0TcP9A5WrKmYcQsEZvPOiPrgmzsy1frWkHd34w@mail.gmail.com>
Subject: Re: bug report: symbolic-ref --short command echos the wrong text
 while use Chinese language
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2023 at 3:49 PM Jeff King <peff@peff.net> wrote:
> On Mon, Feb 13, 2023 at 02:38:08PM +0800, 孟子易 wrote:
> > System: Mac Os (Ventura 13.2)
> > Language: Chinese simplified
> > Preconditions:
> > # git checkout -b 测试-加-增加-加-增加
> > # git symbolic-ref --short HEAD
> > Wrong Echo (Current Echo):
> > 测试-�
> > Correct Echo:
> > // I Don't know, may be "测试-加" ?
>
> Hmm, I can't reproduce here on Linux:
>
>   $ git init
>   $ git commit --allow-empty -m foo
>   $ git checkout -b 测试-加-增加-加-增加
>   $ git symbolic-ref --short HEAD
>   测试-加-增加-加-增加

I am able to reproduce the broken behavior on maOS 10.13.

> I wonder if it is related to using macOS. The refs are stored as
> individual files in the filesystem, and HFS+ will do some unicode
> normalization. So I get:
>
>   $ ls .git/refs/heads/ | xxd
>   00000000: 6d61 696e 0ae6 b58b e8af 952d e58a a02d  main.......-...-
>   00000010: e5a2 9ee5 8aa0 2de5 8aa0 2de5 a29e e58a  ......-...-.....
>   00000020: a00a
>
> Are your on-disk bytes different?

I get the exact same results (on HFS+) as you show:

  $ ls .git/refs/heads/ | xxd
  00000000: 6d61 696e 0ae6 b58b e8af 952d e58a a02d  main.......-...-
  00000010: e5a2 9ee5 8aa0 2de5 8aa0 2de5 a29e e58a  ......-...-.....
  00000020: a00a                                     ..
