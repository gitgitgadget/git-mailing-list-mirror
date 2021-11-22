Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C25C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 21:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhKVVdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 16:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237508AbhKVVdW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 16:33:22 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381C8C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 13:30:15 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y13so82740724edd.13
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 13:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RbS1vsyvNpeoSmNFIhTkL71xZB2bCgecplPvv7sa6IA=;
        b=AvXJ/b/+CM0abVoKauWc/I8aAAg7mwMzXhKbeZBlWIKSAaG4YNwl/5emdFWBHQF9A9
         lRRSswQS+pBlIeRfeaXXh/CvOy9aYukZo0vjHrXp/sCL+8i8KVNJlA5dgyHQMi4kyPjY
         LaiU87XonKnIHzhd5n/5PZzcMIiboP0nwQ8qBJDnVwPQ+h4kCO80gEHVypASA3iLlagJ
         Yk//p2UNJIB0JYZI7tfOQcx3a5bWUKihgJDRt1CCwAeos7Tv0xh/BxXU5ntiyAsBmxC3
         h6hH14X2eSY4seaFjFawTfYr7NFGkUjHOc1sl/gxc1VE2bcs48as8Y1Lc6qwVdzW2PYc
         +hKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RbS1vsyvNpeoSmNFIhTkL71xZB2bCgecplPvv7sa6IA=;
        b=11UoiuUNlO2a7xa1X++q0XWJ7WW5/eyC85AiDy6fds01Kmcdx5mhxgMItWzUoElcwK
         H509k6GmfzR4AVn33RHzylECx//dnWfZ74BqCVx0VvOxw/GvicYNQ2h51RkpOJ0YpKi2
         eWpElwnfXKfFfBq/3bZFGquHkf+cuPrEgRIbTpECr4J7H0it6d4lZxO9lQ+j61NzilRK
         SDMIlD6294eyGuuSWwisOm3WZIhDNlhNdg7RViuY2vz2/S+PPtqmixD+I6Kz4pCXKitZ
         sGWKjAVp+68eeUCuWvKFyKt9N2xN3S2DRY1z1TQB8xWMx2RfiRkfBi+2IFNwALGwmJHN
         mm8g==
X-Gm-Message-State: AOAM532A5BltCW3/sVVo+gIfNgp8dPELIPl2UJJGaeb3e60+i6y4jXoY
        FgR6/bhx2wjivc1jI9dWpMk=
X-Google-Smtp-Source: ABdhPJyNueT/exOcmwiQa5NeQtG95n/kKq/EB7gWwoZPekepioswvpaWbiQlB2m27Iq4O9dpMT9x5w==
X-Received: by 2002:a17:907:2a8c:: with SMTP id fl12mr366713ejc.569.1637616613674;
        Mon, 22 Nov 2021 13:30:13 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m25sm4617189edj.80.2021.11.22.13.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 13:30:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpGtA-001Bmx-NR;
        Mon, 22 Nov 2021 22:30:12 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 3/5] run-command API users: use strvec_pushv(), not argv
 assignment
Date:   Mon, 22 Nov 2021 22:30:02 +0100
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
 <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
 <patch-3.5-fd6c4c960ba-20211122T153605Z-avarab@gmail.com>
 <xmqqlf1fevm7.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <xmqqlf1fevm7.fsf@gitster.g>
Message-ID: <211122.86bl2byj2z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> diff --git a/add-patch.c b/add-patch.c
>> index 8c41cdfe39b..573eef0cc4a 100644
>> --- a/add-patch.c
>> +++ b/add-patch.c
>> @@ -413,7 +413,7 @@ static int parse_diff(struct add_p_state *s, const s=
truct pathspec *ps)
>>  		strvec_push(&args, ps->items[i].original);
>>=20=20
>>  	setup_child_process(s, &cp, NULL);
>> -	cp.argv =3D args.v;
>> +	strvec_pushv(&cp.args, args.v);
>>  	res =3D capture_command(&cp, plain, 0);
>>  	if (res) {
>>  		strvec_clear(&args);
>> @@ -431,7 +431,7 @@ static int parse_diff(struct add_p_state *s, const s=
truct pathspec *ps)
>>=20=20
>>  		setup_child_process(s, &colored_cp, NULL);
>>  		xsnprintf((char *)args.v[color_arg_index], 8, "--color");
>> -		colored_cp.argv =3D args.v;
>> +		strvec_pushv(&colored_cp.args, args.v);
>>  		colored =3D &s->colored;
>>  		res =3D capture_command(&colored_cp, colored, 0);
>>  		strvec_clear(&args);
>
> We used to use the caller-supplied args, run-command API borrowed
> that strvec by pointing at cp.argv, and because it is borrowed,
> capture_command() did not use cp.args/cp.env_array and there was no
> leak inside run-command API side, whether capture_command succeeded
> or failed.  The code was using its own args, so it already correctly
> releases it (we can see one such strvec_clear() here).
>=20=20
> OK.
>
> I gave the remainder only a cursory look so I cannot call it quite
> "reviewed", but presumably all the other changes in this patch are
> the same way?

Yes, I tried to group all of these cases together.
