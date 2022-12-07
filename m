Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D00C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 11:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiLGL6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 06:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiLGL6R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 06:58:17 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB812EF5E
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 03:56:54 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id v8so24576604edi.3
        for <git@vger.kernel.org>; Wed, 07 Dec 2022 03:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FckHlRm9qT+k4D8HcgANpYJSpnqiUhJhJFet+61LMPM=;
        b=QPbB/OjiE5MPYtWQzrrazO9oOEsnFC5ugrsGdpIoVBzNednEA+I0R12RD2r3BIyx5n
         Hyk7Cf8j3PvBX87/CRBSTtVoqqMB/h3wbUbN0eG8Y6GT0sexJZiKiedc0/VCMUxDcRco
         fhAjEHPvNlU1dOcAQ3D5VzCNVjzYWdGnmiYD7w1G7LRg1Ayq9IVc3VpnRINZvKJJPL+t
         j9EvLQ0mLzWFb5ENvcPa/mgAw1GV04blrawI544oOZItPGPbC4WVbq0uLPdCo1Sa7GT8
         3KezBN8N2oDMolhAH7OBfRUgiFGfkpVigdtszN5+xS7JL92RrRUNZMxtl2a+FDqn0BwF
         +rgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FckHlRm9qT+k4D8HcgANpYJSpnqiUhJhJFet+61LMPM=;
        b=K9eDjM0yHWCfsUSO6pi19BX6+p4biNM04BD50Gu+AinEKJOiwzHPFKapk3fRHbbpXP
         aAuRzr5ohXRWtNFvydA4wzdbXmMXUz77JgCUWx57yGSdWROf/E6NArxt3M3DdeyC90tH
         c5V63OVhistvFBhbVFiEXBxekHx42MtmRNSpaT6UFWtSEoVw/F+rPBEizCAkToCGgd+2
         PWAah5bt7mDRXeveQKecinGLxBjgupIzsQiOBjK7bu0wJhb0ERtZ1b9yL+3xLcZb85aj
         HEVR26fgnc3IXRIczfBI5Y4MVGD+WAw7ctlEn+T63kZEnwO2lHlM9LZ1iGERiI5DoFPy
         OxPw==
X-Gm-Message-State: ANoB5pkf1Lcc8tiKJKjE43hXJILdjjcIh9nNFN5YKrb3kSojYp9Hobcd
        FMPcDB/6yDN1ndMNBqmwtyk=
X-Google-Smtp-Source: AA0mqf6xRmEtAD04B2cMglX3IvtuIwwsKPI+OWd4QFmtXQu8uoQKce8y01oVWed5aKDj6RW83+43zQ==
X-Received: by 2002:a05:6402:4497:b0:46c:cff8:207d with SMTP id er23-20020a056402449700b0046ccff8207dmr9790118edb.370.1670414213359;
        Wed, 07 Dec 2022 03:56:53 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id x17-20020aa7d6d1000000b00458dc7e8ecasm2116422edr.72.2022.12.07.03.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 03:56:52 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p2t2i-004PDe-1n;
        Wed, 07 Dec 2022 12:56:52 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        toon@iotcl.com
Subject: Re: [PATCH 2/2] attr: add flag `-r|--revisions` to work with revisions
Date:   Wed, 07 Dec 2022 12:53:00 +0100
References: <20221206103736.53909-1-karthik.188@gmail.com>
 <20221206103736.53909-3-karthik.188@gmail.com>
 <xmqqedtc842m.fsf@gitster.g>
 <CAOLa=ZS5k=s98Bo9GE+RRa3jtanehL35y-hhLhy1DoM7GyO0cQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAOLa=ZS5k=s98Bo9GE+RRa3jtanehL35y-hhLhy1DoM7GyO0cQ@mail.gmail.com>
Message-ID: <221207.86h6y7a0l7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 07 2022, Karthik Nayak wrote:

> On Wed, Dec 7, 2022 at 1:12 AM Junio C Hamano <gitster@pobox.com> wrote:
> [...]
>> Also, at the C API level, I suspect that we strongly prefer to pass
>> around either the "struct object_id *" or "struct tree *", not working
>> with end-user supplied character strings without any sanity-checking
>> or parsing.
>>
>
> I must admit, I did take the path of least resistance here. So we finally need
> to parse the `revision:<pathname>` where the `<pathname>` is generated
> dynamically as we move through the check-attr stack.
>
> My question is, if I generate an `object_id` at the start (in
> builtin/check-attr.c)
> with only the `revision`, is there a way to traverse to find the blob
> for each of
> the different <pathnames>? I haven't looked at Git code for a while now, and
> I'm not sure what the best way to do this. Maybe I've missed some API which
> would make this simple, any help is appreciated.

The get_oid() that you're doing now happens in a loop, and should be
pulled out of it.

I suggested making that a feature in
https://lore.kernel.org/git/221207.86lenja0zi.gmgdl@evledraar.gmail.com/;
but if you keep the interface you've got where you only support a single
<rev> it would make the most sense to do that get_oid() in the builtin/
code at the start, and then pass the oid/path pair down.

You'd still need to call read_object_file() or equivalent for each
<rev>:<path> pair though.
