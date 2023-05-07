Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD00C77B75
	for <git@archiver.kernel.org>; Sun,  7 May 2023 21:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjEGVrq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 May 2023 17:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjEGVrp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2023 17:47:45 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7482C59FE
        for <git@vger.kernel.org>; Sun,  7 May 2023 14:47:43 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-195c83a9ed8so1768879fac.0
        for <git@vger.kernel.org>; Sun, 07 May 2023 14:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683496063; x=1686088063;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzDmcRPmdLWBH8ygwC8gRed7Qe/firFIjGFuU0ZRvD4=;
        b=nr7ezWgM1INsXRm9Cq8swU7IYS4O0cGjuSLskn/8QDh0o0o+Lt/dABKavcbNwxsHe3
         ewvViaimSOiW0HBfMA4MQEjBCFPIxyeSkH7ts/zqffuntxYnW2IxnkU3eeCeYKxgNR7E
         qPpQNTzTxcEzsct18HJr41IQ5XM5hJuZPGTDAKiJvn/AdVgP+1xYnbtOsX/p33PjfumL
         M1YZkuPFDcsHRCddr6dChHXsTBX3ivTh2jBkukeRNY/HDDhuDgYtrXCK1bVqiRLpjtTO
         kwf9IrKBxFz1a2UKOF/0eaDeLhQCzpsgILdUrgKcW67FFXtZg34oPsxmeORS50N5EFCP
         ELdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683496063; x=1686088063;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hzDmcRPmdLWBH8ygwC8gRed7Qe/firFIjGFuU0ZRvD4=;
        b=e0qDFz+DfJGwBswI7qKjggwxRr+u6xPK0mvrpZB69v9YiRSWaLwVdwvMNk2MA5CGo6
         620R4NbjWlbnW/QISQsUMolxNAqqPsMvVl81YfpIjvixxyZ+oEUxiPHoRnXDrBymNjIw
         rALaH69VVgRUSmX8lUHq/F6R0Q1Ga9r0+TpEPQLrT8MKiAZFlRCrSA2u0wx5895vUP/C
         zS4hGmCiKd/91aBbEzaAKNN0pmw2fMlmFJcGt2oE1Y6TmgW0406goFykslMbT8ja6tvq
         ikjFjJjyIZXN5USPHcf3NPw+H//PtR4zYiAjCODf/B/sBlf1TmSvXzrPEzLskP6Gyigq
         cNaA==
X-Gm-Message-State: AC+VfDyVZwA8cMHC87BejoFvRMKCvYnjD2opK4NmsorQBAwUksXOSPDz
        x6MApMNVgBKypEW6R+7+0kH5kYccUbg=
X-Google-Smtp-Source: ACHHUZ4PxGhK8cJqSZTTQTFk8ZVYDmqd7ZUGd306wlw8x96OcrqR8ncCDt/7bGjcoWeKgJNgZu6UzA==
X-Received: by 2002:a05:6870:898f:b0:192:70ca:da4 with SMTP id f15-20020a056870898f00b0019270ca0da4mr5218909oaq.10.1683496062757;
        Sun, 07 May 2023 14:47:42 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id v4-20020a9d69c4000000b006a7b28e052dsm3540479oto.40.2023.05.07.14.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 14:47:42 -0700 (PDT)
Date:   Sun, 07 May 2023 15:47:41 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Message-ID: <64581c7d6d085_4e61294e0@chronos.notmuch>
In-Reply-To: <CABPp-BGk-s+4b+OHi9FDXjwz5BeZPS8qb4XiJ8CVwkt8Siaq8A@mail.gmail.com>
References: <20230502211454.1673000-1-calvinwan@google.com>
 <20230503184849.1809304-1-calvinwan@google.com>
 <CABPp-BGk-s+4b+OHi9FDXjwz5BeZPS8qb4XiJ8CVwkt8Siaq8A@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] strbuf cleanups
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Wed, May 3, 2023 at 11:48=E2=80=AFAM Calvin Wan <calvinwan@google.co=
m> wrote:
> >
> > Strbuf is a widely used basic structure that should only interact wit=
h
> > other primitives in strbuf.[ch].
> =

> "should"?  I agree with moving things in this direction, but the
> wording here suggests there's a pre-existing directive or guideline;

No, it doesn't.

"You should see a doctor about that cough" is not a directive, it's merel=
y an
advice.

> Maybe this should be reworded to "This series modifies strbuf to focus =
on
> string manipulation with minimal other dependencies"?

And ironoically you use the word "should" to provide your own advice on h=
ow to
avoid using "should" as an advice.

I agree it would be ideal if strbuf interacted only with other primitives=
 in
strbuf.[ch], so I agree "should" is a perfectly fine word to describe suc=
h a
normative statement.

-- =

Felipe Contreras=
