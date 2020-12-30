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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F189C433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 17:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691F82220B
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 17:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgL3Rki (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 12:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgL3Rkh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 12:40:37 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38E9C061573
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 09:39:57 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id a109so15994157otc.1
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 09:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=cZIuWFazd/eXuqqEV4szNTziaogz5c8rXcag38lpQ9k=;
        b=OZUmUVw1YvN0boXkOQSeYdFx8OfM2wDHPSkNDAEf88meNmjJ/TYp1ZxxeGRmmvR4KW
         Q+8ezcXxIY8p8XAoInRewip/iXvNYTW4qZFkESFdA65BbgplKC6jVD4D7ohTwIe1EixO
         /66hEDLnOlajlJEMxzcDWvfDI5yUAJcePayKFvvs+i16YCxs7NUvt0isLBoZZmIr+iBT
         aVY4/vY+Sq6a8sO/ccIDej6JBP78O5baDdpWY+LyrwELh1xSIdr8K85a5FPJd7kDYoAm
         4NamDwelwzhre9n3q7U4Jd9+5l1nDjLHZfFD0P3dvKBcVs2uAKemPqGdv+vJ53ten4dL
         GMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=cZIuWFazd/eXuqqEV4szNTziaogz5c8rXcag38lpQ9k=;
        b=s8IAK/f++thT6z0acgz9YBRq3+8ZclsBurQi6REtm8opQes6zfWXORIuxiOHEbapc+
         5FTB0E5H05hGbRe/OEX/pu21bj1Z+wXl+9L5/Y8VKsE6TrLAfZQkV87njqdHjDEr5JW+
         UnJXqucNWkLc/5oCF0M3RGpt9ivu6pzfdiRW/GuKznPQdTIIpQyBmRYjvEjYNs2XoUT4
         sfJzT8dg9SboTzvTB2vLYzr+jsXYlWDyCvEEa0pyxbqGBaXOIj5NeVKdGGG6p++ZeQju
         foEStBQKM0J1thjYG4vTd9GJBCLe8peFZjPek28Ps7ISBNkTq97TRHiLYY/dMroOUiyc
         2V+Q==
X-Gm-Message-State: AOAM531Pq3G8wbFmuyzAyEblq80RrQRSgZJHvY8lbrCl1rM+BYmYxPvA
        mKklbhs7Ky4AAnjdtOzYZwU=
X-Google-Smtp-Source: ABdhPJzb8R8NXUNeIyu/2Co01wHaJs2rQDULMUbBTrncB6ZyFNG5/7ldsII4dNppSJFuOoyoilF9Hw==
X-Received: by 2002:a05:6830:4f:: with SMTP id d15mr39536118otp.185.1609349996836;
        Wed, 30 Dec 2020 09:39:56 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id f67sm10606002otb.60.2020.12.30.09.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 09:39:56 -0800 (PST)
Date:   Wed, 30 Dec 2020 11:39:55 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Message-ID: <5fecbb6b2f9a_871cb208f6@natae.notmuch>
In-Reply-To: <1402dabd-089d-616a-ef79-ff1ae3fcb438@web.de>
References: <20201229170837.297857-1-felipe.contreras@gmail.com>
 <20201229170837.297857-2-felipe.contreras@gmail.com>
 <1402dabd-089d-616a-ef79-ff1ae3fcb438@web.de>
Subject: Re: [PATCH v2 1/3] completion: bash: add __git_have_func helper
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe wrote:
> Am 29.12.20 um 18:08 schrieb Felipe Contreras:
> > This makes the code more readable, and also will help when new code
> > wants to do similar checks.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  contrib/completion/git-completion.bash | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> > index 463a3124da..869c73ee2c 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -3358,15 +3358,19 @@ __git_support_parseopt_helper () {
> >  	esac
> >  }
> >
> > +__git_have_func () {
> > +	declare -f $1 >/dev/null 2>/dev/null
> =

> I stumbled slightly over the lack of quoting.  It doesn't matter for
> the callers below, but new callers passing arbitrary strings could
> cause strange effects:
> =

> 	x() { echo x; }
> 	y() { echo y; }
> 	__git_have_func "x y" # succeeds
> =

> 	__git_have_func -a # succeeds
> =

> I just skimmed patch 3, but it seems to call __git_have_func with
> user-supplied strings, so this might become relevant.

Yes. I just just copied the code to minimize the changes, but this is a
valid concern.

> And then I wondered why use declare -f, which prints the function's
> body, when there is -F, which just prints the function's name.  And why=

> repeat /dev/null when redirecting stderr when the more shorter 2>&1
> would do the same?  None of hat was introduced by you patch, of course.=

> Anyway, this seems to work for me:
> =

> 	__git_have_func () {
> 		case "$1" in
> 		-*) return 1 ;;
> 		esac
> 		declare -F "$1" >/dev/null 2>&1
> 	}

I wondered some of those things too, but opted for the minimal approach.

Your change seems good to me, however I prefer this to the case
statement:

  [[ "$1" =3D=3D -* ]] && return 1

But doesn't seem to be too welcomed in git's bash style.

Looks like this would be prefered:

  if [[ "$1" =3D=3D -* ]]; then
    return 1
  fi

I would prefer either one of those to the case statement.

But the other change is good. I'll include that as a separate patch on
the next version.

Cheers.

-- =

Felipe Contreras=
