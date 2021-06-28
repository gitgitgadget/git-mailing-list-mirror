Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A6FC11F64
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD6A61C8E
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 19:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbhF1TED (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbhF1TEC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 15:04:02 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341B7C061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:01:36 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 110-20020a9d0a770000b0290466fa79d098so3246710otg.9
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 12:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ur5pIc9UMYYMjs8y/xSsh86AJSGnfAqbDxb7hbLuc0M=;
        b=J5CeSs3hBGuCcuzFpe6rdZ1M+TT8cfkSt3EWOFusgmJC7voiZ09IfvJsZBjTq6dmb2
         VJlFD1ibSaA4Ya7AcNkEOQlWzh/OAkgsZ9+TuB2w91tDp9AN7JBIbHSyhjKuiwYjQ080
         RRRs7yf3/7XP9Z/D8tNFgdBLexc7rZfTpOZV0S4npUqSu+SUUpneUS8V4daj1GwUH4sV
         wXS/xEgEf8g2vtVtAVaK81huIElXbHDOo4/nopO60RwCoJggUPhUD67PBeDqmwaCSQvY
         0GDYCDHzEG60Ozt3/ziLUAwu8AYRpq2PbsPHscTWZycKzy8bbqiwWB58d7Z/cwo/LYjK
         qoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ur5pIc9UMYYMjs8y/xSsh86AJSGnfAqbDxb7hbLuc0M=;
        b=YYxkegTJTreMmy26JV7a8jirhtjK5RJwo0/KA5NKDyQAy6KFqD4L3fNuiDo4/SqM36
         QgWzV6T9mKG0fLAktRTL+BagRfP2ykLhA3raR5BAvLK79Nr/+0hG66lZUAvGHT5sPHPS
         +tM1+ajQaZO35dkmtzZtnVrk+e+xuSC8WsFvqf6RJnUzcOniVVIflGZIp/uQ2nJH/1Pa
         9fUanVT7AxPfNJKmVK+5Wk59Vgg0D6PqEjMkqxHOQ7ECTEwbs/qqgshf1Fowr2wXltXF
         dLQ6rro0yx5nEDsrR6lNGYfM/hxsop5QRlSZjVzcvrwBdd/O5iAXMdJWSwyDYXCevOEo
         MH9A==
X-Gm-Message-State: AOAM532VvSaJbMGnInmMZHNy99KhqYk4v/nsLl3/PbxuHrPvJ0f9CAIx
        AHhpgsP/cSIg/ixL7+MnP6Q=
X-Google-Smtp-Source: ABdhPJzDVry69EiUtoI5qAqJXl/w7ucimutNeb0uZWB+O7RqFd8KYkzQHFXtDngXSgRPJmOn41jR3w==
X-Received: by 2002:a05:6830:33e3:: with SMTP id i3mr934140otu.47.1624906895566;
        Mon, 28 Jun 2021 12:01:35 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id q13sm3100580oov.6.2021.06.28.12.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 12:01:35 -0700 (PDT)
Date:   Mon, 28 Jun 2021 14:01:33 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'Felipe Contreras' <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?J8OGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uJw==?= 
        <avarab@gmail.com>, 'Jeff King' <peff@peff.net>
Message-ID: <60da1c8de0ca7_1cdb420832@natae.notmuch>
In-Reply-To: <029001d76c4d$f3277550$d9765ff0$@nexbridge.com>
References: <60bfadc0aca09_1abb8f208fd@natae.notmuch>
 <60da10df509f0_1b95d2089c@natae.notmuch>
 <029001d76c4d$f3277550$d9765ff0$@nexbridge.com>
Subject: RE: How dow we educate our users to configure less?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:
> On June 28, 2021 2:12 PM, Felipe Contreras wrote:
> >Felipe Contreras wrote:
> >> It has been suggested that we "educate our users" to configure less =
in
> >> the right way, instead of colorizing man pages ourselves [1].
> >>
> >> The question is *how*? Nobody has answered that.
> >>
> >> This is a continuation of the thread below.
> >
> >> I am still waiting for an explanation.
> >>
> >> How does the user properly colorize man pages for both man and git i=
n
> >> a way that works in all distributions?
> >
> >No response.
> =

> I think you're looking for something does not exist because it is
> platform and environment dependent.

Yes, but there's always some common denominator.

> There are two ways to configure git to work with 'less' on NonStop and
> neither is identical to Ubuntu or Windows.

But I'm not talking about configuring git to work with less.

Once you have less configured, how do you add colors? For example how do
you turn bold into red bold?

> Don't even get me started on what less does in a TSO/ISPF environment
> where everything is some single colour on black unless your emulator
> supports 3279 emulation.

Is it even possible to add color there? I'm talking about platforms
where color is possible in the first place.

> >It's safe to say at this point that nobody knows what that configurati=
on would look like.
> =

> Nobody, perhaps, knows how to do this on every platform in the known
> universe =F0=9F=98=8A. There is no "one way" to do this consistently ev=
erywhere.

In the platforms where color is supported, and you have less, what does
this do?

  LESS_TERMCAP_md=3D$'\e[1;31m' LESS_TERMCAP_me=3D$'\e[m' git help git

(I'm using a bashism, so you probably need bash for the example)

> In addition, there are many different terminal emulators that end up
> interacting with git and many do not support vt220 colours. So again,
> I'm not really sure what can be done.

Obviously I meant in the platforms where it can be done.

How does the user properly colorize man pages for both man and git when
using less in a way that works in all distributions that support colors?

-- =

Felipe Contreras=
