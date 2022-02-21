Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3B5C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 20:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbiBUUU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 15:20:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiBUUU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 15:20:27 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124DD1A399
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 12:20:04 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id q17so31865721edd.4
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 12:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=60LoBkelbAvd2dq5FaCB+jT22N1ipNU4bq4IJtjcSsg=;
        b=OpMChaZMc3KvzJKXRIZfsuXCsrYE4xOGpaEWY+XYnQOljrX2TAPuyccFds5zMIFT/B
         JZWOx1oxKXxkLX7ZcB7DUWjeYuLTtzCdFrJLaYBoC81gOT9PKUHzytabRs2x42aYcUpA
         9vDHrw+smPwaFkJ+2eCNv6OiZQA9M3rGQ9gO5bvyaIc8IpBs0fE+5//wxgIRVtKtKS4V
         juxbygHN2ZyNAcKYLTkNtrIYAJ+vcbu1uWo8AliAMUgl3ilJVgRoY5UJHVZduS+75PbO
         39Hjp97XNsHKS2/C/gTZeoNVsOBn0rbenDPH1xK/PKnqJ0T53FSYQi8SjdUBdgdQ+aqd
         vUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=60LoBkelbAvd2dq5FaCB+jT22N1ipNU4bq4IJtjcSsg=;
        b=U1TyTFuDe3a8xncq2fZJlXbPt08E6zvC7PbI6+Iz1jXqADADtA7fXTem4JV8i3k5/j
         vszLmvw1jX6EFvQ+j9mpawj4D6jaSN4km49EZGua47ax1pcRlsppIOCF2JuEL7VrfOmS
         zjUNRsqQYaUFKEq9r+pFU8F+8v4gI4ianHBe3GEK42ivtOIU84rdSk7pJsGO8197Or09
         flNhgcwu7iJ/ecxpbkbqdvZf7dcf6NTnG0qE2crPSUplVHzXR65rIExqc+nTN812frZG
         rqZKvrO/DtWHMkYAmkMWXWxdG27G4zB76s8YSgREeCOtgVDpfl8oSY/AtNNm1nwIrCy3
         RsXQ==
X-Gm-Message-State: AOAM533Hhotzn+ObIHEAzRc2/0ewcbtso5E3slE7LTMv/x4vKXA6u6Xq
        WsAPHlk8Jm18eLZXAtoqPL8W9iN8LP6s3A==
X-Google-Smtp-Source: ABdhPJwEUa0xzfbKOmnQcglj1nDe9bylYEmkTpONZJKwQdY+wcXj0aKOn9boXKqQgLX/0qhQatFnbg==
X-Received: by 2002:aa7:cc82:0:b0:410:d2b0:1a07 with SMTP id p2-20020aa7cc82000000b00410d2b01a07mr22599050edt.359.1645474802192;
        Mon, 21 Feb 2022 12:20:02 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id n2sm5659583ejl.55.2022.02.21.12.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 12:20:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMFA8-005ojw-Rr;
        Mon, 21 Feb 2022 21:20:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6Bu?= =?utf-8?B?IFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/8] Makefile: optimize noop runs, add shared.mak
Date:   Mon, 21 Feb 2022 21:17:25 +0100
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
Message-ID: <220221.86mtik9dlb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 24 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

A gentle reminder about considering picking up this topic that got lost
around the holidays.

This one is independent of the other Makefile topic I've got outstanding
at
https://lore.kernel.org/git/220221.86r17w9dsq.gmgdl@evledraar.gmail.com/

This thread doesn't have any reviews, but I see that's because I screwed
up and omitted the In-Reply-To at the time. There was feeback on the v1
of this:
https://lore.kernel.org/git/cover-0.8-00000000000-20211217T012902Z-avarab@g=
mail.com/

That v1 was in turn split off from a larger series, and as the
range-diff for that v1 shows the split-off version was was mostly
unchanged from that version, which had a few eyeballs on it.

