Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6C5C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 383FC20826
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgERRe5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 13:34:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39316 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgERRe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 13:34:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id w64so406042wmg.4
        for <git@vger.kernel.org>; Mon, 18 May 2020 10:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYFvDQri9FIC5vsqkA1VKAqXMmTDuTbpVFxMPRWqXLA=;
        b=RWkPneTyr8fPho0AgBCBiMhDFaQbT1Z+KVAiNyB/kIiAvo8NfVoNICw8r5jTLXJgpL
         V9EXUsd2y4+VHeMVZRiw/8zOzUAYvGoqS5tmZoz1ZQps96sBEYCvCDqzqNszRnxc4ib7
         b0kO3HP9aZAIiNofZtHSzBvEBadJMHkHv+IJM1L4nfRARhHf7Z7OuewSXCuZstjofN4O
         kpk2agbaHwqkEbqixD4WiUjSz+7p0VD2FD4unn5IFUfJrfZAMz37sPPij0dEdJZCKRHA
         jUsDX/zEBvXSvMD78IIdGDLkorGKgomxyXwcCTq1pvhyLfXLcbv+/I0TvCagQo5NvWu0
         mK1Q==
X-Gm-Message-State: AOAM5302AJ4BXdw2yL8T7UvcXv2dGDSSa+QNEBbSUGyKGX/eTY4IHPJV
        ROmpK1waACvwfHLrCF9A0yIJzY1fBHK2uC9P0aA=
X-Google-Smtp-Source: ABdhPJxkgKul0g+L91+YxnfPLv4kzsy7Mw/1FPIZyWoaCOLa6N9HkBWAAVbV8I1ZTDpazyou2ea7XebmCklHCZnLYgM=
X-Received: by 2002:a1c:7e4f:: with SMTP id z76mr426500wmc.177.1589823294984;
 Mon, 18 May 2020 10:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200515233130.GC6362@camp.crustytoothpaste.net>
 <xmqq1rnk923o.fsf@gitster.c.googlers.com> <20200516173828.GB34961@spk-laptop>
 <92cb6302-09a8-6780-9398-890b1e766680@gmail.com> <20200516194033.GA2252@spk-laptop>
 <20200517021452.GA2114@danh.dev> <xmqqlflq7fyd.fsf@gitster.c.googlers.com>
 <20200518094021.GA2069@spk-laptop> <20200518135656.GB1980@danh.dev>
 <xmqqzha541la.fsf@gitster.c.googlers.com> <20200518172103.GA2110@spk-laptop>
In-Reply-To: <20200518172103.GA2110@spk-laptop>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 18 May 2020 13:34:43 -0400
Message-ID: <CAPig+cQqx1GckiMqGXgzwyLHZzx-Q1ayst8boaJ0X6GDPirbHQ@mail.gmail.com>
Subject: Re: [PATCH v6] diff: add config option relative
To:     Laurent Arnoud <laurent@spkdev.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 18, 2020 at 1:22 PM Laurent Arnoud <laurent@spkdev.net> wrote:
> The `diff.relative` boolean option set to `true` shows only changes in
> the current directory/value specified by the `path` argument of the
> `relative` option and shows pathnames relative to the aforementioned
> directory.
>
> Teach --no-relative to override earlier --relative
>
> Signed-off-by: Laurent Arnoud <laurent@spkdev.net>
> ---
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> @@ -86,4 +87,79 @@ do
> +check_diff_relative_option () {
> +       dir=$1
> +       shift
> +       expect=$1
> +       shift
> +       relative_opt=$1
> +       shift
> +       test_expect_success "config diff.relative $relative_opt -p $*" "
> +               short_blob=$(git rev-parse --short "$blob_file2") &&

You're using double quotes inside a double-quote context. (Note that I
dropped the quotes around $blob_file2 in the example I gave in order
to avoid this problem.)

> +               cat >expected <<-EOF &&
> +               diff --git a/$expect b/$expect
> +               new file mode 100644
> +               index 0000000..\$short_blob
> +               --- /dev/null
> +               +++ b/$expect
> +               @@ -0,0 +1 @@
> +               +other content
> +               EOF
> +               test_config -C $dir diff.relative $relative_opt &&
> +               git -C '$dir' diff -p $* HEAD^ >actual &&
> +               test_cmp expected actual
> +       "
> +}
