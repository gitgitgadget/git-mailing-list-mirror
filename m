Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE4BFA373E
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 19:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235065AbiJZTPQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 15:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235073AbiJZTOt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 15:14:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D8725EBE
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 12:13:27 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso3628947pjz.4
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 12:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6K+mQYeeMpaNYdI7t89iJFQpP/7bMTYZpLdTBNQUPY=;
        b=lmLvrGzjyN83FNYPdQ6410aqxTx+cvchAqUInZLGRgxPyTfLoz8DADYG0BPviFlvCt
         g70oKZboj/tAo6/EbcjdBR/IoZR/hqrh7C/i2n0+xdj1kCK5TWgyoTzz1N26BgZyUEqM
         IrnyaopypEwX/0lUD8CLiVIcbInV+2mFsD8xsmF47xU4ZpPyvoPRPZaKpUbeeFlW7bEY
         nrpV+NSVNHM2KZchyMTxqjAxV8aoBQ6QmTR1UG5Z3ZEzzjJkAccW0Yw1DJK6HcCWomf9
         ixK0ZCol5MnSoYkAP0DWYBmcc6YeLeNQ6JzWsNFklxE/Q4qGaW96dsvml2GB1SjpGKOq
         BoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6K+mQYeeMpaNYdI7t89iJFQpP/7bMTYZpLdTBNQUPY=;
        b=5MMYVWgs0UntaFYhCa7DEVQYGOS8F3ypjDRZ6dENGtv8VLz8I9uDPQsjVJ6ts7tJvO
         si29m1GTTntirUCpiaT+aJwJKsKrg2Bl+DBfAPorvO6OVaVXGdpiGsRNztoMJsSZh9ON
         kzos4I5S385uvGQwSufSFy31y4YBpbZC/Q4posDyWmpdQyOasuUJ67SxMBOolP5+t2h/
         B0waWdUFYL7cH3jveN0FNhx/sKK8jSDN7jsmat5o6fp3VvKwPBOmtJEKSrygMHJ39gxo
         +IMi89RVLTQnEZd7/TlL7Tm0Po5jaexbJVMkgtDske5mM3c7jle1fYq/keW5kT4ftEex
         nlAQ==
X-Gm-Message-State: ACrzQf3N+bwauVOVUu5Yry8XDo3l008xv2k5foADwIzAHfZCqcTvzHlI
        rZb/r21K+taeUa6TpAv7kbg=
X-Google-Smtp-Source: AMsMyM7DTAv2XcSrr4OBOXsQnHFyf6BLAr2HwfnTOBk09doi9pg/usGnhNalnnr2ZOtp2gJiaRs+CQ==
X-Received: by 2002:a17:902:ea01:b0:186:e4f8:e9e7 with SMTP id s1-20020a170902ea0100b00186e4f8e9e7mr2317618plg.21.1666811607005;
        Wed, 26 Oct 2022 12:13:27 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b00186e8526790sm308053pla.127.2022.10.26.12.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:13:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 2/3] Makefile: define "TEST_{PROGRAM,OBJS}" variables
 earlier
References: <cover-0.5-00000000000-20220901T130817Z-avarab@gmail.com>
        <cover-v2-0.3-00000000000-20221026T143533Z-avarab@gmail.com>
        <patch-v2-2.3-6dcb49f25c4-20221026T143534Z-avarab@gmail.com>
        <xmqqsfjailak.fsf@gitster.g>
        <221026.86y1t2beoj.gmgdl@evledraar.gmail.com>
Date:   Wed, 26 Oct 2022 12:13:26 -0700
In-Reply-To: <221026.86y1t2beoj.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 26 Oct 2022 20:47:43 +0200")
Message-ID: <xmqqeduugzzd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Wed, Oct 26 2022, Junio C Hamano wrote:
>
>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>
>>> Define the variables that make up TEST_OBJS earlier, and don't go back
>>> & forth in their definition. Before we'd first append $X to
>>> $(TEST_PROGRAMS), and then substitute $X back out of it to define
>>> $(TEST_OBJS). Let's instead add a new $(TEST_PROGRAM_OBJS) variable,
>>> which avoids this needless back & forth substitution.
>>
>> Makes sense, I guess.  So TEST_OBJS is no longer used?
>
> Yes, sorry I'll clarify that in a re-roll.

It invites the question why it needed to be renamed in the first
place, though.  If we needed to name something that is different
from the original TEST_OBJS, it makes perfect sense to add a
variable with a new name, but if it is not the case here, then...?

>> Having said that, "all::" being able to be built up with independent
>> pieces shine here in this split from the original.  It probably is
>> easier to reason about while seeing this isolated area of Makefile
>> what is being done to TEST_PROGRAMS.
>
> ...here I'm not quite sure if you want to keep it after all or nat...

I'll let it pass this time ;-) but my patience is not infinite.

