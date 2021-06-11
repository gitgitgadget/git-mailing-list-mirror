Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7378AC48BE5
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 16:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C6C0613EA
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 16:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhFKQEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 12:04:55 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:40485 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhFKQDw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 12:03:52 -0400
Received: by mail-oi1-f176.google.com with SMTP id d19so2233958oic.7
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 09:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ypkGoqsm1hlZiCX5eGr9IjVTCQfiBWeh7Z4pxL36sxk=;
        b=kds9LgiTzL4qlrMgIA6LD2KGdGaACUWFK4kae1NCCtdW8Nlc3bqIGrmW07VzGSOCE0
         977ufIRebY/UnDEBDRYM1apY4CBLvFMjL7DY9/WT9FtGGoRQGZpHwRFQwAxjjY0hga48
         ujgRzTMKimB0ZCf+Tq9xP0/DpiCpd1hDy9VMWp9TyZwVJAQuZWAG/CrcS4DJewA4vV6U
         mTql5FlbjmvKgRRqKyuS1hWlAR2oKFFQ75et11Aj29DYkOS4HXfeYC1u9OqO6EL1sNEC
         I4gre5mMPLml8GxTjj4P6B7BVjrxJODQRu0SpELqb9C6MbraDvvUkaltWOeR6POsTUz+
         w5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ypkGoqsm1hlZiCX5eGr9IjVTCQfiBWeh7Z4pxL36sxk=;
        b=Hgeg6Ag+uZ5oC+usR8HmLfCqtboKUeKvGWjT9AZ5t9IvzyLx0h4g+szBZ/vi/bBeD6
         jBKw1WVOdQ++F4L8eTBgm2Ad81j74yWdb78GVcbrlEnBRbqChw9j624BWJU1MAp4Qs2B
         5I40fbt8C+U2AkJ7sNy1vllGtI2o/K37ElmeKRtVDywU4iHv7wrzahLgAhjoUIyry6LW
         copvwzmrRRUqW1j79rhvU/THFMWBeN44Z/TNNg8I8qwpnH6hpap695gtl8sfC8v1uAYu
         uGzCv/48KjX4Ph9jE8GnnpW/dO7qdMsS19s9ctgIL76sdqBFcj9JARpqz95IpoCNT+uj
         m1aA==
X-Gm-Message-State: AOAM530QmXmkxYji91byO52DCCdav2J6TFIst/BfpYl6G2o7F0PXbUp1
        girC7xmrcWhDhK73LkxinB4=
X-Google-Smtp-Source: ABdhPJw+NKka7akQNgjkDn8Fuu1hoe/Ay1JaFRdSbT5zEfDhD5o1+K/Vszrq/EYLgUGNAiOfJ7oUvg==
X-Received: by 2002:aca:4dc3:: with SMTP id a186mr3528089oib.63.1623427240398;
        Fri, 11 Jun 2021 09:00:40 -0700 (PDT)
Received: from localhost ([187.188.155.231])
        by smtp.gmail.com with ESMTPSA id o24sm1331842otp.13.2021.06.11.09.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 09:00:39 -0700 (PDT)
Date:   Fri, 11 Jun 2021 11:00:33 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>,
        Phillip Susi <phill@thesusis.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60c388a18b658_85c8208bf@natae.notmuch>
In-Reply-To: <790688e5-6816-9837-85e7-2fdbbdf24169@gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
 <60be91757c6ca_db80d2086e@natae.notmuch>
 <87czsu98ar.fsf@vps.thesusis.net>
 <790688e5-6816-9837-85e7-2fdbbdf24169@gmail.com>
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:

> Singular "you" had a similar backlash in the 1660s as singular "they"
> is having in this thread, but singular "you" has lasted (and we use
> "thou" only to signify someone using old-timey language).
> =

> There is more of this in [1] and [2]
> =

> [1] https://public.oed.com/blog/a-brief-history-of-singular-they/

Let's see...

  In modern English, that=E2=80=99s: =E2=80=98Each man hurried . . . till=
 they drew near
  . . . where William and his darling were lying together.=E2=80=99

Yeah, that grammatical singular "they" indeed, but with a semantic
plural antecedent, so no, that's not what you are proposing above.

I'd say leave linguistics to linguists.

-- =

Felipe Contreras=
