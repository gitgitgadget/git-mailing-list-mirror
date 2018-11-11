Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A08E81F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 08:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeKKSb7 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 11 Nov 2018 13:31:59 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40404 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbeKKSb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 13:31:59 -0500
Received: by mail-qk1-f195.google.com with SMTP id y16so8707523qki.7
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 00:44:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ELYFlPC5dPomUZzwH1SECc5u5FmNirL3TcSTxsLngPo=;
        b=P432dDIl5KdaMgKVUwYtquLxRwn9F6eW+C1F7W0rQ85conwYWtMs9qnN87l7AzyHMi
         SQYS9HtcoOKewtF7nvMyBnAhqmX9fvPniM9Ffnlw41clgmS+rrAhsqH5Dm9AbtzUOMkA
         zxSuHFnxhf2s6lXrvak/IB3wNdbHTYYs5tEzPAxwqWDpAXLEsTynrrZFjtx7AwbTT01k
         X4P5UldQceSeCi5QnGmQkTtMWpeKZNyOEOsHyv8Ybj2TNen/Xl+syydMoEnGbBH+n0lS
         bu0jAqgld0CVZTKP3wAkY8BOVJCQQYroX3eh5p0PgXb7mYQCOh1r62eQdNMtxoi3RG+C
         LuQA==
X-Gm-Message-State: AGRZ1gIzuTnxn7igGTHxkcPEpByUcekugHTuuO0f1/1JEdye9Xqxw8LF
        4wci9iNGzNYpMsPP3MPekZe4qhG9ws8gvtlfbiE=
X-Google-Smtp-Source: AJdET5cQf4Q3tD26wl2el12YN88rlKxhqx4VjJ/NOWnl+yDk1RQFDKLNgoIyfNmrnXhAh3JVHuIZUy68jMQJsjFbkko=
X-Received: by 2002:ac8:90c:: with SMTP id t12mr4030276qth.335.1541925842276;
 Sun, 11 Nov 2018 00:44:02 -0800 (PST)
MIME-Version: 1.0
References: <20181107122202.1813-3-avarab@gmail.com> <20181109101803.3038-4-avarab@gmail.com>
In-Reply-To: <20181109101803.3038-4-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 11 Nov 2018 03:43:50 -0500
Message-ID: <CAPig+cTWgmApseaz4cZqUU4U1NJrcu3vq0FzVwHO6icT7nWcPw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] range-diff: make diff option behavior (e.g.
 --stat) consistent
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        "Stephen & Linda Smith" <ischis2@cox.net>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 9, 2018 at 5:18 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Make the behavior when diff options (e.g. "--stat") are passed
> consistent with how "diff" behaves.
> [...]
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/range-diff.c b/range-diff.c
> @@ -453,7 +453,8 @@ int show_range_diff(const char *range1, const char *range2,
> -               opts.output_format |= DIFF_FORMAT_PATCH;
> +               if (!opts.output_format)
> +                       opts.output_format |= DIFF_FORMAT_PATCH;

I think this can just be '=' now instead of '|=' (to avoid confusing
the reader, even if it's functionally equivalent).
