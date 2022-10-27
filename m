Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAF3FA373D
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 23:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiJ0XbC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 19:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiJ0XbA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 19:31:00 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318234B0E2
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 16:31:00 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id j12-20020a63594c000000b004468ff8fc78so1554792pgm.10
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 16:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TvY+Xu9pbpso9OxsEAWxM9RGFzPgJ54zzb7dbFz5cpI=;
        b=O1AEUgSTsHYRDHMpoX7nvB3qV2A4HaYLah8l28mfIPWWw/si6m9MOBKFzVys5Oz1N2
         T7CxJME1A+kWPsfzyHAdOSPWYKX4SVW3qzOKtO0fv1czvy0uFC/TwpOCK2Rp2uaNK0lX
         GggyvrowN4HSVJ4zN4heykRDlMA6XZofEki5+TH2jsXlEXux5pAIHgmZhAs0eR9W8cl9
         ImvcEAIRA+5PzrufHNAJxYBnAtzzcItAzmOwif49/k3oHrLVmRcuVCnTWxlK58ElznPO
         RESeiGxq1F4I5QLNRQAgHUrbyILIxJgYYtRqdOLbQrAbUqhQTymvpQCUkFiPKafsMgpI
         ujwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvY+Xu9pbpso9OxsEAWxM9RGFzPgJ54zzb7dbFz5cpI=;
        b=ELqEFjP2K196TJp3cLcch2c3w8aeOnamhRFBgBRb46dkGgemwlP3PyuvVa9wJNAUJB
         A/NntwzuYqBNoqi6ZaW9O5ifxIYVy7o/HtSB8ov70Wzh4LK+dIthudj5cHyahu42GAyS
         sK7E6ECqsWejSK0d7vZReoi+sSbsi+SUjttBxU7AdFV3gbq6TDLonaUgZKmRVtUdqW74
         7FOInWZuiRwdir/HD/tzMzndpdI40qrctgH5T2JUalUmMhofb+X0xc00CKwjx0OAzr+D
         ilVBcxmE4/w/GV5kCa0rt2oOUT9IXk+2AEnnLMqaMuGdU6xZ7hYRFWyzChMy6rSHoz0Q
         pbPw==
X-Gm-Message-State: ACrzQf1X6E6epAzcALo5Td5vjgCJ2WZ5gX6jnERDl0kNVQULKOHZF3E1
        awctIHPAqv6DdwOGNWRL9QGsIx/evE8mFQ==
X-Google-Smtp-Source: AMsMyM4Vuoheupg5zsWgI2UUkWuj7JkXKwALub8dmZJrmzZICKCZK+VF3ZJERG+fyc5uz8/Psgl6zvMdpVKtWQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:d2c5:b0:186:afd7:56d3 with SMTP
 id n5-20020a170902d2c500b00186afd756d3mr21699079plc.142.1666913459719; Thu,
 27 Oct 2022 16:30:59 -0700 (PDT)
Date:   Thu, 27 Oct 2022 16:30:49 -0700
In-Reply-To: <20221027185437.1842331-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20221027185437.1842331-1-jonathantanmy@google.com>
Message-ID: <kl6ledusdety.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 9/9] archive: add tests for git archive --recurse-submodules
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Heather Lapointe via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?utf-8?Q?Ren=C3=A9?= Scharfe" <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Also, I don't think we need to extract the tar to check it; using "tf" 
> and inspecting the resulting list with "grep" and "! grep" should do. 

It might be even easier to inspect the output with test_cmp, instead of
reasoning about which files should and should not be there.
