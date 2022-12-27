Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB17C4167B
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 18:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiL0SSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 13:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiL0SSK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 13:18:10 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D17E91
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 10:18:08 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id i15so20068139edf.2
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 10:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1SFXcFOdfHG94TQK85eslxXXNO9ThCwvl/v+0Visupo=;
        b=ZIdlRoI2q6tWvRTWaj8mTNCVHpm9EXDplNTTMSdEOOpzFrR79rfUVr37/M+c5A3zBj
         7KKo0IC7RSPLvIzM+RcrL2sdfTuIoRclE4rvgMxmk4oNcFgooSK36KsOCps+ArfsCW63
         vKpnwgmy/MVtKg/S/WOdjHw0OsjsTTayEnYXmaQNSs5a9M0qFQTJZT+OXL7s5FEX39rv
         St4t89pEDoz5zds9utrytR+iNcwLB9ioTjQTwcDUwzofc7fcjPndMezIGuOgbbf4T7BQ
         qpEKdC/z7f6DPYTJUsIhNOdIAmjTFUvpVxmeY2D7kRv76EA2Pe1/p1nb4vxW5/NpMHv1
         MENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1SFXcFOdfHG94TQK85eslxXXNO9ThCwvl/v+0Visupo=;
        b=Ne52NKBq9SKZhi7A7TpMSOqKRSyHA4hkTA8ep5aG3AIp6qHqyExQkWDKmBv0s+jGXz
         oQa1j9mKcyycsasfEWejRwhiyLXV6w9m9A+STNDk45/lETSQWcdKi3cxJa9Nsuu9uYXh
         hf6oHZc94Vp35E1BLEJUMUT1QuSh5AZB0ahRf62Upx/sOAYX292Gj35tVsZFXgwW5YfL
         bMwRrUbyxcGKqYLV6h6Zdvaj1Fqf2Fv6+AzCcI7vxicF4+4nzidlGXmJWxOithcK91Ib
         pNv77OPVtsS36uoh8/dwBFE8rrfpzYRJBP4dVlq5HJ4K8IaqkP+MGZBSw/KlJVzD3qX+
         mvYg==
X-Gm-Message-State: AFqh2kqlv4niGjiKYf06ylj0G42Xw4WEj2gfv4gVFp1tqiYV+1dWB2gx
        q1Hg/gQFX5fBFXlIrrYBiEJxJswfQDc=
X-Google-Smtp-Source: AMrXdXuFm2wLEHvMM3G1nC7+etWABCOCpWv5N1hCam+T2m4D/xstEEu3uJ/Ox1PbuxrSzW0CIHRdWA==
X-Received: by 2002:a05:6402:2932:b0:47e:bdb8:9133 with SMTP id ee50-20020a056402293200b0047ebdb89133mr22384056edb.38.1672165086927;
        Tue, 27 Dec 2022 10:18:06 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id h14-20020aa7c94e000000b0046f77031d40sm6115162edt.10.2022.12.27.10.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 10:18:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pAEWb-009MSI-2l;
        Tue, 27 Dec 2022 19:18:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 2/6] t/lib-patch-mode.sh: fix ignored exit codes
Date:   Tue, 27 Dec 2022 19:14:52 +0100
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
 <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
 <patch-v4-2.6-d351075f0ab-20221219T101240Z-avarab@gmail.com>
 <d9053dbe-a9b4-3d85-626d-0f1633058646@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <d9053dbe-a9b4-3d85-626d-0f1633058646@dunelm.org.uk>
Message-ID: <221227.86h6xgvhgi.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 27 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 19/12/2022 10:19, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Fix code added in b319ef70a94 (Add a small patch-mode testing library,
>> 2009-08-13) to use &&-chaining.
>> This avoids losing both the exit code of a "git" and the "cat"
>> processes.
>> This fixes cases where we'd have e.g. missed memory leaks under
>> SANITIZE=3Dleak, this code doesn't leak now as far as I can tell, but I
>> discovered it while looking at leaks in related code.
>> [...]   # verify_saved_state <path>
>> @@ -46,5 +50,6 @@ save_head () {
>>   }
>>     verify_saved_head () {
>> -	test "$(cat _head)" =3D "$(git rev-parse HEAD)"
>> +	git rev-parse HEAD >actual &&
>> +	test_cmp _head actual
>
> Aren't these two lines are re-implementing test_cmp_rev()?

It does --verify, and this does not.

Could we use it? Yes, but I wanted to narrowly focus on just fixing the
lost exit codes in this series. Once you start to untangle "save_head"
and "verify_saved_head" you'll see that whether we narrowly used a
helper here or not isn't the only thing we could improve.

But such an improvement would make use use --verify, and we'd then want
to use that "--verify" for the earlier saved_head too, etc.
