Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28E7C77B76
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 07:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjDRHPV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 03:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbjDRHPS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 03:15:18 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58074273C
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 00:15:16 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6a5f765d5b8so159378a34.3
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 00:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681802115; x=1684394115;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNmhFcKNiVO3/xxEkgqTzPovTAe2DX4zsWMEl8LoPig=;
        b=dWBIUmk4Omi24K4O45wzkCt5NbwRVjBS4qOHAhwSwDTfSUqbfnPEMWK2UV+290DoJf
         iyk7uiRe1Ya5eZh2GcsnnU2aDsaozpRX+gYdXEfF40gPDhAlYclvv6sAFUDt3OU+nOSQ
         t+jux6x3XXllJzhZxqWFzJRzRNnauymUMz5bsEQ+lbQ1HyhjmR2IqfFY8ZZCe3B5s66f
         3YFBMUGNjPb4Piv+NwOGOyQ2gmbNE9dseLMKS0dpghGO1X5p9Ywt5hFUv9QCRrgXf88q
         sm8faFS3BJhLtOFLU5tt55q6f1iQvsoXsQJA9X2dEyR8ifFO8oMENSFhFETGoKg0/54m
         V05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681802115; x=1684394115;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jNmhFcKNiVO3/xxEkgqTzPovTAe2DX4zsWMEl8LoPig=;
        b=es2D57EodBdxEhhfhv6GbZDiZ0pfutq2DZEYG7v0pvZnZ0Syw3rQ7o74LgxY4lFZxu
         Z1XanD4SGIUL4cz2PRZN6/MtJaaCsTv2yW6nMzpGmaDmGVVy+fkk0vql+eHSv7O+Q3rW
         7KrH4eiVExvl1zf2NOwF+oVxTlcpBHBN02kPknxxH6R0yxPyUUXJVRlrX0yIGsrILWrD
         vxnEN8eUeYOHjc8SBkrHJEe75TRgCeqepG4BWve3rd71Ohx13EAuGejxTGSqpvCkU2Gn
         JlgcG/RY/hPhrjtUFFmNRE7rnDsrvHLnKxOpMB1CyOyNONaOWd2OJNRWbO0R2xvzvqlq
         NSiA==
X-Gm-Message-State: AAQBX9fcx91ryv9sA4TibB9GZ72NOhU6lxfw8a7sVncVefgRquw+WmAi
        ye1cDeS1bzDEM5GPqMNIBPc=
X-Google-Smtp-Source: AKy350a4d80oGsKIOSQ5yAYxt6dB/0AE9hEHIr0NAJlF6PrOvEdAlLVTfTrq9/RS/Of5gIs5sN6bAg==
X-Received: by 2002:a9d:62d3:0:b0:6a4:2d0e:d9dc with SMTP id z19-20020a9d62d3000000b006a42d0ed9dcmr575133otk.20.1681802115635;
        Tue, 18 Apr 2023 00:15:15 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id j23-20020a9d7d97000000b006a5f788cfc5sm538510otn.26.2023.04.18.00.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 00:15:15 -0700 (PDT)
Date:   Tue, 18 Apr 2023 01:15:14 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>
Message-ID: <643e43824a220_21b043294f8@chronos.notmuch>
In-Reply-To: <20230418061713.GA169940@coredump.intra.peff.net>
References: <20230418011828.47851-1-felipe.contreras@gmail.com>
 <20230418040034.GC60552@coredump.intra.peff.net>
 <643e2aeae0515_217cdb29473@chronos.notmuch>
 <20230418061713.GA169940@coredump.intra.peff.net>
Subject: Re: [PATCH] doc: remove custom callouts format
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Apr 17, 2023 at 11:30:18PM -0600, Felipe Contreras wrote:
> 
> > If we do this then the parser has no trouble understanding what we are trying
> > to do:
> > 
> >   --- a/Documentation/git-checkout.txt
> >   +++ b/Documentation/git-checkout.txt
> >   @@ -523,36 +523,37 @@ EXAMPLES
> >      the `Makefile` to two revisions back, deletes `hello.c` by
> >      mistake, and gets it back from the index.
> >    +
> >   +--
> >    ------------
> >    $ git checkout master             <1>
> >    $ git checkout master~2 Makefile  <2>
> >    $ rm -f hello.c
> >    $ git checkout hello.c            <3>
> >    ------------
> >   -+
> >    <1> switch branch
> >    <2> take a file out of another commit
> >    <3> restore `hello.c` from the index
> >   -+
> 
> Ah, that makes sense. I tried something like this, but asciidoc was
> unhappy with the "+" continuation between the example and the callout
> inside the block (which makes sense as there is no "list" to continue
> within that block).
> 
> Just putting the example and its callouts in a block is sufficient, but
> I agree that putting all of the "The following sequence..." list item's
> content into a single block makes the source easier to read.
> 
> > I don't see why we insist on creating such complex list items though.
> > 
> > Creating a subsection is much clearer for everyone: the reader, the writer, and
> > the parser:
> 
> Unless the subsection has a meaningful title, the formatting of the
> result looks a bit odd to me:
> 
>   EXAMPLES
>      1
>          The following sequence checks out the master branch, reverts
>          the Makefile to two revisions back, deletes hello.c by mistake,
>          and gets it back from the index.
> 
> as opposed to:
> 
>           1. The following sequence checks out the master branch,
>              reverts the Makefile to two revisions back, deletes hello.c
>              by mistake, and gets it back from the index.

To me it's the exact opposite: it's odd that the whole example is indented,
when it's part of the main content.

I prefer the example to be indented at the same level as all the other text.

Also, because I use manpage color trick, the subsection header "1" is rendered
in red, while the list number is not. It's odd that even the callout numbers
inside the example are highlighted in red, but not the number of the example.

> If each example had a short section title, it would make more sense.

I don't particularly mind, but if you think that's a requirement, then why not
add that?

I sent a patch series doing precisely t hat.

> At any rate, IMHO it is probably best to start with purely syntactic
> fixes that don't change the output, as that is uncontroversial and
> addresses the issue with your original patch (which is otherwise making
> most spots look nicer). And then any conversation about sections versus
> lists can proceed independently.

But the syntactic fixes changes the output.

Have you looked at the HTML output with asciidoc-py? It has the same
indentation problem you spotted in the manpages.

I don't see it in git-scm.com, but I presume that documentation there is
generated with asciidoctor.

> > > It's probably still worth moving forward with your patch, as I think it
> > > takes us in the direction we want long-term (and which builds with
> > > asciidoctor are already using). But we may want to pair it with a patch
> > > to work around the issue with git-checkout.1 using asciidoc to avoid
> > > regressing that section. It may require re-wording or re-organizing to
> > > work around the bug.
> > 
> > I can add that patch depending what we want:
> > 
> > Open block:
> > 
> >   1. foo
> >   +
> >   --
> >   bar
> > 
> >   roo
> >   --
> > 
> > Or subsection:
> > 
> >   === 1
> > 
> >   foo
> > 
> >   bar
> > 
> >   roo
> 
> So I'd prefer the open block.

What if I add a proper title?

    === 2. Merge

Another advantage is that we can link directly to the subsection in HTML:

    git-checkout.html#_2_merge

It's not something that's probably going to be used in practice, but to me it
makes total semantic sense to have big chunks of prose in a section of its own.

Having a huge list item on the other hand does not make sense, it would be like
having a list item that spans more than one page of a book.

Cheers.

-- 
Felipe Contreras
