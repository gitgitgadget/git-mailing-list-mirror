Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57145C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiGYMEb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiGYMEa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:04:30 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9C818E30
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:04:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l23so20182478ejr.5
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=VxKW5M+HxigphS9XfDTJgunygJSMOD6fm7cVMgMegPg=;
        b=hhRLmcgxc0f0fZaXaM2DD+hlWRq6VdBAT07ECinUY6MkT2V5Zo7Ox/63nhY3zOwFzX
         JzXboxPxdy82IQrOj8th6LlfxScsdolNrBEpA5ovP8tfJOLj6LPsLuMS2rhdWyZcgz6j
         ST94WHCmA8yVK00UBvuPRvJlVFfJ6uPdOlDWVhjZnCTmIj0CJBmKNzSA3GVRz/d2v/1L
         DVjcPWxKC02+L+SZ2HnoUPJNndwqyZK/8gthkTNSkUHPwZ7nkUIgggJndI3FUGrUKEh+
         vmegUEOZHB8GffJUqNQi4vmBQNWBNhVm2XqZ4NmlItulNiLWHmlDliApnWhX4gQhfr32
         fdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=VxKW5M+HxigphS9XfDTJgunygJSMOD6fm7cVMgMegPg=;
        b=bJ4f9I+LUPmneqsybIOl+fJgm2i8IcgGHSSIIKzPz82DUW/su9kOTfDcEouJclMDbT
         AsWsyb9tgaFmCb8G7ylvMhl71TW5y2BTrXk11XUcrrnmfHsvmE6P3nVI8/kTCrsf2H/J
         MgBlLCWCOsN80Bo0GNbJCYcka/qZy8GvgXSCrKkXETxdZmv3k7ei44DZ1L99l5oyaOh9
         FNcIX5tlZ2zm5svbVYN4sjxt0NzrGM2A5YrsPfA7VkfKt+RPPE27+erxC+/d3VaVAz52
         iMbCHTXXg7ztFba/x9vhFJcB1USDJrX6h/Mv0bmq02JsdAPP++rrqr+EoSKgcDOUo4JG
         zQpw==
X-Gm-Message-State: AJIora/D2mMIvGu6KZ1TbJXe2/2qOceNWJl5/1LKbISEu8lDoqjW0xbC
        21sTP3EhpyqnoVnv06bwQX4qU349C74=
X-Google-Smtp-Source: AGRyM1vOT2RgaNRg52jg2DijIvQxjcKdElKc8XKEs9RKhgx6H9HcX9vi2MBEl34mW5XYLrgGZeX5Xw==
X-Received: by 2002:a17:907:96ac:b0:72f:1dea:5b66 with SMTP id hd44-20020a17090796ac00b0072f1dea5b66mr10113508ejc.266.1658750667596;
        Mon, 25 Jul 2022 05:04:27 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id l7-20020aa7d947000000b00437938c731fsm6985729eds.97.2022.07.25.05.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:04:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oFwp0-005frd-16;
        Mon, 25 Jul 2022 14:04:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: C99 "for (int ..." form on "master" (was: [PATCH v3 4/5] merge-ort:
 shuffle the computation and cleanup of potential collisions)
Date:   Mon, 25 Jul 2022 14:00:05 +0200
References: <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
 <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
 <d3eac3d0bf6539d81751813d89ec5158dcb57338.1656653000.git.gitgitgadget@gmail.com>
 <220701.86o7y9b2ys.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <220701.86o7y9b2ys.gmgdl@evledraar.gmail.com>
Message-ID: <220725.86zggxpfed.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 01 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Jul 01 2022, Elijah Newren via GitGitGadget wrote:
> [...]
>> @@ -3106,6 +3105,7 @@ static int detect_and_process_renames(struct merge=
_options *opt,
>>  {
>>  	struct diff_queue_struct combined =3D { 0 };
>>  	struct rename_info *renames =3D &opt->priv->renames;
>> +	struct strmap collisions[3];
>>  	int need_dir_renames, s, i, clean =3D 1;
>>  	unsigned detection_run =3D 0;
>>=20=20
>> @@ -3155,12 +3155,22 @@ static int detect_and_process_renames(struct mer=
ge_options *opt,
>>  	ALLOC_GROW(combined.queue,
>>  		   renames->pairs[1].nr + renames->pairs[2].nr,
>>  		   combined.alloc);
>> +	for (int i =3D MERGE_SIDE1; i <=3D MERGE_SIDE2; i++) {
>
> The "int i" here will need to be pre-declared earlier, per: 6563706568b
> (CodingGuidelines: give deadline for "for (int i =3D 0; ...", 2022-03-30)
>
> I also don't mind us just saying "we've waited enough". Junio?

This case got fixed, but per the changed $subject others have snuck
through.

Since be733e12001 (Merge branch 'en/merge-tree', 2022-07-14) we've had
these forms on "master", see 6debb7527b0 (merge-ort: store messages in a
list, not in a single strbuf, 2022-06-18) and cb2607759e2 (merge-ort:
store more specific conflict information, 2022-06-18).

We could "fix" those, but per the above I think it's just as valid to
just move up the deadline & say that 2.38.0 will have a hard dependency
on this C99 feature...
