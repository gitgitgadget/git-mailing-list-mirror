Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453BDC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 14:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E92620787
	for <git@archiver.kernel.org>; Mon, 18 May 2020 14:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker-net.20150623.gappssmtp.com header.i=@dtucker-net.20150623.gappssmtp.com header.b="hzvl4GGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgEROlg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 10:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgEROlg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 10:41:36 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC9FC061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 07:41:35 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id z3so6545269otp.9
        for <git@vger.kernel.org>; Mon, 18 May 2020 07:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dtucker-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0luCWNpg+KyFZeqnGkLrMsSa7wdfKk7tNsAkJsZ3D8=;
        b=hzvl4GGajMPpt7n3W1SV/TKnmK319304Yjbfz6ZnsS/YEJwnufC4EQKFMygLAlyykU
         UuggYbRuOZUVg+SjAwLx0XP+ebNbQbzbb1ayCQ9QcheAdzgkUuuQ3d4KrMF8CfNG+TrA
         vRam1G9PxtTktUTdRJCzkWMVIa3p9vwUyZQTbotwbF4Ni3khPUhgI8MfEhjbocS0eGo6
         Bow9ushaX5gCLUY3+mvKlXVFppSR+0yiREIdNQldY0agJgdZa6tniF4G7rBPDUVcm93n
         odAw7HNxUko6P4OpzLD8fgcmEmOwW2v+5/Uzo78NqbRUbjLGgLgEdTrAnSLKaIdhlBwH
         ZIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0luCWNpg+KyFZeqnGkLrMsSa7wdfKk7tNsAkJsZ3D8=;
        b=pLTAzxM3tldDpFxxEfhEgNb7rfcVPVpwp+2KnIhneSj9jRSk/YrGuHbfO/WzGz3Puz
         gRMzKRpygjRZuRg/7Wzg/DJGFp4+89PU6Rt4wFVJSYaCq+g0oazDBn/Uv15bjvkNb78x
         XO6e38alG1+wUFmULTktquRIIyTQSrWJ46ayDTnJNu47eELz6EmtmE4QBdwDON6Ica/c
         mNW3IosDW/xGR5zssD9QfEcPppleG9/R6ImsCQueruSKHpxI4Uht4BtDAAE++T1xQ+a1
         1Wy8OXzSBpNeGkPNHhvOFx8H0tfbU2xG70K7AZeeX63GEpw+wiJN1AP/iT+JlMgmtPIE
         4dDQ==
X-Gm-Message-State: AOAM533WBzE0alZFIwkLRX9SEHfuq4PbPBYOdcF6C3QdKTKDIJLLXszc
        YlkwMR6XByO6DZZQJ8/UiR0jWEw+JPbWJYv3qlcGadk99MI=
X-Google-Smtp-Source: ABdhPJzE2g5dG8w9q0nZdSKnZRVS+hqCqNesm20S8QV1Xt3q5TEwSL+qANtesPGMZTCgkQXtiPz05Swm/Xc2X8bfdbY=
X-Received: by 2002:a05:6830:30b8:: with SMTP id g24mr12397023ots.225.1589812895262;
 Mon, 18 May 2020 07:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200518100356.29292-1-dtucker@dtucker.net> <20200518100356.29292-5-dtucker@dtucker.net>
 <87a725r16n.fsf@igel.home>
In-Reply-To: <87a725r16n.fsf@igel.home>
From:   Darren Tucker <dtucker@dtucker.net>
Date:   Tue, 19 May 2020 00:41:24 +1000
Message-ID: <CALDDTe0ZDQgZnMYHAdcOJnU_ObdA6RmnnhvNwsfmP0RdU_+eTw@mail.gmail.com>
Subject: Re: [PATCH 5/7] Define LLONG_MAX/MIN etc if not already defined.
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 18 May 2020 at 20:24, Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Mai 18 2020, Darren Tucker wrote:
[...]
> > +#define SIZE_MAX ((size_t)maximum_signed_value_of_type(size_t))
>
> size_t is an unsigned type.

indeed; missed that in my cut and pasting.

[...]
> These definitions won't work in the preprocessor.  The are no current
> uses of these macros in preprocessor directives, but that needs to be
> kept in mind.

I originally had these defined to LONG_LONG_MAX and ULONG_LONG_MAX
which it (HP-UX 11.11) has.  It's also got SSIZE_MAX but not SIZE_MAX,
so I originally had

#if !defined(SIZE_MAX) && defined(SSIZE_MAX) && (SSIZE_MAX == LONG_MAX)
# define SIZE_MAX ULONG_MAX
#endif

which would work in macros, but I changed it at the last minute to use
those other macros since it seemed more likely to work on any other
systems that had this problem.

-- 
Darren Tucker (dtucker at dtucker.net)
GPG key 11EAA6FA / A86E 3E07 5B19 5880 E860  37F4 9357 ECEF 11EA A6FA (new)
    Good judgement comes with experience. Unfortunately, the experience
usually comes from bad judgement.
