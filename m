Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F05EC7619A
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 20:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjCVUOj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 16:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjCVUOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 16:14:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0803882372
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 13:05:19 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o11so20328933ple.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 13:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clumio.com; s=google; t=1679515476;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z41PP6WYUENlE/mR2N7ET4CqBBbGHbFYuzLyfePX50o=;
        b=HZ9Sk4gYttNGdJ2wLSY2QCsSKBTj/J0a7E0soVEbrELUizV4Lw5FPGxEjciDd9gXIx
         NpMLV825h9N+SsN4G6SLROkqI9FD94dfTTRctMeVkawGUJt0CuTaLBeMgpZ+52eRosQP
         KOU7a/mGS3K+7dWkS1cU++WhvhQsZ94pwnTOvc+uozOcKHE9JWXq4tcJteJcHfEqWfrS
         +6XjD1bUVX5q/a11dLjV17erPZmikkvDSnb93krdpmwDobmkvGEjMN1TZb0jtEwXhc5B
         b962UHvOZHckktODt8FyGrZqJME8Jc+yKEDgvkGpp6YF+gyPuvGSeYn1Lg7Ymd/39gub
         YwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679515476;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z41PP6WYUENlE/mR2N7ET4CqBBbGHbFYuzLyfePX50o=;
        b=3sD+84lkOa6N8DMvDJElZmOUXSGhC2hCWmpHhfgz4kshHeq2/VR2MSHmsKCn/RpfSP
         6rbsTLhU4eOcYEzARkjHPoepiBpfDMncnRPuCZWM0xce+4pt1NNi2yaemdXzbHgXJpOa
         mmYLUH/6wTtQuHpc12CRhBS9CzgwGvd1jUXuT6FGgdnaA8VIbSxtnwfq+V2UnDSYaMp5
         6R3D/flrGJ3tMbtxX9N4X8LIV1Q6SLPW2Zl+NOSYsm5znZePC1XDg3tub1wJ0hb+PPlh
         XQPIZiHX/9s5mIbfy7rcKtkeOZ6danKTf8erCr+KQKPD/PO9+CL+MggAuMF3Ez5qss0s
         TXCg==
X-Gm-Message-State: AO0yUKXN+E8RL7j2RQvoYF0xXb8C44HPVdQl2Lr9Nqtnjum38jdjwH6O
        Ic6oZabjaOwi9bwhQNEl1BJm5QubDoY4AMpchvVzCQ==
X-Google-Smtp-Source: AK7set9cDF2ejITrUMnJ2DwfvU+WzXircL5H1Z2bFrV8J/cPMBsf2vhq9XyRMN4sRDxMF8bLpqIU2A==
X-Received: by 2002:a05:6a20:6d91:b0:d9:d287:75dd with SMTP id gl17-20020a056a206d9100b000d9d28775ddmr513278pzb.50.1679515475704;
        Wed, 22 Mar 2023 13:04:35 -0700 (PDT)
Received: from smtpclient.apple (107-194-200-191.lightspeed.sntcca.sbcglobal.net. [107.194.200.191])
        by smtp.gmail.com with ESMTPSA id n21-20020a62e515000000b0058bc60dd98dsm10430697pff.23.2023.03.22.13.04.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2023 13:04:34 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [EXTERNAL SENDER] Suspected git grep regression in git 2.40.0
From:   Stephane Odul <stephane@clumio.com>
In-Reply-To: <4a103812-c4c6-a010-c2e5-4e42e9855c2e@grsecurity.net>
Date:   Wed, 22 Mar 2023 13:04:22 -0700
Cc:     =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C24D1B3F-AA4A-46E3-B746-5AA551F64E2C@clumio.com>
References: <7E83DAA1-F9A9-4151-8D07-D80EA6D59EEA@clumio.com>
 <xmqqttyejc7y.fsf@gitster.g>
 <b0f4b588-9871-8e59-e5a2-3f8745a7c4cd@grsecurity.net>
 <51078D7E-C325-4F57-96C1-601B4E102DD9@clumio.com>
 <4a103812-c4c6-a010-c2e5-4e42e9855c2e@grsecurity.net>
To:     Mathias Krause <minipli@grsecurity.net>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is great work Mathias!

Now that you have an easy way to reproduce, and I have a good =
workaround, I do not believe there is much more I can contribute and =
will leave this in your expert hands.

Thank you,
Stephane Odul=
