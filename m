Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1147C47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 22:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB8796121E
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 22:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFEWUz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 18:20:55 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:39818 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhFEWUw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 18:20:52 -0400
Received: by mail-lj1-f176.google.com with SMTP id c11so16515971ljd.6
        for <git@vger.kernel.org>; Sat, 05 Jun 2021 15:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dbL1nG1lSGOSr4iCYzBt12TNo3sDBdsISk3wC60jw9Q=;
        b=Hdf+kgGSA3gkE4aysbIsn67quOgr+KnIjdSb3OjmgMOecFPHpRPojVgBIy7WdCTN2+
         /ToWhngJhinRC/t48qDnexLaTJDm3c0iMhJkaYXw9NQRyoomPz/ZoB17UT346IZOz155
         aD3bWqPI33+jJxmTeoRUSb56VREVA52Fq6vNjoSGru97PZvNNFww7FUjUbPlVX1veaRb
         x7FXNr6RmulUcvg2KlItr+pJdPP5EPaaVonzUXiFUZi7hx6ujrw8cRZNL+/vNE4cLLhI
         HywZ6xIRMuM4psReTwdxtGXuSfM9M6J1ss/Z9uI4qMhANaEKVjStSPySw1a8tmgY7ajF
         oa/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dbL1nG1lSGOSr4iCYzBt12TNo3sDBdsISk3wC60jw9Q=;
        b=UGj30ByB7HCVMeQwUSstgyE+IQQlqk9Ard/1joG7WPTytKZ8Em/bXypKYI178G5cin
         5UyQQhZJxdZKPAhYD/uJbuBeAAxIPikieRYuCUSCgPqJSK5hlFuyZxTp5Wh9/tyx/sPK
         3l3tpKWi810/lY3fxPhvYVYb33vMpb7f0K2HA88K+BMjhb/1xfwit7Z6ySJS1IN2VkEB
         54kM3U3bsUbJ18lAdjPUami7qe+ljNQ1Bpv3df6korBf8IfUEo+curLQKEmbIsGhfNDc
         4QEX5muXCeebX7WXuec4lSk6kP8/12wa/CHi741gT61zPfVQp7z2s1UwJwFGrFS7t5Vi
         k7Mg==
X-Gm-Message-State: AOAM530kH04qL6U09Dxv3mOFRdij/ZuXdZIVIMRSE3VV//0WFkU9wZTN
        MuL4b1sFt9Wia9HxwHV83/RTkN6BOsF91i0GeuIMjw==
X-Google-Smtp-Source: ABdhPJz3KCPbvzeaoCmFPbLN2zSp7+SzJVQ5vj58O5Y4fCRMDxG+yHpvNqkesffm5kY5CLxW+xyAqy5IPWqD3DsDAkc=
X-Received: by 2002:a2e:90cd:: with SMTP id o13mr8745110ljg.248.1622931483086;
 Sat, 05 Jun 2021 15:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <eb4bcd4c-e6d2-cbeb-8951-cf22b9d3d5fe@web.de> <472c1411-fcf8-862b-cef9-52c2c994914b@web.de>
 <87fsxw5bav.fsf@evledraar.gmail.com>
In-Reply-To: <87fsxw5bav.fsf@evledraar.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 5 Jun 2021 19:17:52 -0300
Message-ID: <CAHd-oW6_29y90Ui-2mKjoyjZS0n9tyBY2a5ON8shEyddM0t8pQ@mail.gmail.com>
Subject: Re: [PATCH v2] parallel-checkout: avoid dash local bug in tests
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 5, 2021 at 5:03 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
>
> On Sat, Jun 05 2021, Ren=C3=A9 Scharfe wrote:
>
> > The parallel checkout tests fail when run with /bin/dash on MacOS 11.4,
> > reporting the following error:
> >
> >    ./t2080-parallel-checkout-basics.sh: 33: local: 0: bad variable name
> >
> > That's because wc's output contains leading spaces and this version of
> > dash erroneously expands the variable declaration as "local workers=3D =
0",
> > i.e. it tries to set the "workers" variable to the empty string and als=
o
> > declare a variable named "0", which not a valid name.  This is a known
> > dash bug (https://bugs.launchpad.net/ubuntu/+source/dash/+bug/139097).
> >
> > Work around it by passing the command output directly to test instead o=
f
> > storing it in a variable first.  While at it, let grep count the number
> > of lines instead of piping its output to wc, which is a bit shorter and
> > more efficient.
> >
> > Helped-by: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
> > Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> > ---
> > Changes since v1:
> > - Explain the root cause.
> > - Get rid of the local variable "workers".
> > - Adjust title accordingly.
> > - Still use grep -c, though.
> > - Remove input redirection.
> >
> >  t/lib-parallel-checkout.sh | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
> > index 21f5759732..66350d5207 100644
> > --- a/t/lib-parallel-checkout.sh
> > +++ b/t/lib-parallel-checkout.sh
> > @@ -27,8 +27,7 @@ test_checkout_workers () {
> >       rm -f "$trace_file" &&
> >       GIT_TRACE2=3D"$(pwd)/$trace_file" "$@" 2>&8 &&
> >
> > -     local workers=3D$(grep "child_start\[..*\] git checkout--worker" =
"$trace_file" | wc -l) &&
> > -     test $workers -eq $expected_workers &&
> > +     test $(grep -c "child_start\[..*\] git checkout--worker" "$trace_=
file") -eq $expected_workers &&
> >       rm "$trace_file"
> >  } 8>&2 2>&4
>
> I'd find this thing much clearer if the v2 just narrowly focused on
> avoiding the "local", and thus demonstrated the non-portable shell
> issue,

I don't have any strong preference, but if we are leaving the "grep |
wc -l" -> "grep -c" conversion to a followup patch, perhaps the
simplest change focusing on the dash issue would be to quote the
right-hand side of the "local" assignment:

-     local workers=3D$(grep "child_start\[..*\] git checkout--worker"
"$trace_file" | wc -l) &&
+     local workers=3D"$(grep "child_start\[..*\] git checkout--worker"
"$trace_file" | wc -l)" &&

(Ren=C3=A9, could you confirm if this works to make the test pass on dash?)

Alternatively, we could use `test_line_count` as SZEDER G=C3=A1bor
suggested in a parallel reply.
