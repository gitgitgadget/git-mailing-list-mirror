Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509BEC2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 10:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A65A20768
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 10:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=portswigger-net.20150623.gappssmtp.com header.i=@portswigger-net.20150623.gappssmtp.com header.b="Y+HWaSNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896617AbgDOKq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896448AbgDOKqR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 06:46:17 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AE3C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 03:46:16 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id g184so744725vsc.0
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 03:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=portswigger-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CxU18abXAANUSNaxLRSrKIoOTEgCVl8YcmxrJmQl14o=;
        b=Y+HWaSNgdzV9wiJfpx2edg69w8EJDzHZrACQuIe/T9VdAc7fq+6ZqweGsI90kxxV2K
         +dxtTuuDOtXZeXPWEF/YXu70TwOxV67v2K9OhTEg9+KNWey426BQJ1cCCiakEtV0bDQd
         N38BETZpwwa83/bSk7X0dcreHkSzG+qZRjTpK6pYvsqx8BsuWecQhPGxX1Ku/Q1+/KM9
         DaG7bWe7nrOX38ak/2OBg77lyeNkoFyFNeILASbMj2xWLUsM8peTTvVN8dGSW4nQojlQ
         m5KVkKxUFu3MSUYdgEjxtNMk3iB4UEh4AWcwIN9sMZ9CRCCNuOQXRPn1rfCv+LZt7AOb
         a9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CxU18abXAANUSNaxLRSrKIoOTEgCVl8YcmxrJmQl14o=;
        b=icq0nJAUyqBRupEuK8HCK6G3swtX4siVb1sQutIMQNLbfwpZChZyYGKcXKfy9UN2WX
         0AzrowxOfnrBWlOXrPdXiiHwG0KT8UUM3lfSNv/7K8jZ+OdRJApasRRsMaI9GK/qLig0
         1OReYG1XkdsAS2H4P6pRXkasinBF7tKa1YqO84dQG4020ufFfErs51qtITv1zV9gPOTi
         PWw2/s0KW2zPTvLPq3JsKR3fpRkGIJkkIJKj+SVToDvugPR4sW8mvywyihyINbvUnytZ
         JChZuOKOAsiCe+ojr7U4vagHj/p1UyNnEJzLypqDtEhh2ssy563RD/KditZG9NFh8pDM
         1fjw==
X-Gm-Message-State: AGi0Puaj9jsiNRJdSSxE1q46b6bytUHFsMZbB0H8DGq5/zOEnvFF30Qc
        1zszx9PVJkkQB9dBc7N/zx+laq9umGBvmAX3xqWUvIcrJDseDg==
X-Google-Smtp-Source: APiQypKouU12s+n+1BRMf392Wqs4Wolwq0Am9WSr2HyrESpV4Lg3TtV/MLIwejqbJTYgu5wSxJrE3TxDqFUL8FlDmS8=
X-Received: by 2002:a67:80d1:: with SMTP id b200mr4056314vsd.76.1586947575346;
 Wed, 15 Apr 2020 03:46:15 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Bannister <adam.bannister@portswigger.net>
Date:   Wed, 15 Apr 2020 11:46:04 +0100
Message-ID: <CAJQu+bp9SrzaMBuMv1UC8y8rJGn15MAsVogSCm_DNDKRMji1+Q@mail.gmail.com>
Subject: Media query - Git flaw
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I=E2=80=99m writing a story for web security publication The Daily Swig on =
the
research that uncovered a bug in Git:

https://bugs.chromium.org/p/project-zero/issues/detail?id=3D2021


I was wondering if someone who works on Git might have time to spare
to answer a question or two briefly?

If so, this is what I was thinking=E2=80=A6

How did the disclosure and patching process go?


What is your advice to Git users?

Thanks for your time...

Regards,


--

Adam Bannister
The Daily Swig
https://portswigger.net/daily-swig
