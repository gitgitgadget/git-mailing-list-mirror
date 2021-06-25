Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEA7C2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 21:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D056B61921
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 21:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFYVjY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 17:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhFYVjX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 17:39:23 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17435C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 14:37:02 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id v5-20020a0568301bc5b029045c06b14f83so10779227ota.13
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 14:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=WaM30xGyV2d9UxQH8vmc9nYRHEWJhE7npm21xJznWv4=;
        b=HXJSuW4WteNrE6LJqCJyxV7T9eMNkQ6L2G2iXzoKLdxZwDVUPN/g9TLv/qdsY4JB/q
         uKNdKVksEmJPtb0e+HzSlEIpL2F7I2N10MOSpg/UqGJ8+5EncDi1uUj9FNQzRk4CbsL2
         V2f/5DElMozm4X+s460QXr1VenUPdy1S/7LP5zCHgbBPfvR0LPJdFYZ9chol4AjxRlqZ
         pmEdnV96bc8I8AHk8cgJz6aaNPdhbNTSWZO2Sv8KWrWqnEDOQQRYDzo8buvxwWrcFeHX
         +GBwf9BzCV9zTdbn1e2zBtUCttXPbGIcbOrPll+Asq44FX4ONs9bt9cDQaq4Lv00iPXO
         V1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=WaM30xGyV2d9UxQH8vmc9nYRHEWJhE7npm21xJznWv4=;
        b=PCXNKL7hPzuKcsNGm8dsnI1Zp67v67iaNwlZgwc65doytAXbhsQMqfzEFo0lZmaQZZ
         KBZKDJ3aZFy2MnOg0D6mbeeafa6Qmjb75i3Wav5KzP7kvuSsRZL2Q17K0XbG/HSjdVIc
         DUZrGmtJv2M8d80+wtAlxPoJAeWKHRXqYjbTB853KwKPjX9BnghrE+W72BldAnwx5Qgv
         OrhZRbrisRsnpv2zJuxWlXw8vnEDSTo0RVYbPKm3z3v1daCxBi4luTO4xyJEKRBTz+oM
         kIlCgY76O8F0LoUSxauy62MYyyrjVl6N+g+gan1A33N29/wEpN3IEEZaI6Zd6oR+2fWc
         y0ww==
X-Gm-Message-State: AOAM533MIN0waRayi7yD7H4ZLPhyHKnR/+kYYCeJlU8iq9u7oeEamprF
        qN4zh3hETbXF1ak6k1BeRd4=
X-Google-Smtp-Source: ABdhPJzudmfDI1tmlbIaHcQ7gbhUsQkT2J5hg49c6JSBHcgLOshmamKRsavFAtIqmajH+HHZeXgVbg==
X-Received: by 2002:a9d:7c95:: with SMTP id q21mr11543702otn.111.1624657021519;
        Fri, 25 Jun 2021 14:37:01 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id y84sm1564799oie.56.2021.06.25.14.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 14:37:00 -0700 (PDT)
Date:   Fri, 25 Jun 2021 16:36:59 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Message-ID: <60d64c7bc3d52_118e82088a@natae.notmuch>
In-Reply-To: <60d6138c185bf_cc8d20811@natae.notmuch>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-2-felipe.contreras@gmail.com>
 <b4e612ba-21c7-3bef-d113-0f070449cd87@iee.email>
 <60d49748b8538_2fb2082c@natae.notmuch>
 <c2170f74-b93b-599b-1fb4-45b013c7bff1@iee.email>
 <60d4d75e7622c_242620854@natae.notmuch>
 <93084036-804d-4c52-2836-42efd5deba1c@iee.email>
 <60d5183a9e34d_3a20208b@natae.notmuch>
 <87im22xpp4.fsf@evledraar.gmail.com>
 <60d5b430f2f13_ba7520890@natae.notmuch>
 <87czsaxksc.fsf@evledraar.gmail.com>
 <AS8PR02MB730230DADF38B6C572CE8DC39C069@AS8PR02MB7302.eurprd02.prod.outlook.com>
 <60d6138c185bf_cc8d20811@natae.notmuch>
Subject: RE: [PATCH 1/2] doc: pull: explain what is a fast-forward
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras wrote:

> Yes, but regardless of that for whatever reason it's already part of the
> culture, and people are using fast-forward irrespective of the original
> meaning:
> 
>   "They fast-forward to present day ten years later, where he has been
>   hospitalized and is on life support." [1]
> 
>   "So then fast-forward to now and, like, six months ago, they found the
>   script and called me up." [2]

Hmmm,

  Fast-forward 6 years and all this code has been substantially
  overhauled by several folks over the years

https://lore.kernel.org/git/CAPMMpohp6+jW2C0ewfYEp3rrwbKSqGVa94LRgQDcKJvYmiANuA@mail.gmail.com/

-- 
Felipe Contreras
