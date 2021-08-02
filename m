Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A392C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3253060FC2
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhHBRYc convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 2 Aug 2021 13:24:32 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:37601 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhHBRYa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 13:24:30 -0400
Received: by mail-ed1-f51.google.com with SMTP id g21so6243949edb.4
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 10:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5T2pz5lyoCxg7UtMftdWfw5UZaD9VYXImzBycu42ypc=;
        b=aqtQWc8YOqFl3qdJ5HxwmU3SOOaOei+356VmPiw/GR/H4H8mSTCBJ+SrxgttwaEGTM
         DLcwRq/iA3OFQ4X8WmbpVKL4bysj7pgjViq0jcSn+w2pZ9JvZ/krjocFNAZT+XfzoGmq
         L5yl5v8gx28ea+bwFNlJHXhowgyo2umPF/0yoFQ4o/Vf/ZvqzACMgDUAzWUMLcSC/4Tt
         ZAWFlkbvGNUKgD5oQSy2xcWmpS4QWBnhBfGHkJKOZaJ+x9QrTrph7GSiUNcLV/0cUcX+
         0qjTNogwU0wNyrcs4ZRwBQD5JvRw5sx4UnS3oIeuW4TBt0xjKpFHr4WmCS9x+ezaQhs0
         uyXg==
X-Gm-Message-State: AOAM5328N1Ver5bv7J1LP+OHmhSzivLVnJmsgif8c95DWLWQ37WWGX99
        LRj+pwl8v2Aoyid0kt3N/vppBi4hDZ9rP52vA6U=
X-Google-Smtp-Source: ABdhPJxvKOLOGHUKdb/o42eqvyLjBSBYNcanMFK9LNAopndYtHx7F9I1dwJbSCQJDO5ClJsQiFkyYBN23NydUNkfuzE=
X-Received: by 2002:a05:6402:d7:: with SMTP id i23mr20648857edu.291.1627925058872;
 Mon, 02 Aug 2021 10:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <patch-1.1-f81f3911d5-20210726T235452Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20210802T134610Z-avarab@gmail.com>
 <patch-v2-2.3-36c57178c55-20210802T134610Z-avarab@gmail.com> <20210802171429.GC23408@szeder.dev>
In-Reply-To: <20210802171429.GC23408@szeder.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 2 Aug 2021 13:24:07 -0400
Message-ID: <CAPig+cS5MyZ9iFC3kaipMmPSq93DoiQzoFffYds9rASOkJXWFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] test-lib-functions.sh: add a test_with_columns function
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 2, 2021 at 1:14 PM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> On Mon, Aug 02, 2021 at 03:46:27PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > +# Test a with a given number of COLUMNS in the environment.
> > +test_with_columns () {
> > +     local columns=$1
> > +     shift
> > +
> > +     COLUMNS=$columns "$@"
> > +}
>
> This function needs some redirections to separate the tested command's
> standard error from the function's '-x' trace, see a5bf824f3b (t:
> prevent '-x' tracing from interfering with test helpers' stderr,
> 2018-02-25).

This is also potentially problematic when a test is expected to fail,
in which case we avoid the:

    FOO=bar command

idiom and instead use:

    test_must_fail env FOO=bar command
