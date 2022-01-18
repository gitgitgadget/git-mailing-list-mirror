Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6811BC433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 21:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349550AbiARVrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 16:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbiARVrX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 16:47:23 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359FEC061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 13:47:23 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so645235pjp.0
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 13:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uE+FGG4oyeCFq+4KsVGbHDQvmyykNVPgv/AZFRO9n58=;
        b=R0ks4ua7oVw6fFc56hYcq275GD2KQWPB9erqWQxYtlbl0LR11WfyykR4nzCDnEtZm8
         3ML6nyJ/77SKNMig92hwV/tN47SGZQujKAbFYBfMioWASvGfOc2Cmov65K5N6Dg9vZSJ
         YlrMcyyz0nRb7FDTK03+TsZ0GO5i9EsRWZGDh8vfm7BrDIlhgXx6rLPaQLIRdh7GjfHb
         +GhQhmG3cdt3Vp6l/r5zdAek0vrSFAufRk990yy6PTLdrB6oGVYe1Dwu8gB8xj5WsHwd
         KHFSsMfUAvcD1BSDtQa0CGMgVOzjWDtFBScUqr2JxyGTGDelWvn+6rzWIoVeUZZSCGRQ
         HFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uE+FGG4oyeCFq+4KsVGbHDQvmyykNVPgv/AZFRO9n58=;
        b=b8Orxo3J6mFwgvwQs1sj8obWvvqQQmfzOXoPMvZ4ulW9/r2nO4mOkF7HUUt+xPIRp+
         9TjLoVrVS/5xGrd1cVc6B3O7XsmdP90qmAcaG202VTUfCc75waTE0f0PuvpoDje7mB/Y
         23CJDGtNyy1c1nA+QStwn7t8E3bdNkhvMLViX+vtCsC4kJ9nj01IZEHM5VawlJsBxMyc
         c228hXI6e9l4TQyQhA4PEx2bHeFzjEiyUi+LnTdvIVra4qdLPcHRfxNr23ESfx79POsM
         7YX50+ylnZSlFR676XtjgEyRswaIwnNyiP/ikqdobNOl9uYurMJU4fvRTbFI98gISXU4
         4moA==
X-Gm-Message-State: AOAM530NpidfGcLvXqFcgEDX7ubAKQKcAFy02a+tguhLSIuV1bpVI0mn
        ET+MFyd4FPm4CZMuOz1FLrs=
X-Google-Smtp-Source: ABdhPJw584duM1cWK+KOeJHtndLMEYZA9+3P+r2/z1QcsnjOY4Fhg/1pDobht3fEAdrAaMB+1Fo95Q==
X-Received: by 2002:a17:902:9049:b0:14a:ea20:1f21 with SMTP id w9-20020a170902904900b0014aea201f21mr2279165plz.35.1642542442708;
        Tue, 18 Jan 2022 13:47:22 -0800 (PST)
Received: from neerajsi-x1.localdomain (c-24-56-226-231.customer.broadstripe.net. [24.56.226.231])
        by smtp.gmail.com with ESMTPSA id ip14sm3723038pjb.11.2022.01.18.13.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 13:47:22 -0800 (PST)
Date:   Tue, 18 Jan 2022 13:47:20 -0800
From:   Neeraj Singh <nksingh85@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?iso-8859-1?Q?Bel=F3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH] Makefile: FreeBSD cannot do C99-or-below build
Message-ID: <20220118214720.GA8652@neerajsi-x1.localdomain>
References: <xmqq4k7j68eg.fsf@gitster.g>
 <YbEMnksMEuAz3Nt0@coredump.intra.peff.net>
 <211209.867dcekm9h.gmgdl@evledraar.gmail.com>
 <YbMWNZCpy578Qu+l@coredump.intra.peff.net>
 <220113.86tue7vr6d.gmgdl@evledraar.gmail.com>
 <YeDUA6NhHuCUkqXf@camp.crustytoothpaste.net>
 <xmqqilumayfh.fsf@gitster.g>
 <xmqqzgny7xo7.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2201181308540.2121@tvgsbejvaqbjf.bet>
 <xmqq1r15szpg.fsf_-_@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1r15szpg.fsf_-_@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The approach of building with C11 on FreeBSD is a good one
compared to trying to hack around the headers.

It appears more like a compiler bug that's being worked around
here. The FreeBSD header supposedly uses a GCC extension if the
C standard version is less than C11.  See: 
https://github.com/freebsd/freebsd-src/blob/1e7b5f950b2d54ddb257d008592563c4d753aa54/sys/sys/cdefs.h#L317

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
