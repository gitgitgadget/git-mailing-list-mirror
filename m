Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10480C433E0
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 23:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85C12224D
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 23:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="trsMr0Sx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgHGXHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 19:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgHGXHT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Aug 2020 19:07:19 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558AEC061756
        for <git@vger.kernel.org>; Fri,  7 Aug 2020 16:07:19 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h19so3798753ljg.13
        for <git@vger.kernel.org>; Fri, 07 Aug 2020 16:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=72Gx7BrkZRM53cgur8zXVx2AhSluM9AqVCpJ2ppm9UM=;
        b=trsMr0SxDASTdinD+cF7KPys9jhqJYhc+dHhyAHJFXQyoJ57oKPQM5nLFfYovoY2mC
         st8I5Bwq1MO59jc7v1FFHMBIcwMBfbUPCaMfCPGHFS3j6Yuq+yYylHzkPgV7BogeZbEE
         kNAtuxQY2JReQUgOmkyfQLToA4BgdrTChAzPc9GgV8MpZ4qwzqlBCMvdlu4WkyAOXJdw
         4CqluB5y0cMdbKop5raw6xjxT0muCdSPshzCbIsBEJH4X+IYqXtPZDzwrDZmy1Av5jmS
         ZGU91lAcMtbZ5DRSzEhfzbaI9qt/yTu9NltfN7AcnGzUDUEp3PVTodkw0U6OcH+8J+zA
         U44Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=72Gx7BrkZRM53cgur8zXVx2AhSluM9AqVCpJ2ppm9UM=;
        b=A1qrdP3me/9rl7hZD9miEo3mn0aExSG1AGEpuwGHwVJnHrQ2AWIScUZJZSnXIl+kCC
         CBlmEnqH7i7GhBvJIQZMahtUvvjlfcwMimLxBPfoB3hC8ELJRpMe+E1UNTmHHcoXl2yV
         xmmVwHzTJb3SDU0jJpSJ+rNS7F42oesIM93FljNbaN6RojAQib/7VDwcgdqpo6LrDOS6
         K5YiZVq9W4/uZhD9bBS/QNxTIZfqJPsJeR2zRFPR+fXVgkJ0rGPU5ZElAKsHjdDAJk7W
         ykcUcN4+i76epEYmPp08BfGuiueJTHq3nxLQYL6G57ZvsQicy2st4BBJRq2HXNFJ3zla
         DnpQ==
X-Gm-Message-State: AOAM5313ERwYa35gCR4EqdHNW3eob9uGoDL9ndaeujx4zUN0htufmOGp
        +jrWVMYMQanEJRtktVVZVT8=
X-Google-Smtp-Source: ABdhPJxIaPqS49j7ScV2ToC8iEnbWwrHosTyfT0xKDd/S7PZPLi3uJmG6TfVaTqB1klm3tm01rlldw==
X-Received: by 2002:a2e:330e:: with SMTP id d14mr7125699ljc.407.1596841637819;
        Fri, 07 Aug 2020 16:07:17 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s21sm4284914ljs.8.2020.08.07.16.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 16:07:13 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru> <xmqqbljqrydm.fsf@gitster.c.googlers.com>
        <20200804200018.GB2014743@coredump.intra.peff.net>
        <877due1688.fsf@osv.gnss.ru>
        <20200804212201.GA2020725@coredump.intra.peff.net>
        <xmqq3652rs84.fsf@gitster.c.googlers.com> <878seuxdz8.fsf@osv.gnss.ru>
        <20200804221440.GC2022650@coredump.intra.peff.net>
        <xmqqpn86qb6a.fsf@gitster.c.googlers.com>
        <20200807082643.GA34012@coredump.intra.peff.net>
        <xmqqlfiqgxn7.fsf@gitster.c.googlers.com> <87364ymji7.fsf@osv.gnss.ru>
        <xmqqh7tegu0m.fsf@gitster.c.googlers.com> <87tuxel17m.fsf@osv.gnss.ru>
        <xmqq8seqgrx3.fsf@gitster.c.googlers.com> <87a6z6kxmm.fsf@osv.gnss.ru>
        <xmqqv9hufaxc.fsf@gitster.c.googlers.com> <87y2mqjh9f.fsf@osv.gnss.ru>
        <xmqqft8yf7gj.fsf@gitster.c.googlers.com>
Date:   Sat, 08 Aug 2020 02:07:12 +0300
In-Reply-To: <xmqqft8yf7gj.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 07 Aug 2020 14:54:04 -0700")
Message-ID: <87imdujbrz.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> The only question regarding it I then have for now is what are
>> preferences for names selection inside single option? Abbreviated yet
>> somewhat sensible, or verbose? I mean:
>>
>> --diff-merges=first vs --diff-merges=first-parent
>>
>> --diff-merges=comb vs --diff-merges=combined
>>
>> etc. What's better?
>
> If we were to shoot for easy-to-type, we could go for ultra-short
> abbreviations like 'no', 'c', 'cc', 'each' (the last one is the
> traditional "-m" when used without "--first-parent"; diff with each
> parent) and later add 'fp', but in a sense we are already lost the
> easy-to-type goal by "--diff-merges" being sufficiently long.

Do I get it right that there are no common guidelines and every case is
to be considered separately?

Anyway:

$ git log -d
fatal: unrecognized argument: -d
$ git show -d
fatal: unrecognized argument: -d

so it seems we still have -d to (ab)use for, say "-d 1" or "-d m", if we
decide to.

>
> I personally wouldn't choose "first" or "first-parent", but just use
> "1", so that we could support "2" when viewing a merge that was done
> in the wrong direction with "git show", though.

I fail to see how using "first-parent" would deny using a number either
later or right now, though based on your own rating of octopus merges
with which I whole-heartedly agree, the only thing we'd ever need seems
to be "second-parent", or 2.

> IOW, even though I said that "use these parents but not those" (i.e.
> set of parents) smells overkill, at least to me, I think specifying a
> single parent that is not necessarily the first one would be a
> reasonable thing to do.

The second parent, I'd agree. Others? Well, that's more a completeness
theoretical issue to me rather than practical one. More relevant to
plumbing than to porcelain thereof. And, as additional safety, we still
have that "all|every|each|split" -m that will show needed diff among
others.

>
> So, if I were to vote, it would be
>
>     "--diff-merges=" ( first-parent        | 1 |
> 		         combined            | c |
>                        dense-combined      | cc |
>                        each-parent         | m )
>     "--no-diff-merges"
>
> leaving some room to add '2' and  <any posInt> later.

Thanks for voting!

I believe we still have the room for digits even if we use first-parent,
and then won't

 "--first-parent implies --diff-merges=first-parent"

sound really cool?

Overall, I incline to support short (traditional and numbered) variants
along with new longer spellings at the same time, similar to short and
long options.

Thanks,
-- Sergey
