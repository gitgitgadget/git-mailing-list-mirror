Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C577C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 16:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15CA2208CA
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 16:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+3IFset"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgKRQq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 11:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgKRQq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 11:46:57 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07E9C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 08:46:56 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id c66so1770726pfa.4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 08:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=w1DRZQTKVBy4L+DZdQr+4BVdmMPwMp5a9GadbhLFqZ0=;
        b=o+3IFsetBgXCqJKE5+zj1J04sdXODiTpeZNzTfNooPcWSKlwbhvzIdayGjxOuAl2tZ
         /HRcerDaoT4eq1CnEScroC2pvX6T2Ka8L1jvZBBgeusj+9bhkh/fe0EjsCMGzzOsbQaU
         1UcpFer49Sf64HT9TbbG2DW62+nhrlbEitQghediGz5iGYmdw3jbGvxOljD/zEz8BJGf
         lTlR8L9UbYmqYPGh61la3RFhoc/29xGv8fhhDokIliUnFeztxfmMzMVu9QzY69ecMmNn
         NcBeuIfFd5sENcsYXqUAxB6bob3mpCxfIRaoOfv8KKRpHi8iRIlJ6YMKd264Qx4sQo5I
         uBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=w1DRZQTKVBy4L+DZdQr+4BVdmMPwMp5a9GadbhLFqZ0=;
        b=PgYvdGkNA/5h4KFQ8KK/5EuIBYQ86Cxr8TwTvYa4G+C5N+lzMvu/MApQ1IUUW5u7Hb
         OAVElrtAFECL15/LKLh6ioRQ7LL51VW6B3U+NJN72PTe/wTKZk3Tv2Do4bPWKaeYVbW9
         tQL3MGyTsq05w5QiJrtwf+Gp2r9NbXQD+qF2pY/cqHonL7rV0r6yM/UDcWJSifkovtWc
         VlJcFQ4QlPNm6+4ZjNHYm8RQ7j1LWL5e93eIx45wSy3Y+6x05IAokplItv2PLMZIU5Z9
         U0k4Nn/LiG3VHHxgN4LA6kXXSDiKJniA90SHBwobYdhwpIKWvy95ZO307uWEtlj2ZmIP
         3qvg==
X-Gm-Message-State: AOAM530mFLROYTqJxSdxgrx6E6d21y+RyDFZbYKgSFN2tHplvzj7d3nY
        mHhM32ho3ZF4nOzg0/CNwp1LrvPWTevXthom4vE6tAezEnWIbA==
X-Google-Smtp-Source: ABdhPJwELFfn/jhPFhe+4j88cZDyxgNgel422dm+Jb8aIklpyTBqQlY/DfIlX4s14WpAQOj2idf7jIRqauRSaq8SV5k=
X-Received: by 2002:a62:7ac2:0:b029:18b:c5bb:303d with SMTP id
 v185-20020a627ac20000b029018bc5bb303dmr5233599pfc.71.1605718015941; Wed, 18
 Nov 2020 08:46:55 -0800 (PST)
MIME-Version: 1.0
From:   Peter Hadlaw <hadlawp@gmail.com>
Date:   Wed, 18 Nov 2020 10:46:30 -0600
Message-ID: <CABrPy+GrSB87mFm5tXsXkC+OKg6NBxUJA5b0NYsa18a8EbcrNw@mail.gmail.com>
Subject: Keeping the original init.defaultBranch config value
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Just wanted to confirm that in order to keep new repositories
initializing with `master` as the default branch the command would be:

```
git config --global init.defaultBranch master
```

Regards,
Peter
