Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28962C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 01:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41FC2078A
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 01:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoYRPsdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389933AbgJPBtJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 21:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389331AbgJPBtI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 21:49:08 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BABDC061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 18:49:08 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y16so882414ila.7
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 18:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eXHAbMx7fKZoTmr6gMnEUXNRWtAmNympcOysEOsp3e8=;
        b=OoYRPsdYHTc50G+32YkXAsqK5l5n4DyXwYTsDjziZfM7p4QGQ7WyiyGQ9Z5zEU1H8d
         N1zN1/L8t5ExlwGYegsMyJGam5EXBwes6FN/lU2jhwda6tWJW6yfKfE+iFw1xz3I3F3r
         3JHjTVsn2Q534G4mxXJoIRyVYLuAvuRH1mHgYLzP2dBg1Lgxd8E162h2RXm0cOLWUgnl
         UMZcYNHHAsZlr09m9qZf76G5xCSgR5ebby7Fjq9K7w93fERoSV/FxE01wzm/h5//ycV8
         ZUSGB9tFHxcl7r9DPKfSyzWvclrF35pSiidsveTkdC8c2wkVUeUWLI6IuPUeF48sVt8d
         iRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eXHAbMx7fKZoTmr6gMnEUXNRWtAmNympcOysEOsp3e8=;
        b=CvEynNA5Q4RpXND37EdlIBe2+ilH6iYGQt/g1Y/PEccSC0c/D18LhCjeDSxgLfItzC
         ObEvkMfacMy4MaZC/wG3jaX8oJDLp/wpo6W9ib6SrW/Ul2iQU2I1+GO717dl+yyf06yD
         LLY1HNytwLIziIe5OxghFQ+ro1dMYFbT8qharw3/GM1soiMlS7izNsvZf94jh+pVDThC
         L4+g5ClICDRxcyLI9O3wxqAmCffWioCyturrLxFpKwywIEaVEgLvJNKsucw4edbJngnI
         IrH9EVl5++bPMMT6NMw5TJaeOlpynVJLHdCUv91CRtSBritAqH4VmCQntTRwni0xxcga
         7VFA==
X-Gm-Message-State: AOAM532eLIGg2hoCPY7AYgiKTj9bOEn1GxvYyOcpIzeBnz9uUkPWcoNd
        CmU7bxg7xn1uvUHuFMHJ/87oBDIYjfk=
X-Google-Smtp-Source: ABdhPJzXeUOHaqsG0JM4DOqZmclBcUmqCtItqhNzgOVeRDU+VNIv0JuhAUivqtBwLlT5jQN3QrmkUw==
X-Received: by 2002:a92:85cf:: with SMTP id f198mr959433ilh.158.1602812947995;
        Thu, 15 Oct 2020 18:49:07 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id o17sm761315ila.47.2020.10.15.18.49.06
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2020 18:49:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 0/1] Clarify and expand description of --signoff
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20201015215933.96425-1-bkuhn@sfconservancy.org>
Date:   Thu, 15 Oct 2020 21:49:03 -0400
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <59E3B060-63E3-41C2-A7C4-5B2C888F8D68@gmail.com>
References: <20201015215933.96425-1-bkuhn@sfconservancy.org>
To:     "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bradley,=20

> Le 15 oct. 2020 =C3=A0 17:59, Bradley M. Kuhn =
<bkuhn@sfconservancy.org> a =C3=A9crit :
>=20
>=20
> Documentation/git-commit.txt    | 13 ++++++++-----
> Documentation/merge-options.txt | 13 ++++++++-----
> 2 files changed, 16 insertions(+), 10 deletions(-)

Since the changes are exactly the same in the two files, maybe
a preparatory patch that creates 'signoff.txt' and includes it
in 'git-commit.txt' and 'merge-options.txt' would be a good idea ?

Cheers,

Philippe.



