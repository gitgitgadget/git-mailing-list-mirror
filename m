Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6D9C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 10:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbiCDKpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbiCDKps (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 05:45:48 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0871AC283
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 02:45:01 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qx21so16548325ejb.13
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 02:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=6/BQI+B8KFpW8jWQMylfqwDJSV6Swy5LU/D1kSaoC44=;
        b=FFC1UadtpAqmfeYWeCZD14z+D0d7SMaSKOOcY9Trd1ynarXisJTYzU2RNeC+/LPmvK
         aeBHKmhdYVRE1GKo6Lq14Egw422rdpjXLrKZuIQGyHf5XIBMnx+UgEkIS39NNBtnhRTy
         U9ZyUahKKw2SWVfWBO67NjmnTMSObVFZPlcTtOKMP7jMof4BPInz9gw9a/vxTuvNbWeq
         Qr6yPPoEGas2z4oL6pXt9+6kOwLto6BOEHGEbQeqgAitEGGsBfNrugvgDSV+O6ngmU09
         X+rB/M2P7HN9D15iVHb9K5+ESGmrPHIDekI1sd/yIsfT/AAyreHO2KPFebqPRI3avI8k
         N0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=6/BQI+B8KFpW8jWQMylfqwDJSV6Swy5LU/D1kSaoC44=;
        b=Rzl+EXAmhs1EAvyBstjaQX/WYd/PfOMfwSbfcrm3jWC90XNSbL2TQKAavFHsgWWlbl
         7JrV731FymGzq2P1L499HYqoygb+g5aFJ3t5G5SQg+XVNzUvs2tncvg4utehcxOn1MlN
         e3vzeA2M8GrI07jUDFCzki1FwQNR3b7WpTFb16e8vDI9W6t7qB6+la0kEJrv37XfOTQc
         5biz+a7CWeUg2b1xqxBFRNLlr/ieaQv7HDEwYbFHXumFgwMjJK1fJbk0ltoGOiWX49P0
         Wv7ccLe8k9mzOWLzIe46b3olTep0irq8TdOW1+LaEkbxKhUBgUw/07uj0zPxUvqi+Mcb
         5XWg==
X-Gm-Message-State: AOAM531/EiOPibZ1K1L3F3Jhjb1FqxkXA6GGRY7oQUTxSvZYVq/8AWP0
        v4sR2ULltssT50ntyMDLpAY=
X-Google-Smtp-Source: ABdhPJxsf636M1wt7eQj2l6tumDVQzoJE6k7a+9E9r7/V8VEhsnCN1kzsOv8zLuWUJ3KcRIPSFLvyA==
X-Received: by 2002:a17:907:3ea5:b0:6da:6ef4:b058 with SMTP id hs37-20020a1709073ea500b006da6ef4b058mr9397813ejc.124.1646390699156;
        Fri, 04 Mar 2022 02:44:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bm24-20020a170906c05800b006d58518e55fsm1615927ejb.46.2022.03.04.02.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 02:44:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nQ5Qf-000ERj-RA;
        Fri, 04 Mar 2022 11:44:57 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, tytso@mit.edu, derrickstolee@github.com,
        gitster@pobox.com, larsxschneider@gmail.com
Subject: Re: [PATCH v3 05/17] pack-mtimes: support writing pack .mtimes files
Date:   Fri, 04 Mar 2022 11:40:10 +0100
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646266835.git.me@ttaylorr.com>
 <0600503856dbccb135aaead27693b6815a774b4f.1646266835.git.me@ttaylorr.com>
 <220303.86ee3j2dae.gmgdl@evledraar.gmail.com>
 <YiFQxsmkcqb63azh@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YiFQxsmkcqb63azh@nand.local>
Message-ID: <220304.86ee3if13q.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 03 2022, Taylor Blau wrote:

> On Thu, Mar 03, 2022 at 05:45:23PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Wed, Mar 02 2022, Taylor Blau wrote:
>>
>> > Now that the `.mtimes` format is defined, supplement the pack-write API
>> > to be able to conditionally write an `.mtimes` file along with a pack =
by
>> > setting an additional flag and passing an oidmap that contains the
>> > timestamps corresponding to each object in the pack.
>> > [...]
>> >  void write_promisor_file(const char *promisor_name, struct ref **soug=
ht, int nr_sought)
>> > diff --git a/pack.h b/pack.h
>> > index fd27cfdfd7..01d385903a 100644
>> > --- a/pack.h
>> > +++ b/pack.h
>> > @@ -44,6 +44,7 @@ struct pack_idx_option {
>> >  #define WRITE_IDX_STRICT 02
>> >  #define WRITE_REV 04
>> >  #define WRITE_REV_VERIFY 010
>> > +#define WRITE_MTIMES 020
>> >
>> >  	uint32_t version;
>> >  	uint32_t off32_limit;
>>
>> Why the hardcoding? The 010 was added in your 8ef50d9958f (pack-write.c:
>> prepare to write 'pack-*.rev' files, 2021-01-25). That would be the same
>> as 8|2, but there's no 8 there., ditto this new 020 that's the same as
>> 1<<4 | 1<<2, but there's no "16", just WRITE_REV=3D4.
>
> I'm not sure I understand. These are octals, so octal "20" (or decimal
> 16) just gives us bit 5 -- the next available -- by itself.

Urgh, tired/rushed eyes yesterday. I managed to read these as decimals,
sorry.

I see from:

    git grep 'define[^0-9]*(\b020\b|\b16\b|1.*<<.*\b4\b)[^0-9]*$'

That I managed to patch what seems to be one of two other places in the
codebase using it recently (that goes >=3D020) in 245b9488150 (cat-file:
use GET_OID_ONLY_TO_DIE in --(textconv|filters), 2021-12-28).

Anyway, I think nothing needs to be done here. If you ever feel like
some churn here I think converting it to the almost ubiquitous "1 << N"
style we use almost everywhere else would be an improvement :)

Sorry!
