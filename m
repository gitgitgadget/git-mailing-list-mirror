Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32531C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 17:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJMRCw convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 13 Oct 2022 13:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJMRCv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 13:02:51 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F849EC535
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 10:02:49 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id l127so1849349iof.12
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 10:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsC9q1AUfLXX29Jd3+6NqqR0OXSdIaWLR/WeA8OJJIU=;
        b=fwXV4FJFR40w5R2Qdhbk1uumMYHP0qNLvQxlduJXiWTWvZ/ShE22R2TVkiTasR8L7w
         uLgppwu4HqYbmMJeaOHPEWIz3M3X6yRTkwFUL2uuFBO9zVNJkJwckpGylZVdJJMjdUj0
         YYYW4AN2IxslwRIK/v1Hu/h+iQA7fqnA9bvNZTykr6d7PMTl5222LCEKCXCLofdXnkko
         nz0iFj05wuQ63CSpsFg8R/bPXKCLsquts/OaZvkaz6Q1CVMG//xujCnYe6z1qXo//cY9
         QsUjWFL3jXQcAmwQ3388PTAm+FxKvZtnj5udB8uuP82Vc3bPSGH0ezFAZwJUKNuuoOZL
         BHaA==
X-Gm-Message-State: ACrzQf3Vdob5X36FdjwAtmfUjeWfB8gGRlVDxLPM9d0c5ydWJG4JElJO
        EcwzvvRTH9uIkNqknXcPwh/KAMxuminab8cocOE=
X-Google-Smtp-Source: AMsMyM5GKwiQtXcYs3kPUzuIxCeZSwghT86gFINKVqxISSg7jbq65f+pTV/GDZk9f9ivig2sgWgsbwsGykv8iRZ7BEQ=
X-Received: by 2002:a05:6602:2c89:b0:67b:7e8c:11c1 with SMTP id
 i9-20020a0566022c8900b0067b7e8c11c1mr422169iow.101.1665680568808; Thu, 13 Oct
 2022 10:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <af5611aa-8662-7508-4f00-7fcf4e9cbcc6@web.de> <221011.86pmeyo7ch.gmgdl@evledraar.gmail.com>
 <27ec1253-4d34-1de2-caee-12bcf1dac03e@web.de>
In-Reply-To: <27ec1253-4d34-1de2-caee-12bcf1dac03e@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 13 Oct 2022 13:02:36 -0400
Message-ID: <CAPig+cRuqq=n=CLkCSH=axLO92=F2JGwNnK51aBEeCoMSdJjqg@mail.gmail.com>
Subject: Re: [PATCH] archive: deduplicate verbose printing
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2022 at 6:40 AM René Scharfe <l.s.r@web.de> wrote:
> +test_expect_success 'git archive --verbose' '
> +       git archive --verbose HEAD >verbose.tar 2>err &&
> +       test_cmp_bin b.tar verbose.tar &&
> +       find a -type d | sed s-\$-/- >verbose.lst &&
> +       find a \! -type d >>verbose.lst &&

Aside: I was curious whether or not we care about older `find`
implementations which don't print anything at all if `-print` isn't
specified, but I see that the test suite already has a mixture of
`find` invocations -- some with and some without `-print` -- so that
answers my question.
