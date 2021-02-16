Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8324FC433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 16:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B1B64DE0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 16:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhBPQI2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 11:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhBPQIY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 11:08:24 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73829C06174A
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 08:07:44 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id b24so7349966qtp.13
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 08:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RO+x76uklF969S+xuv3PzWTMDg6FJehdH1XvhpAQDpw=;
        b=f42u+SqnMEFqEDy3nw2ZVh3Ur8HWPs5gl9VvO8yOwtwZwUMWOTddv/Y2ik3NaSFVJ8
         XVQ3evcQPuR2v7QmPLz0QN3lcu5+A4Rg28nCyttIW/O+BkEJ5GXZrLWDXkVNhGMNq9b1
         CLkHYkm0HKiz/Ao8NC1a0nXXK9cy9Wo0mfA1ABfzBtaFGsM8ej0GagxKuN33quI7a5LM
         SAZO5MFra2idjYzFLR1mvEZKw0KAXyOeihCFmMgTBh5UVoFKEabOd4ubikuk/tkSZ4wh
         v1F/3xDxqRhHsmdTBLiYfY9NbzsSPK93Fp2HAGMpL5SUzaI0Fv05FfG2fEjcIARFjCFM
         ej8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RO+x76uklF969S+xuv3PzWTMDg6FJehdH1XvhpAQDpw=;
        b=uSzu92yagTeyMkJUFqaFR34aVOtDHUcvHzxZLCngZHjrioMhs6sqUFCR64ODvsV96/
         DXtyfvZg6EMz/sD+NI1TVyIPMsEnik7BafJqnOkHzWEbVl0MOEVbgoCx5x2igYd7yMYG
         E5rgetKk5dGET0BeU/pZT2fBS3NOU2rE8CU8TMm9wvuQKkaGHVuAq2VXF9aMX19eu67p
         ZNABuwMEZPndWEOiE4lGjdgvPKSEqmrgEGpe+uiFvmxGgOqZK4S9k1xx2VVT/XqAoThU
         lqXm8ZUiXMncDgM+WzS8ogvcL4jVWo4RGk3PCyT3wQQrdrMzPCW3qBwfQyVq2Qj1xUvU
         PFkw==
X-Gm-Message-State: AOAM533x3cfLdqvPXbOHY6w5ueHpEXDLZMjsIKH9RNiFrXoNs0y0QIdV
        DXeMhWE+EfCbAMfycZzt+OqeElQgfpRUiEot
X-Google-Smtp-Source: ABdhPJxGggz8wkpR+lMbUCrgN8V6yfJ+O+ge5+tHpqDoF1gi+6RHmoprFKY/tSCzaos7Hw6+h35MDw==
X-Received: by 2002:ac8:dc5:: with SMTP id t5mr19927946qti.246.1613491663759;
        Tue, 16 Feb 2021 08:07:43 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:c1ff:146e:b5:8cba])
        by smtp.gmail.com with ESMTPSA id d1sm13135499qtq.94.2021.02.16.08.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 08:07:43 -0800 (PST)
Date:   Tue, 16 Feb 2021 11:07:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Blake Burkhart <bburky@bburky.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] add open_nofollow() helper
Message-ID: <YCvty0WvJycB7WXi@nand.local>
References: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
 <YCvaRpQs99TBaCrQ@coredump.intra.peff.net>
 <YCvcoPnDAEWNcv+h@coredump.intra.peff.net>
 <YCvoQBhmCeeR9Cup@nand.local>
 <YCvsj2Teym2K06wa@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCvsj2Teym2K06wa@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 11:02:23AM -0500, Jeff King wrote:
> Can you double-check your initial timings?

Aha, I forgot to update the input to the second check-attr tests after
putting .gitattributes files everywhere.

Rerunning with O_NOFOLLOW, the initial timings look something like
128.8ms and 183.7ms before/after.

Thanks,
Taylor
