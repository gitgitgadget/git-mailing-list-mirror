Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D461BC43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 01:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiFBBQL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 21:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbiFBBQK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 21:16:10 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810EF290BE6
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 18:16:09 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id oa9-20020a17090b1bc900b001e67bbd7f83so788559pjb.4
        for <git@vger.kernel.org>; Wed, 01 Jun 2022 18:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=d9Xy0qkCTV3Qn3y8g5A2+mHUi5fLYRgi8u8ykdAUNgo=;
        b=DYm1CLBV/qhxpiGOZqO7YBkP7xOKr5ZFAxEf5k8Y5TFj72tGxwgTRCvhvM+AMzCqkl
         7ppx2oTiOMsBWJv0lUPUy8kiObE8jSGgDIF0bGu+X3eHp+nWzEiATdy/i/V0HqA5yQkw
         hPTB20U3Hx0DlM2dEfCunWS8HmgGrORxH2rYy+CcyEYZGTLB4aWW+B3IB3sa6GpVRYs2
         Mj9gorv10VtCWuosxBE/aL8OXnt/zAFADCP8jw4AGEddXwoZFEjyR5ZCtFpiuhM+Oxmu
         2qzrXWTf7/5mTAieO2u7fu2SmysEH6vpyIia00dZ1YHivE7Hmd9fExIdclEIGkulcjLl
         J/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=d9Xy0qkCTV3Qn3y8g5A2+mHUi5fLYRgi8u8ykdAUNgo=;
        b=1ic8aI7zSKLj2NZS0sgPN5OrZGEqILfM6pyF56D5qttUHllsTjKel1NRin3A7ODYTq
         36hmeZen0HL3p1fmVLzgTNbD9fbWXVMXvFmr6HKoPhPw6B+l62yVs5OXWd1+WosyuXqj
         TvZkTsv2AK52ImxTSyR4f95O01jsh1gQs6SGYbRDtoCgufsZ9aNCtYlk03L4V83iwM/D
         Tc5Pw0X11XLMz98QzO7NtxO41xrBmvh7vK9//tqw1H+Ytd3Skp9awSG0hgzS1qXmzyWV
         IRb3kKiOFNaylgfiiNIAb18KFNC9bfEA1UEJrPUXCOndJyMH4Iliyo5lPy80LFqaLKu0
         vnOw==
X-Gm-Message-State: AOAM531G+JqSye2A9PnQlnugVFKjwHwBb3vXEkgFdR2920Mi+97PYLpA
        TI/rj/crqENB0hQR1cOb1OJ4WuCMMQxW+w==
X-Google-Smtp-Source: ABdhPJxyOpgmfFimB0mq/Ls9j73r3oIpa9RaVPqH+D2nSYoK90sklV7AKGObGYv5VwDEnPoQdD68lirM9IjQOw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:dac5:b0:164:13b2:4916 with SMTP
 id q5-20020a170902dac500b0016413b24916mr2272423plx.32.1654132568918; Wed, 01
 Jun 2022 18:16:08 -0700 (PDT)
Date:   Wed, 01 Jun 2022 18:16:00 -0700
In-Reply-To: <xmqqee07q3xc.fsf@gitster.g>
Message-Id: <kl6lfskneugf.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqqee07q3xc.fsf@gitster.g>
Subject: gc/zero-length-branch-config-fix (was Re: What's cooking in git.git
 (Jun 2022, #01; Wed, 1))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * gc/zero-length-branch-config-fix (2022-06-01) 2 commits
>  - remote.c: reject 0-length branch names
>  - remote.c: don't BUG() on 0-length branch names
>
>  A misconfigured 'branch..remote' led to a bug in configuration
>  parsing.
>
>  Will merge to 'next'?
>  source: <pull.1273.git.git.1654038754.gitgitgadget@gmail.com>

I'm happy to see this go to 'next' if =C3=86var doesn't have any lingering
concerns over the commit message [1].

[1] https://lore.kernel.org/git/kl6lilpke31e.fsf@chooglen-macbookpro.roam.c=
orp.google.com
