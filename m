Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6ABC47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 12:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ECB06136E
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 12:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhFCMgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 08:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFCMf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 08:35:59 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BFBC06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 05:34:15 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 6so5007149pgk.5
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 05:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SabT5uIfCUG4Bglcp0eNvzeBCe8m4ERVxKQbXO3ktO8=;
        b=QnViAT3tcKX0fHTEgl9isecZa3kaXH7RSKTB6T3BQn/z2jg9/MANoiMVbEIYTrfCoX
         J5K3hzxMaEAQRCc9rMXw6fmnHWaX25paaLLPeIRSVmxFPgLHGGBa0bYOfwJeY0+vlBOR
         MSmc91IQgYJuQbgpUmKpcysPbvPa8bBpoYBMCQgCxsddTnqo3aWiE/23a/micazmU7xA
         xil72K8J/jjILew1q8bBkhZ4MJWBpqacOVPDhOrpYNWLzkr4spCl/kqqIh5yLUg+lpG6
         V9yUpt1k3Ut+5B+VO8DCimGI6FjuP8erAe/ENoBT/0sJLQTfSfORRLj1mFXKJJThUft+
         U3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SabT5uIfCUG4Bglcp0eNvzeBCe8m4ERVxKQbXO3ktO8=;
        b=qKPUjA8nX+AiXBAslb2MGm9np/tPs7Inx9KQwtvlN1ohJBwtbyMXdLNupBsw/VMULG
         7E7riNbdZbifF/YlVHckwQLVeAmooP4Wpa0O66a16vFcnjWx7XW4dbBcZCtXXpDEtGTo
         ajM/tXthkagzNWdSoXOA+XzyfpGm/NZ1GudzZLJov/fOyHDye64z/wFQSz3FxJTeeC9+
         YGtqZIYU20/947pS6zlMXVyPtpyz7BYo4cl5yUlol60p0p7yJSn/5+XDy/2e8UD5g/d8
         BY7AoeAy5nrrn27X5V+vu++WO5psXuw/8mLlGWIC+JGybONSDC9RmPoA8mHwxz9wY0jK
         dQxA==
X-Gm-Message-State: AOAM530WS874fPwUXB1FdFILfCY4ftXOibjpY7Z05o9+vWPUVt/oj2UU
        I30d9Tmmft4+dla3O4SyuTuyS9xB6x9bIw==
X-Google-Smtp-Source: ABdhPJyz9Nl+SmVnihhtmIYY2H1J0kYoc01+CMfkiPOKN1rtpW1Eaaf0QtWjT6cEFzwQNOcdUbCHcw==
X-Received: by 2002:a65:424b:: with SMTP id d11mr38881575pgq.171.1622723653721;
        Thu, 03 Jun 2021 05:34:13 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id ne4sm1644425pjb.26.2021.06.03.05.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 05:34:13 -0700 (PDT)
Date:   Thu, 3 Jun 2021 19:34:11 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, gitster@pobox.com,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] t2080: fix cp invocation to copy symlinks instead of
 following them
Message-ID: <YLjMOGGVLCINlqqz@danh.dev>
References: <5386ee606567248464d39c313ee6177862a1f337.1622071475.git.matheus.bernardino@usp.br>
 <87r1hsl4qb.fsf@evledraar.gmail.com>
 <871r9n2dlu.fsf@evledraar.gmail.com>
 <YLbgi0jQn8BJ1ue2@danh.dev>
 <87pmx47cs9.fsf@evledraar.gmail.com>
 <YLdqDn9vCBc7sPDN@danh.dev>
 <87mts875d3.fsf@evledraar.gmail.com>
 <YLeMrwSiuGIzMfIN@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YLeMrwSiuGIzMfIN@danh.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-02 20:50:39+0700, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> On 2021-06-02 15:36:57+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> > That's getting us there, now we don't fail on the 2nd test, but do start
