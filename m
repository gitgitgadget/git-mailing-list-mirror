Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98AEC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 17:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351886AbiCXREl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 13:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243263AbiCXREj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 13:04:39 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B67FF4A
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 10:03:05 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r23so6402074edb.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 10:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1cO6I5edZGV0f4nbw8Tr7mntyDaDFyF+YuKSx8ME7Xo=;
        b=QNaGp8aG6BmK49u/TlDg1baG1oGAk8e16dZoQGxTcL77oWHwNjy2nA4c5V1kHAVeGr
         DEd52dl0AmGduMJwSXil1rU3Xu8v2EoU1jAS636FceY6ZZtmV5QKX2I0Kb3TFLuPpB91
         j/2Cc7A1c4Yg73rM9SrbG8kBEaU070wayEd3hwBV+hxnbeag75BYBIA1RTfUP8eCxOiB
         pSgUI5GG7yAAcZlLGpPFpnUNwcKvwHXIwBf39M+z3WW4hfQfCsKx2ezUe0RDEZRrAiNk
         SNIKoSV8aoA1duzO01kr+UeneCFXDvaTbZ2+s4kJITMjK3t045ntCzH4jZyCLRFrl61G
         gxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1cO6I5edZGV0f4nbw8Tr7mntyDaDFyF+YuKSx8ME7Xo=;
        b=E9oatfdh8ZZajJylWv6PpDeAF7k5xU3f9SEhTBPx9DDjf3TB/kU/LC8SZERCjUuVrx
         5b/J/nP3RVazqK+sBTrZZmzwzyktCqLWwkOUiV8ihXNUa7/2wNav3xyKuwixeji8Pl1w
         TTMAXJO4D/HdleF7XQx85X4NBJnvpbndAAmVsQrvrOwmCQvDi0mhCl8VFlbJgJgE+cxE
         1lT7aPVyanBR4XsAKqVzYFmERT03/5nIo+lwd+Bp+n/IF4MnXYxTp8dA0Zji/Z7gCIMk
         p/ZgXy5Vxqc4aQ/PM/3osJJ4y3Pw+QZwoGmsdu+bhk5D/+GoVA4dHT4/ytPBtlXOqRjd
         XYPw==
X-Gm-Message-State: AOAM533MiFPKQ9DSxnaY6iWOmNzTQl+AZl8MyIYJ911CfAlebiyU4Z9K
        xsmwbE/gWNNjMZWVdhROb40=
X-Google-Smtp-Source: ABdhPJzbZKRB/jmQynqT0ptv39c+Q+zbzAUkN5FmG3UYHGvPDngCIxn3As9CMzPemx/O4PJfsafkgg==
X-Received: by 2002:a50:d84c:0:b0:418:f176:79df with SMTP id v12-20020a50d84c000000b00418f17679dfmr7643813edj.353.1648141384038;
        Thu, 24 Mar 2022 10:03:04 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906144200b006ceb8723de9sm1346508ejc.120.2022.03.24.10.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 10:03:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nXQrW-001jJH-Kr;
        Thu, 24 Mar 2022 18:03:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 06/27] revision.[ch]: provide and start using a
 release_revisions()
Date:   Thu, 24 Mar 2022 18:02:26 +0100
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
 <patch-v2-06.27-7194aac88e1-20220323T203149Z-avarab@gmail.com>
 <xmqq4k3om04m.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <xmqq4k3om04m.fsf@gitster.g>
Message-ID: <220324.86czibmgft.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 23 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> diff --git a/revision.c b/revision.c
>> index 303d1188207..90bac9ada03 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -2933,6 +2933,13 @@ static void release_revisions_commit_list(struct =
rev_info *revs)
>>  	revs->commits =3D NULL;
>>  }
>>=20=20
>> +void release_revisions(struct rev_info *revs)
>> +{
>> +	if (!revs)
>> +		return;
>> +	object_array_clear(&revs->pending);
>> +}
>
> Yay.
>
> It is unclear why we want to allow passing NULL to this, though.  Do
> we even have any code paths that allocate on-heap rev-info?  Address
> of an on-stack or global rev_info will never be NULL.

I'm almost certain it's boilerplate from early testing, and running the
tests with it removed just now passed.

I'll make a bit more sure sure it's OK (with SANITIZE=3Daddress et al) and
drop it in a v3.
