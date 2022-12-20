Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B922C4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 01:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiLTBIF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 20:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiLTBID (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 20:08:03 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF275FF6
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 17:08:00 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso14964008pjt.0
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 17:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bT7ZRTqtZ+lSBlGPyVXD3QF4IvRo8DEjUhXVlXZpmFg=;
        b=Glnd/dEXUspudsI+HN6dzLix0A/TqofBIZ9lR1wgTOjsLYYdvIaSFzI8Qfha88ZFZS
         gFEVYxszQwM04LomUpywACdgeqHRMuO9TqBggP6dr8sxQ5Gou+auk/59Y27VzRZ67/oI
         as+S8t58RcK7fPzEVd1JW9Jme1Eva321uNCl5LLaOPUV+hdomNSWSr2Zsx09bQ/rRR9k
         W3qaBRTiIrUlDZYXNypjcb+Nwvatmgclw1Kg2BHP7OsXO85ksbONMVLBge9WId8pvE6j
         318uvr1uEm/LbD9b0tctBy2KhuyXbw8KoIddcoirBOskOI+QtkM6v1QYu+oCydV/uIjf
         kJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bT7ZRTqtZ+lSBlGPyVXD3QF4IvRo8DEjUhXVlXZpmFg=;
        b=m3HRpqGSKJ8UYDMNOQgSecNf3rNdVOmE0qm7GOD50frYfX14d2oPsbjC6gT6OcAAGu
         wBKGbaBcwKtPrvdEP2BPMsS9eiQgY/N3P+Uwt586sXVck57OLoXeboIYShHsNB983CJ4
         COGBPsCsrOhmKtu+vN7Ispmkk/jXxGwBFXfkzh7JtNmyxYGOt4vdftC6P1mKkem8397E
         mEYTuRiyIm9GbbEm9OAjkYUIa4+u5mvMbvhY5eUcuTFTT+AdO7T3vxnOStNvYE1cPR7T
         Ktck7UgM5jGsHwlObIWm/aatJ1t8KiR3hTeuMZkBj0+I68e4n7Sbte/ZAA39UKDJGnjQ
         DLdw==
X-Gm-Message-State: AFqh2kpKt6UCBNQ2r/oQJHKnhGCiT0InACQ9mY1SXCkfawK3y08Ew8cc
        W49ADFdgAmeIzqpQWGHuXh7W0WqCHsa2Ag==
X-Google-Smtp-Source: AMrXdXtmoNTXxB1R+Y8Cp7XiIeFwWt8GqU0mO85ZlIZjzDrHCOHCMfQVLiuET3BAttxcLFeBEKcfVQ==
X-Received: by 2002:a17:902:8207:b0:191:f83:636b with SMTP id x7-20020a170902820700b001910f83636bmr11976229pln.25.1671498480310;
        Mon, 19 Dec 2022 17:08:00 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i16-20020a170902cf1000b00186a2444a43sm7840134plg.27.2022.12.19.17.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 17:07:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Lars Kellogg-Stedman <lars@oddbit.com>, git@vger.kernel.org
Subject: Re: [PATCH v4] line-range: fix infinite loop bug with '$' regex
References: <20221205193625.2424202-1-lars@oddbit.com>
        <20221219224850.2703967-1-lars@oddbit.com>
        <221219.86edsvxank.gmgdl@evledraar.gmail.com>
        <CAPig+cSEtW3TpUkQhNVjM=7WBk-3ZYOCDohsu+AZSpEAPKwk2w@mail.gmail.com>
Date:   Tue, 20 Dec 2022 10:07:59 +0900
In-Reply-To: <CAPig+cSEtW3TpUkQhNVjM=7WBk-3ZYOCDohsu+AZSpEAPKwk2w@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 19 Dec 2022 19:00:25 -0500")
Message-ID: <xmqqo7ryzxu8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> The change of direction for the fix itself looks good to me (re my
>> earlier feedback on a previous round), i.e. that we should fix our own
>> code, not forbid '$' in regexes.
>
> It's subjective, of course, but the patch seems "good enough" as-is
> and the tests are easy to understand. Therefore, can you clarify for
> Lars and other reviewers if you're merely presenting an alternative
> approach, or if you consider your suggestion "blocking" and expect a
> reroll.

Thanks for saying this.

I personally felt that the original was easier to follow---given
that these tests do not have too many moving parts that may need to
be changed (in which case abstracting common parts out would allow
us to maintain only one copy which is a big win), being able to read
from top to bottom without having to read a function and recall what
the parameter was etc.

