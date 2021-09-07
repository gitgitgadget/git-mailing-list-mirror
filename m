Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFDDC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 23:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB5160F01
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 23:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhIGX2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 19:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhIGX2A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 19:28:00 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65F3C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 16:26:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i6so277096edu.1
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 16:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gYsGPkE5eeIRX3SysT2+d4QDBMW1vDZKtmhKleYk2jE=;
        b=aKCs+RuPTPv2X0AEc+mcnCSC4nXw5tqDZg/af/+chYecGy9IdKdy7z51mmH9y3aXQT
         UaoDR4o3+lKquTaoEzYRCAgAuFy/hx3Gh1nQ3vDSwZLrCOQU/RXwnBApwZ7RNGayLm+p
         DAz7F4CecnEyM/AA9lkBQxMWYEPHzS1fEDn3mMEYWAoIEBg73JCy9Ltr0BWWk/uXGMZo
         msmkHXFuZyGt1zBsJ6siApJYKuhnB3DwAiJGVU9LcodaU092b1l/SOw23g7TayCAm6Li
         o6Uwmy2k21myfl+cGY9PEUeePx2k5hl3L5ZRayXye786gSsCWZa3gtXwVDgqiKvDM3lT
         UyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gYsGPkE5eeIRX3SysT2+d4QDBMW1vDZKtmhKleYk2jE=;
        b=fYCjUzPH3RQJ0a8MX02sO7jvSPoPNLE86tXGQwQzT1FbkHB+ko82OTuHR4CFA8jz1x
         Dt92n426gFLgh6To5GO2aDFMKrF5sP6ywoyffONH0Jmds9kGStqi8hU0vY40YMmZD4Fm
         /jq7Cj2v+fpMysSISQmcyEsfbbXC3/AuyWgSkwizpsvIT6bIBFtw7bTbsjyE9365G0dB
         VBete4WM4fQfAKzhJ3+rkAXaKGOT7RQFUQwn3SrV1MUu8VxXttbO6gHJ7xQs2CNYAFMc
         Ov4n8+sgRjOGOFukYmBtwvLMtUQZqB9Ky3EoYmmRfXVPFOikweu+5CVZFz3iOqOop7fd
         7X2A==
X-Gm-Message-State: AOAM5306OPZMyeaBOi3jqZuHodRroMUFJiyfwZuADEE20ycsC3RSqp7x
        syEhgymsTtW7Hgc112E4Q9U=
X-Google-Smtp-Source: ABdhPJx37SdL3Lg6OAJOp505WfX/fG9UPwePKU8CjXjiT13br0LNBRWOdz0cX1aCTmrULz2D50zFnw==
X-Received: by 2002:a05:6402:22b3:: with SMTP id cx19mr779387edb.238.1631057212364;
        Tue, 07 Sep 2021 16:26:52 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v10sm202188edt.25.2021.09.07.16.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 16:26:52 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] pack-write: use more idiomatic strbuf usage for
 packname construction
Date:   Wed, 08 Sep 2021 01:22:05 +0200
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover-0.3-00000000000-20210907T193600Z-avarab@gmail.com>
 <patch-1.3-0e6ef07ce00-20210907T193600Z-avarab@gmail.com>
 <YTfl7U93ttUQu2jc@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YTfl7U93ttUQu2jc@nand.local>
Message-ID: <87pmtkj7b8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Sep 07 2021, Taylor Blau wrote:

> On Tue, Sep 07, 2021 at 09:42:36PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Change code added in 5889271114a (finish_tmp_packfile():use strbuf for
>
> s/Change code/Code/ ?

That would make it:

    Change code added in X (...) to do strbuf_reset() instead...

Instead of:

    Code added in X (...) to do strbuf_reset() instead...

> (I wondered also if the missing space in 5889271114a's subject line was
> intentional, but it does appear in the original commit.)

*Nod*, it was automatically generated.

> Reading this patch, I'm not sure I agree that this makes the later
> changes any easier. To be honest, replacing things like
>
>>  	if (rev_tmp_name) {
>> -		strbuf_addf(name_buffer, "%s.rev", hash_to_hex(hash));
>> -		if (rename(rev_tmp_name, name_buffer->buf))
>> +		strbuf_addf(&sb, "%s%s.rev", tmp_basename->buf,
>> +			    hash_to_hex(hash));
>> +		if (rename(rev_tmp_name, sb.buf))
>>  			die_errno("unable to rename temporary reverse-index file");
>> -
>> -		strbuf_setlen(name_buffer, basename_len);
>> +		strbuf_reset(&sb);
>
> Does not much help or hurt the readability, at least in my opinion. One
> advantage of the pre-image is that we're doing less copying, but that's
> probably splitting hairs at this point.

> So, I would probably be just as happy without this patch. You mentioned
> that it makes the later changes easier, but I couldn't come up with why.
> I may be missing something, in which case it may be helpful to know what
> that is and how it makes this change necessary.

It's not that continually appending/trimming the strbuf is per-se less
readable than having a "prefix" and copying/appending to it, and as you
point out this moves us towards more allocations, but in this case
that's not the bottleneck.

It's that if I retain the current pattern while splitting up these
functions I'd need to pass a "basename_len" owned by the caller between
the two, and we'd end up juggling the "tmpname" as the "if
(write_bitmap_index)" codepath is moved around.

So just having each site get the prefix and add its own suffix seemed
much easier to deal with,.
