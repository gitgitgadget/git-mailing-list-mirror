Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34186C48BCF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 13:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05BA261153
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 13:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhFMNdJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 09:33:09 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:33373 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbhFMNdH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 09:33:07 -0400
Received: by mail-ed1-f45.google.com with SMTP id f5so37915361eds.0
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 06:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=y5LFNVrY65YM2rKT8+aZ4G3GuLBtTpTJoMeUnmXNyZs=;
        b=UupdG+bWIT4G9lT9In5ptwrEnXf+IY6wK6Xk9CcySfEYO5mYRi6KoILHwE2N/88ztU
         hcf2ngTuB84yrb2IMbr6zD/bS1juoK0IOOfsJlEDzGUwwceafDPZ79eyJ89SdmraOyHq
         dpGap0NPAGq8zpLwlS4flb/Yx3lrRQWLNtRcuhxhI2PkOihNVSJcsvxItY7e/qtMeVob
         ThVaYuRSuwHdpvEcmBdHSOGFhN1b7ZvtcQWg8CfBVEy/4ExD8QS7KbSkGRMaGlVA8nV2
         Co6U1rl4/B8v9472+iv402nnGJxrxmLUxNeL8oK6EeeqE5hjhnEQDE8eLAHZPGeOLTky
         twKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=y5LFNVrY65YM2rKT8+aZ4G3GuLBtTpTJoMeUnmXNyZs=;
        b=SEyhzETXiNU1dnAjJHeB29HwCOj67hmfBeF0fh/H5kHYVTFx9woiGH1S9EAt4DRUxT
         utN8NCMLIeYl6+AKh0kvkD85LULJAeomB9m28gwrEVfi02zkX2kRIwaLMBnDkBx8R0W+
         ZAwZ8vKH5ytxl9neA/CNJ2Ql7liJcvvzlW1Rqo/77Gr69VBOOB+/mBtuH7WP8fAGNX9X
         5qxzYkMt2I+xacasNrJgEGl0qitN4POW3UxvCUNltiVNVRGrkj+XqVrprn9p2/1kSyRA
         iwky74rEQVJ0jOeiFyAkqAjH6WwchMvewVgd8btnNBXOrKZ3ZrWVygsXQg0Ex9DaIbVi
         UD6A==
X-Gm-Message-State: AOAM530Wy/RS47Y0rLGOvzhHQzaKb+M8F/e5IJ+Om6OQrsN7t+bButXs
        EITeptOfwUHyBa6NfALBrc8=
X-Google-Smtp-Source: ABdhPJw3sWgvUpRswuzQDGoZMK+I3RuIoViuc/Clq6Pe14bhCkJLuflaohEsbvA/XK+/KPREiPpMFQ==
X-Received: by 2002:a05:6402:b82:: with SMTP id cf2mr13017561edb.351.1623590992589;
        Sun, 13 Jun 2021 06:29:52 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x3sm4765901ejw.69.2021.06.13.06.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 06:29:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] test-lib-functions: introduce test_line_count_cmd
Date:   Sun, 13 Jun 2021 15:28:58 +0200
References: <20210612042755.28342-1-congdanhqx@gmail.com>
 <20210612042755.28342-2-congdanhqx@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210612042755.28342-2-congdanhqx@gmail.com>
Message-ID: <87bl8928q9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 12 2021, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> +	   { test "x$1" =3D "x!" && test $# =3D 1 ; }
> [...]
> +	if test "x$1" =3D "x!"=20

We don't use this test idiom in other places, it's OK to just use "$1" =3D
"!". I think we're past whatever portability concern made that popular
in some older shell code in the wild.
