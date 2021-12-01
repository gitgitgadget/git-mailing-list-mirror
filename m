Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6656DC433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 14:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349603AbhLAOI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 09:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244709AbhLAOI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 09:08:58 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C754C061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 06:05:36 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z5so37069671edd.3
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 06:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=JHbP70UJ7VJvhMZCiuCa6kufeHax2FxcmlI7hEC0IOs=;
        b=Cc6m/vbgyDNrw7snd+7Zth0z01lnC/eqlmMj6OU/U3maiIteYAhcuhtG8H+XIA6XQg
         T4JCtkr5iR21Zgu0ufVcFIyRebPCgNTzhGGpKi0WN+8OfBubLhMDa40nT6+0JK56wB6/
         VDPQYsd/5l+der/IDzbDeYwOODt0zu2roZ4CKDsdpZfcwwU0qN/WvnYcHBhr9+sdV8vU
         rDhrBxuZIz91DB3T3IMG7xd1gs9QvCEPWpxaA4tEsAXyARAbiLYcknV2j1w1iyXjhd27
         gIV4NJeb3xIAlBZ0isAVYmBko6RTFgQHO9BC9/8NLXcMU+plYmvgAJKaXRzvtq6AZ13D
         09/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=JHbP70UJ7VJvhMZCiuCa6kufeHax2FxcmlI7hEC0IOs=;
        b=cgX615pb3teSI506ijDPRcxlghwIaTZxmycnnJ+mrsQiXRhQgaCireJ2JLfOy7oclC
         hfrZofvx6X0p7/0+eZl/IA51/u51+gbsdJ1p2O8niKFW0uXvmJ5Xezsv3/8w66zjVwlp
         aGFqK0vwWBR3gwf02iXo9mXMIP83sp1PIh90/Pyq9nuRI31Ec2tMRsA4bPOBYsNZkxy0
         6GRpWIegPWWxI3UjJcOc7fffAcpRmn2tY+sk2OBq7htbgCyHYjhB8CEZUaxCzDpP6ceE
         PL2TPevUA2b1PmD50gtiCNZzIV0FnsGPX4dY8CZfqtb7tONzRC+7owXaU74z9MkmFMr7
         Jqmw==
X-Gm-Message-State: AOAM533DvQhR92BneqixzZMAlMYjY+JO44/pBYElrDjvoS8S4M4DvErA
        xxlAKTe0jUcswYJOKDCAovI=
X-Google-Smtp-Source: ABdhPJy9UfURqqV2Z9p2bT0RPODn+YnKTYelOnK1JiWpaJtpC/l7pJBa9NUKXkDl06DLsVLM5o+Dmg==
X-Received: by 2002:a17:907:168f:: with SMTP id hc15mr7400094ejc.115.1638367535032;
        Wed, 01 Dec 2021 06:05:35 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x7sm15993089edd.28.2021.12.01.06.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 06:05:34 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1msQEn-001G8T-E0;
        Wed, 01 Dec 2021 15:05:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Is t7006-pager.sh racy?
Date:   Wed, 01 Dec 2021 15:03:23 +0100
References: <xmqq1r4b8ezp.fsf@gitster.g> <20211024170349.GA2101@szeder.dev>
 <YZqSgu4XjPWnURju@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <YZqSgu4XjPWnURju@coredump.intra.peff.net>
Message-ID: <211201.86czmgbetu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 21 2021, Jeff King wrote:

> On Sun, Oct 24, 2021 at 07:03:49PM +0200, SZEDER G=C3=A1bor wrote:
>
>> > What makes us expect that the "git log" invocation should trigger a
>> > SIGPIPE in the first place?
>>=20
>> A misunderstanding, perhaps, because those 'git log' commands with
>> their early-exiting pagers rarely trigger SIGPIPE.
>
> I happened to be looking in this area today[1], and I think it turns out
> not to be "rarely", but rather "never" for some of the tests.
>
> The test in question sets the pager to "does-not-exist". But in that
> case we will realize immediately via run-command.c that we could not run
> the pager, and will not even redirect our stdout to it.
>
> For example, doing this:
>
>   GIT_PAGER=3Ddoes-not-exist git -c alias.foo=3D'!yes' -p foo
>
> will never get SIGPIPE; it will just write infinitely to the original
> stdout, and return success.
>
> Whereas this:
>
>   GIT_PAGER=3Dfalse git -c alias.foo=3D'!yes' -p foo
>
> will reliably get SIGPIPE. But even if we used it (with a while loop to
> instead of "yes" address the portability concern), the tests in t7006
> would still be wrong, because they are sending test-terminal's output to
> a closed pipe (so we'd still see SIGPIPE regardless of Git's behavior).
> They should be sending test_terminal's output to a file or /dev/null.
>
> It seems like this thread stalled. =C3=86var, were you planning to fix th=
ese
> tests?

Not at this point I'm not! :)

Anyway, a belated thanks for tackling this issue & sorry about the
mess. I see jk/t7006-sigpipe-tests-fix is marked already & those fixes
LGTM. This fell through the cracks for me among other E-Mail traffic.

> [...]
