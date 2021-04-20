Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D03C433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 10:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30E86135F
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 10:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhDTK7w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 06:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhDTK7u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 06:59:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82889C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 03:59:19 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id e7so44421327edu.10
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 03:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=h8yY7W6WJVfaOZUdWs3Jb6bN7Khjbqx3jPbZRB4xxKo=;
        b=c1MHlYtmdMB4R6NAbBDi0ksHml7nRY5I3qOZzURjUHPNsaFPp+61r7zb+HpOazAqvq
         vDDJStnyPBUpmQlm+OHmlQhBlBUFOG+cnwosomM0ZUgBfsldj+6Ufy/LeSeVxC5WFPen
         FBTEv0xkMhHo4q8ywazo8U114qdYPSLxzAy+uPg4HMw+KzfdHD82360Yy2/34xbYWvpF
         m87HaQ5aZeccKl45XtD0pWGhlKoRrlrtctyOjyxtlNRSuYgo70s+iQRIhBmUPorisCX1
         WfEdDc8rOGlmVV7WNAC4hc70FFTuPRqxnPd2vov9wFp5g+twUj+2niUJUIhYoBcB+8PR
         6iUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=h8yY7W6WJVfaOZUdWs3Jb6bN7Khjbqx3jPbZRB4xxKo=;
        b=DcRNfW6dkI5n4+GjN4ES4nbV+mDIWAvDT5DtT6XQANHIepOe/Dq73R6tH7qq8VRAjU
         diF84gM2loKOOZjuU0lROa7mImruyQTUg5NQFSbbDXTIcHXSHSRQGVkHSXSjeFHf6ed+
         JpaHeQS52MPq/plmwAErK1FY6GpPZI1RqXK6Z95d2a//8rfW8+zgMx90IGAOMepbhL6b
         uDjRXzGcONUo/I670ggW8L7hFoyRuVchBmkfQX2YqsBp0in/xMGLjS8Kxq0E1YC1X34F
         9L+6kHwDORU2Nmzny9i39qEv2HImPsB0gmChXEtHn34wYWv7CCZXmRL5Ag36bGbDozMt
         kfrw==
X-Gm-Message-State: AOAM531O32uxVdm1EiHvznvWNiVMuKLjsP7xTtId93/j5WZqMGnYSdV5
        OKon/6e4Ticeem+OzklnI5w=
X-Google-Smtp-Source: ABdhPJyP+oLqSZYFAQoVQXPTNnNciIBScxDXZdEYGz4vZM01cWQEnk5n65wyhTaFh9AFc5x9MOjPsw==
X-Received: by 2002:aa7:da42:: with SMTP id w2mr22473473eds.58.1618916358256;
        Tue, 20 Apr 2021 03:59:18 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id nc39sm11558898ejc.41.2021.04.20.03.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 03:59:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Simon Ruderich <simon@ruderich.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v8 2/8] config: add new way to pass config via
 `--config-env`
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610453228.git.ps@pks.im>
 <470396d36f938f0070b8c849a85b1a30949056e3.1610453228.git.ps@pks.im>
 <87o8eeteyz.fsf@evledraar.gmail.com>
 <YHqeh9MeRDADviU0@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YHqeh9MeRDADviU0@coredump.intra.peff.net>
Date:   Tue, 20 Apr 2021 12:59:16 +0200
Message-ID: <87y2dd2pdn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 17 2021, Jeff King wrote:

> On Fri, Apr 16, 2021 at 05:40:36PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Bonus points to anyone sorting out some of the existing inconsistencies
>> when fixing this, i.e. --exec-path supports either the "=3D" form, or no=
t,
>> but various other skip_prefix() in the same function don't, seemingly
>> (but I have not tested) for no good reason.
>
> I suspect just because it's more (per-option) work to support both
> types, and nobody really cared enough to do so.
>
>> It seems to me that having a skip_prefix_opt() or something would be a
>> good fix for this, i.e. a "maybe trim the last '=3D'" version of
>> skip_prefix. Then we could just consistently use that.
>
> There's a similar situation in the revision parser (which does not use
> our regular parse-options). There we have a parse_long_opt() helper
> which does the right thing. We could use that more widely.
>
> I also wouldn't be surprised if we could leverage one of the
> sub-functions of parse-options, but it might turn into a rabbit hole.
> Converting the whole thing to the usual parse_options() might get
> awkward, since many of the options operate at time-of-parse, not after
> we've seen everything (I suspect many of them don't care either way, but
> you're always risking subtle regressions there).

So we could use parse_options() and guarantee the existing behavior if
they were all OPT_CALLBACK?