> As the v1 notes (among other things):
> https://lore.kernel.org/git/cover-0.8-00000000000-20211217T012902Z-avarab=
@gmail.com/
>
>     This speeds up noop runs of "make" by a lot. After a "make" running a
>     "make -j1" with this is ~1.5 faster than on "master"[2], and around 3x
>     as fast with "make -j1 NO_TCLTK=3DY" (the TCL part takes a lot of tim=
e,
>     but that's another matter).
>
> This v2 re-roll addresses trivial commit message/comment grammar/typo
> issues pointed out by Eric Sunshine, thanks Eric!
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (8):
>   Makefiles: add "shared.mak", move ".DELETE_ON_ERROR" to it
>   Makefile: disable GNU make built-in wildcard rules
>   Makefile: define $(LIB_H) in terms of $(FIND_SOURCE_FILES)
>   Makefile: move ".SUFFIXES" rule to shared.mak
>   Makefile: move $(comma), $(empty) and $(space) to shared.mak
>   Makefile: add "$(QUIET)" boilerplate to shared.mak
>   Makefile: use $(wspfx) for $(QUIET...) in shared.mak
>   Makefiles: add and use wildcard "mkdir -p" template
>
>  Documentation/Makefile |  63 +++-------------------
>  Makefile               | 118 +++++++++++++----------------------------
>  config.mak.uname       |   1 -
>  shared.mak             | 109 +++++++++++++++++++++++++++++++++++++
>  t/Makefile             |   3 ++
>  t/interop/Makefile     |   3 ++
>  templates/Makefile     |   8 ++-
>  7 files changed, 160 insertions(+), 145 deletions(-)
>  create mode 100644 shared.mak
>
> Range-diff against v1:
> 1:  f74b47662b7 =3D 1:  b652fc78fda Makefiles: add "shared.mak", move ".D=
ELETE_ON_ERROR" to it
> 2:  b0c63abe091 =3D 2:  b0c9be581a6 Makefile: disable GNU make built-in w=
ildcard rules
> 3:  c6c6f7cf8d8 =3D 3:  ed6fd1c0bd1 Makefile: define $(LIB_H) in terms of=
 $(FIND_SOURCE_FILES)
> 4:  ed64cd1bd4a =3D 4:  4c6d8089fff Makefile: move ".SUFFIXES" rule to sh=
ared.mak
> 5:  1749085b929 =3D 5:  f1f02c71dbc Makefile: move $(comma), $(empty) and=
 $(space) to shared.mak
> 6:  c25284b24cf =3D 6:  fb877060d6b Makefile: add "$(QUIET)" boilerplate =
to shared.mak
> 7:  3daef7672be =3D 7:  90d804ea9a0 Makefile: use $(wspfx) for $(QUIET...=
) in shared.mak
> 8:  aca560ca410 ! 8:  59c1b7032db Makefiles: add and use wildcard "mkdir =
-p" template
>     @@ Commit message
>=20=20=20=20=20=20
>          But as it turns out we can use this neat trick of only doing a "=
mkdir
>          -p" if the $(wildcard) macro tells us the path doesn't exist. A =
re-run
>     -    of a performance test similar to thatnoted downthread of [1] in =
[2]
>     +    of a performance test similar to that noted downthread of [1] in=
 [2]
>          shows that this is faster, in addition to being less verbose and=
 more
>          reliable (this uses my "git-hyperfine" thin wrapper for "hyperfi=
ne"[3]):
>=20=20=20=20=20=20
>     @@ shared.mak: ifndef V
>      +## needed.
>      +##
>      +## Is racy, but in a good way; we might redundantly (and safely)
>     -+## "mkdir -p" when running in parallel, but won't need to exhaustiv=
ely
>     ++## "mkdir -p" when running in parallel, but won't need to exhaustiv=
ely create
>      +## individual rules for "a" -> "prefix" -> "dir" -> "file" if given=
 a
>      +## "a/prefix/dir/file". This can instead be inserted at the start of
>      +## the "a/prefix/dir/file" rule.

