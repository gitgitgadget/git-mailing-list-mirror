Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECA5C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 11:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D332D610CC
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 11:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbhJFLOV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 07:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237836AbhJFLOV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 07:14:21 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0B0C061749
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 04:12:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id d8so8404208edx.9
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 04:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1iqExXEzf2x4/9GMygCn9AQ9vmPdeayIDTBCgm5byrE=;
        b=BxhTA5K0s6WBChMJD6xXf+MhTMJXX9h+T3s8r7WengAjih+dFl0FaIwJunkbqqO1//
         +zqDExJqODZ9tPagJOg36pSiu+F3oF2qeINiWQAcYtC/aqDJHv4w0nWiPxq6A9LtAu5u
         xBGADPUXau1qZHbwjrOlc7iGni77Hu2DQjAh/aYSapePFVn3TBfAwpDWH+AbTNTfHk6g
         BlVYaQq5XjKLQdX/Pewo8NktmMuxvKBg4EYlss+mkRypAuW3gRlL/VA32v/VeVpTC/Yr
         XQk6szn1H4inQ+eHg35p/M9PoxRqvvValLbW3lgsCoeoZWrHg2yFhYeeykbtkfSV0wjU
         W6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1iqExXEzf2x4/9GMygCn9AQ9vmPdeayIDTBCgm5byrE=;
        b=VtgGrMOLIyDUDixf+xvfvUP8H/XzYPxpdlcEBehkUcsL+rjDRUGWlb0CmD5+d3zPhi
         AvUrBGTCbedmU7T+snR5D+3iB4ViS1P0XUIVK6OyV9HD3m7kWFJw0T12c2nt1nxf7tcn
         EyS8FCLAe76szW4OZU15nwu1Q0JTiPDpHsESvklxxs8vgHNv+Uu03VS3x7b7I6TrinnE
         64nEz45TT6gE/AWKarIhUc+g4Rl8uC6F45sV/iq4nxr/7i3rcF4Z+m8X1G8XFCXAPFAv
         4FidhLBaFmF0KccH+5iA9apkGPM1mjGPQyeK9cQBDMmHakU+eyyfDEGw/b7mDDaj9x4w
         AVzA==
X-Gm-Message-State: AOAM532FwYpHE7nfvak9i6MZ/Em3AFGOpfl50OC/yKOYBVu49GcfU4Qp
        rKyKcblBVHiBj16O8Vm4X6s=
X-Google-Smtp-Source: ABdhPJy4OlyoYVKpDY/2VURggwqCrufN6pi4DpbvTjRcadGixrTB3/EYX5PF6CBl5b4j6vk1ddSdEw==
X-Received: by 2002:a17:906:3cb:: with SMTP id c11mr29295208eja.404.1633518746197;
        Wed, 06 Oct 2021 04:12:26 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u19sm10124729edv.40.2021.10.06.04.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 04:12:25 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: ab/config-based-hooks-N status (was Re: [PATCH v5 24/36]
 run-command: add stdin callback for parallelization)
Date:   Wed, 06 Oct 2021 13:03:38 +0200
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
 <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
 <patch-v5-24.36-bb119fa7cc0-20210902T125110Z-avarab@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <patch-v5-24.36-bb119fa7cc0-20210902T125110Z-avarab@gmail.com>
Message-ID: <87a6jmiezr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 02 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

Emily, there's a...:

> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
> index 7ae03dc7123..9348184d303 100644
> --- a/t/helper/test-run-command.c
> +++ b/t/helper/test-run-command.c
> @@ -32,8 +32,13 @@ static int parallel_next(struct child_process *cp,
>  		return 0;
>=20=20
>  	strvec_pushv(&cp->args, d->argv);
> +	cp->in =3D d->in;
> +	cp->no_stdin =3D d->no_stdin;
>  	strbuf_addstr(err, "preloaded output of a child\n");
>  	number_callbacks++;
> +
> +	*task_cb =3D xmalloc(sizeof(int));
> +	*(int*)(*task_cb) =3D 2;
>  	return 1;
>  }

Probably trivial to solve failure here in t0061-run-command.sh if you
compile with SANITIZE=3Dleak. This failed in combination with my[1] (but
for anyone reading along, this patch has been ejected from "seen" a
while ago).

More generally: The equivalent of 01-07/36 of this series is being
merged into "next". As described in a plan to submit this topic
incrementally I was hoping to do 08-20/36 next, i.e. up to "run-command:
remove old run_hook_{le,ve}() hook API". See [2] for that plan.

You've been inactive on-list recently, it would be nice to time this so
that by the time it gets to 21-36/36 (which I was planning to split in
two per [2]) that you'd have time to review/help with outstanding issues
etc, for eventually re-submitting your "config based hooks" on top once
this all lands.

1. https://lore.kernel.org/git/patch-02.10-9a8804e1d9a-20211006T094705Z-ava=
rab@gmail.com/
2. https://lore.kernel.org/git/875yut8nns.fsf@evledraar.gmail.com/
