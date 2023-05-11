Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717D6C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 19:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbjEKTy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 15:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238502AbjEKTy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 15:54:56 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D22FF
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:54:55 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1960e7fe45dso2633150fac.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683834893; x=1686426893;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVSmdsVPW4zIq3w2Tl/NdP7MAphTz/6S3X31B7wgbYM=;
        b=F5X/BlKs3n+DgvQEcG2wKybHqv+3tRwfEyZSRcDnMIsTfM5GpMhKJipDPM5iD5jKh/
         mApyqxmwASW9fp8eixBHwBl9+22WdOOyliF73ltwe/KjbyaPVzliLlInbmiDv9NcJC2H
         28w/gcLBANykfxwdwRazCixSxS7OHf2tVEYzgR1H4tJuSxubf/6RoZeBBCIcSE/ACX3v
         i8QFo0INdGypr4etZI9R1X4bjEEES7bGWx82LOd+cnWh5Ug5WwELzRoIo7cISFba5nVx
         on239Jzrh6wzxXhj4kCdy4PiqOyvNEaxwr3KZfKSRIgm8jxd5mIRstrSwWl28Z38Fgzz
         m/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683834893; x=1686426893;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kVSmdsVPW4zIq3w2Tl/NdP7MAphTz/6S3X31B7wgbYM=;
        b=ZT1+HX0EB6gTMdK7QmVLHJFMogW0b0P+eM+XfcePDLcLhWvk6oYgN4B1ZBTU0RPIle
         eexcidjMfR/wgMMon0Pft+IQiTwuS1yhdlhomNW82tRjTcmVHltIiVekzqXqbO9NAYSR
         2k8tuDHFHxLOoT6ajjHRZQkxV5/9PlnYCmY1Fw4FGxTDP4IrjW4yONio9dDu6PbD4tye
         C299yzMqdxxTCMnY+jpwwOoZtFLgNeTrJZexMQJn7UU7axpdzLAvnxfi61Y7inO+QM7j
         6kT61HwP5wQm9v/4IILe2PdJb6lq2Ap3R2Hwtf9eF1kZK2b0QdUcOFRKsi+3ydt12lKD
         WxCQ==
X-Gm-Message-State: AC+VfDzpigulGdc3Wi9dMYaIt4PMECr4DS8s8Xpwr0EnYFcD8ro+bmoq
        DBmaWKDouxrvi9jLraC9UEc=
X-Google-Smtp-Source: ACHHUZ6sCYFbAuvEcCuVvwqi6Rn5O2Q3737mghv9Ya30j6yfPHpB1/llKVxCDiOpRKlVDuRzKG5GTg==
X-Received: by 2002:a05:6808:6298:b0:394:811:4978 with SMTP id du24-20020a056808629800b0039408114978mr5028750oib.48.1683834893481;
        Thu, 11 May 2023 12:54:53 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id v1-20020a4ac901000000b0054c9382b871sm7491817ooq.12.2023.05.11.12.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 12:54:52 -0700 (PDT)
Date:   Thu, 11 May 2023 13:54:51 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Message-ID: <645d480be344d_260ff5294c@chronos.notmuch>
In-Reply-To: <87wn1ezms9.fsf@osv.gnss.ru>
References: <645c5da0981c1_16961a29455@chronos.notmuch>
 <871qjn2i63.fsf@osv.gnss.ru>
 <645d28e112294_26011a294b2@chronos.notmuch>
 <877cte200m.fsf@osv.gnss.ru>
 <645d3dbf785a5_26069229463@chronos.notmuch>
 <87wn1ezms9.fsf@osv.gnss.ru>
Subject: Re: Can we clarify the purpose of `git diff -s`?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Sergey Organov wrote:
> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
> >> > Sergey Organov wrote:
> >> >
> >> >> I'd rather think about generic interface for setting/clearing
> >> >> (multiple) bits through CI than resorting to such convenience
> >> >> tricks. Once that is in place, one will be able to say "I need these
> >> >> bits only", "I need to turn these bit(s) on", and "I need to turn
> >> >> these bit(s) off" conveniently and universally in any part of Git CI
> >> >> where it's needed.
> >> >
> >> > It's possible to achieve both.
> >> >
> >> > Imagine your ideal explicit interface. In that interface the default
> >> > is no output, so you *have* to specify all the bits, for example:
> >> >
> >> >   git show --patch
> >> 
> >> No, that's not what I meant. There is no point in making "git show" to
> >> have no output by default, please see below.
> >> 
> >> >
> >> > Or:
> >> >
> >> >   git show --raw
> >> >
> >> > In this ideal interface it's clear what the user wants to do, because
> >> > it's explicit.
> >> >
> >> >   git show --patch --raw --no-patch
> >> >
> >> > Agreed?
> >> >
> >> > My proposal achieves your ideal explicit interface, except when no
> >> > format is specified (e.g. `git show`), a default format is chosen for
> >> > the user, but that's *only* if the user hasn't specified any format.
> >> 
> >> My point is that the default format should be selected as if it has been
> >> provided by existing options, rather than by some magic hidden in the
> >> code.
> >
> > But why?
> >
> > I don't see any benefit, only drawbacks.
> >
> >> > If you explicitely specify the output format that you want, then the
> >> > default is irrelevant to you, thus you have your ideal explicit
> >> > interface.
> >> 
> >> That's not what I had in mind, sorry. It'd rather be something like:
> >> 
> >>   --raw: set "raw" bit and clear all the rest
> >>   --+raw set "raw" bit  (== current --raw)
> >>   ---raw clear "raw" bit (== --no-raw)
> >> 
> >> In this model
> >> 
> >>   git show
> >> 
> >> would be just an alias for
> >> 
> >>   git log -n1 --patch --cc
> >> 
> >> and no support for a separate command would be need in the first place.
> >> 
> >>   git show --raw
> >> 
> >> would then produce expected output that makes sense due to the common
> >> option processing rules, not because somebody had implemented some
> >> arbitrary "defaults" for the command.
> >
> > But now you are at the mercy of those "arbitrary defaults".
> 
> No, see below.
> 
> >
> > Let's say those defaults change, and now the default output of `git show` is
> > `--stat`.
> >
> > Now to generate the same output you have to do:
> >
> >   git show --raw
> >
> > in one version of git, and:
> >
> >   git show --no-stat --patch --raw
> >
> > in another.
> 
> No: --raw in my model clears all the flags but --raw, so
> 
>   git show --raw
> 
> will produce exactly the same result: raw output only.

But that {--,--+,---} notion doesn't exist, and I think it's safe to say it
will never exist. So, could we limit or solution-space to those solutions that
could have the potential to be merged?

What you suggest could be easily achieved with:

  git show --silent --raw

But because no other format is explicitely specified, following my notion of
defaults, that's the same as:

  git show --raw

`---raw` can easily be achieved with `--no-raw`.

The only thing that's missing is `--+raw`, but I don't see how this:

  git show --+raw

Is more valuable than:

  git show --patch --raw

If you know the default of `git show` is `--patch`, and you want to add
`--raw`, then you can easily write the latter.

Doesn't this approach achieve everything you want to do? Albeit with a
different syntax.

-- 
Felipe Contreras
