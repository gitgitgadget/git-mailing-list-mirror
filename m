Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E4EC77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 03:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjEQD6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 23:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjEQD6W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 23:58:22 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFEADC
        for <git@vger.kernel.org>; Tue, 16 May 2023 20:58:20 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-25344113e9bso168524a91.3
        for <git@vger.kernel.org>; Tue, 16 May 2023 20:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684295900; x=1686887900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99ta+83ei8pNr9acXuQ2Jr3NdtXT5AY1Ae3H+WGH1f8=;
        b=M++WxlUZ51KmE6Xye5QW0tkKWR3kAUcPJAh4o6rAOVX4INomGKHFU2mDgikYAhaDXV
         +hTUoRWi+UPK/7DqJ2rO7ovLVI0gcHON0qbigW9di+dJzt4hV+qZ41WQptBY6AKgZheh
         FIS7fJzm0jECvMBWSbWhw4d5EM3IrtWTEfnP28y1Z71vwn5zxde3aGCCoAKmp03OAgCr
         fXu5hxwH1/AH115qp0YGTCfNgi0nSf/1F4QUXvE8FitxgJwCAJwGL6f1zSo0s2WRHULZ
         U5ghmrfVzS3tFoN4YgWbHPVqTPOH5OK66o6RzEt7xH+EuI6T+kvYUzVQpeU63A1/LIl5
         foEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684295900; x=1686887900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99ta+83ei8pNr9acXuQ2Jr3NdtXT5AY1Ae3H+WGH1f8=;
        b=FnPkh3vrNfudGwYkj+bB7HeGDv+Fu4BICVQdDXypD1KV4djips83E421hXHihgOhVe
         NrKqdd79/XG1TVBAPJOoYesSKiSKATAtPY9O5u9eSS4EYiIFoc2ze8Q1hIfHENzoA+zS
         G07M5K+UVN2YuwL3T+TN6Plh4STDutET5Ahb+NgMIGWolqndDIN8bI7Op//kRx7HwbiC
         UxkyBQihZE6eemg05xF8cvbN9AnUwG5IqAB6h9JzhNC1GlfQr8YxvKJNhXCCxvBqDlEE
         VoKmAYZmiIlIvEzeITeOG+npIsRRpFtak0m71U9sezIscVl4umV0b3tKnTUk4rTIRGqa
         vokw==
X-Gm-Message-State: AC+VfDx0S0vmHYPFhwrREf8H9P8KE/yEbciigeSZiUa6m+wkixdHuPu0
        NsZ6kypTUzcRJBT2vkn9Elg=
X-Google-Smtp-Source: ACHHUZ4sPPAMsJ/da4v2ZRMSwA+bbo7WU6M36PqycB7UVGPzZZQ3AzcFuiw6wZ/BVi2bDSOIuhT99w==
X-Received: by 2002:a17:90b:390e:b0:24d:fcd2:bdad with SMTP id ob14-20020a17090b390e00b0024dfcd2bdadmr37431213pjb.35.1684295899884;
        Tue, 16 May 2023 20:58:19 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.49])
        by smtp.gmail.com with ESMTPSA id i8-20020a170902c94800b001a96562642dsm16196547pla.277.2023.05.16.20.58.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2023 20:58:19 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, code@khaugsbakk.name, dyroneteng@gmail.com,
        git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v9 4/6] notes.c: introduce '--separator=<paragraph-break>' option
Date:   Wed, 17 May 2023 11:58:12 +0800
Message-ID: <20230517035812.4210-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.41.0.rc0.1.g6b682d90.dirty
In-Reply-To: <xmqqttwcus7p.fsf@gitster.g>
References: <xmqqttwcus7p.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> I think --no-separator maybe a better name, means that not any separator will be
>> append between two paragraphs even a newline.
>
>It would work as well.  Is it something we can safely add before
>merging the topic to upcoming -rc1?

I noticed rc-1 will be released at this Friday, I will post a new patch
about "--no-separator" today(UTC/GMT+08:00).

Thanks.
