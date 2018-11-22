Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A63A1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 18:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392191AbeKWFkO convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 23 Nov 2018 00:40:14 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34906 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392171AbeKWFkO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 00:40:14 -0500
Received: by mail-qt1-f196.google.com with SMTP id v11so8364419qtc.2
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 10:59:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E97aeKrr9CbKWP2APmXVNngnF089XgXGC+5TKftcPpE=;
        b=dvNqIC/aMLZAHSb2lsN6ygxC7g+FJnJ3rZ4B7eiS6G3roxCR4Nt1vbZ4pFsvJAimXf
         tPMVdJNMAejRaHstXNnDspOJFeS8CLSgGeRGDHoshk6Ox42BnrcXqTvWB5g+5ndNvQc5
         HdYt3JuymqRNElaPjbZzTJlfG2cKy5aj954j2BQE5wxDpNtqYoK0Zg9OsR30A3m1ysDp
         a3P8kbjU42JquG1Aob0YOQ1zujZL+mlzc2Q2yzjmkvw6ddTc1ZGPph8wEn0B6CBFpQio
         8kJ8EXHV/y7BdVWqzariTI6EFGhP+pGOfcjP9Vg5IRLV+K94EgxXfAHyaOsS7oMvszBL
         cyXA==
X-Gm-Message-State: AGRZ1gIo/Vphmixl29eq53wN9IxhogkBL22wB4ABlLFRO5OJZ3Y7qC8p
        6Ss1KvuwmcSM4XG7XxpZ9ZqdD8R61alJMclgHag=
X-Google-Smtp-Source: AJdET5dEHWqL+hxBo+VyWsj3fcHNvXcV72ETiO7BWe50iKRVj2bkK26FU1xytfnAjPoeJIdkkP9SPeWX6erZt/daIR8=
X-Received: by 2002:ac8:2a81:: with SMTP id b1mr11392393qta.110.1542913173728;
 Thu, 22 Nov 2018 10:59:33 -0800 (PST)
MIME-Version: 1.0
References: <20181121012600.26951-1-szeder.dev@gmail.com> <20181122132823.9883-1-avarab@gmail.com>
In-Reply-To: <20181122132823.9883-1-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 22 Nov 2018 13:59:22 -0500
Message-ID: <CAPig+cRCrbnoQoX72bmRcuYVP9b8W0gfrg0tL4kmuKfsYGa3bA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] commit-graph write: progress output improvements
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 22, 2018 at 8:28 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Range-diff:
> By the way, is there any way to....
> Pass the equivalent of "git range-diff origin/master topic-2 topic-3"
> to git-format-patch?

git-range-diff documentations says that the three-argument form:

    git range-diff <base> <rev1> <rev2>

is equivalent to passing two ranges:

    git range-diff <base>..<rev1> <base>..<rev2>

git-format-patch synopsis shows:

    git format-patch --range-diff=<previous> <rev-range>

where <rev-range> is the range of commits to format, and <previous>
can be a range specifying the previous version, so:

    git format-patch --range-diff=<base>..<rev1> <base>..<rev2>

should do what you ask.

However, since the two versions in your example both derive from
origin/master, you should be able to get by with the simpler:

    git format-patch --range-diff=<rev1> <base>..<rev2>

which, if you were running git-range-diff manually, would be the equivalent of:

    git range-diff <rev1>...<rev2>

for which the range-diff machinery figures out the common base
(origin/master) automatically.
