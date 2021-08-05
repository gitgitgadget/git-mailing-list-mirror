Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B60C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 19:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC60361078
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 19:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242594AbhHETMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 15:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242493AbhHETM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 15:12:27 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9827C06179C
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 12:12:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id qk33so11242550ejc.12
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 12:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=OLmUcWTIRMMcL+EMgv0IJDDTnIhKRYxjUkTIaMRZ/wU=;
        b=Ex/LnoCQGo9oNfAh/8wWnuKbq34v6FNtDVnkGUmGePGgINRIGfudv0pEuJQrnHqxS3
         QL1iEJZ5bMLVtHcnqUdq3/6ARESQ5Ny6I5jckbXnnsT8romaHqd7I2QGhLeghNKX2MGq
         U38mIFRKHbq19lav2G7QouqbIwVE/SyZ/n/zzqsyDNBez6ZX4Q/0u0GG/ldGPIOhqRlR
         /2bYGIFCQxmVxDBGMFsF+UsA/qBnnGB8OHzdXQhv8wKlULD0a157fJpc+npDX0pXG6rV
         nBiTgcIuL6rQHFpfklR9LTv55j21/qWPnjd1+gzNEN2U5ECa7bTJYTGygK7RLf80OPvI
         ifzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=OLmUcWTIRMMcL+EMgv0IJDDTnIhKRYxjUkTIaMRZ/wU=;
        b=CswJwNu2a/yFKEsDSWHtc7qGfaE1gl39ohbqJu3YINaBp1fe6QUpwXgYIlSFW6XZNH
         s5hS+QHiM6pIUfZFxlj+scxSUa6O+UF8CFGwKrY5F6QaLmEF3P3Z7YUxG8FHk2nHhmVh
         SvLTdPgKUz4WFVHAQaVC0SFlP9xNfpw5mIJUBa8xuK0v6g8FSN8nkS8KTaSSSdxPtBG2
         /zlhRswpr+T6Pjc1TDJ0X8tB6cS4F/h535UY+3XqAc/LzBydlJ4UR40ZXWzs2nl3WGLQ
         TmNHTT3V3ZNEnB0ToVKwDBsAFZhY5MUv30Ovf71di5FXLXWD3gFAdT4ZForReBAgNc72
         01bg==
X-Gm-Message-State: AOAM532hwc7T0I4ukcUETT0+u/9WW3H32168m5HB0lMqkiMd3Kr3g1j0
        VVmyLIhuyQQRB/xPOYkJ0h0=
X-Google-Smtp-Source: ABdhPJzBAq3l26OSV1RexPTkVYKnVcpbx9ojCytBNSBoDQlEnwb+om6JXH5anvkTTLYBiL5FYknJow==
X-Received: by 2002:a17:906:f112:: with SMTP id gv18mr6344425ejb.439.1628190730085;
        Thu, 05 Aug 2021 12:12:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x42sm2740191edy.86.2021.08.05.12.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 12:12:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 2/3] midx: don't provide a total for QSORT() progress
Date:   Thu, 05 Aug 2021 21:07:36 +0200
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <cover-0.3-0000000000-20210722T121801Z-avarab@gmail.com>
 <patch-2.3-3411fe0515-20210722T121801Z-avarab@gmail.com>
 <5cf55741-d06a-f8f3-5027-02c5e1dfa672@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <5cf55741-d06a-f8f3-5027-02c5e1dfa672@gmail.com>
Message-ID: <87v94jzoxj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 05 2021, Phillip Wood wrote:

> On 22/07/2021 13:20, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> The quicksort algorithm can be anywhere between O(n) and O(n^2), so
>> providing a "num objects" as a total means that in some cases we're
>> going to go past 100%.
>
> Being pedantic QSORT() is not necessarily a quicksort, for example
> compact/qsort_s.c implements a merge sort.
>
> I'm confused as to how we go past 100% when we only call
> display_progress(progress, 0) and then stop_progress(). If my reading
> of progress.c is correct then this change means we'll stop displaying
> a percentage as progress->total will be zero in
>
> static void display(struct progress *progress, uint64_t n, const char *do=
ne)
> {
> 	/* ... */
> 	if (progress->total) {
> 		unsigned percent =3D n * 100 / progress->total;
> 		if (percent !=3D progress->last_percent || progress_update) {
> 			progress->last_percent =3D percent;
>
> 			strbuf_reset(counters_sb);
> 			strbuf_addf(counters_sb,
> 				    "%3u%% (%"PRIuMAX"/%"PRIuMAX")%s", percent,
> 				    (uintmax_t)n, (uintmax_t)progress->total,
> 				    tp);
> 			show_update =3D 1;
> 		}
> 	} else if (progress_update) {
> 		strbuf_reset(counters_sb);
> 		strbuf_addf(counters_sb, "%"PRIuMAX"%s", (uintmax_t)n, tp);
> 		show_update =3D 1;
> 	}
> 	/* ... */
> }

Hrm, now I'm also confused. Yes you're right. This whole patch doesn't
make sense.

I.e. it's perfectly fine to provide a target of <num> for QSORT and then
use display_progress() just to bump the progress bar's display like
this, and we have other code in commit-graph.c that does the same.

I think I might have (badly) extracted this patch from some WIP work
where I was giving qsort() calls progress of some sort, or maybe I was
just being stupid...

(I have a few local experiments in progress bar output, one of those is
that you can give the API a <num> target, and not be sure if it'll be
O(n), O(log(n)), O(n^2) etc, and we'll show progress output
appropriately, i.e. "still working, at X items of work for N, so north
of O(N)...".)
