Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CCCC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 02:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F06C60F10
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 02:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbhHECuE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 22:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhHECuD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 22:50:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1321DC061765
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 19:49:50 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z11so6195601edb.11
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 19:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=lmVtbD6OCxKYxsGuBwu8pdxuXMXPr+yyZDDvLt9BA6w=;
        b=RuBQDyACFly4tBR3Fa8RfVBYxMQl/uRvbyHAs/PtQ0ZlraeNciIssM/B9Jrp6MzGoH
         5UMuH6l06spz6h8g6qkUIAMoY2Idh8YP5iz8vXVm6NWQ3t4kJkjSTptepWAJK+1Z3U1p
         Wmuk//OAKgtTkkwlRyUr/bHk8TbVDCEoQJ9u2G9Qs/lOuZ9CLImUMe6++A+f3picmqYF
         nnjy4LaenS7NXvYtTAS+le8Tz62za7MA09MisexUPH3ZV7jKIZgReBUgE4vvzrsVlPXQ
         2/PgnZRqPcGADZeI3kPO0HMtvmtUUWinvyFehcgTZcpVMKxR1ALUi/aP0pdT2drS1dwh
         ys0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=lmVtbD6OCxKYxsGuBwu8pdxuXMXPr+yyZDDvLt9BA6w=;
        b=ukHmxhVlSwhn5rtiRynCOn2bG+wCRu6326tAVg3h69dLeH0+nIafqhJfF3t56cyf6/
         JWKs/Hk74+mKWR/eNHwD7VlV/dXLL4uh5KQDrKvXPkdIDkp2GD6pRYsLeWcwfOeSYP/q
         w8/RBwJOZWVgpcVNs3Mp4mNF7QOrzrjWWm3H9FfEX6On2mDcKJN/9kmAlgco7C1BlNf/
         7Bcb4iSSF0wNUdJjCaAtkC5Q6eFVFULKGTQQmSm3zQKsONGnqqlv8xGmtc8npXAt7/Py
         ED/ZlPSdjrhxRG21L/uz0ggs4gVfKvKIJ/jibH0HHaPdNs0rlT/Pf29bT1aiRgkkL4Z0
         AUhQ==
X-Gm-Message-State: AOAM531qm1Zct4nVHQ1InR1cfgBup9TGe9u9JZznotomux8ALBST5Gzz
        5aM9pok4ZzIh+4iSUNJlzT0=
X-Google-Smtp-Source: ABdhPJz784JmxFmCNK9KshB1dQtc2ehnntTl93l+E1MjsZ9OCRNn5KZ17x+92jg/dFCsTZNM5G3iew==
X-Received: by 2002:a50:bb43:: with SMTP id y61mr3492405ede.22.1628131788629;
        Wed, 04 Aug 2021 19:49:48 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id d23sm1213317ejc.4.2021.08.04.19.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 19:49:47 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v2 2/2] connect, protocol: log negotiated protocol version
Date:   Thu, 05 Aug 2021 04:47:16 +0200
References: <cover.1628115064.git.steadmon@google.com>
 <d138b2615c1af288627b9a2f8f7dd3d2fed184d7.1628115065.git.steadmon@google.com>
 <87a6lwn52u.fsf@evledraar.gmail.com> <YQs+VQIYDO3pkCNS@nand.local>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YQs+VQIYDO3pkCNS@nand.local>
Message-ID: <874kc4mwqc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 04 2021, Taylor Blau wrote:

> On Thu, Aug 05, 2021 at 01:40:51AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Wed, Aug 04 2021, Josh Steadmon wrote:
>>
>> > It is useful for performance monitoring and debugging purposes to know
>> > the wire protocol used for remote operations. This may differ from the
>> > version set in local configuration due to differences in version and/or
>> > configuration between the server and the client. Therefore, log the
>> > negotiated wire protocol version via trace2, for both clients and
>> > servers.
>> >
>> > Signed-off-by: Josh Steadmon <steadmon@google.com>
>> > ---
>>
>> I know Taylor asked you to change it to a string from in int upthread in
>> <YQmxSxTswHE/gTet@nand.local>, but I really don't see the point. But am
>> willing to be convinced otherwise.
>
> The conversion to log a string instead of an integer is necessary if
> Josh wants to write "<unknown>" instead of -1. To me, that seemed
> clearer, and I like that it makes the trace2 representation for a
> protocol version separate from the protocol_version enum.

Yes, having a magic -1 value would be bad, but since it seems we'll
never get it in practice...

>> It seems to me that both of these codepaths will never usefully use this
>> new "UNKNOWN_VERSION" string you added, i.e.:
>>
>> >  connect.c                             |  3 +++
>> >  protocol.c                            |  3 +++
>> >  t/t5705-session-id-in-capabilities.sh | 12 ++++++++++++
>> >  3 files changed, 18 insertions(+)
>> >
>> > diff --git a/connect.c b/connect.c
>> > index 70b13389ba..5f0e113625 100644
>> > --- a/connect.c
>> > +++ b/connect.c
>> > @@ -150,6 +150,9 @@ enum protocol_version discover_version(struct pack=
et_reader *reader)
>> >  		break;
>> >  	}
>> >
>> > +	trace2_data_string("transfer", NULL, "negotiated-version",
>> > +			   format_protocol_version(version));
>>
>> Right after this.
>>
>> >  	switch (version) {
>> >  	case protocol_v2:
>> >  		process_capabilities_v2(reader);
>>
>> We'll die here with BUG("unknown protocol version") if it's unknown..
>
> Good eyes. In fact, the second switch statement shouldn't even need a
> case-arm for protocol_unknown_version (but has it to cover all
> enumerated values).

I didn't check if crafting an unknown version will be found earlier, or
if we'll actually reach that "unknown" case.

> I didn't realize before that the unknown case really is dead code, so
> we'll never log "<unknown>". And since the mapping from protocol_version
> to string is identical for known values, we could probably do without
> it.
>
> And I don't much care either way. I think the benefit is really pretty
> slim, and arguably my code is just adding unnecessary overhead. So I'm
> happy to go with or without it, but I'd be rather sad to spend much more
> of our collective time discussing it.

Yeah, I just think if we can be sure it's an integer *and* a valid
version when we log it, people writing future log summarizing code will
thank us, i.e. just 0, 1, 2, and in the future maybe 3, ..., but not -1
or "<unknown>" or other values we'll trust die() etc. to handle.
