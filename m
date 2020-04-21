Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150AEC54FC9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C3720787
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 13:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neBolY2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgDUNGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728859AbgDUNG3 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 09:06:29 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BF3C061A10
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:06:29 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c63so14365368qke.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 06:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6HczBTZv9tDmoRGBtQpHV/NPlrKC9EXRelCQKuJYXts=;
        b=neBolY2gI1gCLzbbegBe5/u90bqvXTfqSicEzRDMoP5rrj3RCHG/Bj2FZKvsiQ/Yvt
         GRuG82iVlS1u9NSBBsumGuRpbHifTt3WqsX027DC0Bw0hZq1J4rX8x1+TPo747O8l/My
         RlfA3gKw71yOZTRZ1t4jXKD91C2+RiqXKlQPLB6M/+2S9pzwsUfBrAtKoT+AFijSxFou
         iEluUlhKfoMXExsq7YHu5hbHq615JsTTVL6CaK0jhJ2erLIgIVFYTs1z1Z/d5FaTr16q
         GEDZZrLGQKir2/RxKQDqVLWQySqG8LNhLZ9Cq6BIdsaeMOVLWji4qX8o8RAWGl72Vn1p
         1dSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6HczBTZv9tDmoRGBtQpHV/NPlrKC9EXRelCQKuJYXts=;
        b=KcrllyXop8QLFn2XyHowXjxlc59fCNCobxgujYCR7BlxWFpt5OFMzXAsx5v5L5Bp4Q
         ZNdaWtuXpQdGaKO7EBW8xSvwqLZYFIvpxdSQl8hVAGHKvkpunwgFcHuuw3tA6gWHae8A
         7Q5oe7SFjOZkBmZBGPDefuOJ1ws0j4yNoNwdx1RLF1NHSlRLmyF9ureb+ch+G9Dn8MMo
         pZZu3z6SzoKZktwwUt3IDD1+AS6swOn51DwwmaACfo+A1pidw1KKYQTF6CWWD5VySXmb
         auztyluEsKc05Bp4O8ROrkRqvLdBKL3ywvIily3Fzmfj2Fq0Hi5EX707F3LN3xVJeqMu
         wmUQ==
X-Gm-Message-State: AGi0PuaC0riP6sa6NO8hLQTtZ2RE+vqzxnZKI1+0pMm7VrlEFCzRsyKf
        GWoBv4ZVfEhFMNMS3KZO57w=
X-Google-Smtp-Source: APiQypKhet85fDKg94yu7VG96T2gSAapFkjIkJhk83tfQV/1/RJaXhIPiNQrS9zIIoiGLLNRC+HDHw==
X-Received: by 2002:a37:9d08:: with SMTP id g8mr21050092qke.138.1587474388120;
        Tue, 21 Apr 2020 06:06:28 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id h2sm1713836qkh.91.2020.04.21.06.06.25
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 21 Apr 2020 06:06:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Apr 2020, #02; Mon, 20)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqq8sipppmt.fsf@gitster.c.googlers.com>
Date:   Tue, 21 Apr 2020 09:06:21 -0400
Cc:     git <git@vger.kernel.org>,
        Damien Robert <damien.olivier.robert@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6EF27DB-E72A-4854-B447-98371F911ABD@gmail.com>
References: <xmqq8sipppmt.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> Le 20 avr. 2020 =C3=A0 21:57, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> * dr/doc-recurse-submodules (2020-04-06) 5 commits
>  (merged to 'next' on 2020-04-20 at 601e10f9a1)
> + doc: --recurse-submodules mostly applies to active submodules
> + doc: be more precise on (fetch|push).recurseSubmodules
> + doc: explain how to deactivate submodule.recurse completely
> + doc: document --recurse-submodules for reset and restore
> + doc: list all commands affected by submodule.recurse
>=20
> Documentation updates around the "--recurse-submodules" option.
>=20
> Will merge to 'master'.

I added my "Reviewed-by:" to this series here:=20
=
https://lore.kernel.org/git/7B4732CF-967E-4FF6-86F0-CE3612AB3CA4@gmail.com=
/
but I see it has not been added yet to commits in the topic branch.

This is my first review so I'm sorry if I should not bother you with =
this.

Thanks,
Philippe.

