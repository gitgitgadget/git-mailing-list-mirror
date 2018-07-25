Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7DBE1F597
	for <e@80x24.org>; Wed, 25 Jul 2018 08:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbeGYJog (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 05:44:36 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:42120 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbeGYJog (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 05:44:36 -0400
Received: by mail-yb0-f193.google.com with SMTP id c10-v6so2681877ybf.9
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 01:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=rNqOy85fiWoVXOpcpiHK4tQV4BwDC07J44DU5FgcWjk=;
        b=IRK8ViulgxXt0LAAG8AD7/DokuAoeBhGSjm9DuSsXeA0ZUUIAvEvVAnGEjGbwJeBHm
         nzBs21aJjCNiU5Tb9Up4tp65tURix1C9DETtzM1ZJDuj8ZVjF1A1LM3f7Kdw7xiQ7dQn
         MCBLvlbeMhJMbi1jU/K0png9g+rD1NhO9iyPAuPxJs2S1MQHNvdmSWQiK7Hdd25H82bA
         uoCkIUE7NkhDIMm4br3lR8KcQRk9WVdQHpTokyNH0JhoTHbXH6DjMCmYfwUdzMEG0gK8
         Vd7oafl8f+BHFFOX6ddQs6Jb3DZUDKuWRJsUwnpAeOvOqmqoHT31MMOCu6ARfq2L6z+4
         kehQ==
X-Gm-Message-State: AOUpUlHPcoRZ+6kc4SfT5NA6R/bsBQP/pgOjIv2mSWC0Az4PZxSeHdGH
        XUNZRP29gVRZ/05GrDEVmxYgL9Q6l0cB5qftJjc=
X-Google-Smtp-Source: AAOMgpfIaEtzftHxL9xHwsYJrvDe2DQjcUTPMJzUlnOYs9KSAwe2+beUouAdkZDo6eBM9R+HokH5866eOj+PklruW+U=
X-Received: by 2002:a25:488a:: with SMTP id v132-v6mr11071932yba.263.1532507638572;
 Wed, 25 Jul 2018 01:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180604235229.279814-1-sandals@crustytoothpaste.net>
 <20180604235229.279814-2-sandals@crustytoothpaste.net> <20180611074743.GA24066@flurp.local>
 <20180724221712.GJ18502@genre.crustytoothpaste.net>
In-Reply-To: <20180724221712.GJ18502@genre.crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Jul 2018 04:33:47 -0400
Message-ID: <CAPig+cT44egNgzMKLHwJb-WHkpK1gnVrre_Ebv+O8xnemRRWRw@mail.gmail.com>
Subject: Re: [PATCH 01/10] t: add tool to translate hash-related values
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 24, 2018 at 6:17 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Jun 11, 2018 at 03:47:43AM -0400, Eric Sunshine wrote:
> > Here's what I had envisioned when reading your emails about OID lookup
> > table functionality:
> >
> > --- >8 ---
> > test_oid_cache () {
> >     while read tag rest
> >     do
> >         case $tag in \#*) continue ;; esac
> >
> >         for x in $rest
> >         do
> >             k=${x%:*}
> >             v=${x#*:}
> >             if test "$k" = $test_hash_algo
> >             then
> >                 eval "test_oid_$tag=$v"
> >                 break
> >             fi
> >         done
> >     done
> > }
> >
> > test_oid () {
> >     if test $# -gt 1
> >     then
> >         test_oid_cache <<-EOF
> >         $*
> >         EOF
> >     fi
> >     eval "echo \$test_oid_$1"
> > }
> > --- >8 ---
>
> I'd like to use this as a basis for my v2, but I would need your
> sign-off in order to do that.  Would that be okay?

You can have my sign-off for the code above.
