Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872C6C433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 15:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58334610E9
	for <git@archiver.kernel.org>; Tue,  4 May 2021 15:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbhEDPPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 11:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhEDPPA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 11:15:00 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20748C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 08:14:04 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id l7so2216741edb.1
        for <git@vger.kernel.org>; Tue, 04 May 2021 08:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dDtjiPxXos2EO/S3rw71x9UJrNExo9nt+qMu1WFnc3g=;
        b=qIu+0DsYYCYxx8x53pUhLBz52GzBWDAbrfsa4yPyySnQwllQED/rDsYFzKUZEXWFBs
         l2mW/5qtfs5sw+N9HZcvpHfYnjguODDWQ54raSN45bCHRvv4tx531jl9DL59s3c1lPi0
         7xk2fdepOfwuvx0XmeCjKWoYiaXOHa5ii0QEM8Y6Oby25OJZl4BMKV7QSvZXL1wV2SZF
         Z8WzCwFDfmgVbnaPSerHio3EBvEsBCN7CAaVZVe8Ar/LcXTMFrD197zjuTzgMbAI2Rub
         U5nkpCdwaPr6yPznmuCa45pN/ogPcHBZvXpERtRW6ct0r5wAp1pRkHWUqo+d93Sghu/H
         eOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dDtjiPxXos2EO/S3rw71x9UJrNExo9nt+qMu1WFnc3g=;
        b=UA9L7Tpu40MX3Ul99MaAPqP2VJrClm4Kll2UbDtdZtPlB9K83JDQfdZf93GCXDGTTA
         ChOwaqOt1P7K9dYh0RIzoV0zJn56AKeP1o0t1cNx4rWEUFOOyDEyouotF8Ni5ILbXsBf
         W/kwbHaHx5tSnRzRX0DxiyNsiDfZI3HU6rSUJfY/BtQDRA4+Fak09/0UqEJ6Af2YfNdV
         0/CSJzQcxBNCpq/NU3gVc54yIbBwKTb9KwpQfqye1O/KnGLYlY5BJhxR5gSaeNkjlEO+
         2nAOhCbCZHK4x8OoE/1jNPaR0IuTf7YzJNUK2zz8lS2kcYkID+v4TYd0dljWHElRDWMB
         n/6Q==
X-Gm-Message-State: AOAM533VsRq0T9VHZzk5PNAso6p8O1F5/3dGBTuMIciXTgrERH2nMOdm
        rzhaV7RgOHCXLT6erQl0GhA=
X-Google-Smtp-Source: ABdhPJzWKpYGGKZ+PFRLfZfYX9fLP0dI1YAD0tifzzWtC1vTn7/u2R0aQqwZATANtThTsNuBIRWgVg==
X-Received: by 2002:aa7:c30c:: with SMTP id l12mr26389100edq.217.1620141242777;
        Tue, 04 May 2021 08:14:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id mp36sm1495345ejc.48.2021.05.04.08.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 08:14:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] CodingGuidelines: explicitly allow "local" for test
 scripts
Date:   Tue, 04 May 2021 17:09:54 +0200
References: <xmqqfsz4a23x.fsf@gitster.g>
 <CAPig+cR19WDY1=qTbJMCzxeXjV4XtEddS1+=H8Cj6NUi5ZdN+w@mail.gmail.com>
 <xmqqsg348k9j.fsf@gitster.g> <xmqqo8ds8k6r.fsf_-_@gitster.g>
 <877dkgxk9p.fsf@evledraar.gmail.com> <xmqqpmy76w31.fsf@gitster.g>
 <87czu6wuf3.fsf@evledraar.gmail.com> <xmqq7dke7jeo.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqq7dke7jeo.fsf@gitster.g>
Message-ID: <87a6pawmyu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 04 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> It's effectively synonymous with saying "we still want to support git on
>> platforms that are so broken they can't even run a single test in our
>> test suite".
>
> Not really.  Those on such a platform would (rightly) say that it is
> the test suite that is broken and out of compliance.

Indeed. But the lack of any reports about that suggests that in practice
this is universally supported enough to be a hard dependency.

In any case, it's clear you don't agree and you manage the patch
queue. So I'll leave it at that.

My aim here was to discover if we had any reason to think that "local"
was less universally implemented than other POSIX/C89-plus features we
rely on. It seems that it's not.
