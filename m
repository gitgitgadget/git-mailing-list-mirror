Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6EBC4332F
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 10:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350689AbiDLKA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380576AbiDLIW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 04:22:26 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D1847AF8
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 00:50:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id p15so35599497ejc.7
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 00:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=keK8NMSbT96wPLdqXLmlj8inOZFqZQ51Zw9V7fYxcB8=;
        b=pyG7em0JWS4B4x+Tj6hCoQdHQ2RJB+YwZrl5vhPX1TZb+WOVA+86QfJVL2ZJ6+4wih
         AzumuYsKTYs/HBkY0J0be2xqmsbf9lT4pKe9IcsPEr+pqw252wJEvmkDh/fFvcB1CsoY
         uTpB/OXma8nXqYH1PdS9iAFeduSef7sTzQKvgSWb/NWeKirU9Ccpf51atrTYpP4E04Gh
         Qj4fe4F68/Ft4EoFTiGCXI0lD5uDCZhak56CWNguFPtCwzhcjALkCPyM+CZIcNJp1xF/
         XTU1CZTO3IhOcqvIBHznaCaQsJhkrM9SAHuRDHV+7CUafMzerFL1aC9LHsH0C/TR35/Y
         cHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=keK8NMSbT96wPLdqXLmlj8inOZFqZQ51Zw9V7fYxcB8=;
        b=FavuKiQJp+oOnmP8jeA7R5LO9UDDZD7OZE9I7RkR6A8OP90WGKE/j4ehNllEd0h3if
         jnSWPKJfcKKx6A1SK3rHUr3aiGknP/c8lNZ4ZL0OvMMu+gQ0TDhBOWlMZ1wKnxg6qzUa
         PDnSdtaTQ4/Np+xBw7Bp90DNbLXFCWjgsYulvnFNSiWoGUzry2W7d7B2bZZgSSEDynIu
         hu9MM/VlGZgvaCqQ6hdiMYv2uIQqRzm3o5p/9yb4M3yaMZmKk6f2MzqeioEub4I0XfdH
         DDdzFg1hJAOmPlbEolJ4sy8OSUKKgnjYZj6Sv6czKe4u/YHONWN8EZWlgVJMg8OynFAv
         koxA==
X-Gm-Message-State: AOAM5303R4udTYvJuFBxOIA0QNCRLYVH3Bolt6SXRwdOfmanNLy5P/3J
        BwZVoWDb9nt5BLgiDayN8iQ=
X-Google-Smtp-Source: ABdhPJyM1OW+VCd2pVASJ3tGx0YSSWQOwgfJNsk3MahuUShhkDqjUKO73/6p972ojOFd4R6gVeY2WA==
X-Received: by 2002:a17:907:d1a:b0:6e8:b4fd:d566 with SMTP id gn26-20020a1709070d1a00b006e8b4fdd566mr1288627ejc.104.1649749832350;
        Tue, 12 Apr 2022 00:50:32 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i22-20020a1709063c5600b006e8a8a48baesm1028310ejg.99.2022.04.12.00.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 00:50:31 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1neBIE-004VCg-Vx;
        Tue, 12 Apr 2022 09:50:30 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elia Pinto <gitter.spiros@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] tests: make SANITIZE=address imply TEST_NO_MALLOC_CHECK
Date:   Tue, 12 Apr 2022 09:44:01 +0200
References: <pull.1210.git.1649507317350.gitgitgadget@gmail.com>
 <220411.86bkx7i8qi.gmgdl@evledraar.gmail.com> <xmqqk0bvfcd6.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqk0bvfcd6.fsf@gitster.g>
Message-ID: <220412.867d7uivuh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 11 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I wonder why we have to justify that we'll only turn on
>> TEST_NO_MALLOC_CHECK if it's SANITIZE=3Daddress.
>>
>> I.e. we also have SANITIZE=3Dundefined, wouldn't it be more future-proof
>> to just say that these analysis options are mutually exclusive by
>> default?
>
> Given that the SANITIZE mechanism itself allows more than one to be
> requested at the same time, it is unclear to me why other checks
> like undefined needs to exclude checks done by other mechanisms like
> MALLOC_CHECK_ by default.  If I correctly read under-the-three-dash
> commentary Phillip wrote, it's not like that use of MALLOC_CHECK_
> inherently interferes with the way SANITIZE=3Dundefined wants to work,
> no?

Because:

 * It makes it slower, and part of the utility of these checks is that
   they run in a timely fashion.

 * We add these glibc checks because we'd like to catch malloc()/free()
   issues, and run the test suite with them by default.

   Someone using the SANITIZE=3D* feature is almost certain to be also
   doing a "normal" test run, so I don't think we're getting anything
   extra by combining the two, except needlessly slowing it down.

 * Even though SANITIZE=3Dleak,address & valgrind are strictly speaking
   incompatible with the glibc check, having inject itself into other
   sanitize modes is surely going to make debugging harder until you
   discover that we're also injecting the custom malloc.
