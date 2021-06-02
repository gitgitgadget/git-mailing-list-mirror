Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09B9C47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 13:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAD5E613BF
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 13:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFBNwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 09:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFBNwn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 09:52:43 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5982DC061574
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 06:50:44 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t9so2299996pgn.4
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 06:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1ibcznskIgzNBWYF4FXg8Rw/iTGQU8MYwBEADHFLAW8=;
        b=CYtbAwxV3PkEY4ODauie/5WYpNDjI2HkPgxzuRcr2fTir1AhAcrtxJ+VEWFRteLs77
         3k6KDdOOTT/Mgddpi0R8FPCohzheAhmnagKHVzjAMO13QCGCV6zV9GXQusy5z6ri+cAL
         drk6nQjIzEbLDY8dcIyQ5IwVIxGoX3ANzNmoa5z1dRQppdTORX2cStffflfQLBtZpmf/
         pe5crxKKYOulnF8wCkLWnwN9JfoKRxcsirVId83VrTS18ss/FmBk1lcadaHDXl4HeBnY
         wK4x8VNI7kGl7cbcRlxYHHbXTNSU/8zKCODLqWO26+8SjFbReaVwNZNWDIOtCreCRu/I
         klnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1ibcznskIgzNBWYF4FXg8Rw/iTGQU8MYwBEADHFLAW8=;
        b=mQEyTyzlBWI92DdL+CcwkpZfTznKwo7EyWiKQRcwF+Zg3yKeMiIaAWQeG8QxXwJpDK
         ljABu5e0+EXTzvr8+09wZuu3xlD++Itg3XB1QB/Gm+0srvG/dN26d2GaNyGiooeJWd+d
         DmrtuvmUk3qlHMmMKdutTt++ufSqi30zMkKX3NgYCfRe9TzIzq1p2A4o7edXFyFUx9Ba
         h7b1F1L0kImVCXB/qF2tvO/w2ngkA5vMjJ+LBv8ezub3wSuGAKF+QFNtD2jeotfE7dNp
         D4JvhJUGv/cxxojwOv01C2eIBU/00PeRwGNnL7Z2tg1zZHvKTQy8Rekxsi4/59n29wrP
         cnYA==
X-Gm-Message-State: AOAM530tKgk5sUYGlxU6pW0ONcKuvWbamnjBBGz9yZnfngoxpnNsxqK0
        6W8bKKywFklB9pDWwMwL6FI=
X-Google-Smtp-Source: ABdhPJyERHkAiChfNqpU8uAFaZZuiJg9ykZn7hGguCRM/tXCbXp5TckOvG5OUbSKbph7SvxboBdszQ==
X-Received: by 2002:aa7:8882:0:b029:2d5:fd51:6417 with SMTP id z2-20020aa788820000b02902d5fd516417mr27320692pfe.54.1622641843619;
        Wed, 02 Jun 2021 06:50:43 -0700 (PDT)
Received: from localhost ([2402:800:63b8:97c0:59aa:7727:6cb5:cccf])
        by smtp.gmail.com with ESMTPSA id s3sm18419036pgs.62.2021.06.02.06.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 06:50:41 -0700 (PDT)
Date:   Wed, 2 Jun 2021 20:50:39 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>, gitster@pobox.com,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] t2080: fix cp invocation to copy symlinks instead of
 following them
Message-ID: <YLeMrwSiuGIzMfIN@danh.dev>
References: <5386ee606567248464d39c313ee6177862a1f337.1622071475.git.matheus.bernardino@usp.br>
 <87r1hsl4qb.fsf@evledraar.gmail.com>
 <871r9n2dlu.fsf@evledraar.gmail.com>
 <YLbgi0jQn8BJ1ue2@danh.dev>
 <87pmx47cs9.fsf@evledraar.gmail.com>
 <YLdqDn9vCBc7sPDN@danh.dev>
 <87mts875d3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mts875d3.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-06-02 15:36:57+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> That's getting us there, now we don't fail on the 2nd test, but do start
> failing on the third "re-encode to UTF-16 on checkout" and other
> "checkout" tests.
> 
> The "test_cmp" at the end of that 3rd tests shows that the difference in
> test.utf16.raw and test.utf16 is now that the "raw" one has the BOM, but
> not the "test.utf16" file.

That meant we need: ICONV_OMITS_BOM=UnfortunatelyYes for AIX?
I can replicate that test failure when building for musl libc without
ICONV_OMITS_BOM undefined.

-- 
Danh
