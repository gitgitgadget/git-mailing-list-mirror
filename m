Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29853C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 15:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029C760F42
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 15:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbhHaPdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 11:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbhHaPdx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 11:33:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B62C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 08:32:58 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id b6so28368887wrh.10
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Lm0XKuD6QqnBAHP2FWkpQEuaFRwyg97LKZuJJaXjU14=;
        b=F2NtMBK1qdjEB55/3rm3YLjV69CaEGD2rMElOXYz8jSo+c1XzMtAt73r/hvVkwuxk/
         eLEc0fm4SfQbKgSSXHNUqOrYV/LzLbGKakidU4ZglsLiQv7CL4q/8ekYLpRtoWRQSypN
         7ZfSxQIPRpd4W8QU5OUBVro1IrD8Pjx7UHCX+AtOKZffRE17x90rhslxIYe8U9d+0D8Z
         GtFRvcX/ik2k4XK6R3/G/I8mdAAlofWnHQny33+XyzDYsYlvnr/m0atA7E6BQCXgk2nf
         s1rJTNor5C8w8YyHiBFREgg1UeP3BF82BwCydA7dCiyr1KHnxxtCyALZaUyv75hfbrtR
         n3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Lm0XKuD6QqnBAHP2FWkpQEuaFRwyg97LKZuJJaXjU14=;
        b=QmZ8Hbo/cAADw+cam4OAamSI+RIrwPEDwN9u4w0cLXs+guEKQd86UA94iCP02VDbxr
         FpYi4RWJnMBvLBPXQiG8xWCc/yjRD53B4rrc6cksGhUT4Eg+VE6HXeS9mcHRVqFZwwCD
         nSgAz0/s0N2ORVU5Fuo28JL/19c5g6xXpG2qFIRG/crtt7EJBKyVjKDsYnxPKGiTNCa+
         TeDOHDDHIUqCoqv2fGCBQ70ACKmUn3F0NPtEBwChBfGMEMrDPPp3dwm9ao68SlPC+yZ9
         9GWXfTEqs1HIgKW9ITNRySft+7xhnpufJDfSLw8yBA5Wmxymz2P6BlbSf7G97XKd17yG
         n65g==
X-Gm-Message-State: AOAM533bewERWllC2z1YJwBrhkjfCBXvt4itqOCaHmNoG60fEfHQmrdO
        uzzjM35IIHw0rrnwHg7kZ6Z/fbtMIiAQpxVUD4OeMTDpngjR/w==
X-Google-Smtp-Source: ABdhPJzeL1jPQ5NMQgOpVJm/niE9GlfaTZRZEwLcvXqlmJsp5qRR8oVz4ZxRCwPGi992O4mkagUBIpjpJbqjHTKDino=
X-Received: by 2002:adf:8170:: with SMTP id 103mr31942382wrm.167.1630423972850;
 Tue, 31 Aug 2021 08:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <patch-3.4-b7fb5d5a56-20210714T172251Z-avarab@gmail.com> <patch-1.1-9acbc21cdd3-20210831T134632Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-9acbc21cdd3-20210831T134632Z-avarab@gmail.com>
From:   Bruno Albuquerque <bga@google.com>
Date:   Tue, 31 Aug 2021 08:32:36 -0700
Message-ID: <CAPeR6H6g_VM3SUyjfYfc+mQa27af7AJE9wbKN_TUdG6m5rAUow@mail.gmail.com>
Subject: Re: [PATCH] protocol-caps.c: fix memory leak in send_info()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Andrzej Hunt <andrzej@ahunt.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 6:46 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

[Replying again as I used HTML mail by mistake. Sorry.]

> Fix a memory leak in a2ba162cda (object-info: support for retrieving
> object info, 2021-04-20) which appears to have been based on a
> misunderstanding of how the pkt-line.c API works. There is no need to
> strdup() input to packet_writer_write(), it's just a printf()-like
> format function.
>
> This fixes a potentially large memory leak, since the number of OID
> lines the "object-info" call can be arbitrarily large (or a small one
> if the request is small).
>
> This makes t5701-git-serve.sh pass again under SANITIZE=3Dleak, as it
> did before a2ba162cda2.


Thanks for cleaning up after me. Yes, this was my lack of knowledge on
how the internals of Git works. I was also not aware of SANITIZE=3Dleak
so thanks for the heads up. This looks good to me.
