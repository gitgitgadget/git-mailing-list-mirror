Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19765C433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 17:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3AAB6522F
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 17:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhCIRxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 12:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCIRwx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 12:52:53 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324B3C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 09:52:53 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so7406847wmj.1
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 09:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pKkT8Rxgt+9zdz9kbi+YfA7KlCcE+uxF/m7DjNs8fp8=;
        b=Fb0bbKg85drPCsiYSYrL/Flu6O1D/KkMgc9LaQl+jUAdyEUUoLFFM0MDR5rhK87JXZ
         XsQgsotst67bl/yE9AJCjU+hE9YxxmqAYha8qNTYAaDBG+LktXyBbjMws3MzZ33GepP8
         jUi4QvUU4qO6/4TMHCAvS+QOllE0DQeT3uAYCrbaYR33BYGJCWdthH94bnpSdBmfrKf3
         2ZwwPT8lghx3h3wRdEHBC+OkWlYKv6zHRhP0ZUjyd6wT/G8YDQqHvZ/CxLRS7EYPFRfO
         FZXDyHMM+1X5Xhm7CZRAFmEP9iiD+0b9bQGnBZieX88qZMOq0SYiREiQ52mExqQ2RGkw
         /SdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pKkT8Rxgt+9zdz9kbi+YfA7KlCcE+uxF/m7DjNs8fp8=;
        b=dHTXyaiHxtU+OQ4Wvt4AIutUSwkC7CoW4NBI302+iGyjLLa9KeERUhQfC1MxRZ+fGE
         l90Aue9kpvmHcBYfwFhrr1auQ4VsiwJQprBMf/qpqVD5knJh7UVTH1BkvbLnCT12c+SR
         wO/J5o7z9+7xmylFEexLiVvB23J4FQol5BU4LrX3SRGeVyw4bY1MX8V1+xuUcSFtNJWZ
         LAqXDn+4TV9P0Xm6QZuKjO+0jlz6JZRbgyaRvFeYyZDBwhOlymoWpHF6DRTo4ls2Osc9
         C9S5/M23jFdLw7ydSo6M3txXvNvxmzQEMyUcJvBRaSWZaDbHYYg6rSRVz+LbEAwYe9CV
         Olzg==
X-Gm-Message-State: AOAM531IO/BukkQRVre4drNfSehyV+7rLXxeB0ToM1C9wxj2KnqQLVPW
        2ssjaPqJ/OyuJO/DQEHB8XE=
X-Google-Smtp-Source: ABdhPJwpGTVeCDztebclD9epLwf1AEjcJlvZEPVCPJJtVgKFgJIqAtNxI/tbDsuSUeDq/4dRe7ta1g==
X-Received: by 2002:a7b:c4d1:: with SMTP id g17mr5380590wmk.101.1615312371904;
        Tue, 09 Mar 2021 09:52:51 -0800 (PST)
Received: from szeder.dev (94-21-29-148.pool.digikabel.hu. [94.21.29.148])
        by smtp.gmail.com with ESMTPSA id l15sm5318425wmh.21.2021.03.09.09.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 09:52:51 -0800 (PST)
Date:   Tue, 9 Mar 2021 18:52:49 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/6 + 1] test-lib: make --verbose output valid TAP
Message-ID: <20210309175249.GE3590451@szeder.dev>
References: <87r1kzj7xi.fsf@evledraar.gmail.com>
 <20210309160219.13779-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210309160219.13779-1-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 09, 2021 at 05:02:12PM +0100, Ævar Arnfjörð Bjarmason wrote:
> The eventual goal not included in this series is to have multiple
> output targets, and e.g. convert ci/print-test-failures.sh to use a
> TAP parser.
> 
> Machine-readable "TAP --verbose -x" output can bring us a lot of nice
> things down the line, I have some local WIP code that's a smarter
> version of ci/print-test-failures.sh that knows how to spew out only
> the output relevant to the failing test(s).

I wonder what you mean by the word "relevant" here, as I can't imagine
how you could possibly identify what is relevant for a failing test
and what isn't.  If you didn't at all meant "relevant", but that it
will show only the output of the failing test(s), then this is a bad
example.  Our test cases depend too much on previous test cases, and a
failure of one test can be the result of a change in a previous
successful tests.

Therefore, any such change to 'ci/print-test-failures.sh' will have my
firm NACK.

