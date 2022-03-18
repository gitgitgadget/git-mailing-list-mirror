Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FC3C433EF
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 14:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbiCROID (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 10:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbiCROIB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 10:08:01 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9E817AB4
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 07:06:42 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r13so17255750ejd.5
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 07:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=6oYh0NJ7wee6hVPAuTTdIIIyfTCIZ51+Ii4EJhBIlBs=;
        b=oeRv8qlwpfJZNuggm524JY8gXHX66kAuB6YPr3dX5me4PmAkdmYBEm/H+87Px/n5iQ
         rIdBAN+sheO9zThfGK2ZRWco2HwhFK8gfpQdEDxj1SrTY9Q8q+cOELSiPWQIt79gtNlH
         DybUSTMx4B3c5jdmiT57Hs9AAWR4b8t5XYCzsVkXSxt21jO23f1rf+Ck1ws/zFKR48vo
         NwjSjdcFi2RyBeAJ0+BlfWHkPzyZSGcKvaDedMDGP8kOHXG1y4maLioTO7eWogP++5ox
         XOTE3F74l2UpAa9GacJiK2/pd4tRhi1DDxdh0KfzxWRAxEQPnPw/9cg6wBJ8wSddbiQf
         5QGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=6oYh0NJ7wee6hVPAuTTdIIIyfTCIZ51+Ii4EJhBIlBs=;
        b=d+DPXcNUqAmb/eTHhbYMpt/4BnjtzRuIt9y6YpBg734oXaqaxFfb6A9C2c5WZfLVnQ
         yAHpzp1ojmpswC1heQO1YtOFA9jD/28OB1GbVOq/x9cDS/glFdxHE1o4Yq5k7iiOkspr
         q4rDZDHaAbgjcdiPxmOt1EAIPDKRyxcQK5YI6K4stk4RakFkvskkyF0IFH0WGrF1ZB/V
         INNlCXFQSlXHrHGWzwcpSrd5QvYReq5G8c185Ly/+EmxBm+UueRvrj+orR7ucgSKXTB0
         YbYdsxfSsx5aHhHI70uJeJw2V0ZeQblIDhomxaG12AqZwfwBLt76cobImKe4oed+Jiay
         0E9Q==
X-Gm-Message-State: AOAM532MVRb4HmkF7pU+3dg+F2wq4KGPl0OcTcOKzFIQPYxAyrxPaxq+
        v2fCNELKG4X4C9rPzrnakf+bmg3VXu4qwA==
X-Google-Smtp-Source: ABdhPJzhLamFrI30eV9WcYR661dw11gx0wvbIHQeIymmnau1WEecXQLlQ4FmlUgfTMRt/x/q+hUopA==
X-Received: by 2002:a17:907:6e1b:b0:6df:9ebd:f45f with SMTP id sd27-20020a1709076e1b00b006df9ebdf45fmr6930703ejc.362.1647612400468;
        Fri, 18 Mar 2022 07:06:40 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v17-20020a17090651d100b006dfa26428bcsm1836877ejk.108.2022.03.18.07.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 07:06:39 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nVDFX-002mUK-82;
        Fri, 18 Mar 2022 15:06:39 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: ssize_t portability (was: [PATCH 4/6] builtin/stash: provide a way
 to export stashes to a ref)
Date:   Fri, 18 Mar 2022 14:41:57 +0100
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220310173236.4165310-5-sandals@crustytoothpaste.net>
 <220311.86bkydi65v.gmgdl@evledraar.gmail.com>
 <2422376f-79aa-2d35-2646-c3611e2ef8d6@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <2422376f-79aa-2d35-2646-c3611e2ef8d6@gmail.com>
Message-ID: <220318.867d8rcq34.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 14 2022, Phillip Wood wrote:

> Hi Brian and =C3=86var
> [...]

Hi, sorry about the late reply, just on this point (which I see is stil
unaddressed), and changing $subject for the generic question:

>>> +	for (ssize_t i =3D nitems - 1; i >=3D 0; i--) {
>> The ssize_t type can be really small (it's not a signed size_t), so
>> this
>> is unportable, but in practice maybe it's OK...
>
> I'm not really convinced by this ssize_t can be small argument[2], do
> you know of any platforms where it is true?

Where we'd overflow in this code as written? Yes, every platform we
build on, since e.g. on Linux it's got half the unsigned size of
SIZE_MAX, on my 64 bit box:

    SIZE_MAX  =3D 18446744073709551615
    SSIZE_MAX =3D 9223372036854775807

Of course exceeding 2^63-1 or even 2^31-1 number of stashes seems
unlikely in practice.

If you meant are there platforms where ssize_t is as small as you can
pedintically make it, i.e. not just half the signed range of size_t, but
something much smaller?

Possibly, but I think that's unlikely in practice given the
homogenization in computing. Even C just mandated 2's compliment!

Although I think it's still imporant to understand that in the specific
case of ssize_t, unlike other "signed version of type X" the *intent* of
the standard is clearly to *not* mandate that it's a signed version of
size_t. I.e. it's intended for functions like:

     ssize_t read(int fildes, void *buf, size_t nbyte);

Which both per the standard and in practice might have limits that are
much smaller than their respective types. E.g. on my Linux box read(2)
says:

    On Linux, read() (and similar system calls) will transfer at most
    0x7ffff000 (2,147,479,552) bytes, returning the number of bytes
    actually transferred.  (This is true on both 32-bit and 64-bit
    systems.)

I can see how *some* platform might take those liberties in
practice. I.e. 1/2 of your addressable memory/offset !=3D number of bytes
you'd want to return or consider at once for I/O purposes.

But in any case, we do have existing unportable code in-tree, but
generally with C it's good practice to avoid unportable code if it's
easy, you never know what platform will be released tomorrow that you
might have to scramble to support.

As I noted in this and other similar cases it's trivial to just use
size_t here. It's just a matter of changing (leaving the C99-specifics
here aside):

	for (i =3D nitems - 1; i >=3D 0; i--) {
		item =3D ary[i];
                [...];

To, as I did in 99d60545f87 (string-list API: change "nr" and "alloc" to
"size_t", 2022-03-07):

	for (i =3D nitems; i >=3D 1; i--) {
		item =3D ary[i - 1];
                [...];

Or even, if repeating "i - 1" is tedious:

	for (cnt =3D nitems; cnt >=3D 1; cnt--) {
		size_t i =3D cnt - 1;

		item =3D ary[i];
                [...];

Portability concerns aside I think such code is much clearer and easier
to reason about, since you no longer have to carefully squint to see if
we're doing the right thing with the two types in play.
