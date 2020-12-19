Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFB3C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 12:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8466623AC2
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 12:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgLSMAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 07:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgLSMAm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 07:00:42 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556FFC0617B0
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 04:00:02 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id y19so12227037lfa.13
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 04:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JbWmjtDEvxaDs9434DcUrFoh8H1PpM9nkyEQIV3FvVU=;
        b=ODSCM3LbmTL+hGzICi5/qRD+8ZUVu439yifQzXFznYfGlC/svQQAaEvocX/kmcejuZ
         Xn4pL4DIgIc4JGgtMNU/vNz0IjKnxNroOtL4o1wGB4L3zPIOjpiYpdpx3O5rhjDopVZJ
         Kkca3+H4f6Rdd55xrTCbUwSDWJJ63v9v9vuu8dn6d5mASskyTbuKJ44UZfSNf/abKm3H
         BGASWxgZ7jCWwf2cS+3qdIy9h6TBnANRrasJFhWgWKPkmXUnH9BNHGYmIKX+2Z/7LVic
         S7aVCsJDDIFkn2NuWMDwydRM6wIJoE8+3AvMWWTJmsXrriHKgaI89wFDTTfR17x+Y50k
         avLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=JbWmjtDEvxaDs9434DcUrFoh8H1PpM9nkyEQIV3FvVU=;
        b=VoUIudhtZ68tzO2yH4Y1eIA53BI5GYlyaf/TsjAs7Cl2uFTvXTsNdgs5yxyvPlLgdZ
         sO78ywaRv9WahjKj1lEgmL9qWgVzsd3jcPbDodSr8Gnm1zzToJ07amIRtuN5ODODJZo0
         EsyEqf3XQCK6QcGJRgCTKmaA3aQY8buzexFqQyqanh9FDSAfYTMjI7YF1wms/K8tsYbd
         uTxPyQTmAg429EiDg7P0hUiUWMYOwvs0pZl+o+tERXkFj/SSIL7ey6MM79kaqOP2GLoI
         Fnov4QrGy97ltyCPT2YXak3XD+KcWoS7NlgE+dSQaf/OeouOaqHpu9Q5yOOv0ot/PWwl
         T8xg==
X-Gm-Message-State: AOAM5314yY1rM1kln5AQvWsv4pFgiEkOOjur1xsfp4uq4JrqUN9NAwBd
        Rm/+40/kyyjaLNanhrKzhZuqiNdoUZo=
X-Google-Smtp-Source: ABdhPJxOTSOWbTHQxnbTh7IgdpuplogWWd6QowLNLZ/1s7h9E0ewPXhfZF1xQ4a1ERYKycneM4W60A==
X-Received: by 2002:a2e:7a12:: with SMTP id v18mr3763734ljc.72.1608379199255;
        Sat, 19 Dec 2020 03:59:59 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w16sm1275389lfn.227.2020.12.19.03.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 03:59:58 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 23/33] diff-merges: fix style of functions definitions
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <20201216184929.3924-24-sorganov@gmail.com>
        <CABPp-BEf2nbahjzR6aLLNy0YsHYcHqCozCe6veoZOH3LAM892g@mail.gmail.com>
        <87blercju2.fsf@osv.gnss.ru>
        <CABPp-BGPZiwjSzZw5PLwkctW7hnG2S6UGHmkTGCh1BqgXJ+vEQ@mail.gmail.com>
        <871rfm95b9.fsf@osv.gnss.ru>
        <CABPp-BEZ6VqyTah7QCzkuUm-p7tA_6cnpGPWpgpQbHp_c3Wc5Q@mail.gmail.com>
Date:   Sat, 19 Dec 2020 14:59:57 +0300
In-Reply-To: <CABPp-BEZ6VqyTah7QCzkuUm-p7tA_6cnpGPWpgpQbHp_c3Wc5Q@mail.gmail.com>
        (Elijah Newren's message of "Fri, 18 Dec 2020 14:56:04 -0800")
Message-ID: <87sg82m2f6.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[...]

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Elijah Newren wrote:
>> Personally, I think that a really important point to keep in mind when
>> submitting patch series is trying to figure out the easiest way to
>> move the code from point A to point B, not the route you took to get
>> from point A to point B.  This is especially true for longer patch
>> series.  It's common after you've finished a series to discover there
>> was an easier or cleaner route to follow that would have arrived at
>> the same end-point.  It's not uncommon for me to spend a significant
>> chunk of time rebasing and restructuring a patch series to try to
>> highlight such a better path.  This includes not just style fixups,
>> but different patch orderings, alternate ways to break up functions,
>> using different data structures, etc.
>
> Me as well.
>
> It's extra work for one person, but everyone else benefits, including
> that one person in the future (who usually forgets why he/she did things
> in that particular way).
>
> Cheers.

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> When Junio noticed and pointed to this deficiency, I asked him if I
>> should fix all the series from the start, or it'd be OK to use fixup
>> commit. As he didn't answer and nobody else commented either, I opted
>> for the latter.
>
> Sorry if it slipped through the cracks---I get too many discussion
> threads to pay attention to.
>
> Yes, we strongly prefer *not* to keep the honest history that
> records all the mistakes we made along the way.  Rather, we take the
> time a topic is still in flight and not yet cast in stone by merged
> to 'next' as an opportunity to pretend that the topic came to
> existence in the perfect shape, thanks to collective brain effort.
>
> It is our basic courtesy to future developers who has to read our
> code (i.e. "log -p") to understand what we've been thinking, when
> they want to fix some stupid bugs we will inevitably leave in our
> codebase.  It is distracting to read from the beginning of a topic,
> notice something funny going on and keep moveing to later patches,
> while harboring puzzlement in our minds, then later discover that
> the funny thing we noticed earlier was a simple mistake that gets
> fixed, not some clever trick the reader needs to think deeply to
> understand.

OK, so I'll do it.

I'd like to have some agreement on the final shape of the topic though
before I cleanup the series, if possible.

Thanks,
-- Sergey
