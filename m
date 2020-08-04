Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E663C433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84AF4207FC
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cY5cNygg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgHDWPd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 18:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgHDWPc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 18:15:32 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B19C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 15:15:31 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d2so17574975lfj.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 15:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NCFL3h9lghD8KJee6+C27H5e7RfhGUJ6Hi1N0AnDN+o=;
        b=cY5cNyggZ7eJp9rYfOzKPDlKCZuHDyxyPkMXX1FReE15T869bW1WpgDO94kHm3iajj
         cyDNl1Ov6ZJfzoIc2Liy7j6kEUnlOqESQUzkS21HCgS4iC8Acubu22BC2PgvIb83P704
         45NUdOkJwKI4Z1Rc7PgOkNQ+oCVm5FHoCIi+YPn0yYide34pVvIyyWBDYpIWlK7w0vQQ
         +BnQPYiTr9jqomuoe0qWFCZANrZjpcbgmUqgTLD4tIA9HVXqwdfi7bVYMEvsEsuhw+M1
         Cm9yqspJfIvI517OlbzXsbtp7MJmj3dU37rZeM7FEeKfOtAAqBjLro59pUQCwZWn//e2
         Ueqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=NCFL3h9lghD8KJee6+C27H5e7RfhGUJ6Hi1N0AnDN+o=;
        b=MvNtb97BnxmZyTHe18+A9QYO4l/UjCUNu0gUoKRYNhCiILZ9zxSVQ9xhoeiGFGpFTE
         vu9ASQ/0opU2cadCyXHG4pJfUUtutso3LjwTVMY8H2m0Up8I9i1mPuM0nVgGbUxZX4a8
         aPg5Ouu0485RwVlprAPu2T5BrgFOSYN6sBRsQNDefCgqgPYYOhvgPN0E404Wbr3+ATk5
         XBP3RSydP5nQwEOdO97ZgnQzIx52MYH57+E7HZYL+K/J9uJ2c6qr2BkYUD6bXxzJsiWf
         nBaRyHrAFIQ2scx/WQtJCM0voOcZW8F37ntQwe0pfYLxFEOrJnk7eXrblqIdeZKO44c0
         VBFQ==
X-Gm-Message-State: AOAM531bwigR1Mn4Y9gFwYA8qDJCgQAypbm/QFAIfvM1eOHsjfAaa62I
        mUi/01MVD3altn3ZCebgCtyRaqaY
X-Google-Smtp-Source: ABdhPJyudInuElbJlC9u9J7GFdz/gS+nP0GDUdsZ5UryC588YQonl4r1iGlarJjyOm3D9NuVoRC0xQ==
X-Received: by 2002:a05:6512:556:: with SMTP id h22mr138124lfl.200.1596579329420;
        Tue, 04 Aug 2020 15:15:29 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b81sm132548lfg.60.2020.08.04.15.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 15:15:28 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru>
        <20200804195830.GA2014743@coredump.intra.peff.net>
        <873652166e.fsf@osv.gnss.ru>
        <20200804212518.GB2020725@coredump.intra.peff.net>
        <87y2muxf5m.fsf@osv.gnss.ru>
        <20200804220740.GA2022650@coredump.intra.peff.net>
Date:   Wed, 05 Aug 2020 01:15:27 +0300
In-Reply-To: <20200804220740.GA2022650@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 4 Aug 2020 18:07:40 -0400")
Message-ID: <87y2muvz0g.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Aug 05, 2020 at 12:41:25AM +0300, Sergey Organov wrote:
>
>> >> It's 4 lines above, as it's in fact common for all the cases but the
>> >> first one.
>> >
>> > Ah, I missed that. That raises more questions, though. ;)
>> >
>> > For "-m" we do not need to set revs->diff; why do we need to do so
>> > here?
>> 
>> Good question!
>> 
>> I believe --diff-merges=all should reset revs->diff back to 0 to
>> entirely undo all the effects of '-c' and '--cc', provided those
>> appeared before on the command-line, that '-m' fails to do.
>
> Making it counteract "--cc" makes sense, but revs->diff is used for much
> more than that. So "--cc" sets revs->diff to 1, but so do many other
> unrelated options (e.g., "--full-diff" for one).
>
> I think to do it right you'd need to have this part of the code just set
> a single enum variable, like:
>
>   ...
>   else if (!strcmp(arg, "--cc")) {
>           revs->diff_merges = DIFF_MERGES_DENSE_COMBINED;
>   } else if (!strcmp(arg, "-m")) {
>           revs->diff_merges = DIFF_MERGES_ALL_PARENTS;
>   }
>   ...etc...
>
> and then later resolve that into the set of flags we need:
>
>   switch (revs->diff_merges) {
>   case DIFF_MERGES_DENSE_COMBINED:
> 	revs->diff = 1;
> 	revs->dense_combined_merges = 1;
> 	revs->combine_merges = 1;
> 	revs->ignore_merges = 0;
> 	break;
>   case DIFF_MERGES_ALL_PARENTS:
> 	revs->ignore_merges = 0;
> 	break;
>   ...etc...
>   }
>
> it may even be that we can get rid of the separate combine_merges and
> dense_combined_merges flag and just have callers look at
> rev.diff_merges, which would simplify the code even further. But that
> cleanup could also come later on top.

Sounds like a plan! I like it.

Thanks,
-- Sergey
