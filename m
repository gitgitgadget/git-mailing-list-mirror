Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C63C04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 18:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7383561411
	for <git@archiver.kernel.org>; Mon, 24 May 2021 18:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhEXSjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 14:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbhEXSjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 14:39:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3C3C061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 11:37:57 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ne24-20020a17090b3758b029015f2dafecb0so10491186pjb.4
        for <git@vger.kernel.org>; Mon, 24 May 2021 11:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NOfo7Ai4cyd3VahIVyXVtlIt5aA/JS0GLj3lmmfLINI=;
        b=jVwQufsbjCpgh3OnaYO4QruhKMyUJ4AHH8btGFZm2lSFWoG6z6krYsNh5NaUfCoj9A
         zqcwXOVasZP++ih9VpyZoUbSqHdm6y9l07CItIlWeTy3TA0Kq+FjT4+tWQXlrR2STtkh
         9KVsyjwdECtByoAc2bUmUoif4o/fxkE9rBOMLfJNl4Xbq6wlHEIed09wE+ygBf9Dktv6
         ugfILls8mA3oUoFqZ6c1j3AYzoS6SirrzJcPhZbHgtzHKjHPzlyyu1450DraaV1QBUZR
         hqMEPH8lhZVvXdm5ASM1TucUwphzt2UB4TmGBcJH6v4rmC6LRjPCrGBPdtqLngZShwVN
         8m+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NOfo7Ai4cyd3VahIVyXVtlIt5aA/JS0GLj3lmmfLINI=;
        b=Gik46vzrNoI9w/ddhBd1xvVSLsdjqRh9Mu0dRMQ2Ehy3wXBU7vY2X2qKJzHK1Oow2Y
         d05G4SKUUwZeUzzOiHiY10Y11kDAnd57BiokLmt0lzFKY12FHoxxGR6HqX5HC7xavBJj
         kt15ahdonATMu2Cj1uTF7l2ltATVObXSgFsusjoP9KUJOYXmdFLZ1WAqYKD9aqEIkfmv
         pWIMFa5/E7sFcqDNYqB940tK50tJGcYRoIjUF17BcHrxC1cSyxxhpwshaNXPw8jrn/Io
         38Ry1g3lkj6wh5NiUF1yC7goKgZzxMi+enk2v2BFkz79POVUQ37lAzQri6wpQg4PV9Hr
         hJyg==
X-Gm-Message-State: AOAM530ClN2opZSs4QsQRb67tdJbqoqL4Ovfse3omC4MM+pqndlQJKd2
        7YMJLTJd/uhcNEphHQj9H/5iew==
X-Google-Smtp-Source: ABdhPJwkgwSTssRSEeHZI8+2P/qcuJNR/QStmn6XL7SMCH7qQBVDHaOalTnsWKXs1Qyjc2HXG5kgcQ==
X-Received: by 2002:a17:90a:e291:: with SMTP id d17mr561988pjz.42.1621881476317;
        Mon, 24 May 2021 11:37:56 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:cd8d:2ee1:d1a9:b26c])
        by smtp.gmail.com with ESMTPSA id e22sm5188039pfl.188.2021.05.24.11.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 11:37:55 -0700 (PDT)
Date:   Mon, 24 May 2021 11:37:49 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] tr2: log parent process name
Message-ID: <YKvyfe0arCWNR+N7@google.com>
References: <20210520210546.4129620-1-emilyshaffer@google.com>
 <xmqqpmxksuqa.fsf@gitster.g>
 <YKgDxahhwK/zYznH@google.com>
 <xmqqwnrrr7sp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwnrrr7sp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 22, 2021 at 08:22:46AM +0900, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> >> > we will need to discover the name another way. However, the process ID
> >> > should be sufficient regardless of platform.
> >> 
> >> Not a strong objection, but I wonder if seeing random integer(s) is
> >> better than not having cmd_ancestry info at all.  The latter better
> >> signals that the platform does not yet have the "parent process
> >> name" feature, I would think.
> >
> > Hm, we could...
> 
> Please don't.  There is a misreading here.
> 
> You mentioned "However, the process ID should be sufficient" and I
> read it as "In the worst case we can emit the process ID if we do
> not know how to turn it into name", and to that I said "showing
> process IDs is not all that useful as they are random integers
> without extra info on processes that were running back when the log
> entry was taken".  Similarly, my later "OK, we do not show pid as a
> placeholder." is "Contrary to what I thought you said earlier, you
> do not give raw process IDs and instead honestly say we do not have
> that information by omitting the record.  I am happy to see what the
> actual patch does".

Ah, thanks for clarifying. I'll see if I can make the "PID should be
enough" statement less confusing, instead - what I meant was "on all
systems, the result of getppid() should be sufficient to look up the
process name, so this code is probably shareable", and Randall has
pointed out elsewhere to me that that's false.

 - Emily
