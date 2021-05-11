Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDF4C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9BF61376
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEKUAn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 16:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhEKUAm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 16:00:42 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD69C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 12:59:35 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso17791540ots.10
        for <git@vger.kernel.org>; Tue, 11 May 2021 12:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=5NANmUseEnCYglwxBXKZ+ApCutwxM9pvq3yVMhR8MeQ=;
        b=QmHVt82dFe0g2uQ6NEhATz5rE3B830jEXcSJ4RgE2StR5oyWQTOyiOjGooQr42co5H
         jZx6l8hDLJywj7R9XJqsqnOeF1i81PZH0IeblDr+Fd7W9uIl0z3lNwmiMkRoyt3PiGYp
         9+AjDia6i0MMk4/E/9O292sDK1wbUV6+n+z1c6lWPaxHf85+LUHY/axePWrNHI/6jTsL
         m24bBAddPyCKW3jlgF1fBA/VyglDkfD9ChPs21uVFDdPJ47PCq7kd9m/ReCmflyDWoC2
         GrJeJ8YFbvATnWxtP0KVwtN8fUX5mBSYoOUWENkiYyYt8gt4JX7YIuLsGMK56EYO6luk
         p2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=5NANmUseEnCYglwxBXKZ+ApCutwxM9pvq3yVMhR8MeQ=;
        b=PU0ch0ZkLjSZC7qJiqE9u4hFW5i8C9yt/3Ri7w7llodvoGndB2q+WeKBq6HEDbfelu
         rX0wOud/cXVVICE9fVnv9WYt+Z5phggkR/WQDmcR3Ff9W4s+tx9XrWArUMY5I7KIajAM
         tLSu/+ml0DVlphFCWNLe3Rewyz932TwQcjDN81kNMwr+p/0xE9h6QhNqOSRzthMjtLQh
         2cNLza0ViwlMTzkj7FTQPKnyL/yIRzh6s9/WRUMBdzGEVOo7CWrLWDwYssEKjyLhAPjO
         ZskQIZHvcJrPAxVE9Zb1H+q3aAjnX8ZopKtIpyVciGXS29A47hDK6TxYdtClwKqYAh0g
         7uVg==
X-Gm-Message-State: AOAM5318qCR8qusKLVtYpN35SYT3MWpHGXYKJLZ1JATF/q4bFeOlMqql
        gYbB/3vaPCqyvfWF83Rk6VkUNwLF1eViYg==
X-Google-Smtp-Source: ABdhPJxDWkpdv+EWA+fSElGmIrRp304TdwTqVrebYz1/PbdLf3SE5VCbTS49/5GCtCS9usnB5gZtKA==
X-Received: by 2002:a05:6830:124a:: with SMTP id s10mr27580558otp.300.1620763174519;
        Tue, 11 May 2021 12:59:34 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id w10sm3500513oou.35.2021.05.11.12.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 12:59:34 -0700 (PDT)
Date:   Tue, 11 May 2021 14:59:32 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Varun Varada <varuncvarada@gmail.com>,
        =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>
Cc:     git@vger.kernel.org
Message-ID: <609ae224aa509_6064920851@natae.notmuch>
In-Reply-To: <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
References: <CAD2i4DBj6fNvq=Lc3KiXJj5uBpteyKfEKp7ATOWrTE36KUeRww@mail.gmail.com>
 <20210406092440.GZ6564@kitsune.suse.cz>
 <CAD2i4DDr3Ftk6RE8cA74iSsJTpC9nEb=Cqvr79pF51BpcWEnsA@mail.gmail.com>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Varun Varada wrote:
> On Tue, 6 Apr 2021 at 04:24, Michal Such=C3=A1nek <msuchanek@suse.de> w=
rote:
> > while using "will not impact" in an incorrect or unclear way may be a=

> > problem the word "impact" in itself is not "jargon".
> =

> The word means "to have a strong or marked effect on" (v.) and "a
> strong or market influence" (n.) when used figuratively; it is not
> synonymous with "affect" and "effect", respectively, as shown even by
> all of the entries you've cited. Using it as such is the incorrect
> part, so those are the instances I've changed in the diff.

There are two ways impact can be used as a verb: transitive and
intransitive, but git doesn't seem to be using the intransitive form. In
the transitive form it usually means to strike "the car impacted the
tree". But it can also mean to have a desired effect "reducing CO2
emissions impacted climate change".

None of these are used in the documentation, we have things like:

  the index does not impact the outcome

Which is clearly wrong (unless we are talking about possitive outcome of
the outcome, which makes no sense).

As a noun it can mean a siginificant or major effect: "the impact of
science".

However, the documentation is not using it that way:

  the runtime impact of tracking all omitted objects

The noun usage is less wrong than the verb usage, but it's still wrong.

The verb usage could be corrected by changing "the index does not
impact", to "the index does not have an impact on".

But why bother? The word "affect" is a much superior choice.

I'm in favor of this change.

-- =

Felipe Contreras=
