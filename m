Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E169EB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 23:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjF2XGc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 19:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2XGb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 19:06:31 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2FD2D7F
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 16:06:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so1726a12.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 16:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688079988; x=1690671988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRKs14QUFbSkE6wyrlnc9/9NKAkSUxAMttdim8zMpxw=;
        b=SA+jaxP1LILK0yyI+9k5vzpnQXJBQHu3MNVAFP3AQgVrF/ydOtcAaA+1G9Zgb4x7Zx
         3SyisBYAArmsLYYoOfFzmu9y5cGV6qV86+gVZpPK15vk7GKJLaEsjovSPuUWUrD7dLHg
         jJdxjTwaE9Vx5mtJ3ekk7i6vdgrTF62WJwwrtGMKqbQeepLGS8eCNrE+9OHGGiDJTQAn
         iUieAe1GnMBpwEWxex+dHateU7zU/68Z2/OmrsLaIxFKyG1Nv6lXH1Q2TITzPJIN4gji
         rkdGVPnCQ/n/UyNy5OGmXUX865ZSJ7aw4OAS0Irh62TtlRp9/UTgdjRH1ZWcgXdKka3q
         DvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688079988; x=1690671988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRKs14QUFbSkE6wyrlnc9/9NKAkSUxAMttdim8zMpxw=;
        b=cGBhtwA0tRCaPkO6OyXIxP3mCIH7KosYgUlWFwe0pmUtJNcehvX6oEbKT9jbTaYfxY
         tyD/PBjRziPiUHcg10l91HxhEze9+NJmDyP/drCVMusD/rsq1e9UkmBwqvEyRPuZQXxz
         FOapdYlrkqlPrg5g0X6jFem5nZhDwCl/unRxWL4g/huOVRe8thlDrkSLgGtCOMmI7hPj
         8QalqO/87/2LzZH43u2Dj0hNfHsUusNIHecEtDCld8dIald+tG/9SNt26ZhqRpQtr808
         bDGTTavHhM5zuAOUwLYTxzh1IfzNqD/YivhIv9KCGr9cvlpwQJWa+STPKF3Bmi0/h9U3
         VHmA==
X-Gm-Message-State: AC+VfDyhO625H9Rtvamm0AzrpSzvo/ldjDs/RocYueF+aYJpfGOB0cvu
        NhI4k1zCjJqGnqjcF8IgVBfV3g82/aonaB95BOkefA==
X-Google-Smtp-Source: ACHHUZ74qCLeTwbWu9gcS9fVC6v4SCSb4UHfbpq1dXBWKcDCzWYW1HE5LyxrHQ4o+A3g9Jv4jThw8fWWp2kEgfVsT34=
X-Received: by 2002:a50:d4d1:0:b0:514:92e4:ab9f with SMTP id
 e17-20020a50d4d1000000b0051492e4ab9fmr214764edj.7.1688079988246; Thu, 29 Jun
 2023 16:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <CADE8Naq5W3Bn=gwV7W-xMvYOMMRO=ZY9Ly6im4Rb_qFjMWTbTg@mail.gmail.com>
 <CAJoAoZ=OEfsgkqsag926tH4GEuafX26A09SGZ1vR1uLh2W_4TA@mail.gmail.com> <xmqq1qhu9ifp.fsf@gitster.g>
In-Reply-To: <xmqq1qhu9ifp.fsf@gitster.g>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Thu, 29 Jun 2023 16:06:17 -0700
Message-ID: <CAJoAoZnaU7WsCpnZY0Pvjg4_GJMZADF0FNC9fNZK56ShX2JO+g@mail.gmail.com>
Subject: Re: Documentation/MyFirstObjectWalk: add #include "trace.h" to use trace_printf()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Vinayak Dev <vinayakdev.sci@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 29, 2023 at 12:28=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Emily Shaffer <nasamuffin@google.com> writes:
>
> > Yeah, it's almost certainly stale in MyFirstObjectWalk - there was
> > very recently a patch to clean up some headers which probably were
> > implicitly including trace.h when I wrote this walkthrough.
>
> We are lucky that we have folks like Vinayak who tried out the
> examples and then bothered to spend time reporting the failure
> discovered.  What does it take, however, for us to have a bit more
> automated way to prevent such a breakage that comes from API
> changes?  Is it feasible, for example, to add a test that extracts
> code snippets from the MyFirstObjectWalk document and try to build
> the result?  Alternatively, we can ship such a set of sample source
> files somewhere in our tree (e.g. contrib/examples?) and have such
> a test try to build using the current set of source files, but then
> we need a mechansim to ensure that the sample source files will not
> go out of sync with the document.

Yeah, I remember we talked about this when MyFirstContribution and
MyFirstObjectWalk went in, but never made much headway. I do very much
like the idea of keeping the reference source in contrib/ as a set of
patches, maybe along with a script to apply them (or a readme with the
right `git am` invocation), and then checking that they still build.
Checking that against the contents of the document is trickier,
though, like you mentioned. Hm.

I'm interested in figuring out how to do this, but not likely to have
a lot of development time available to do it. Maybe I can take a day
here or there to poke at it, but if someone else is interested and
beats me to it, I will not be disappointed. :)

>
> Thoughts?
>
> Thanks.
>
