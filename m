Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455E2CA0EEC
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 14:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236013AbjILOeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 10:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbjILOd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 10:33:58 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349E310D
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 07:33:54 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50091b91a83so9362448e87.3
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 07:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694529232; x=1695134032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=854HS/6ej6pA7KHe13zy6edfcYbLJHrvTgA8SvxDdaI=;
        b=sFcRmdWz1XUHO4ucotnlMmpM5hXLp+siVx99gDpruCVif85FiNeSUHkZLnwrwTLSQU
         5Ng3HKSweGNjmKSu0sw904Bvs/wPk5x+zqMFUm4IExi2+KMOnRPL6BEG0dI4/+kh76ql
         D1c9bZUAikfalFMScK3mq3wrDiQ1s7wMpGTkjukT7VwJMf12FT2Apf+hsm32GOhr7kkY
         wdki0wooxsHsgrxiO/L4Z4RxTuN3ils4jod1dzZWNCeJrGjEjr7v0hoCSm//karLAxn8
         QpCA3nwRBsn0utEavEYxrvIxuT5MOQ5InghVsKlEE2X4GHrdzuUVu9KufMRiiXQC2PcB
         1lHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694529232; x=1695134032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=854HS/6ej6pA7KHe13zy6edfcYbLJHrvTgA8SvxDdaI=;
        b=hJu48VviiI0LrwCKZ58Kb89pz6mZ0hpqrj65dodjQDhpICW8KvOKwdnaEXo3YLAdMT
         LieIWP4Wu9yTawxi1+vX06XabUn70pxr8OZVGYHswUxHUZfSKx9hQSaU5w0cOMu8zxFl
         dVLBLu2FFuFt+1a4LhhCkzxrFT9xubWOvCOfEVnCG7a5bnknxC7to4ya2xzEADQR8du9
         31rY/wa07bHQOfCTNwbP86F0dTLewhgOvkZO8jdjXimj7dzqDvxGXsxDj9dMWpqj3+UQ
         wQ19ee2O6zjsig0dI7tsxBBu5SkQdu8c6XrYjz8zWLR8bQKu+ZZr7XPWLCWdt2z2GJhS
         n0Lg==
X-Gm-Message-State: AOJu0Yz4K1C2KUf/9H2gA3aqDPw8OZz9tajeYnQrzlF3lzfT4xv65qYr
        glFUY7B5a5dTVr6vaK/0fyQ90CBoa25o69YILsWEMgML8FKQMA==
X-Google-Smtp-Source: AGHT+IEgY57Df97AfSP2EULNbylRtGi/YqsJUzYCEJpadHrN1TaY5CBbKN35lQv1qVsyHplBL+UrLApWe/OFJLMWh0U=
X-Received: by 2002:a05:6512:3d09:b0:4fb:89b3:3373 with SMTP id
 d9-20020a0565123d0900b004fb89b33373mr13109954lfv.43.1694529232031; Tue, 12
 Sep 2023 07:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAH7zdydYgSf+21GB70=gRhEcupv4e1ix==7LWCeQYgpD-1Rcmw@mail.gmail.com>
 <xmqq8r9cs2x1.fsf@gitster.g>
In-Reply-To: <xmqq8r9cs2x1.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 12 Sep 2023 07:33:39 -0700
Message-ID: <CABPp-BE-4ewkDjkR++iyY2K=-T5cBGTk5cRbCqBE3F02tFkxug@mail.gmail.com>
Subject: Re: Commit dates on conflict markers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Roger Light <roger@atchoo.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 11, 2023 at 4:31=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Roger Light <roger@atchoo.org> writes:
>
> > When I carry out a merge with conflicts, it's not always clear when
> > resolving the conflicts which is the correct part of code to use. I
> > sometimes use git blame to guide me as to the age of the different
> > chunks of code and hence what to choose.
> >
> > I was wondering if there might be a way to help include that sort of
> > information directly into the conflict.
> >
> > If you had a single line conflict it would be straightforward to
> > display by including the date the line was last modified alongside the
> > conflict marker:
> >
> > <<<<<<< HEAD date:yesterday
> > print("please")
> > =3D=3D=3D=3D=3D=3D=3D date:10 years ago
> > print("help")
> > >>>>>>> main
> >
> > With a more realistic change with multiple lines and context from
> > different commits, it's not immediately obvious to me that it's
> > possible to do in a way that isn't completely horrible.
>
> Our conflict marker lines do get human readable labels but the
> format used by merge_3way() both in merge-ort and merge-recursive
> backends is hardcoded to be <branchname> ':' <pathname> and it is
> sufficient to let you tell which commit involved in the merge and
> which path in that commit the contents came from.
>
> A change that only shows the commit date without allowing end user
> configuration will *not* be worth doing, but allowing them to use
> placeholders like '%h %s' in "git log --format=3D'%h %s'" (check
> pretty.c for the catalog) would be a good exercise; it should not
> take somebody with an ultra-deep knowledge of how the code works.

Generalizing conflict marker annotations to use other hints may make
sense, but I am not sure that "date" is a good example or reason to
generalize it, for three reasons:

  * [No date] Virtual merge bases from recursive merges do not have a
date to associate with them.  Do we just make one up?  Average the
range of dates of the commits being merged to create the virtual merge
base?
  * [Wrong date(s)] The date Roger probably wants is the date when the
conflicting text was introduced to the given side of history, not the
date of the tip of that branch.  merge-ort is pretty fundamentally a
three-way merge algorithm, meaning it only ever uses the merge-base
and the two branch tips.  I don't want to see that changed either;
other than for computing the merge base, I'm very skeptical of any
movement to make merge-ort depend upon any intermediate commit(s).
Such changes would likely be better placed in an entirely new merge
algorithm, but then you have to write an entirely new merge algorithm,
which is decidedly non-trivial.
  * [Too many dates] What if the conflict region had two lines on one
side and each line was added on different dates -- what then to
display for the date for that side of history?  The earliest?  The
latest?  Some kind of weighted average?  Feels like a bug report
generator to me.

So, if we generalize conflict marker annotations, we probably ought to
omit "date" from the new possibilities.
