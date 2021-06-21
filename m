Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C6EC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 23:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CCE961153
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 23:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhFUXyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 19:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhFUXyn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 19:54:43 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31150C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 16:52:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u2so720963plf.3
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 16:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KJ8jzfL3xiq3rV8WHeUhFm+QFfFGhyAomxmKtW7WPIU=;
        b=fiqwiAniucXSoIeC2e8Me2T/cNIIY29MOgfajvZwwwKE42zetW9Dz3v/jc+azeGQHy
         P36iHKfc0awuJ3z03b/zv2oubBUBkT4UiglkicEuhsReGTiJvDyiClkIa+h4laiCM6pJ
         P12/Kt6iwvvCANSbjtkkCq4/ngQQjTwq50wsO9m+LY00uxNzma/e7WmoZufhbJyG0g+3
         Lr65se9PjkiMtyj2iaSWHdqn2vikTSNFt4IEp2N7yQ8eQtGlaKNGnOBlSMiXILtsCZjX
         6x9gLg/UWrJ0CB98aVlX41NkOMxQOPQ0pJqKJl0ourEfkVNNCYuwMRwD6di8v7pLLGLj
         6Yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KJ8jzfL3xiq3rV8WHeUhFm+QFfFGhyAomxmKtW7WPIU=;
        b=EDoXdfG7DW/6rNR+LIUXsenH+5FsUeqqMvP+XqdiVsrLOD2mvQLZ7+2Q1uvrz6yIED
         cmUTg8QHWV8OrGCcg7LEMjnZ6u7LaEp1sdgfIUhObW+aN0yd1RxpvGKPOGrXv0b2n0Mv
         kwxPQ+tcTJFzGgeUKNaJKMnsHt/iBNJVVLSh8N6RlYl5IQF/OD4McFLHU3XSgUjEfxik
         Kl5lQFQa1tw2482Al82y9EUvhlgRvgJwVgEuiZBNLXNGPZ0fX7U0+FlvriumglEG3JId
         gotWEqtSUb+/HGeuglxlZImuR2ohjVXKfT3u8Xm8GG7o7JYR0RX9wBkGcJ8jfYvFSYfr
         BqGg==
X-Gm-Message-State: AOAM531+dO0v4ATy73s+sUZzXHWlo1ltozSEGBTeHiGeofdFLZA9kY01
        kN+JYgn5w/ZJe7N1ykBYaMw=
X-Google-Smtp-Source: ABdhPJyHgv8itG3kZRIbvnrqmhrKHsADd7vsBWqjaBgKY7XxcoG3vHdNYzg8S0XpoVQ2kLX8tjBMTw==
X-Received: by 2002:a17:902:8f94:b029:103:62e4:686d with SMTP id z20-20020a1709028f94b029010362e4686dmr20300605plo.42.1624319546553;
        Mon, 21 Jun 2021 16:52:26 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d894:c20c:47df:f687:87d4])
        by smtp.gmail.com with ESMTPSA id p6sm289636pjh.24.2021.06.21.16.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 16:52:26 -0700 (PDT)
Date:   Tue, 22 Jun 2021 06:52:23 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/4] t: new helper test_line_count_cmd
Message-ID: <YNEmN0HmQbiCMuaU@danh.dev>
References: <20210615172038.28917-1-congdanhqx@gmail.com>
 <20210619013035.26313-1-congdanhqx@gmail.com>
 <CAPig+cR7tUXB4=j3fGHN07=tPJ-skGb_6M7SExTq5eAH7FSwOQ@mail.gmail.com>
 <xmqqfsxel6oo.fsf@gitster.g>
 <CAPig+cQdDibt2K6jFKehaWyGdtb72pj7FQ9nGLJYEmqna3vf5w@mail.gmail.com>
 <xmqqy2b6jql2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy2b6jql2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-19 15:50:17+0900, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > Indeed, I have no problem seeing this as a new mode of
> > test_line_count() triggered by an option. In fact, I suggested exactly
> > that[1] when this idea first arose (except I named the option `-c`
> > rather than `-e`, but the latter is fine). However, my suggestion was
> > pretty much shot down[2] (and I don't entirely disagree with [2],
> > which is why I didn't pursue the idea in [1]).
> 
> ;-)  
> 
> Yeah, I still am skeptical that we'd gain much by hiding the
> redirection to >actual behind the helper, so as I said in response
> to the v2 series, I am fine without this new helper or an enhanced
> test_line_count, but go with more use of test_must_be_empty etc.

I guess the overall feedback for this new helper is negative.
I think the consensus here is a local helper in t640{0,2} for counting
ls-files?

-- 
Danh
