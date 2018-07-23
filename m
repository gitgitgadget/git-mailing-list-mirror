Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C8C91F597
	for <e@80x24.org>; Mon, 23 Jul 2018 18:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388012AbeGWTae convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 23 Jul 2018 15:30:34 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:40031 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387873AbeGWTae (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 15:30:34 -0400
Received: by mail-yb0-f195.google.com with SMTP id y11-v6so627442ybm.7
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 11:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kNCz6k8to8eKgO+s/2cSnZZMlk+rdJDYEU2jRBFWIAI=;
        b=HbY3Qqo83RYkXa8ieQ4sfxa/6Ag8W3F31HdTvSMLU+s4OS8skWAybbjDdQLaOE3bhs
         aAWkeL8z/WwfSAa+owH/wa8NUK+jnixcoB2C7IEy0g53SHScPTWo6EXp9nG16jzbeLpx
         8rXjsSgxKgkp1JkzSU6jNixBgcpb8k9iglLahaBPRpMr9GLgcdT3Wpybinl4coZH7TIt
         ehcLGPBUfbCCnghSgpajjA1xymIEKSZt16avW9LJI8DwDKYihX0KxfxDcJOxxJFcVs6l
         GeT/4lGPz+8l92wVS2eJ/utHmCABvFe5uVQp4PR9ckdxM4yHmUNrMC5LQYcmB+D64Wyr
         JLZg==
X-Gm-Message-State: AOUpUlHJ1xibYKH+f3nUakPNoM0eSfyZX92g6hLrsWJSseuENtGKSqbw
        s0izYzWrZJATmTFV76U3oXBl6tb/UJ56dRYGjo0=
X-Google-Smtp-Source: AAOMgpf/OSn3zxTaiOO8a+7tnvFr0t1dld7bvloZwShQDrphyiiGja+aa6RmRpqEM44XizNkL6bMwy62q3JOL/GITCU=
X-Received: by 2002:a25:ac44:: with SMTP id r4-v6mr7529432ybd.497.1532370485563;
 Mon, 23 Jul 2018 11:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180723135100.24288-1-szeder.dev@gmail.com> <20180723135100.24288-4-szeder.dev@gmail.com>
In-Reply-To: <20180723135100.24288-4-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Jul 2018 14:27:53 -0400
Message-ID: <CAPig+cSOZd+t17j7FSCYAydS34ZtfcRFZyE6E9fz=u7xB-01Mg@mail.gmail.com>
Subject: Re: [PATCH 3/5] coccinelle: exclude sha1dc source files from static analysis
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 9:51 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> sha1dc is an external library, that we carry in-tree for convenience
> or grab as a submodule, so there is no use in applying our semantic
> patches to its source files.
>
> Therefore, exclude sha1dc's source files from Coccinelle's static
> analysis.
>
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
> diff --git a/Makefile b/Makefile
> @@ -2666,10 +2666,16 @@ check: command-list.h
> +ifdef DC_SHA1_SUBMODULE
> +COCCI_SOURCES = $(filter-out sha1collisiondetection/%,$(C_SOURCES))
> +else
> +COCCI_SOURCES = $(filter-out sha1dc/%,$(C_SOURCES))
> +endif

Can't you just filter out both of these unconditionally without
worrying about DC_SHA1_SUBMODULE?
