Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D69C00140
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 11:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbiHXLjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 07:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiHXLjH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 07:39:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866D88284F
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 04:39:04 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u5so12609965wrt.11
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 04:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=8lGowmkFo8sN+1Cku0eRSBYCdl9+wIMtwb1wJzjdFig=;
        b=gYhvrk5KBTLB/S4tLtn04RP7twcVWXqZ5W6PMaiCMIHrFXsXY8stEx34yOUPdh+kXQ
         vjdxe1mAhTg2F1yuMASroh2wBdOIEPS5S7iwjk4Qc81VOi/P4AnWOnSfW/1KtthSooWJ
         0GFIBjvyt/PFwBYqCdl8snTzcuu5Qp9aTAuhgAGUNU+XLMSqSM6R+LaxneRx53qxh2TF
         FckjGz1lCXEHwBNtl7DWjukvEYSMTwrz4+YVczoROvOSOqUjJ3voP/ZTBljtOEEhUBVq
         0PLTrDH9zBHloo7OLApTAMKz0hIaYtbjBmgWJM9hZ3GXAKmrslxwsSPEpwffmTOJumco
         akfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=8lGowmkFo8sN+1Cku0eRSBYCdl9+wIMtwb1wJzjdFig=;
        b=qZjA3aDHFGRx+Uq9zquhbQqBzfAjGpfUf7abd94awu40QAiQDyxz1YSudDf3dm+jsF
         VHaZ9IU49FTGarkR/nx5v9tRPvLk1e3twc/n6EE2qtuQumTYPAlVYGGaV1awXXhXRVm6
         ng8nQG1AxjDekRTlS9wusihpw4x2QQESaqxzOVwzuGrKVwxu1Lf7NnDxRt1SL/Vy03qk
         v0sevrjurWhsD3nVBX6+PUSqKRSbZESrFD14RFPgueyhCyO54KcqMpxvUlikiILBYNpx
         pgxaAuYJ+TM2cK1/drLL2N+c8P691UIUv/C+tknKjzDDgyEHYMHJU2q25NtWD0CRFhGV
         qtOg==
X-Gm-Message-State: ACgBeo2yxwvg8pJiPzVGIb2NAiKkhSY6345/b/vq5DxbSVNOQ2ZYDndj
        W5C7rARbiJuJdlA8AYk+hVE=
X-Google-Smtp-Source: AA6agR4JAMT9egx9QAXtyrC1gmbRAr10oGIP1dEOJvmAIXoqWh73H3xBpKsO3ynfOA0pRkrfDi0NTw==
X-Received: by 2002:a05:6000:1106:b0:225:6f9e:4d10 with SMTP id z6-20020a056000110600b002256f9e4d10mr1903887wrw.4.1661341143035;
        Wed, 24 Aug 2022 04:39:03 -0700 (PDT)
Received: from localhost (78-131-17-114.pool.digikabel.hu. [78.131.17.114])
        by smtp.gmail.com with ESMTPSA id bd7-20020a05600c1f0700b003a601707174sm1718507wmb.33.2022.08.24.04.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 04:39:02 -0700 (PDT)
Date:   Wed, 24 Aug 2022 13:39:01 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] promisor-remote: fix xcalloc() argument order
Message-ID: <20220824113901.GD1735@szeder.dev>
References: <20220822213408.662482-1-szeder.dev@gmail.com>
 <20220823095733.58685-1-szeder.dev@gmail.com>
 <YwXiKXONiTt+fIdi@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YwXiKXONiTt+fIdi@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2022 at 04:32:41AM -0400, Jeff King wrote:
> On Tue, Aug 23, 2022 at 11:57:33AM +0200, SZEDER Gábor wrote:
> 
> > Pass the number of elements first and their size second, as expected
> > by xcalloc().
> > 
> > Patch generated with:
> > 
> >   make SPATCH_FLAGS=--recursive-includes contrib/coccinelle/xcalloc.cocci.patch
> 
> Thanks for digging here. I think it probably explains a lot of "wait,
> why did this result change" head-scratching I did back when we started
> batching a few years ago.
> 
> Is there any reason we wouldn't want --recursive-includes to be added to
> the default SPATCH_FLAGS?

