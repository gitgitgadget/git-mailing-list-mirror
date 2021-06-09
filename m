Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3C4C48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 20:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 365A4610C7
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 20:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhFIUid (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 16:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhFIUic (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 16:38:32 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88432C061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 13:36:23 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id q5-20020a9d66450000b02903f18d65089fso9046020otm.11
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 13:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=wkC/Tf3oi+kyhSrwAdWEcm0VtlfI1NqASNy9a8E/mAQ=;
        b=tcIDLetiqbNrdUO2WOh2V85oYNMPjgg50V0XLbCz2YiuNFFmlM4zJiuf0FQvrUDHOb
         DDzFzKoZauVlEAjTFKptEGvsPQO6CAwfF4j/YPE7NERCOLltXwIWHLO0+oiKcWJ1xG1S
         PSo3uhh4klt6W2ICnsZfzz3YQgO/FBKZlOObK5RJYifvDTilVz/YWn14OUxknGaKbyff
         WAZu8u1hY2JNgIfozI5aADruJBKk8qHuhrk4sCt6tnJ4BbRFMLDUKKW6bzDxPmfG1oeI
         /32zSRp/IUAJNAbEJDLmiTdjDxd8D/7Yr5mH6hUxze+7cIS4hMCFmM7EQ35c9g4OaNVE
         cROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=wkC/Tf3oi+kyhSrwAdWEcm0VtlfI1NqASNy9a8E/mAQ=;
        b=c6U6STeJvnzjHf9n6+N8qMLuvpZyZkCXQRqzqhj/Fw2/f70eWOwTlOtMbD49k+09mE
         wlrHdMcHvtfr+LVFTFWJBqM4uG8XH6N0zoS9yQBbOrnj9vzm+BgC563apqhttjDbUWn4
         29ZC0KVEpv2Z75/O1/NrBykATaUPSeBuw6sfldDvUpB+jykva76YHw0WLOmnNcRUvcHt
         duXoMOQzaZqFD6rIyIl3hwZgSZe0FeFo65/YBg3CuphSD305wk+Xlu2pNwtkZeHUwxe0
         7ditgU0TQTzKo7BLAPLIVZTFkKvV+UAzQxxBwB0X0uS/eul9E+tsIQ9nceiy8tGXoPSa
         nGeg==
X-Gm-Message-State: AOAM5308ZXWmO7tr1mnNl3KHBbycGk1pdjlfjHLEuOHYz4uAnSvghwqN
        C3+QQSZdtjgGGPCmfmFONDYpf6JtjbI7GQ==
X-Google-Smtp-Source: ABdhPJxs81GSNjD+/82Ryw+w5PVHNS6fYli4KWyS1ALjaYw2Q2pNA7i4KkNlHJPq1/QFKHO9UbUrqg==
X-Received: by 2002:a9d:6484:: with SMTP id g4mr1033344otl.331.1623270982963;
        Wed, 09 Jun 2021 13:36:22 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id c205sm161674oob.38.2021.06.09.13.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 13:36:22 -0700 (PDT)
Date:   Wed, 09 Jun 2021 15:36:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Andrzej Hunt <andrzej@ahunt.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>
Message-ID: <60c126456351d_aab462081@natae.notmuch>
In-Reply-To: <fcb0eaee-6ae1-f2cc-51d5-103eea64532a@ahunt.org>
References: <87czsv2idy.fsf@evledraar.gmail.com>
 <fcb0eaee-6ae1-f2cc-51d5-103eea64532a@ahunt.org>
Subject: Re: UNLEAK(), leak checking in the default tests etc.
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrzej Hunt wrote:
> On 09/06/2021 16:38, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> > I wonder if that shouldn't be in DEVOPTS (or even a default under
> > DEVELOPER=3D1). I.e. you don't need any other special compile flags, =
just
> > a compiled git that you then run under valgrind to spot this.
> =

> I'm not familiar with git's development conventions/philosophy, but my =

> 2c is that it's better not to enable it by default in order to minimise=
 =

> divergence from the code that users are running.

It woudln't be on by default, you would need to turn it on with
`make DEVEOPER=3D1`.

-- =

Felipe Contreras=
