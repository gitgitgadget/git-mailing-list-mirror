Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2BA11F597
	for <e@80x24.org>; Sun, 22 Jul 2018 10:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbeGVL2Y (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 07:28:24 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:42107 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbeGVL2X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 07:28:23 -0400
Received: by mail-yw0-f196.google.com with SMTP id y203-v6so5862096ywd.9
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 03:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMA+oB6yQm8QGizBUHJ+s7iKl0k0tREMj0s0Mf0T1s8=;
        b=J04tdHJXL6+VOaAkWCvEiSQtMNgv7kpDI0JcEnmX7/EEbfz9Kr5zgf6wmwSm+OFxm0
         H2mABFeRiuLiitFl3AkAgmGlDFcDt2gZ4utYodrDS66OcJp+VRMS7x0ewRGiibNzl4bu
         0LWjffC8Qzf7fI3HXxJcJrEU6CFIcB0gq7yLuTPHP8eTV7v9xeRrn0LRdaaPQvwORsIA
         AQZPJMBHL3rmV2sdcjEB8u0IE+JoFnbiBJ1jxtgkBWxHcTvZhxNB3przHaUrBTMSmN1z
         q1hScYQMJcShvHD/jaN2SGki+G69wWtvILvFr/EwShNQXWisuQEtEO6VtAW2AXgNoi05
         Xe6Q==
X-Gm-Message-State: AOUpUlH3Gwpnx/cy2bRAn4C+tND69A9CGO6sXmDzaTKvFYScdhvvkqxs
        eFJrdir809TldPD+tFt+fBmxQijzKDSkFRCP3Pbu+Q==
X-Google-Smtp-Source: AAOMgpeYpC/QyOu0UaFFH/W21KRdI+6uKpkgzGKfvi7zJlXVYc0Dh7IDy6fwNz+0z30eSQj1eOs4SeDCMcUxgsWgNKY=
X-Received: by 2002:a81:7bd4:: with SMTP id w203-v6mr4368619ywc.70.1532255529250;
 Sun, 22 Jul 2018 03:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180722095717.17912-1-sunshine@sunshineco.com> <20180722095717.17912-3-sunshine@sunshineco.com>
In-Reply-To: <20180722095717.17912-3-sunshine@sunshineco.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 22 Jul 2018 06:31:56 -0400
Message-ID: <CAPig+cSuYUYSPTuKx08wcmQM-G12_-W2T4BS07fA=6grM1b8Gw@mail.gmail.com>
Subject: Re: [PATCH 02/14] format-patch: add --interdiff option to embed diff
 in cover letter
To:     Git List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 22, 2018 at 5:57 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> Add an --interdiff option to automate this process. The argument to
> --interdiff specifies the tip of the previous attempt against which to
> generate the interdiff.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
> diff --git a/interdiff.c b/interdiff.c
> @@ -0,0 +1,17 @@
> +void show_interdiff(struct rev_info *rev)
> +{
> +       struct diff_options opts;
> +
> +       memcpy(&opts, &rev->diffopt, sizeof(opts));
> +       opts.output_format = DIFF_FORMAT_PATCH;
> +       diff_setup_done(&opts);
> +
> +       diff_tree_oid(rev->idiff_oid1, rev->idiff_oid2, "", &opts);

Passing a 'rev_info' to this function is overkill. It actually only
needs the two OID's and a 'diff_options'. I'll make the change if I
need to reroll for some other reason, otherwise I'll do it as a
follow-up patch.
