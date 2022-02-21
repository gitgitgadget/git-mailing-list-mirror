Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47ECC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 18:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiBUS4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:56:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbiBUS4E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 13:56:04 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD87249
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:55:40 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x5so31197991edd.11
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 10:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1CYsGL+3/uEAr9AkhJ67/TTeJnwuMvCPHO3LkgWY2AY=;
        b=D+Uq8s0udg0r7oFC+GIVOkqMcIE3bxy4FLVxnYLQyFC2wVRH+wj3wyW9rAuVAvC6nT
         g38GqLSAMy2UMABEP8B1OPRScWDXBR0V6WxBmc/Mu9df21X0hSRf+kVG/aFXwU+GwH5J
         wjSB7Veygdy3VgLWR8bzlmDiv16bL+Q4Xtjn/UfYjhLDFFpYPHcABmvTx9IKZ035LL+m
         64nE/ffWGOEgLoyBK8E1eflB69f/CoBmOf3kCkENp5A3YaMi70kw4J3WVzFGlHRdhD8p
         5EP+DLPrFs94iqk+1tD1nxSLc95wV50NoAdat6oUNqydRuE71FI2Zq5QHQSugjqcuAM8
         9Teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1CYsGL+3/uEAr9AkhJ67/TTeJnwuMvCPHO3LkgWY2AY=;
        b=t/dcaLQyoufPM0H9imNyuTq0P+fORwuLAPNmlRLGFnmY6U5F95TQ884D302dJMGuFf
         gUMr8BXWHBCEhIDT8tzRH3kl5f5k5ecxXrucuHGVe5VbSferXPIilGL9Gj5A6tHwRq84
         dnALFymWynXx6H4rJgragFkUL1YVBnGfrT8x0a+Uj7Yk9wuGBkrErlpsWhqiWxwqR+ui
         JwyoEzlutcUqvQEw8YddVaeyF3JkBr5dccWt1j900DeqItCd9BdMLbFqBfirVHidxWd1
         cSn/C1bFscDKAuogn8/FxP2QgqdjEJ9AxWMvQEl3duSNSWMZY048Lx+0ZJImc4bdI19G
         YxEA==
X-Gm-Message-State: AOAM530vhNota7lEx0ZyigjjYA+NZxOf5knJo22Iou3aobfzAyjkqgc9
        HgCknvmkmIQ3oK77KUgXESM=
X-Google-Smtp-Source: ABdhPJx1VqkzfL/8lBuqR5kG8VWmgSjfPPOshAbxdchxC0gH4exJnkviFOe0P5Hz0RXLHNGm4wgYhA==
X-Received: by 2002:a05:6402:144b:b0:410:b990:a68a with SMTP id d11-20020a056402144b00b00410b990a68amr22864725edx.25.1645469738970;
        Mon, 21 Feb 2022 10:55:38 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y11sm5402004ejk.210.2022.02.21.10.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 10:55:38 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMDqT-005ksn-8y;
        Mon, 21 Feb 2022 19:55:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/4] test-lib: improve LSAN + ASAN stack traces
Date:   Mon, 21 Feb 2022 19:55:24 +0100
References: <cover-v2-0.4-00000000000-20220219T112653Z-avarab@gmail.com>
 <cover-v3-0.4-00000000000-20220221T155656Z-avarab@gmail.com>
 <xmqqo830ta0w.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqo830ta0w.fsf@gitster.g>
Message-ID: <220221.86czjgaw2e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 21 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> A UX improvement for [AL]SAN stack traces. See
>> https://lore.kernel.org/git/cover-v2-0.4-00000000000-20220219T112653Z-av=
arab@gmail.com/
>> for the v2.
>>
>> Changes:
>>  * Renamed GIT_XSAN_OPTIONS to GIT_SAN_OPTIONS per Junio's suggestion
>
> Heh, I wasn't suggesting anything.  I am OK with or without X, or
> with X but X replaced with anything else ;-)

Ah, anyway I'm happy with this version, so unless there's another reason
for a re-roll...
