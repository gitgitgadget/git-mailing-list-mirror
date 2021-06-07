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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0390DC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 18:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF7B661003
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 18:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhFGS1a (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 14:27:30 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:44626 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFGS13 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 14:27:29 -0400
Received: by mail-ej1-f44.google.com with SMTP id c10so28208090eja.11
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 11:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=w+DyAB4jqqMD2ljE3M4SnQ+bPeav/qQL8WEPyUlQxSs=;
        b=kfVKJ0I7EMPER5H2xzxg/Hla+z/ugtmpp9wrxRNN7uuCKFgUtrRp1nxHBvLzbB1Wgo
         yODVHU5wgnZGpAOTSaYtwM13fdsEsWSMcd3Kaej4RmBFZkKU5rmMfbQcmWc7SloyoUrS
         P9v4ExBdCQj5H6F61YJqyflP8Xk/eYAZPi2Bqs0ckI/olsHp6Xp97Fg9g1R1FqJvaS7y
         csOnVnHwUAlFDRkw/IUykwaFts9l7RkwC5Cjeb/G0KHNoOiuKtrxwmfWP4nhp0Ge5CG3
         8rH3n6yM45DJXHGja5NOdgEK1MWOeVGm+6yL3VEcr2TwMavSSsHcOGgidNH3dpuVsf5q
         h79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=w+DyAB4jqqMD2ljE3M4SnQ+bPeav/qQL8WEPyUlQxSs=;
        b=Oj/aWc+ciwpvjsiAOJ+rSxpsut8AQF8t/lzmtMRuO9nh/b28lZy8ni9ua3XOV31dCA
         TnPIbWEOMAbt8XeqjFasJ+iMnUrM5Coc/pKKpYAj5Ad6u3isoM/+7UmjQT4zKD7RIEHv
         8AEaDfyRZIolbyEUQW+O+GYjFooplRzq3UZC7QyRf76elJ7vvQKKV3RZQa5l3ElONWgU
         G6X3iblqn1eYlB/HOluhrXrim1cC/v3Utn4+4Tr6/X+4PLXhdK6PBdKqKV5hL+1xthVz
         ksFD0HHLMzOZYIx5BQtAJC/LL3z7MWLZ9Lfokoa9a2vPGNWfmOb24Dcz1sJWI9bsG13G
         26XQ==
X-Gm-Message-State: AOAM531MUmASrnM4QYXWyMwGUVG+zOQG3wYlx89fTUrJlLwO0gQjbjqy
        pYzrlI4L8eermlWaf4pOQmwoGuTBxDnuWw==
X-Google-Smtp-Source: ABdhPJwFd0zY7w5OoqVB6QfOifo3f8Ez0hkdJuS83jtc3/MKa1i6YRJYWpQoMB6J/iLMXrqbbysz6g==
X-Received: by 2002:a17:906:35db:: with SMTP id p27mr19058071ejb.391.1623090277161;
        Mon, 07 Jun 2021 11:24:37 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id cw24sm6839934ejb.20.2021.06.07.11.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 11:24:36 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
Date:   Mon, 07 Jun 2021 20:21:35 +0200
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
 <87eedd4n20.fsf@evledraar.gmail.com>
 <9ae26bcd-c6b7-682d-f895-3196c6c04ce2@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <9ae26bcd-c6b7-682d-f895-3196c6c04ce2@gmail.com>
Message-ID: <878s3l4jod.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 07 2021, Derrick Stolee wrote:

> On 6/7/2021 1:09 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Mon, Jun 07 2021, Derrick Stolee via GitGitGadget wrote:
>>=20
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> There are several instances in our documentation where we refer to an
>>> anonymous user as "a contributor" or "an integrator" or similar. To
>>> avoid repeating this role, pronouns are used. Previous examples
>>> chose a gender for this user, using "he/him" or "she/her" arbitrarily.
>>>
>>> Replace these uses with "they/them" to ensure that these documentation
>>> examples apply to all potential users without exception.
>>>
>>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>>=20
>> I think this is mostly an improvement, however:
>>=20
>>>  .../using-signed-tag-in-pull-request.txt      | 38 +++++++++----------
>>=20
>> This is a quote from a mail of Junio's[1] (date and all). I don't think
>> it makes sense to copyedit that after the fact without at least editing
>> the header that indicates that it's a verbatim reproduction.
>>=20
>> 1. https://lore.kernel.org/git/7vehuyosaa.fsf@alter.siamese.dyndns.org/
>
> That's a good point. It does look a little strange that there is
> an email in our Documentation/ directory. I wondered if this was
> included in the docs that get posted to git-scm.com, but I see that
> the link I manually constructed [1] redirects to the GitHub mirror.
>
> [1] https://git-scm.com/docs/howto/using-signed-tag-in-pull-request.txt

We have a few of those FWIW, try grepping for ^Subject Documentation/

It seems git-scm.com dosen't carry them, but googling around e.g. this
site does: https://gitirc.eu/howto/using-signed-tag-in-pull-request.html

> As long as this file remains formatted as an archived email message,
> the edits here are inappropriate. It's another question of whether the
> files within Documentation/howto should be updated to be docs that can
> be more easily posted in places like git-scm.com.

*Nod*, I have some unrelated patches to fix some of this state of
 affairs in Documentation/, but for now it's like that...

I do think there's a time & place for it though, and it's unfortunate
that we haven't done as much of this recently. We've had quite a few
"E-Mails of reference", and IMO we're better off with them in
Documentation/ than not at all, and if we require that they be formatted
into "normal" documentation we're probably closer to "not at all"...
