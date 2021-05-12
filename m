Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6348BC43611
	for <git@archiver.kernel.org>; Wed, 12 May 2021 16:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E0161177
	for <git@archiver.kernel.org>; Wed, 12 May 2021 16:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbhELQqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 12:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239595AbhELQKN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 12:10:13 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A90EC061265
        for <git@vger.kernel.org>; Wed, 12 May 2021 08:46:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b21so12759982plz.0
        for <git@vger.kernel.org>; Wed, 12 May 2021 08:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sUKlFidtRzKaONdaUaxj7r/m9fE0HrGkZgOUYkKQkGo=;
        b=tHJUAgJ29OShZCi2/gGZxTnQhmjcVM8s5nHl8Xke0jwAJi6tmHBxmk0WUNgN8hSrta
         mGFwFLQfR973A5Yb6pd1zs0wR/C0xmWx9AKCVxrDnMlhBlAw9X97YHJE7AInDnpP0dnc
         OxfzYu8A7TrCM31nz+HauqTA/TCt72IWj+cw3I8ZZswBrBCWkFWsdF4B0iGFiGBPXt6J
         JSVrJMerwtuGaIkT4PZ36WARuRoxxKT7kWNkqRqcBgQakt9jgzhAhEvyR2zT1J7ARQZ5
         nF/rCS3xjheuoXu/LGNHSwyW41NbkG13Q458NjNDjnMWS3k4OjnVAvLPQdYbl7YxMpIx
         Ti9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sUKlFidtRzKaONdaUaxj7r/m9fE0HrGkZgOUYkKQkGo=;
        b=iwwju1DPrmz63CFZsMGLLTfR3OzPe41HDhbF36HIxOh9ccmD6Cbn8eQeRN3HNyopNf
         1iPBIMIdg1TfD1r+W4K3nl7Ysx7ToHMcFM5T9XB17JVcENVdOgMO5r6j24WMLH8epKi2
         MfDNZa8wV8ifbyDEcB0+8pBF3fvGu6ah2T9UpSf93bIkUrhH7tcbotcRoOL4sx4o/nfg
         9y2WAqv6XZmi/wQY13YbRZSzqjbp9aGU+7r426saRfTMJyM1jqyiaA3MHx/winvQtFa8
         ZCICFXtGiOLG6McqoGggc09jJuymUONr3H3KmsK/4nFs5ulyf/6SqH5oBHDQ70p5/8yz
         uMgA==
X-Gm-Message-State: AOAM533IRQxHy8GUK7e3PLbtmRJkRl1texfdDQsTD+6BvEm3OxBc/G2h
        0EXitTG1zDXoAbBmDT/fhxw=
X-Google-Smtp-Source: ABdhPJwQ83h+DEAQ2F6nkn0Jt2cEF/JA42jbfNP2IEWpg4ToNWd5LXfaqaPL3J7RyTvuTqQ8Ppb5Bw==
X-Received: by 2002:a17:90a:f486:: with SMTP id bx6mr11714464pjb.54.1620834377195;
        Wed, 12 May 2021 08:46:17 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id gf21sm172308pjb.20.2021.05.12.08.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 08:46:16 -0700 (PDT)
Date:   Wed, 12 May 2021 22:46:13 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/9] send-email: remove non-working support for
 "sendemail.smtpssl"
Message-ID: <YJv4ReEAgHibU5Ir@danh.dev>
References: <cover-0.9-0000000000-20210512T132955Z-avarab@gmail.com>
 <patch-1.9-85b706d43f-20210512T132955Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.9-85b706d43f-20210512T132955Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-12 15:48:17+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Remove the already dead code to support "sendemail.smtssl" by finally

s/smtssl/smtpssl/
 

-- 
Danh
