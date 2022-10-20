Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D11C43217
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 20:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiJTUnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 16:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJTUnL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 16:43:11 -0400
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EF420C99D
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:43:02 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id v10-20020a4a860a000000b00480b3e2b5afso423199ooh.12
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibvJFHlPxeXfjyHgPQzlRf9TqNw4Iff1tumz1lmWu3g=;
        b=qcCoFlfUoDiVtp3nxMUApXPMlltXI4gja4jq3AYxdmZ2+yMY4qRLOqZylGPxl2Hn9X
         YaWi6YxE0UdMoUjTHKVM2dbwdp3qrKayTk55f2hWJT3dcGnV5vO9Oib2X7LsvUVR8Kts
         f8wnse3HxMjFjzwoouMChiAfoeMfNqmuKnuGcqUazHLl9h24CLlcRR7V8jfraW7vyJ3i
         Y1slwjaNxqWpy+P0hZo32oZQi2BZL83zrImK1c230qa59f+RDNx5ARReWtqtm+TycgGF
         J5FjhDsvp/AL8HX3IPyhy30uPRj+r6LdAD1H7uzQ7WflcvjGUK6l856WsMRAkNWLYJM2
         4WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ibvJFHlPxeXfjyHgPQzlRf9TqNw4Iff1tumz1lmWu3g=;
        b=XXS+kar8HcZP/J/Wa6DRQKhFU9irKwn09YOwCusJ3AimMYy9ciHXUUhnC79Npz83H0
         7A44gQbY4Mm6m69tcrxvwEqgQFTgsfqjCFTz47YNdywh993VaLi82ZEM5NFk8EFqhLns
         6BKoTbClWmZXmTCiSCutzvL5x1ERV2s8qVqZ/MVh4YlbaNnIzJFOU453etGBhf5pS4PC
         4fodoVIxZ7eGHKiKhq9G+dAlhcLBM6SMa/L0CRA+DXXFtTKTydo++e3M2FQMOL8JzEwv
         YJtVlaw6x4lY2xC2z6tC6IVippx4hzSVGkoVwEzY/6f1bItguP7/N56b2Slw2vny5Lag
         rVhA==
X-Gm-Message-State: ACrzQf387Icbv1RJZ1dHFFayJuVXZB7bZ1jivRfCOlSKB/5XJ4jjKpLZ
        TpnlKR2ILMsKRfOwlMLsyL1IEKVxY6dHbw==
X-Google-Smtp-Source: AMsMyM6lQxtr5/GLHjsnyue3C+svkTG86D3DiLgqDQR40hQS7bqMJZYLy8kabLHw4vN0XX7Gbv5NUNzHLHD7Gg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6870:6193:b0:13a:e513:fe71 with SMTP
 id a19-20020a056870619300b0013ae513fe71mr4444635oah.67.1666298581972; Thu, 20
 Oct 2022 13:43:01 -0700 (PDT)
Date:   Thu, 20 Oct 2022 13:42:51 -0700
In-Reply-To: <patch-02.10-46bf600820b-20221017T115544Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-00.10-00000000000-20221017T115544Z-avarab@gmail.com> <patch-02.10-46bf600820b-20221017T115544Z-avarab@gmail.com>
Message-ID: <kl6l1qr2z0ok.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 02/10] git-submodule.sh: dispatch "sync" to helper
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonas Bernoulli <jonas@bernoul.li>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Remove the cmd_sync() wrapper for "git submodule--helper sync" in
> favor of dispatching the raw command-line directly to the helper.
>
> At this point we've already parsed out the optional "--quiet" flag
> that we need to support for "git submodule --quiet" (as opposed to
> "git submodule <subcommand> --quiet").

For a moment, I thought this was saying that we're dropping support for
"git submodule <subcommand> --quiet" in favor of "git submodule
--quiet", but that's not true. Both are still supported, albeit in
slightly different ways:

- The subcommand "--quiet" flag is passed via $@

- The top level "--quiet" flag is parsed when we parse top level flags,
  which sets quiet=3D1, and thus passes "--quiet" to submodule--helper.
  We also `shift` out the "--quiet" so there's no fear of passing
  "--quiet" twice.

Hooray!

