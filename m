Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D5361F404
	for <e@80x24.org>; Sat,  3 Feb 2018 00:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeBCAGu (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 19:06:50 -0500
Received: from mail-yw0-f175.google.com ([209.85.161.175]:39602 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeBCAGt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 19:06:49 -0500
Received: by mail-yw0-f175.google.com with SMTP id v196so14488567ywc.6
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 16:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=COMqaCSEqVmnaQc+piXJLFu4vZQ52ByjRSmKVxQG2X8=;
        b=BpTD7HpOyYYRZhGjAcnvHpZFo79D57WlascCFU10PzZYRf+7ROYseqxC2BDSOZYW5U
         0p4TvBkI1EsEGhPEc7BmAJsk/Krqa5jKexjXd3bIMaeaP5gUJwyTrstIOsRqnozj2Rie
         8J6w+NpWTtO2nrivlc4NQu2x4XY8ytan+5u2bBeQvAczoruNqyXQq/sbP+RIHfQmUtKi
         0JIgDXLOH25or2RRTnGFwyUaLinjap1RGxO5YDQAXJsJ4TlYZcLQkCrybfhPUzeUdbuc
         mOm5XFjrhZtPjsj7wPLvcX6E2SFSOGl4irHfVSqRqzAMlVL4vZvM9QlqSuc5+EN5R7bC
         A+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=COMqaCSEqVmnaQc+piXJLFu4vZQ52ByjRSmKVxQG2X8=;
        b=NBBM94faqgd6sI0SQ/2BUz1u5Jv3dq4g1BeQU9XRSN231tzSWlx2T2DFIOZYprmyzd
         JslJwsIL8zCuhbV3iYyNjVE6E3YqQQ4UFJtP6xNnWudfSPCfzjKTl737iIAiysCqwwUp
         +R50U+g4BHhiaSlImx86IOrb0cir6HA3FcAUAXOQICMSqlFk7TQJJWFXqf0sbn/NGdFE
         79ssiZNJiOZULON26b/jF5Dwf/IfLGU6xWbuL1tUh64wID7eF1jfX9mxKWXqn8PB0PyW
         8OGGwHwL/ZtxRsP8yZgL1CrdRicDi+Kd2ghrQPAKVMDa8lVKSIaJkqKLzWSzicUVIDuC
         F44w==
X-Gm-Message-State: AKwxyteoA5sJywW8tmmtUu9+Nl5KE3aNJERSeBzcU+XmkOahqVZ727x0
        If+8GXWU2AdOEkReG+0N3gta0tZaVTbLc6JZhjlpgA==
X-Google-Smtp-Source: AH8x2244iuwbANEZ1UjEtOUKtPHDd4LOxlyK9ob/O21rseVOXmZ70vBDFF+QL2l+hAgERBtF5e8TMV+wQUhuqJz/sUs=
X-Received: by 10.13.220.3 with SMTP id f3mr27908874ywe.288.1517616407986;
 Fri, 02 Feb 2018 16:06:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Fri, 2 Feb 2018 16:06:47 -0800 (PST)
In-Reply-To: <20180130232533.25846-17-newren@gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-17-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Feb 2018 16:06:47 -0800
Message-ID: <CAGZ79kaB-RAP8f4Ea8bDkdVtkmfLSQ4=aA5bYMV_gXOk3qk-zQ@mail.gmail.com>
Subject: Re: [PATCH v7 16/31] merge-recursive: split out code for determining diff_filepairs
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:

> @@ -1354,10 +1345,43 @@ static struct string_list *get_renames(struct merge_options *o,
>         diffcore_std(&opts);
>         if (opts.needed_rename_limit > o->needed_rename_limit)
>                 o->needed_rename_limit = opts.needed_rename_limit;
> -       for (i = 0; i < diff_queued_diff.nr; ++i) {
> +
> +       ret = malloc(sizeof(struct diff_queue_struct));

Please use xmalloc() and while at it, please use "*ret" as the argument
to sizeof. The reason is slightly better maintainability, as then the type
of ret can be changed at the declaration and the sizeof computation is still
correct.

> +       ret->queue = diff_queued_diff.queue;
> +       ret->nr = diff_queued_diff.nr;
> +       /* Ignore diff_queued_diff.alloc; we won't be changing size at all */
> +
> +       opts.output_format = DIFF_FORMAT_NO_OUTPUT;
> +       diff_queued_diff.nr = 0;
> +       diff_queued_diff.queue = NULL;
> +       diff_flush(&opts);

The comment is rather meant for the later lines or the former lines
(where ret is assigned), the empty line seems like it could go before
the comment?
