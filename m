Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A386BC05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 06:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjBNGFi convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 14 Feb 2023 01:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjBNGFh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 01:05:37 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DE1B766
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 22:05:36 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id mg23so7557807pjb.0
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 22:05:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676354731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RI/rDMF+YQ4cvwnchXoKWmoUCQHGLcbvvVHB6F6N0no=;
        b=DJnm0ICtOkGBz/9m86hjqOFPPXyUtTXLaMjn5/LoVGmuLTBoNXck1DiKdKuMaJGq1A
         CX75IWyL4Vxv/7RN9CW6A7faoxoozzb/R+RuFrUdP6f/FENb579rSKwuG5Vj/XQ1CJ4h
         untZgtAbAlmXDBXgI4sDyIrfIEfMQlmITzu01L89jOGgHg0S3XpRGWT64pk/51owIQzC
         lDxRDc1hZpU4FW3b5a9TuJhJj2GmL2QPTwTSV+05ThbfHM7uVLHQXAW88GYlxSi3ecJl
         tZoim8zH+t5Up5An/ND61jdLuYEng+jDFHHsyRdFFZQY9CKcQ9Hk9q0+urDy77kQGCBd
         6XKg==
X-Gm-Message-State: AO0yUKWrbJ2X2k8+VCd5Zb2ZyDM+q2tpK4nI1f5fwvz+pDEoxwtFzMqt
        SdwNWAaWtH1JSdmGmZQSbS0qm7mxxDZ8kRYeyRQ=
X-Google-Smtp-Source: AK7set9oOnqbQGWjbKT/ZCuQ99k0QJQ3lKOTGwzhDu+3WoZKN6mteRFVqqyV4wLlS7TwnSb+Hh9RdVQF1LQPWqdS6Ic=
X-Received: by 2002:a17:903:190:b0:199:1458:6c67 with SMTP id
 z16-20020a170903019000b0019914586c67mr385841plg.28.1676354731463; Mon, 13 Feb
 2023 22:05:31 -0800 (PST)
MIME-Version: 1.0
References: <CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com>
 <Y+qbFN+PhHVuWT2T@coredump.intra.peff.net> <CAPig+cQ9f0aW0TcP9A5WrKmYcQsEZvPOiPrgmzsy1frWkHd34w@mail.gmail.com>
 <Y+rmNvfjIA/u81em@coredump.intra.peff.net> <CAPig+cSTG2_hsv-amhwDwQNcfLSZ2+if6=MJcyDb6PhKBx-WJQ@mail.gmail.com>
 <CAPig+cT5mORvJt_E+uDYEVW+SYbUp_1U8hmjWT8iUkjzOnJm=A@mail.gmail.com> <xmqq7cwk955b.fsf@gitster.g>
In-Reply-To: <xmqq7cwk955b.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Feb 2023 01:05:20 -0500
Message-ID: <CAPig+cQx24PRUsEjEcnuDtokS02SS3n_dUi8MO=WJbBazget8g@mail.gmail.com>
Subject: Re: bug report: symbolic-ref --short command echos the wrong text
 while use Chinese language
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2023 at 12:40 AM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > sscanf() seems to be the culprit. If I set LANG, then I get the same
> > result as you get:
> >
> >   $ LANG=zh-CN.UTF-8 git symbolic-ref --short HEAD
> >   warning: strlen(refname) = 39
> >   warning: strlen(short_name) = 28
> >   测试-加-增加-加-增加
>
> Well, that's ... criminal.
>
> I wonder if LANG=$ANY_VALID_ONE.UTF-8 would work the same way.

Um, I suppose you are pointing out that I messed up by using invalid
LANG code "zh-CN"?

Using (presumably) valid LANG codes results in the buggy truncated
output, but "LANG=C" produces the correct result:

  $ for i in C en_US fr_FR de_DE ru_RU zh_CN; do printf "$i: " &&
LANG=$i.UTF-8 git symbolic-ref --short HEAD; done
  C: 测试-加-增加-加-增加
  en_US: 测试-?
  fr_FR: 测试-?
  de_DE: 测试-?
  ru_RU: 测试-?
  zh_CN: 测试-?
