Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BF5C388F2
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 03:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 801FC2227F
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 03:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyF9vqYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443666AbgJVDKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 23:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440000AbgJVDKC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 23:10:02 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD2BC0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 20:10:02 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z33so119624qth.8
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 20:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=W8AfBFCgkh/JbQAjBk03LGTVITu3SWJZpNKSrp2xNyQ=;
        b=EyF9vqYCxlIXnDt8iM5Z3xP/rNcDQnuB05YUJV7XlHUGleeym3Oi+rMd6V6lOOeLwo
         eDu34F3ST7umfanOj6/5wvRrCYbOWCxaM5XUigXXvxfGGAEhdnMWYpK9q5Ql5ps/NK8O
         SGBNiJ6HE6hcxUd33JN4yT4jyvyp/lF4TBsC7ETFXuxnWVB4oViKMGFSP6scPuoEu5g+
         lljG3/LcbT/uV9pEiqQzH5kXojMNJ6WzZ7PcMcyx7RbDoQxJDsll6MkqPB4aYMjHPqBT
         KGuMXRNIacJ/5cOBT+ULanioIK7JLtaH3anQU0D6WTC2f2yRDUYEes+0ZA9kLd64lWI5
         dyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=W8AfBFCgkh/JbQAjBk03LGTVITu3SWJZpNKSrp2xNyQ=;
        b=PosW2+K2v+w/uZzny3kcAF1pe1N0IhTK11Li9e+U3Ux8di31uRE91N7kbb9rw3bgOk
         i6y9ELBgBFA7ZmE2wwr19pt1/p5SoG/HD+mDJLGVk3cEDrJBnNBEO4ffr+D/qmt12I31
         Vda73qmf6pZ3LRaWkyuB3zDdpSw1m4kHnyMIY9oOiChpjlctSIM3y53eI8atIbjHJM7o
         Y6gcf6dGQDnh7YbyNL91OlfSv8QvNP+kFNuJBfXXhqGgF94BYH6BMBcz9T5THw2a6ml5
         VLFyJbXP9nxVCJZJCog8kMETeDE3W9wmTIUKJywxHhqN9BL1nzQKas4FtWRWsV6bxThJ
         9hBg==
X-Gm-Message-State: AOAM531RSGHs3Kp5PMP+hnYtSm5WBX8zMDTUqfhNopNO8MoOOmA7iZwo
        lEIAcLToZ8vd+RooNXbXyTfcaQyxL088lQ==
X-Google-Smtp-Source: ABdhPJwf3BYcA5QI87A5l7bzQLjXK9wydbZsegvpvH/PshTKm0SaeSUNVy2qqogWNj1f3tKBFELVOg==
X-Received: by 2002:ac8:3016:: with SMTP id f22mr239304qte.340.1603336201246;
        Wed, 21 Oct 2020 20:10:01 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id j8sm304202qke.38.2020.10.21.20.09.59
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 21 Oct 2020 20:10:00 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 1/3] t: add lib-crlf-messages.sh for messages containing CRLF
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20201012224706.GA4318@flurp.local>
Date:   Wed, 21 Oct 2020 23:09:58 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>, Alex Henrie <alexhenrie24@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E00B1E7-DC57-4708-9D81-4402AD931126@gmail.com>
References: <pull.576.v2.git.1583807093.gitgitgadget@gmail.com> <pull.576.v3.git.1602526169.gitgitgadget@gmail.com> <f17d182c3bf5e758490441801423cdb0da17060d.1602526169.git.gitgitgadget@gmail.com> <20201012224706.GA4318@flurp.local>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

>> +cleanup_crlf_refs () {
>> +	for branch in ${LIB_CRLF_BRANCHES}; do
>=20
> Our style is to place 'do' on its own line:
>=20
>    for branch in $LIB_CRLF_BRANCHES
>    do
>        ...
>=20
> This would be a syntax error if LIB_CRLF_BRANCHES is empty for some
> reason, but I suppose we don't really have to worry about it here(?).

Apparently, not in my shell, as I realized I had misspelled =
LIB_CRLF_BRANCHES as
LIB_CLRF_BRANCHES (CLRF instead of CRLF) at another place and the test =
was
passing correctly (the loop was not being entered at all though):

$ /bin/sh --version
GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin15)
$ for a in $b; do echo hello; done; echo $?
0

I've fixed that in v4 which I just sent.=20

Cheers,
Philippe.

