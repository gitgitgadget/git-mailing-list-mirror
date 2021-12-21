Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4CDC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 02:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhLUCej (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 21:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbhLUCei (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 21:34:38 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F2AC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 18:34:37 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z5so46068247edd.3
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 18:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=gk+tUfNUQTxuwdAejLeTEhSeecN7Ir+m8SMeS5itPho=;
        b=TDZvmHgAbeC+3/unuTXYgvWne28T0GgcibHNiGMzUpgZNljQEEs1dAoHmB1jVofeeZ
         jAyrYFJOEmDxQEOawlGERNUCoh7gjfA7Z97LgKtYNiuyN5PxkMASxbK38ADkwW170lIl
         g3w5I/ioltNd3gHOol+c1uyghcTxREnlTWaSPrnYhb2PrLUYU8Ukrwj4BlNfOhA4uBGj
         tW9Fgnm2stBNlhUjeFEwssQPoGk2DdPHyKrx1369AhT/7rpky87EdeRYhHlDsrmHGf1A
         8kg4tTit32ttxenuSRtq4kwJq8D0HMC3tnR72GGSAA5AOlSt/e959M4ShvU3daX+xese
         3Hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=gk+tUfNUQTxuwdAejLeTEhSeecN7Ir+m8SMeS5itPho=;
        b=ksopaYe82C2QI8nH4dr7GSh1C6lfIKA5s8lj4HBZYLyr7QIykOFNGplRdv3g9YsqbR
         T1y3uTp3O9Mlm6IZMW3gsqvgPcIEWz+qboF/qkIpfN/OHBoKohUAWUkiZLH3TioMPNXL
         Jivmn+IEsAicpUZ1OPWZa5lA/LEgneQzoYDp3yLyME9wdT9b08nFLJvZGnMhACloe75n
         UM+hOJjtOPvQs4QF6Kl88nH6zGB4Hn76alkxV0p3QPNLiiLchdxYMAb69qYH9uNk8YRJ
         fyzzivn06ULnaDfCXhEOANblLxvj8OY3LhGy4he4rweePojZxnsIjF1K17giv9UpclKA
         hpsQ==
X-Gm-Message-State: AOAM531lls6RmZAmsj2qnvT1hWqTW5+0To/NqoRITjJhzWeVWlR4DMdJ
        IqR3sILBz3AXjvVTfn13HNg=
X-Google-Smtp-Source: ABdhPJygvUQbCa4ptvyLveBjgz1EYiyZs9aV+qmA0fQ9i/9ExfNCpMK+kfk3Z0qvEZ/YmdwmkgiGRA==
X-Received: by 2002:a17:907:7b9b:: with SMTP id ne27mr847654ejc.79.1640054075747;
        Mon, 20 Dec 2021 18:34:35 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id nb41sm2336358ejc.224.2021.12.20.18.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 18:34:34 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzUz4-000cEM-CD;
        Tue, 21 Dec 2021 03:34:34 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH] object-file API: add a format_loose_header() function
Date:   Tue, 21 Dec 2021 03:27:44 +0100
References: <20211217112629.12334-3-chiyutianyi@gmail.com>
 <RFC-patch-1.1-bda62567f6b-20211220T120740Z-avarab@gmail.com>
 <xmqqilviud6e.fsf@gitster.g> <211221.86wnjyspd3.gmgdl@evledraar.gmail.com>
 <xmqqmtkuso5f.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqmtkuso5f.fsf@gitster.g>
Message-ID: <211221.86sfumsn2d.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 20 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I've got some patches locally to convert e.g. write_object_file() to use
>> the enum, and it removes the need for some callers to convert enum to
>> char *, only to have other things convert it back.
>>
>> So I think for any new APIs it makes sense to work towards sidelining
>> the hash-object.c --literally caller.
>
> Your logic is backwards to argue "because I did something this way,
> it makes sense to do it this way"?

No, it's that if you look at the write_object_file() and
hash_object_file() callers in-tree now many, including in object-file.c
itself are taking an "enum object_type" only to convert it to a string,
and then we'll in turn sometimes convert that to the "enum object_type"
again at some lower level.

That API inconsistency dates back to at least Linus's a733cb606fe
(Change pack file format. Hopefully for the last time., 2005-06-28).

I'm just pointing out that I have local patches that prove that a lot of
back & forth is done for no good reason, and that this is one of the
codepaths that's tangentally involved. So it makes sense in this case to
make any new API take "enum object_type" as the primary interface.
