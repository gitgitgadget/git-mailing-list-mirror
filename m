Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33543C48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 20:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09BD261278
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 20:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhFIUbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 16:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFIUbc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 16:31:32 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A8CC061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 13:29:30 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id k21-20020a4a2a150000b029024955603642so4072062oof.8
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 13:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=L+xW5hhQj0KVzfcpl2YXMu0sfEPg7f3dankMytlNIGk=;
        b=GUD+8dK6fKGx5sL4yZUwCMN2pwym4cp0Pl2g+0giuTn+4nAeCnWbAzXajJXsfxOFwc
         vs5s3T9+lqW6Js07brvYWhNKh9IAnHrJIak7HqR20ssZmAGaR28PbRsHG6lxkstpYv/x
         RVDlIeyD1K96dZTdxR5LlwLemOsmnGZDhEul3alpMOOTMTdnbpz0GqmMs8Ko67XqifE4
         wEefSU2yIdFR8Esgg5xRlJNMJo0X5tiplw7n4N6k/0gGf2Z3qvSU6+wMM3nOgAo0hpqD
         3puOUA7u81tOpZh1LU/hywnB0F/cPsHOHM1Y6chDOtrnZcqkVDykjRwj90q652lfdRgB
         qNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=L+xW5hhQj0KVzfcpl2YXMu0sfEPg7f3dankMytlNIGk=;
        b=JXg3wUsHaDhAXKx2zu5qkH0VwWxw+zQCNrxTMzN6OyJDQeoiWXYNP7PNjTAAeaDeJq
         uFz2J2ya8NSIYIf3AIIggUX1UVV7yLqacoMZjiJsdJ/8hxDyn69GOa9aGb6vUkmoDDnx
         NBnHU0LryLUbqTJL0qjzdDaEKhCNG0wQ9Fa0pvOzmsFqF+ipAg/bKojl2Jl0ph2Vjsbq
         SBuUyhPUc6Z1U9NAXvZ+fAi1TSQVyQqkKH3yla7b50StgEa6/Fvckk4I3qbVTKJx1voz
         4RAExtFk3HApIuvXHwkozmnDtvAS81M0gTljv0V3jLxY1fu6xhVwqzDpOUrlctOtt+Vs
         tLjg==
X-Gm-Message-State: AOAM530mq+6HIEJsHFKnSzBfYPDM8ZfvTCpLAnwKh9hi6CWVG6T9WD3l
        9FBZutoMr31H2roNbPg8BCfkReCBFjka2w==
X-Google-Smtp-Source: ABdhPJwj83henBGCZa7YKiNUu3XnCN17OOLCwUSORQKpKVFsiEWHr9b9XClO+ANn/45zouf2H84SDA==
X-Received: by 2002:a4a:6107:: with SMTP id n7mr1454825ooc.12.1623270569756;
        Wed, 09 Jun 2021 13:29:29 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id l131sm167584oia.0.2021.06.09.13.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 13:29:29 -0700 (PDT)
Date:   Wed, 09 Jun 2021 15:29:28 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git List <git@vger.kernel.org>, David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Message-ID: <60c124a82436_aa2ee208d9@natae.notmuch>
In-Reply-To: <CAPig+cSK1YkFwQASuV1n4fr5Ko8tH8QGxvVgQ=Vd0MeY9BSrzw@mail.gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-2-felipe.contreras@gmail.com>
 <CAPig+cSK1YkFwQASuV1n4fr5Ko8tH8QGxvVgQ=Vd0MeY9BSrzw@mail.gmail.com>
Subject: Re: [PATCH 1/7] test: add merge style config test
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine wrote:
> On Wed, Jun 9, 2021 at 3:29 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > We want to test different combinations of merge.conflictstyle, and a new
> > file is the best place to do that.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> > diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
> > @@ -0,0 +1,44 @@
> > +fill () {
> > +       for i
> > +       do
> > +               echo "$i"
> > +       done
> > +}
> 
> This seems to duplicate the behavior of test_write_lines()...

Right, I'll update the patch.

The above function is used in:

  t6440-config-conflict-markers.sh
  t7201-co.sh

So those two probably should be updated.

Cheers.

-- 
Felipe Contreras