> > failing on the third "re-encode to UTF-16 on checkout" and other
> > "checkout" tests.
> > 
> > The "test_cmp" at the end of that 3rd tests shows that the difference in
> > test.utf16.raw and test.utf16 is now that the "raw" one has the BOM, but
> > not the "test.utf16" file.
> 
> That meant we need: ICONV_OMITS_BOM=UnfortunatelyYes for AIX?
> I can replicate that test failure when building for musl libc without
> ICONV_OMITS_BOM undefined.

Applying my patch and build with ICONV_OMITS_BOM=Yes, t0028.3 passed
but t0028.4 and t0028.21 run into failure. Here is the dump of first
10 characters of test.utf16lebom:

          '0xff',
          '0xfe',
          '0xfe',
          '0xff',
          '0x0',
          '0x68',
          '0x0',
          '0x61',
          '0x0',
          '0x6c',

Digging a bit more, it seems like iconv(3) from utf-16-le-bom to utf-8
there is broken, iconv(3) thinks it's converting from utf-16-be to
utf-8:

source (test.utf16lebom, considered UTF-16LE-BOM):
|  0: ff   |  1: fe   |  2: 68 h |  3:  0   |  4: 61 a |  5:  0   |  6: 6c l |  7:  0
|  8: 6c l |  9:  0   | 10: 6f o | 11:  0   | 12: 20   | 13:  0   | 14: 74 t | 15:  0
| 16: 68 h | 17:  0   | 18: 65 e | 19:  0   | 20: 72 r | 21:  0   | 22: 65 e | 23:  0
| 24: 21 ! | 25:  0   | 26:  a   | 27:  0   | 28: 63 c | 29:  0   | 30: 61 a | 31:  0
| 32: 6e n | 33:  0   | 34: 20   | 35:  0   | 36: 79 y | 37:  0   | 38: 6f o | 39:  0
| 40: 75 u | 41:  0   | 42: 20   | 43:  0   | 44: 72 r | 45:  0   | 46: 65 e | 47:  0
| 48: 61 a | 49:  0   | 50: 64 d | 51:  0   | 52: 20   | 53:  0   | 54: 6d m | 55:  0
| 56: 65 e | 57:  0   | 58: 3f ? | 59:  0

destination (test.utf16lebom, considered UTF-8):
|  0: ef   |  1: bf   |  2: be   |  3: e6   |  4: a0   |  5: 80   |  6: e6   |  7: 84
|  8: 80   |  9: e6   | 10: b0   | 11: 80   | 12: e6   | 13: b0   | 14: 80   | 15: e6
| 16: bc   | 17: 80   | 18: e2   | 19: 80   | 20: 80   | 21: e7   | 22: 90   | 23: 80
| 24: e6   | 25: a0   | 26: 80   | 27: e6   | 28: 94   | 29: 80   | 30: e7   | 31: 88
| 32: 80   | 33: e6   | 34: 94   | 35: 80   | 36: e2   | 37: 84   | 38: 80   | 39: e0
| 40: a8   | 41: 80   | 42: e6   | 43: 8c   | 44: 80   | 45: e6   | 46: 84   | 47: 80
| 48: e6   | 49: b8   | 50: 80   | 51: e2   | 52: 80   | 53: 80   | 54: e7   | 55: a4
| 56: 80   | 57: e6   | 58: bc   | 59: 80   | 60: e7   | 61: 94   | 62: 80   | 63: e2
| 64: 80   | 65: 80   | 66: e7   | 67: 88   | 68: 80   | 69: e6   | 70: 94   | 71: 80
| 72: e6   | 73: 84   | 74: 80   | 75: e6   | 76: 90   | 77: 80   | 78: e2   | 79: 80
| 80: 80   | 81: e6   | 82: b4   | 83: 80   | 84: e6   | 85: 94   | 86: 80   | 87: e3
| 88: bc   | 89: 80

-- 
Danh