I ran some runtime measurements yesterday, and there is a considerable
runtime increase in the unbatched case:

    The tables below show the runtimes of applying each of our semantic
    patches separately with Coccinelle v1.1.1, with the '--all-includes'
    or '--recursive-includes' flags and with batch sizes 1 (no batching)
    or 32, i.e.:
    
      time make SPATCH_FLAGS=$flag SPATCH_BATCH_SIZE=$size $cocci.patch
    
    SPATCH_BATCH_SIZE=1:
    
       semantic patch  |    all    | recursive |
      -----------------+-----------+-----------+--------
       array           |   69.90s  |  140.12s  |  +100%
       commit          |   94.44s  |  223.63s  |  +137%
       equals-null     |   86.93s  |  205.40s  |  +136%
       flex_alloc      |   11.32s  |   16.45s  |   +45%
       free            |   70.47s  |  159.75s  |  +127%
       hashmap         |   83.48s  |  199.70s  |  +139%
       object_id       |  107.83s  |  241.69s  |  +124%
       preincr         |   79.33s  |  202.98s  |  +156%
       qsort           |   16.20s  |   33.86s  |  +109%
       strbuf          |   60.54s  |  129.93s  |  +115%
       swap            |   81.70s  |  200.75s  |  +146%
       unused          |  499.19s  |  626.35s  |   +25%
       xcalloc         |   26.71s  |   57.63s  |  +116%
       xopen           |   30.92s  |   59.26s  |   +92%
       xstrdup_or_null |    5.05s  |    6.94s  |   +37%
      -----------------+-----------+-----------+--------
       all             |    1324s  |    2504s  |   +89%
    
    SPATCH_BATCH_SIZE=32:
    
       semantic patch  |    all    | recursive |
      -----------------+-----------+-----------+--------
       array           |   43.81s  |   52.83s  |   +21%
       commit          |   50.16s  |   52.76s  |    +5%
       equals-null     |   47.77s  |   50.86s  |    +6%
       flex_alloc      |   41.00s  |   43.64s  |    +6%
       free            |   43.12s  |   46.68s  |    +8%
       hashmap         |   42.76s  |   46.12s  |    +8%
       object_id       |   56.17s  |   60.00s  |    +7%
       preincr         |   39.82s  |   42.57s  |    +7%
       qsort           |   39.48s  |   53.09s  |   +34%
       strbuf          |   51.27s  |   49.38s  |    -4%
       swap            |   41.93s  |   58.17s  |   +39%
       unused          |  440.86s  |  445.47s  |    +1%
       xcalloc         |   39.90s  |   42.22s  |    +6%
       xopen           |   40.26s  |   43.19s  |    +7%
       xstrdup_or_null |   39.14s  |   41.72s  |    +7%
      -----------------+-----------+-----------+--------
       all             |    1057s  |    1129s  |    +7%
    
    I don't have meaningful numbers about the impact of
    '--recursive-includes' on the runtime of a parallel 'make -j<N>
    coccicheck', because they're severely skewed by 'unused.cocci' and
    'make's scheduler: applying 'unused.cocci' takes 5-10x as long as
    other semantic patches (accounting for about 38-42% of the total
    sequential runtime), and 'make' on my system usually schedules it near
    the end, meaning that for a significant part there is no parallel
    processing at all.

So I'm not sure about making '--recursive-includes' the default, at
least as long as we don't batch by default.  However, we could still
use this flag in CI...

> I suspect we'd still want to leave --all-includes there to get as much
> type information as possible. If I understand correctly, the two are
> orthogonal (one is "follow includes of includes" and the other is
> "follow system includes in angle brackets").

'spatch --help' tells me:

  --recursive-includes    causes all available include files, both
                          those included in the C file(s) and those
                          included in header files, to be used
  --all-includes          causes all available include files included
                          in the C file(s) to be used

So I think the difference is not about system includes, but rather
about "consider includes of includes" vs. "consider only direct
includes in the C files", so it seems '--recursive-includes' is a
superset of '--all-includes'.  Oh, and let's not forget the rather
surprising behavior that if spatch processes multiple C files at once,
then for each of the C files it considers all includes from all C
files; this explains why '--all-includes promisor-remote.c config.c'
works, because 'config.c' does include 'repository.h', supplying the
necessary type information to catch the previously missed
transformation in 'promisor-remote.c'.


These descriptions don't make it clear (to me) whether the two options
are orthogonal, exclusive, or something else.  However, trying out various
combinations indicates that "last one wins", e.g.:

$ spatch --recursive-includes --all-includes --sp-file contrib/coccinelle/xcalloc.cocci --patch . promisor-remote.c
warning: Can't find macro file: /usr/local/bin/lib/coccinelle/standard.h
warning: Can't find default iso file: /usr/local/bin/lib/coccinelle/standard.iso
HANDLING: promisor-remote.c
$ spatch --all-includes --recursive-includes --sp-file contrib/coccinelle/xcalloc.cocci --patch . promisor-remote.c
warning: Can't find macro file: /usr/local/bin/lib/coccinelle/standard.h
warning: Can't find default iso file: /usr/local/bin/lib/coccinelle/standard.iso
HANDLING: promisor-remote.c
diff = 
diff -u -p a/promisor-remote.c b/promisor-remote.c
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -146,7 +146,7 @@ static void promisor_remote_init(struct
 	if (r->promisor_remote_config)
 		return;
 	config = r->promisor_remote_config =
-		xcalloc(sizeof(*r->promisor_remote_config), 1);
+		xcalloc(1, sizeof(*r->promisor_remote_config));
 	config->promisors_tail = &config->promisors;
 
 	repo_config(r, promisor_remote_config, config);

