Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76E5C433FE
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 01:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiK3BUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 20:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiK3BUP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 20:20:15 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F52711AF
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 17:20:14 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d18so4375769pls.4
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 17:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CR3LA6d3RXU3Kj+qam+QzN9ARZsq02iukiboaLEx7z8=;
        b=jOE0nQz42X7EYjwgfl7tsJG2cHFQIoXr7UTxo8lzSnxP1lp0O9jedntaknSJ2/f8H3
         li2cXzPOVpDcmryIiR93WhORwUc2FY8qgYZTbOM7QMk7Xi1AAyux2Ba0jUVDofZ0/5by
         dUbuo2DeVxa/Z7GUiTQH+PPlfTRa7Yingqpll3xSzZ4GBbd9CmSEaQ/h8q+nyCh1vWHH
         ChZwThXoAR98JKfX55WAg+pDIHBe0jS+4liDgYPxQ1Y6yDu4akDmTkhMAOrG+Fx712uy
         Ary1GMzPJeityxZacl1Y5XDPzajeBD75iYENg9uJ4Jdk04h4AeqmlOv+lX/UDj2zPrQc
         7qmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CR3LA6d3RXU3Kj+qam+QzN9ARZsq02iukiboaLEx7z8=;
        b=FGzusBM1OpxEMuf7ir1/x/x+mKsLzUnQOlWF6b2dgbUwv3y+Np66Psqs1AnSxfRuwl
         17GSXBVXSOM+Hda287LdZSEBSPPZf+gBMW7+Lk93V3+GlYzMsvoqo8HIrsJ0GhfJCA7v
         yNQKEZ++lA0ikJ7/vKa+c7YAN9Pml39JfvKBQcxAkyrP9nwyEbX+zPwzvjAicsCbK6sw
         UpJejgpH/PJXT1XwgNc4RGbgfqFql8VzgghzzeIgYQ+CNa81Ion/h/gRxYgPMV0gORrC
         R/5lj42mB7J/TbDvf7oLVNU3I7j5fUxyPAV/W/q0obZTN3suIRDhxrm8t64Bb+VyUP3G
         TQvA==
X-Gm-Message-State: ANoB5pm4C4BTdDM0WRrZ4GPQu/7Vs8Iwb9CN23lnznluXX6TTZw8EXff
        OulQLQ2RFrOWn+4/mIWetRI=
X-Google-Smtp-Source: AA0mqf7S0UBXcDwlfqP+E8V5vYfDTsnnkuDqnqftyBTVMt07cCl/C5h9cAC80hinBL7lwzJZMOU0nQ==
X-Received: by 2002:a17:90a:a589:b0:217:b6d1:968 with SMTP id b9-20020a17090aa58900b00217b6d10968mr70170533pjq.52.1669771213990;
        Tue, 29 Nov 2022 17:20:13 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e16-20020a17090301d000b00174f61a7d09sm11396270plh.247.2022.11.29.17.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 17:20:13 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 5/5] list-objects-filter: remove
 OPT_PARSE_LIST_OBJECTS_FILTER_INIT()
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
        <c2d3e7a3-599f-dae5-8dde-dc969df39f02@web.de>
        <accc4f29-8e8e-5b8b-9409-6f2ac51c2936@web.de>
Date:   Wed, 30 Nov 2022 10:20:12 +0900
In-Reply-To: <accc4f29-8e8e-5b8b-9409-6f2ac51c2936@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 29 Nov 2022 13:26:44 +0100")
Message-ID: <xmqqzgc91bn7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> OPT_PARSE_LIST_OBJECTS_FILTER_INIT() with a non-NULL second argument
> passes a function pointer via an object pointer, which is undefined.  It
> may work fine on platforms that implement C99 extension J.5.7 (Function
> pointer casts).  Remove the unused macro and avoid the dependency on
> that extension.

Makes sense.  Some of us may consider that no platform of importance
exists in practice that breaks with such a cast, but our opinion
does not matter at all, while opinion of those who supply compilers
and checkers to us do---they may decide to flag such a use with a
warning and that would break our build with the -Werror option.  If
we do not have to rely on the extension, we should.

Thanks.

