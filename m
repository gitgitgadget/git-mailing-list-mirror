Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000A6C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 08:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237754AbiLNIaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 03:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237757AbiLNI3o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 03:29:44 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2F31EEDF
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 00:29:43 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso6312239pjh.1
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 00:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pLRN7LUdaUBkJxh8lnszMtpwHOqbdGTALUarmRerP7E=;
        b=DRU3+74E0Qp+khWTvVKQ3AMkNVMq1Z2X5mrqEWFey4XWBTq39hQWmvHX2GYS6nMDSv
         jqxt7R78SgkTnyXyDvy6BrAmQiCKaG93VXOEtjHMox7sYsIzW95g2XL6yi0Db5uWLvxI
         Jhdic0qG7HIk6kdeCEP1946jUeW5KdQmENsRv0ysdtoSI9wdyN8yJ9RoguQgLapQ0S2M
         0L2kF+vfq1sTgjHHnqY40ttaJ8wGUh+lpuDpMhpJ3g6wC016wpItDSzEVFnBRS29Iy3U
         jrd1VxzzyZ882tIiKSw1TfqLC1BK4FSKJ9Ozg0FiykQylKg1jyhUZjzmTRcjVCdjJHlS
         4uRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLRN7LUdaUBkJxh8lnszMtpwHOqbdGTALUarmRerP7E=;
        b=D2u/Z73OTxVAnhk9O8vLBesPK4o0llyz9mIm3DkpN1V5K4b9WtmTN8PcD+DzuC5n/x
         Uvgze9WptdfH3gL+fAIl6f9ZmMmH6V+Uz0+JNy9qffyovXFM7V8vuvP4uEnLbIst6DwD
         McRtsMBUBcw9w2ayi714LSPSR96d4FSUyrFJ0Ucy4EOaXrXNwCjCclCjKSpB1gGJ7Tzz
         HVf0vyX5ON755a+VAoUCvkdS1O4Tp7WjI43yh4rB/5inbrT2ZGikMoupawpDTbG9sBLz
         GPzLshTvaYIXXqYOtHpiHTISNuZKroeWmp6YMpEU5KST3JBQDixPrKsmtlQRH8HI2tcT
         wItA==
X-Gm-Message-State: ANoB5pl6lvkUXxa5CvMshAsuzi7FAb0u1Qt1JB2K6/vrDR7yaWQkgQ35
        1vyFJWdj1kyZ3s3aTf2vdIGXmeXJfZDD3w==
X-Google-Smtp-Source: AA0mqf6c0WTpcgyAEXDHByt+brWmY0LvBjj3bDuhhN6ZwlKPEnwQwbizzkEJbabd1q3k3IodZCvtzg==
X-Received: by 2002:a05:6a21:8cca:b0:a4:fa9d:d2ee with SMTP id ta10-20020a056a218cca00b000a4fa9dd2eemr28902700pzb.46.1671006583086;
        Wed, 14 Dec 2022 00:29:43 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id w189-20020a6262c6000000b00577c70f00eesm8890991pfb.22.2022.12.14.00.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 00:29:42 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] cat-file: quote-format name in error when using -z
References: <20221209150048.2400648-1-toon@iotcl.com>
        <20221209150048.2400648-2-toon@iotcl.com>
        <93d61412-3786-b2b3-3fe8-4574336b08fb@dunelm.org.uk>
        <xmqq5yekyvrh.fsf@gitster.g>
        <ddae1940-f58f-e410-7606-d0bcf8d06cd3@dunelm.org.uk>
        <xmqq8rjdv5um.fsf@gitster.g>
        <1ea2be75-f67c-fa99-12ed-139825ec5c29@dunelm.org.uk>
Date:   Wed, 14 Dec 2022 17:29:42 +0900
Message-ID: <xmqqo7s6wfpl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> By default quoting also affects names that contain non-ascii
> characters. If we're worried about that we could only quote names that
> contain LF but as you point out the answers are given in order so I
> don't think there should be a problem with calling cquote
> unconditionally. (As this option has only existed for one release I
> suspect there aren't that many users yet as well)

Good point.
