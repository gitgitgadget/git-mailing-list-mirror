Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE61C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B62D60F51
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 21:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbhIQVjo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 17:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhIQVjm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 17:39:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA3BC061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 14:38:19 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id q3so35002941edt.5
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 14:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WFqX/K1NvWNg9ns2ntENcvW88u/n4i62H5dO5/w2rAs=;
        b=FDfMtxEtynUzQziPo/gnJAm9sDxfQNkBQsz8EPxG3jxPerGW1YChlO9UKI3wyYDQuU
         Fk+LopvxM/y2MB5WFcyBVCV240AS/uLhh0VQ0IzJdDcgNq+AAvO/Qr5wqKb/I/+1WeHM
         ZHvYmrZgjs5qMKeexyw9hPZNTIiuyjCISqsr/NYB1iuRARqv01S90wkaqFIxtMHfY3P+
         LrikWi3Kht1MjojT8z0d2H5iyo5vYwBvHqIC8wJOpci5TcSUFTte2WOmRqKkxyCUKOKT
         1Qx3OYKWQ2NdukyJ+xWC/JUsdQv80Si5Zp5jshokkZAarJTodoEHRH9tQ8KwK4LSzGQ1
         X0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WFqX/K1NvWNg9ns2ntENcvW88u/n4i62H5dO5/w2rAs=;
        b=ZrHHhyO7slQuG0VFSXasYYLZOKWuP7mjTe9jn1ptePuVio3FnHEkOfCrWG+thEjGcZ
         lyiyosvoTlSgIJ5BDV7lgldWgG2CucV0Dh105o70j09JnkkdtdvPuhTv1+uC/5QBoENl
         2BbohBtYfvGIBVQjgR+H3zQ8VLeLrv4m5YkbUAVRghyCFSNJ9OqQqgz9LlwB54vNikZ5
         75W2loKrZMcs19U1N/zMYCkF7iodqd/gN08TC6/juE/IB9jlOnZe29VOFP1eLzCDJQbd
         5yGqvLrgtqiv53dngLWuLNfeltx7SOg+za9FhgKANW9hm8SV6acbdYEG0yfWZAXlyrfm
         qJGg==
X-Gm-Message-State: AOAM532vqeNHT1XDVods6coMK6Fi9/ssvoEo74cE3a2PGmywRbAL17E6
        h/NG7wS0K2t5LwQbTd3lscQ=
X-Google-Smtp-Source: ABdhPJx2IFWQmYQshrUyCQIFErq45UZSzbjORopg9JFUWpAU0bydjMYP+IC5vJiHtRVpvBUMthjHtg==
X-Received: by 2002:a17:906:3157:: with SMTP id e23mr14850340eje.29.1631914697439;
        Fri, 17 Sep 2021 14:38:17 -0700 (PDT)
Received: from szeder.dev (94-21-37-152.pool.digikabel.hu. [94.21.37.152])
        by smtp.gmail.com with ESMTPSA id d16sm2770529ejk.39.2021.09.17.14.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 14:38:17 -0700 (PDT)
Date:   Fri, 17 Sep 2021 23:38:15 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 11/25] pack-bitmap-write.c: add a missing stop_progress()
Message-ID: <20210917213815.GD2118053@szeder.dev>
References: <YNKWsTsQgB2Ijxu7@nand.local>
 <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
 <patch-11.25-7f5b71fe1be-20210623T155626Z-avarab@gmail.com>
 <20210917051448.GB2118053@szeder.dev>
 <8735q3g2rg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8735q3g2rg.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 17, 2021 at 07:56:48AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Sep 17 2021, SZEDER Gábor wrote:
> 
> > On Wed, Jun 23, 2021 at 07:48:11PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> Fix a bug that's been here since 7cc8f971085 (pack-objects: implement
> >> bitmap writing, 2013-12-21), we did not call stop_progress() if we
> >> reached the early exit in this function. This will matter in a
> >> subsequent commit where we BUG(...) out if this happens, and matters
> >> now e.g. because we don't have a corresponding "region_end" for the
> >> progress trace2 event.
> >> 
> >> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> >> ---
> >>  pack-bitmap-write.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> >> index 88d9e696a54..6e110e41ea4 100644
> >> --- a/pack-bitmap-write.c
> >> +++ b/pack-bitmap-write.c
> >> @@ -550,6 +550,7 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
> >>  	if (indexed_commits_nr < 100) {
> >>  		for (i = 0; i < indexed_commits_nr; ++i)
> >>  			push_bitmapped_commit(indexed_commits[i]);
> >> +		stop_progress(&writer.progress);
> >>  		return;
> >>  	}
> >
> > When I found this bug I fixed it differently: with your patch there
> 
> Is that patch on-list somewhere or something you have locally?

Yes, it is between the scissors lines in the email you responded to :)
It was another fallout from my isatty(2) vs. progress PoC starting at

  https://public-inbox.org/git/20210623215736.8279-1-szeder.dev@gmail.com/

but it was not included there, because I fixed it some days after
sending those patches.

> > are no display() calls at all between start_progress() and this new
> > stop_progress(), indicating that a stop_progress() is not missing but
> > rather the start_progress is in the wrong place:
> 
> *Nod*, I'll see about fixing it differenty depending on the above / any
> other comments.
> 
> Note that while this comment is current to
> https://lore.kernel.org/git/patch-7.8-eb63b4ba6a-20210722T125012Z-avarab@gmail.com/
> as well, as noted in
> https://lore.kernel.org/git/877dffg37n.fsf@evledraar.gmail.com/ you've
> had several comments on the 25 patch series not currently queued in
> "seen".

Oh, right, I commented on the wrong patch series.  Gaah.

> Still very useful as I'd had some of it planned for after that 8-patch
> series, just noting it for context.
