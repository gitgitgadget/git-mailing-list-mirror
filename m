Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838DCC001DB
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 18:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjHHSC4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHHR4f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 13:56:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AE1AD0E
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 09:25:36 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so49460655e9.1
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 09:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691511926; x=1692116726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXJnWICzKp66TgEZklMk6jY4XWmG7TYYEflXRiTTLgI=;
        b=BTe4JDGzN6rIzACaDyTarwbLZvT19fJZC5iqmNIv+LSOWn/L8HQd2I6vzyNYI2VeTU
         GlOsLmLqSYrGk37oHBmWmmtWpkycwEqEWcnkaXlOfe2qOkq7fNv3hOCnITm98L+gm29V
         0U8QPzoJ+jUdxDlbg4efdEI+pvhamwn5HTXT7uu5t9cX02f+g/wowQcl7qtEkavmg1xJ
         AKd7KZK7gBW0K6OqXoouU5LhFfaC5kWjmxUe6coNp3Ev+6zZ6Jqrkzy39ayDSR7sJmJj
         gyqtqNBaQNnPV01TjlIiJa9z4v9YfV/ufUYIA6a1dA0bIZ9gPP1UR2zczGzQYTAag+FH
         j0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511926; x=1692116726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXJnWICzKp66TgEZklMk6jY4XWmG7TYYEflXRiTTLgI=;
        b=bBgCOLLBrZFGalBAFui2QxOMpbB/r3UhMu4NYXojsf/rp1tO3NcRUFCYFao2ycnoC5
         +yPQGlRBaBrxKhdDM4rGFsEnClJtc4AvIBWTkXLkmFHv3Se6J5wQk7pNFH0zyurAbxL6
         t2/D+VqZjQpAEtoxc+xEE63sJ4NRCWPVbCE/V6KVDAHDQt102tX9rbPsK5sZWoFn9m0W
         BxIc+tIkOV0PuNsV8kanUJ/pM+DPYQ/aevxGuKCcl6OgixCc7Vfvt6dC44Vbr3XYKq4n
         uz3PNd2iSqQhUQUmFIrlW6xcZ8T6KmHihWRw7CbgFi1yab377d9vA1ILgb8c8w5IEy8i
         96Bg==
X-Gm-Message-State: AOJu0YziUD4JMLlEcfK8gAZMPWlyLBBTUYpR5c0MC4qFaWEb05H1RWxt
        WQBMcUpD7JACabtnbVhkMx19RgOWm/nYpbk8hlj+sAt5
X-Google-Smtp-Source: AGHT+IGLE4T5SxdrulFxsSr7tLo5N/sNP72VvLQLQi1RRY4i+dvqk1+9icUrCGBo32VbwYGZ/9095P4U3szkumWQr78=
X-Received: by 2002:a17:907:7607:b0:99b:c2d4:ddd8 with SMTP id
 jx7-20020a170907760700b0099bc2d4ddd8mr9778131ejc.31.1691483324360; Tue, 08
 Aug 2023 01:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230705060812.2865188-1-christian.couder@gmail.com>
 <20230724085909.3831831-1-christian.couder@gmail.com> <20230724085909.3831831-3-christian.couder@gmail.com>
 <ZMBQRRppsadqa8Ua@nand.local>
In-Reply-To: <ZMBQRRppsadqa8Ua@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 8 Aug 2023 10:28:31 +0200
Message-ID: <CAP8UFD3_XOtY-cetnO6sPSj3N-EpF+eq836Vv0v8jPDTSkVupA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] t/helper: add 'find-pack' test-tool
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 26, 2023 at 12:44=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrot=
e:
>
> On Mon, Jul 24, 2023 at 10:59:03AM +0200, Christian Couder wrote:
> > ---
> >  Makefile                  |  1 +
> >  t/helper/test-find-pack.c | 35 +++++++++++++++++++++++++++++++++++
> >  t/helper/test-tool.c      |  1 +
> >  t/helper/test-tool.h      |  1 +
> >  4 files changed, 38 insertions(+)
> >  create mode 100645 t/helper/test-find-pack.c
>
> Everything that you wrote here seems reasonable to me, and the
> implementation of the new test tool is very straightforward.
>
> I'm pretty sure that everything here is correct, and we'll implicitly
> test the behavior of the new helper in following patches.
>
> That said, I think that it might be prudent here to "test the tests" and
> write a simple test script that exercises this test helper over a more
> trivial case. There is definitely prior art for testing our helpers
> directly in the t00?? tests.

Ok, I have written a new t0080-find-pack.sh test script for this in
the version 4 I just sent.

I have also changed `test-tool find-pack` so that it now accepts a
`--check-count <n>` option. This addresses some of your comments on
another patch in the previous version of this series. As the code is
now a bit more complex, there is more justification for a test script.

Thanks.
