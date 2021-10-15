Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5092C433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 20:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A6A46105A
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 20:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbhJOUX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 16:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbhJOUX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 16:23:26 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6C1C061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 13:21:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x27so46050144lfa.9
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 13:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bWQnLPgWq9C9ZgEkY7zoVpvcA9T3eZ2k6IVIGZHjbXk=;
        b=gyl4lLfWS0sFY49qIdGLVbHXYy7CkzGNidthUpHJTAa7iVwIy47As0FvWOdHeB/yt4
         UARRJlxar7l2y4Xg5snAFq4kY2lV7WRlrbVsU6y1f5dEQZ5CC+VWrhvKKuv4pztMWEYG
         BLyKNv1bqU9/53NdKP+6lUsyCFg9e4gTpGUQ0Tc2TQejC5Hw7CMqX4andIEpXLbtJxc2
         3fbQw3WKthaZisuve4zf4VopKcbK+nCwEew+2NU1AOktEuu1/Vl6FgHs9uU5RPJybONI
         9zali7PWv+kzjRiQ11M95NTnXgCWpXff5NOaq7//pbGSVPp+iPHts4fOU8OURT+LLakJ
         hWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=bWQnLPgWq9C9ZgEkY7zoVpvcA9T3eZ2k6IVIGZHjbXk=;
        b=o4mD40WFkz6vpnQQoxwvmjtZ2pNo9PRIcCqVBrn5mBopcg6XbxbIPfYD6PeFtfROFA
         ezXcThX+LFsfIO7VN9M44+i04VREU55FCeqMfpzb6OmmRuvh60dbN4Ihl/xcF+yPGKMT
         ExSuBDrk7b2enFx15V+iy6uDjZ9gop+5YGrkWT0gIDP+ZBZwSSuSl4YU69Iq+wqwOHDP
         PZKdKDobrv/B3/79BTeXvp6hliqb2EzR7ZALjhbVxYQ/4aqVEsq+Cqa072+VehWwhnhO
         gHSBdmkR0GOcUJi5UCAGSCFB+x2QLGBiW9erAvrLsncBHxy7m9p8jE/9O0K075gZ2tNE
         PSzw==
X-Gm-Message-State: AOAM531Go+SChRZs9+pR0wOG0i/JpEq2dtBE/eBd57R62epZiiC2xVZa
        uRQdc5qm9DqZXGvXjb8APyg=
X-Google-Smtp-Source: ABdhPJyk9vdNAKtabcQ+dGwl0Ri0jhRGMQF74Y5BYB54+sf2UVsi2Rfp3/4gO9coHNI1cE/9j2EAbA==
X-Received: by 2002:a05:6512:2292:: with SMTP id f18mr12787523lfu.619.1634329277415;
        Fri, 15 Oct 2021 13:21:17 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w8sm616584lft.293.2021.10.15.13.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 13:21:16 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] stash: implement '--staged' option for 'push' and
 'save'
References: <875yugcs3l.fsf@osv.gnss.ru> <87lf2zz59w.fsf@osv.gnss.ru>
        <87fst2gwia.fsf_-_@osv.gnss.ru> <xmqq5yty6uh1.fsf@gitster.g>
        <87pms6cdnk.fsf@osv.gnss.ru> <xmqqsfx25c09.fsf@gitster.g>
        <87lf2uavum.fsf@osv.gnss.ru>
Date:   Fri, 15 Oct 2021 23:21:16 +0300
In-Reply-To: <87lf2uavum.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        15 Oct 2021 23:14:57 +0300")
Message-ID: <87ee8mavk3.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>>> but
>>>> unlike the "stash -p" that goes interactive to let the user pick
>>>> hunks, in which context "oh, no, you did not SELECT anything" makes
>>>> perfect sense as an error message, this message would be confusing
>>>> to users who weren't offered a chance to select.
>>>
>>> It seems to me that it makes sense to leave this warning as is, in case
>>> the user invoked "stash --staged" without anything staged. I'm OK to
>>> change this if you have something better in mind.
>>
>> I am not questioning the presense of the warning.  It is just the
>> phrasing of the warning---"You have nothing staged" would make a
>> good message, but "You didn't select anything", when we do not offer
>> them a chance to select in the first place, would not work well.
>
> Ah, I agree, your phrasing is much better, -- will fix.

Changed to "No staged changes" for the next re-roll. Looks OK?

Thanks,
-- Sergey Organov
