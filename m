Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80249C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 13:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C90A20773
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 13:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pc/l9dPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgGGNM6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 09:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbgGGNM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 09:12:58 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE516C061755
        for <git@vger.kernel.org>; Tue,  7 Jul 2020 06:12:57 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id a14so18768294qvq.6
        for <git@vger.kernel.org>; Tue, 07 Jul 2020 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0bM6tRb14zJFpbOljSa6x4TX6JcQSca9pnQKqH2+sos=;
        b=pc/l9dPQR9xTKkrfwrrbQUNnQZmFqd3xgU8FOCrHqoCB3Wu3yz58anC2BwG1N87Rc+
         2zkSEO73AfZSbiOPgfSEDQ6wGWTXJTrIVGkMHwuqustKibosPzIL0C9o2T61Fkiajbd/
         E1cyClDR8bYsuc6y9WiO8kcmUnlmgJR8IdgSFPAEZ6nQdUyn8BZ54Aerqg4VoTHlqY8o
         eLxCWN+9OCnsFyFWKaFHfKLm9L3IIV/VflsleXbyR+r9wUq9aIGczfWW+sijqjZQDNM2
         kBKY07BiSK9V7mehUQ/GToLaEQ3ELM24Nb2GSF5QGRMnMRNToX2HGMCQjKAEe/V6Q0jV
         Of5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0bM6tRb14zJFpbOljSa6x4TX6JcQSca9pnQKqH2+sos=;
        b=gWznl40Gsp1mLLQZchjca8USKXO99K3gg+XH2jOH4TLjhYaRLrmKhdItCt9XOL4+/Q
         08H1knWoA4mmrv99vcCDe/l0EeH+kF/jHXIvVju4ToRm1Ia+WG0OZU0c5yzuNV7Scdai
         GNgEim92cUTvuyrtsk83sKgNUK1Wh9nqD7NdKy0XR+TLteLsZVKi6nwHZUD2Gx4veJfc
         P0Ne7BSZiTn31ywAziOI8yVYsgOdnx7YJvbAqW+hnDh3T4+md/iRnD8Ms5MVlnM/ommg
         LxMEZ0WDNzZfuvUC5+fXLL56/9J/ob1cNnLAWkzw6B9TQnwoB12R/7ARVCWyhl7GuxTb
         5J6A==
X-Gm-Message-State: AOAM532S+g7Zg/Arxu02XwhOOa7u3DOFridOQrqIlTEZChceAi48NNBi
        c7XuS39m9LkRNw8UAd76+WY=
X-Google-Smtp-Source: ABdhPJyk+M5lIclndhXi6op9fwifZNZKfVT73hL2FJz4DEjGzb6XUHqpB00c3EMELUSS3Bpr5luujw==
X-Received: by 2002:a05:6214:8f4:: with SMTP id dr20mr49025600qvb.228.1594127577219;
        Tue, 07 Jul 2020 06:12:57 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id m7sm25612611qti.6.2020.07.07.06.12.56
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2020 06:12:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 4/4] rev-list-description.txt: fix Asciidoc syntax
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqqeepo87hz.fsf@gitster.c.googlers.com>
Date:   Tue, 7 Jul 2020 09:12:54 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Lawrence Siebert <lawrencesiebert@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4FEB0C20-2CDE-4110-B153-251AABD17CC4@gmail.com>
References: <pull.590.git.1585429894378.gitgitgadget@gmail.com> <pull.590.v2.git.1593747509.gitgitgadget@gmail.com> <3b923780c1f38ee183397b5766aae65933eec4aa.1593747509.git.gitgitgadget@gmail.com> <xmqqeepo87hz.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 6 juil. 2020 =C3=A0 20:59, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>=20
>> Using '{caret}' inside double quotes and immediately following with a
>> single quoted word does not create the desired output: '<commit1>'
>> appears verbatim instead of being emphasized.
>>=20
>> Use a litteral caret ('^') instead.
>>=20
>> Also, remove the leading tabs in shell examples to bring them more in
>> line with the rest of the documentation.
>=20
> These should be done _before_ 2/4 as a preliminary clean-up, I
> think.

I agree. I'll reorder that for v3.


