Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DEBFA3745
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 16:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbiJ1QQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 12:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiJ1QPj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 12:15:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBAF4F381
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 09:14:20 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id sc25so14004684ejc.12
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 09:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1cw2GzACeGHdaURc3xLC5pAMnNA7qY2a6kx4zf7/evI=;
        b=C4s9RTHhuFtPDp0L+mAY625eU/+A6VpeWllutr4g22BPybP2ijz08Ki8lBvuJqsBkV
         VIukYK5l3cGNIGQyMx7WA1RoOxvydW3ZjiYTyyqq/YWt3taZotoAq9zjVnGc7Fz7HLPq
         F9kS5RRBS/hcKg97N1APXK9vrE7tI4V6HaHhBwet+FDI8aipK0+Bw9nBHtJHlwb1YCRF
         ol8QMYx5imL68/gkLTiJcXIdQm9w4a1i4qHbujzU/oVpo8YCYYc/8dHlfZM6t+FHy+mo
         tW9fu7/Bdknp2kR0FtlmDknqG96X17NildaT0id1x9SXkHECr7Ks6WMSwhjTwEPH0u6/
         ZHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1cw2GzACeGHdaURc3xLC5pAMnNA7qY2a6kx4zf7/evI=;
        b=MTO3/6Eh59m7ak+nnjEv6H2jis3XmoXWLv8tOCxqDEpOEMdCJ9hpegWxFJvFme1smb
         7iM5fMYbaOPO0PMWXeHWD7dBgzYO/hXMzD86QhWavWAS1BIQbCj5pBRTpyaS0hAfqrqT
         aDFw35bDewHCHDKd9L/En49jkVushpjhG+BL6mWDPHyqGRDOXb/wSshB3ihtPD06YW1a
         QgA+Nrd4mX+8LdBbInrUQJTEzELZqF9JIOWp9n0cyDyxN+DnRehB2Npy/8Q+cu5rU8Jo
         kpGndTU/La3yhJKnnlFrkFZ1Bu54GMXnL2ibu9etVJl4jniiQguXx1+BeHJquME4Uz06
         ldiw==
X-Gm-Message-State: ACrzQf0RJCbUGvnAFhkkLVWt0xrJhRxMEWuWDE8K3dYIPUXk2uWTq9RW
        VuEYMbbf2BLYT/AtVZwsyys=
X-Google-Smtp-Source: AMsMyM7lWY+K78IaVMSM1AxkoyGlHqjPMjtPXEXOpoKNKpXfl/l3aVr+OSwu7WM5xDBGSKzi/zfaoQ==
X-Received: by 2002:a17:907:7b95:b0:72f:9c64:4061 with SMTP id ne21-20020a1709077b9500b0072f9c644061mr73325ejc.351.1666973658751;
        Fri, 28 Oct 2022 09:14:18 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id d19-20020a170906545300b0073dc4385d3bsm2363272ejp.105.2022.10.28.09.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 09:14:18 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ooRzt-009wsB-0d;
        Fri, 28 Oct 2022 18:14:17 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/8] run-command: remove run_command_v_*()
Date:   Fri, 28 Oct 2022 18:11:35 +0200
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <221028.86edusan0k.gmgdl@evledraar.gmail.com>
 <749f6adc-928a-0978-e3a1-2ede9f07def0@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <749f6adc-928a-0978-e3a1-2ede9f07def0@web.de>
Message-ID: <221028.8635b87wo6.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 28 2022, Ren=C3=A9 Scharfe wrote:

> Am 27.10.22 um 23:46 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> - I wish C had a nicer syntax for not just declaring but squashing
>>   together compile_time bracketed lists (think set operations). But the
>>   below "CHILD_PROCESS_INIT_LIST" is a pretty good poor man's version.
>>
>>   I see gcc/clang nicely give us safety rails for that with
>>   "-Woverride-init", for this sort of "opts struct with internal stuff,
>>   but also user options" I think it works out very nicely.
>>
>
> That's a nice and simple macro.  I played with a gross variant =C3=A0 la
>
>   #define CHILD_PROCESS_INIT_EX(...) { .args =3D STRVEC_INIT, __VA_ARGS__=
 }
>
> which would allow e.g.
>
>   struct child_process cmd =3D CHILD_PROCESS_INIT_EX(.git_cmd =3D 1);
>
> Yours is better,=20

I actually think yours is better, anyway...

> but they share the downside of not actually saving any lines of code..

To me it's not about saving code, but that it's immediately obvious when
reading the code that this set of options can be determined and set at
function or scope entry.

We tend to otherwise have creep where the decl and option init drifts
apart over time, and with complex init's you might stare at it for 30s,
before realizing that between the decl and fully init ing it often 50
lines later nothing actually changed vis-a-vis the state, we could have
just done it earlier.

I think that's worth it in general, whether it's worth the churn in this
case...

>> - We have quite a few callers that want "on error, die", so maybe we
>>   should have something like that "on_error" sooner than later.
>
> We could add a die_on_error bit for that, or start_command_or_die() and
> run_command_or_die() variants (there I go again, multiplying APIs..).
> They could report the failed command, which a caller can't do because
> the internal strvec is already cleared once it learns of the failure.

*nod*
