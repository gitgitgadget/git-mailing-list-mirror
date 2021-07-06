Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F694C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE3C961CB3
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 21:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhGFV5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 17:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhGFV5B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 17:57:01 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255E0C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 14:54:22 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so277857otl.3
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 14:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Ag3tZ1rmXBQSW11eEaPQ+sM06aHd7h5S4RxxIpTsZKc=;
        b=oNs5SjYcsiMT2E91yAj2gS8wrHbHM35sdAdhLLQC82Il7Wciplt9u/hw8U8cWCUgYs
         ZN6RcStuaC0403IsBZoAagifMxzWwXBatPHO0Ypp3HEga6rJ0M4N7eppLkQoe2A3QWhY
         pmrQvJy3/D4l/UYw5f3jCxJJpNNfC1TMbny6TiLsKIKMMk8SqDiKz3OljLT23hQKfndt
         jrVVtcqD6aJ17VTcFc3S6D4dWjJpjokNuzsknfJ916nqhRGRzZoN6hYC00a+f0bcUSpp
         eCCHKTVTIs3yCfndyoUX+Vi0ZXRNsDhJalMkh17ogXhCVd3DP1uqk3TjVSmQNKCGkMrY
         M24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Ag3tZ1rmXBQSW11eEaPQ+sM06aHd7h5S4RxxIpTsZKc=;
        b=HNC9pjChiojOdQsv7/Wg69Td/VBsugiqqHQpFOQrjzxidOvZckLKZT64QITmXp1CcN
         FD7wFNx1EslXT2l0kPLcnonH1+pwR+Wy46vHVH5vUXjSpZ9PAc2kWLtVbNuOmLsCc+eN
         aD0M2HHuLRDJH85N6/JbxFffyg30uTfi9G/piqSF9mCpFdby1rNNzMIhQf0OB0R78CtP
         MJvR51cd4cEjRiomObTCC8GPxgpeFVZgHGrqWwCdjv1d1uWP9p6WNULORKseAxx4pxOQ
         tYYxv6+NJc77GQ+s0CowKH8q0oeX+qrrhpDbzxkfaR8Eu7+MfalHWLmVl1/q9H+Hv9QL
         OfDQ==
X-Gm-Message-State: AOAM530Om9Xz84XbinLb36dg7yQv8T0UlSCDP0jAP8Zo0JfaGgzOzjGi
        YfYndTOJCiW4/d/tFHuYNc0=
X-Google-Smtp-Source: ABdhPJynlHK9ySLXvIGDk8PSpf+PMvbdnCP+/iIIr/FGve38mHlXoHqR+WststNWswSDvSputPzsUA==
X-Received: by 2002:a9d:6b05:: with SMTP id g5mr16115566otp.329.1625608461502;
        Tue, 06 Jul 2021 14:54:21 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id j194sm1457314oih.43.2021.07.06.14.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 14:54:21 -0700 (PDT)
Date:   Tue, 06 Jul 2021 16:54:19 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60e4d10bd8127_1c428120848@natae.notmuch>
In-Reply-To: <YOBA6s7wXUVmh++d@coredump.intra.peff.net>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <YOBA6s7wXUVmh++d@coredump.intra.peff.net>
Subject: Re: [PATCH 5/5] config: add default aliases
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Fri, Jul 02, 2021 at 05:05:06AM -0500, Felipe Contreras wrote:
> 
> > These are all the aliases everyone agrees are essential.
> > 
> > Virtually all VCS in the world have aliases, except git, so let's change
> > that.
> 
> For anyone reviewing or discussing, here's an older thread on the same
> topic:
> 
>   https://lore.kernel.org/git/1379791221-29925-1-git-send-email-felipe.contreras@gmail.com/
> 
> (I don't mean to imply that we can't revisit old decisions; but some of
> the thoughts there are worth considering as input).

Re-reading that thread--and filtering all the noise--the two thoughts
that I think are worth considering are:

 1. A default alias might leak into some unofficial documentation, and
    people with a different alias could be surprised after typing that
    command and finding out it does a different thing.

 2. A person might be used to an alias doing one thing, move to a
    different machine, and be surprised that the default alias does a
    diffrent thing.

But as mentioned in that thread those two are *existing* issues. People
using certain configurations (not even aliases) are surprised when the
same command does a different thing. And also people use their aliases
in unofficial documentation already.

Default aliases would in fact make the situation less worse because if
one of these aliases leaks into unofficial documentation, there's a
higher chance that the command will do what was intended.

The counter-arguments were not addressed, so the conclussion is that
default aliases would *not* make the existing problems worse.


That being said, there's ways to mitigate these problems, for example we
could add an avdice stating that a default alias is currently being
used, something like:

  hint: You are using a default alias: co -> checkout.
  hint:
  hint: If you want to incorporate this alias into your personal
  hint: aliases, type:
  hint:
  hint:  git config --global alias.co checkout
  hint:
  hint: Disable this message with "git config advice.defaultaliases false"

There's many other ways to mitigate the issues. It would be in the best
inerest of the probject to explore all these possibilities to their full
extent instead of just throwing the towel and stay in the current
undesirable state.

Cheers.

-- 
Felipe Contreras
