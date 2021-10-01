Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85981C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 22:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6570C610FB
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 22:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355826AbhJAWpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 18:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhJAWpp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 18:45:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E634EC061775
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 15:44:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v10so40185014edj.10
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 15:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5+B+Jt4MaX+aNSYdUa45+koac3yy4c9UO7hD5awvmJA=;
        b=GQCmiSoZDtMA+jjTWl9swgmw9xm5UaSAhYJC8zlJkj7d/J05ta7yqw79l4GxTMVNYv
         tLgOIaf4QJPjmTjTJ7+SAW/13R6Y7ZSIyz6OkzP7ZDL+2v5RurNpi13ihWUdq4NTMPd3
         hcKfaPsR20NV0ZL1yG/GwLHR3HkwcnPEq8qwrHXuozpb2SUYY1JyUrhJpyVBt0sQzRXA
         yEbfxdVO7dFTx7oJPt5lDvoY02oo3FwQVGp4rWLXr6PzY6TUaPWX2P5EsxscrHyVkZHO
         GPVdEl0OYA3tBJy9dU6wLtSmqy5i8NpFRv4qEqIcWASXWejs9C8jGVT4C2RAaojzh2sS
         5yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5+B+Jt4MaX+aNSYdUa45+koac3yy4c9UO7hD5awvmJA=;
        b=AGzoWWJmqVr6hqlWZrS1TxMItU6kZM3fWFPeJ+MzEKsV5LHgfMyIVIQQBM0KBJPx5b
         6orR81BuwrIs96OMnd9pWN6TFfRt6KkvhuI1rCSfQH6tNW0BELkRCRt90rnu3WHE/yU8
         kuWfps8nBYTxrKL7MchM6StZqqlOdLvzocoz3UF+4EzdSRqe24HWBXRlpFXGkvEwkiJp
         XpTpv50/9B+xGnU0k03fOe8tWsWxSwKzBAHICw7Vnp8lgy7AJAzV/29EqsT7X5S7PBHl
         oFH9pcwSEOfuevGQrBHPlH+VL+I4B3cLfKYR+NXS+PVLqMwLmqZ5SAYO75/e/+A+Z+c4
         S2Dw==
X-Gm-Message-State: AOAM530Y0fmcYMwBLVbrQJio97f1jBthcouS+e9MhQ+Qoc4/ywfgROHf
        m7/GzNKfSPJ4ohD0r4OuAdw=
X-Google-Smtp-Source: ABdhPJz6Max9U4s/EduCpgHWo6Lc25mlW7Z/KMmjJxg8L8Bt9naORJenMX1e6hPfm0hAH6ccUFRzzA==
X-Received: by 2002:a05:6402:3486:: with SMTP id v6mr157526edc.122.1633128239406;
        Fri, 01 Oct 2021 15:43:59 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id l18sm3773728edw.78.2021.10.01.15.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 15:43:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v10 17/17] fsck: report invalid object type-path
 combinations
Date:   Sat, 02 Oct 2021 00:33:40 +0200
References: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
 <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
 <patch-v10-17.17-838df0a979b-20211001T091051Z-avarab@gmail.com>
 <xmqqk0iw2y0m.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqk0iw2y0m.fsf@gitster.g>
Message-ID: <87sfxkpdqp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 01 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> diff --git a/builtin/fsck.c b/builtin/fsck.c
>> index 260210bf8a1..30a516da29e 100644
>> --- a/builtin/fsck.c
>> +++ b/builtin/fsck.c
>> @@ -615,12 +616,18 @@ static int fsck_loose(const struct object_id *oid,=
 const char *path, void *data)
>>  	oi.sizep =3D &size;
>>  	oi.typep =3D &type;
>>=20=20
>> -	if (read_loose_object(path, oid, &contents, &oi) < 0)
>> -		err =3D error(_("%s: object corrupt or missing: %s"),
>> -			    oid_to_hex(oid), path);
>> +	if (read_loose_object(path, oid, &real_oid, &contents, &oi) < 0) {
>> +		if (contents && !oideq(&real_oid, oid))
>> +			err =3D error(_("%s: hash-path mismatch, found at: %s"),
>> +				    oid_to_hex(&real_oid), path);
>> +		else
>> +			err =3D error(_("%s: object corrupt or missing: %s"),
>> +				    oid_to_hex(oid), path);
>> +	}
>>  	if (type !=3D OBJ_NONE && type < 0)
>>  		err =3D error(_("%s: object is of unknown type '%s': %s"),
>> -			    oid_to_hex(oid), cb_data->obj_type.buf, path);
>> +			    oid_to_hex(&real_oid), cb_data->obj_type.buf,
>> +			    path);
>>  	if (err < 0) {
>>  		errors_found |=3D ERROR_OBJECT;
>>  		return 0; /* keep checking other objects */
>
> When we say "hash-path mismatch", we would have non-null contents,
> presumably obtained from read_loose_object().  err is made negative
> when we give that messge, and we come here to return.  Did we forget
> to free "contents" in that case?

No, e.g. the "cat-file -t and -s on corrupt loose object" test added in
this series doesn't error with SANITIZE=3Dleak.

This is because as we go through read_loose_object() we'll make our way
to unpack_loose_rest(), which will return that malloc'd buffer. So we
would leak it if we returned after that.

Except that in read_loose_object() we'll go on to call
check_object_signature() right afterwards. The expecte OID is whatever
we inferred from the FS path, and the OID we saw is what we get from
hashing. That call will return non-zero, and we'll free() the
contents. The buffer isn't NULL'd, but we can't use it.

This is all behavior that pre-dates this series. I think it's a bit
stupid, and we should arguably do better about data recovery here, as
alluded to at the end of the commit message.

I.e. ideally we can use the information that we know we wanted OID A,
who cares if we found it at path B? It hashes to A and completes the
graph! Let's just re-write it to A. Or maybe it's not worth it. Or we'd
want to optionally log the content we *do* find on such failures,
e.g. maybe the content is partial or whatever. I had some WIP work on
top of this that did that, e.g. to recover in cases where you append
garbage data at the end of an object (in which case we *do* have the
content and can recover, we just need to stop reading at that byte once
our OID matches, and re-write it out again).

But anyway, it doesn't work that way now, and this doesn't leak memory,
or as far as I can tell do the wrong thing in these various edge cases,
because "content is bad" is always synonymous with read_loose_object()
itself calling free().

Thanks a lot for the careful checking!
