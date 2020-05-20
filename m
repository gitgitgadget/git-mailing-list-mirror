Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A044C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 01:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D16BD2075F
	for <git@archiver.kernel.org>; Wed, 20 May 2020 01:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker-net.20150623.gappssmtp.com header.i=@dtucker-net.20150623.gappssmtp.com header.b="LZ82u+jP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgETBtW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 21:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgETBtV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 21:49:21 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E65BC061A0E
        for <git@vger.kernel.org>; Tue, 19 May 2020 18:49:21 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 69so1253187otv.2
        for <git@vger.kernel.org>; Tue, 19 May 2020 18:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dtucker-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PGHaAWKCvFCaM98O/+2o4AP8Gngn/X/iAtJZIOiOkes=;
        b=LZ82u+jPxT7mzDHmMz9Fldwjen2d3adqJcQZ8MP9jbn42K/y7ccnC82F3M6GGJPXe2
         C/KALWGM95z37dqyXMgZuTXh9rUeozTgUtUAplJyNV7/cwopzf8mjd4Nrb7qrG7wCnIV
         O4KnVsHeegSH4rGXSh9CAF9Ju/R36P0/ulbX5G4TdxtDg85IQkwpKg+8UKPWzVFUYcVE
         lxN0GXWC+7CPrq1gxlv6WIY8ZB19GVgt57kOEgLYyI9COzUMiPEwJxeDCtRKJBN6aWdM
         /EfFJctoLAZJU/86JAUrhFTzrUlcftRPQ0hxkpCDg/MqnaVXbxt7vnh42V2G7C5Oih8p
         mawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PGHaAWKCvFCaM98O/+2o4AP8Gngn/X/iAtJZIOiOkes=;
        b=dsFSe2ixxs2/1DyE+yTPbmJsF/RLKJYr/N3zIlU+fesr4gN+hKj3EVosJELMtc12FH
         ddMkPj9tIswl0zOqtyV+/SL+PfB8FlQopTkTVpCkdieCpEOKEP0ADhuwfqPcyVqbfjTF
         ViX7tIMWXSRNCWHeIUqU5kuWStOetkdJzFVRQQKsbutWVxjB89i8nfqXWsQQBH/mEkY8
         fbRaYvV/Bm8p2esRoIwSUTmxVUa/17/qT0XaSR8cQZ2DNPneM8LFR3T390RHFOcnGYO9
         TaII9Ob7Bw2V9ESgFZBC31MNWy4LGeKJMJm1LMn82WtMASgXchaZfWo9vOW45I+KVIK3
         yfkA==
X-Gm-Message-State: AOAM532oxSd3ZHsI7jB8hhtVETUkEXczIafoQMrpr2mjNVhZ6+f3A5OM
        mz2RtB0hj7+qQjdoPcjq+pI9biV+iiONza+cJ38hVcwUY+DAgw==
X-Google-Smtp-Source: ABdhPJypEM63fowoBsxoOExWK10Z+8apOo8eZOZnrSJmDIrpOYpj33CfwpqZikOxUnPr4hYj+bRg5KRXGjDOkGWj9zE=
X-Received: by 2002:a9d:27c2:: with SMTP id c60mr1570459otb.8.1589939360376;
 Tue, 19 May 2020 18:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200518100356.29292-1-dtucker@dtucker.net> <20200518100356.29292-6-dtucker@dtucker.net>
 <xmqqo8ql40z7.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8ql40z7.fsf@gitster.c.googlers.com>
From:   Darren Tucker <dtucker@dtucker.net>
Date:   Wed, 20 May 2020 11:49:09 +1000
Message-ID: <CALDDTe3CBUxEC7E+xc3RhJP45N3v8QXNqt3oq98308x-PJ9r_w@mail.gmail.com>
Subject: Re: [PATCH 6/7] Check if strtoumax is a macro (eg HP-UX 11.11).
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 19 May 2020 at 03:17, Junio C Hamano <gitster@pobox.com> wrote:
[...]
> It is kind of surprising that we got away with GIT_CHECK_FUNC() that
> misses an implementation by macro without having problems with other
> symbols.

I suspect that in most cases you'll go to the fallback and be fine.
In this case, it falls back to strtoull which it doesn't have. (Adding
the strtoull test in patch 3/7 makes it fall back to strtoul which it
does have).

The other annoyance is that it produces a macro redefinition warning
on each file.  An alternative solution to that would be to undef
strtoumax in git-compat-util.h before redefining it.

> I don't mind taking this patch as-is, but it makes me wonder if we
> need to devise a more systematic approach to the issue than "oh, I
> found GIT_CHECK_FUNC() does not work for X on system Y, so let's add
> an AC_CHECK_DECL() for it, too" approach, which this patch is its
> first step.

The caveat with putting it in GIT_CHECK_FUNC() is that you'll need to
include the union of all of the header files that might have all of
the things you're looking for instead of the hopefully small set of
them that might have the one specific thing you're looking for.  I
suspect that would be more hassle than it's worth.

-- 
Darren Tucker (dtucker at dtucker.net)
GPG key 11EAA6FA / A86E 3E07 5B19 5880 E860  37F4 9357 ECEF 11EA A6FA (new)
    Good judgement comes with experience. Unfortunately, the experience
usually comes from bad judgement.
