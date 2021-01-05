Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23157C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDFAB22C7B
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbhAETTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbhAETTD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:19:03 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835A5C061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:18:22 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 23so960586lfg.10
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ReVlHw6RbkdAoasPa03pRRBNg1rUpgqXFjMWzDN6mxY=;
        b=OAh3/ERU5+uEFlqVYW8HqF2o1w/V42MYIgjRS/obAWkXPrTEwZVa4auu6QYh+Xobnm
         IszEGK4CwG8TIExM1G79bkfJq4gjk4Aqk766nLCVRppH5Toiu+7Al96EK2v6RdH/P3aD
         HnG3HbjVFWy2qdOSTqB/zhYQdbxTXkm8ooRfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ReVlHw6RbkdAoasPa03pRRBNg1rUpgqXFjMWzDN6mxY=;
        b=G38rNbl6iZ/VcRpbwBUC2qprSOyaBFFEAVK6CAsQYXp1BH2F2k/KRkwb9rjKn34CR/
         OqN5OK7TAIaUe6Frkn7bYcZRMnEHCYGnt5iQr4kYYl84K8Oi8MHfydhJ2+jemGx60/2v
         FRGwGNghGrRwhGdOV4hKwKtiKf19ydy1D4q2QpMRM5NkNDAnZJcYhwO+l7JUGKJfJfga
         YrX5hQJqmhIy7Ig2rejy8yH11Wt0lzRA2QqJ8IJB9NckaTTfrTrY3bWYn3t84zQGFYyS
         qoKBMgccCzX41MjJIobbysOoVhqyyIn/UDopMbkooYeLh68O3Jo2/7nX/7m8QQHQpm9k
         TWmQ==
X-Gm-Message-State: AOAM532tzAoQpNCB5Iy5S0K0X0b0JiuHjVD6XeF0x+2XlbZcWpEyBWca
        PomBJrnFlte9Ed/yGO0aFm9V8vFEzyrygg==
X-Google-Smtp-Source: ABdhPJz4EgHJnv06SkO3MRwhyJiOp5oJX1mvm1T1Pc3Ut5m5bkRoLM105/G3IgAehkSYI362+1TvcQ==
X-Received: by 2002:a2e:8151:: with SMTP id t17mr512322ljg.460.1609874300621;
        Tue, 05 Jan 2021 11:18:20 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id m19sm8807lfl.38.2021.01.05.11.18.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 11:18:19 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id l11so1117566lfg.0
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:18:19 -0800 (PST)
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr530588ljj.220.1609874299472;
 Tue, 05 Jan 2021 11:18:19 -0800 (PST)
MIME-Version: 1.0
References: <7vejrs54kp.fsf@assigned-by-dhcp.cox.net> <20210105130359.21139-1-avarab@gmail.com>
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 Jan 2021 11:18:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wixHyBKZVUcxq+NCWMbkrX0xnppb7UCopRWw1+oExYpYw@mail.gmail.com>
Message-ID: <CAHk-=wixHyBKZVUcxq+NCWMbkrX0xnppb7UCopRWw1+oExYpYw@mail.gmail.com>
Subject: Re: [PATCH] shortlog: remove unused(?) "repo-abbrev" feature
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List Mailing <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 5, 2021 at 5:04 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Remove support for the magical "repo-abbrev" comment in .mailmap
> files. This was added to .mailmap parsing in [1], as a generalized
> feature of the git-shortlog Perl script added earlier in [2].

Ack. As you found out, I haven't used this in ages.

           Linus
